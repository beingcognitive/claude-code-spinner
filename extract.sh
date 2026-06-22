#!/usr/bin/env bash
#
# extract.sh — Pull Claude Code's UI word lists out of the installed CLI binary.
#
# Claude Code embeds several human-readable word lists as plain strings inside
# its compiled (Mach-O / native) binary:
#
#   • spinner verbs — the present-tense words shown while it works
#                     (Thinking…, Pondering…, Brewing…). 187 of them.
#   • past-tense    — the completion words ("Crunched for 51s"). A curated 8.
#   • tips          — the "Tip: …" hints shown at startup.
#
# Each list is stored as a contiguous, alphabetically-sorted run of strings, so
# we slice out the block between two known boundary words and tidy it up.
#
# Usage:
#   ./extract.sh [--present|--past|--tips|--all] [--plain] [BINARY]
#
#   --present   spinner verbs (default)
#   --past      past-tense completion verbs
#   --tips      startup tips
#   --all       print all three sections
#   --plain     one word per line, no numbering (for archiving/diffing)
#   BINARY      path to a claude binary (default: newest installed version)
#
# NOTE: no `pipefail` — the awk extractors exit early on purpose, which sends
# SIGPIPE to `strings`; we only care about the final `sort` exit status.
set -eu

# Force a byte-order (C) locale so `sort` is deterministic everywhere. Without
# this, case-mixed lines (e.g. tips) sort differently under a UTF-8 shell vs a
# bare launchd/cron environment, producing spurious "changes" every run.
export LC_ALL=C

MODE="present"
PLAIN=0
BIN=""
for arg in "$@"; do
  case "$arg" in
    --present) MODE="present" ;;
    --past)    MODE="past" ;;
    --tips)    MODE="tips" ;;
    --all)     MODE="all" ;;
    --plain)   PLAIN=1 ;;
    -*)        echo "Unknown option: $arg" >&2; exit 2 ;;
    *)         BIN="$arg" ;;
  esac
done

if [[ -z "${BIN}" ]]; then
  BIN="$(ls -1d "$HOME"/.local/share/claude/versions/* 2>/dev/null | sort -V | tail -1 || true)"
fi
if [[ -z "${BIN}" || ! -f "${BIN}" ]]; then
  echo "Could not find the Claude Code binary." >&2
  echo "Pass it explicitly:  ./extract.sh /path/to/claude/versions/<ver>" >&2
  exit 1
fi

# --- list extractors ---------------------------------------------------------
# Spinner verbs: contiguous run Accomplishing … Zigzagging.
# `strings` truncates multi-byte é, so restore Flambéing / Sautéing.
present() {
  strings -n 4 "$BIN" \
    | awk '/^Accomplishing$/{g=1} g{print} /^Zigzagging$/{if(g)exit}' \
    | sed 's/^Flamb$/Flambéing/; s/^Saut$/Sautéing/' \
    | sort -u
}

# Past-tense completion verbs: contiguous run Baked … Worked. Restore Sautéed.
past() {
  strings -n 4 "$BIN" \
    | awk '/^Baked$/{g=1} g{print} /^Worked$/{if(g)exit}' \
    | sed 's/^Saut$/Sautéed/' \
    | sort -u
}

# Startup tips. IMPORTANT: tips are NOT stored with a "Tip: " prefix (the
# renderer adds it), so `grep '^Tip: '` misses them. The real tips live in a
# contiguous text region (first tip → the `tipsHistory` config key) and are
# RECONSTRUCTED into complete sentences here, handling four complications:
#   1. No "Tip: " prefix     → slice the region by content anchors.
#   2. Runtime assembly      → each tip = several fragments with a value spliced
#      in ("Hit " + key + " to cycle…"). We walk the region in byte order and
#      join fragments, treating a Capitalized fragment as a new tip boundary,
#      slugs/garbage as separators, and dropping render markers.
#   3. Mixed encodings       → some tips (plugin-disuse, team-onboarding) are
#      UTF-16LE; we decode BOTH ASCII and UTF-16 and merge by byte offset.
#   4. Em-dash clauses       → a clause after a non-printable em-dash starts on
#      its own; we fold lowercase/quote-leading lines back onto the previous tip.
# Result: one complete sentence per line. A few tips with purely dynamic values
# (a credit amount, an editor binary) show a small gap where that value would be.
# See TIPS.md for the grouped, annotated reference.
#
# Two QA anchors guard the two decode paths (asserted by tips_check):
TIPS_QA_ANCHOR='to cycle between default mode'        # ASCII  (shift+tab tip)
TIPS_QA_ANCHOR_UTF16='startup and context cost'       # UTF-16 (plugin-disuse tip)
tips() {
  perl -0777 -e '
    open(my $fh, "<:raw", $ARGV[0]) or die; local $/; my $d = <$fh>;
    my $s = index($d, "New to Claude Code? Run", 190000000); exit 0 if $s < 0;
    my $e = index($d, "tipsHistory", $s); $e = length($d) if $e < 0;
    my $r = substr($d, $s, $e - $s);
    my @tok;
    while ($r =~ /([\x20-\x7e]{2,})/g)         { push @tok, [pos($r)-length($1), $1]; }       # ASCII
    while ($r =~ /((?:[\x20-\x7e]\x00){2,})/g) { my $x=$1; (my $t=$x)=~s/\x00//g;
                                                 push @tok, [pos($r)-length($x), $t]; }        # UTF-16LE
    @tok = sort { $a->[0] <=> $b->[0] } @tok;
    sub cls {                                          # classify a token
      my $t = shift;
      return "m" if $t =~ /^(suggestion|chat:cycleMode|chat:imagePaste|Chat)$/; # render marker
      return "v" if $t =~ m{^\s*/[a-z][\w-]*\s*$};                              # slash command
      return "v" if $t =~ /^[a-z]{2,8}\+[a-z]{1,8}$/;                           # keybinding
      return "v" if $t =~ m{(clau\.de|claude\.(ai|com)|https?://)};            # url
      return "C" if $t =~ /^\s*[A-Z]/ && $t =~ /[a-z]/ && $t =~ /\s/;          # new-sentence start
      return "t" if $t =~ /[a-z]/ && ($t =~ /\s/ || $t =~ /^[\s\x27"]/);       # continuation fragment
      return "s";                                                              # separator (slug/garbage)
    }
    my (@buf, @out);
    sub fl { return unless @buf; my $l = join("", @buf);
             $l =~ s/\s+/ /g; $l =~ s/^\s+|\s+$//g; push @out, $l if length($l) >= 12; @buf=(); }
    for my $k (@tok) { my $c = cls($k->[1]);
      next            if $c eq "m";
      if    ($c eq "s") { fl(); }
      elsif ($c eq "C") { fl(); push @buf, $k->[1]; }
      else              { push @buf, $k->[1]; }
    }
    fl();
    my @mg;                                            # fold em-dash continuation clauses
    for my $l (@out) {
      if    (@mg && $l =~ /^[a-z]/)     { $mg[-1] .= " \x{2014} " . $l; }
      elsif (@mg && $l =~ /^[\x27"]/)   { $mg[-1] .= " " . $l; }
      else                              { push @mg, $l; }
    }
    @mg = grep { !/\\b|\[\^|\*\*\//
              && !/Cannot destructure|null or undefined|Failed to check|can\x27t auto-update/
              && !/^(off|on|warn|closed|text|low|high|dark|startup|upsell|plugin suggestion)/ } @mg;
    my %seen; @mg = grep { !$seen{$_}++ } @mg;          # dedup (binary stores some twice)
    binmode STDOUT, ":utf8";
    print "$_\n" for @mg;
  ' "$BIN"
}

# Verify both QA anchors are present; warn to stderr (and fail) if not.
tips_check() {
  local out; out="$(tips)"
  local ok=1
  grep -qF "$TIPS_QA_ANCHOR"       <<<"$out" || { echo "# tips QA: FAILED — ASCII anchor '$TIPS_QA_ANCHOR' missing (region anchors may have moved)" >&2; ok=0; }
  grep -qF "$TIPS_QA_ANCHOR_UTF16" <<<"$out" || { echo "# tips QA: FAILED — UTF-16 anchor '$TIPS_QA_ANCHOR_UTF16' missing (16-bit decode may have broken)" >&2; ok=0; }
  [ "$ok" = 1 ] && echo "# tips QA: OK (ASCII + UTF-16 anchors present)" >&2
  [ "$ok" = 1 ]
}

emit() {  # $1 = function name, $2 = header (only used when MODE=all)
  if [[ -n "${2:-}" ]]; then echo "## $2"; fi
  if [[ "$PLAIN" -eq 1 ]]; then "$1"; else "$1" | nl -w3 -s'. '; fi
  if [[ -n "${2:-}" ]]; then echo; fi
}

echo "# Source binary: ${BIN}" >&2
case "$MODE" in
  present) emit present ;;
  past)    emit past ;;
  tips)    emit tips; tips_check || true ;;
  all)     emit present "Spinner verbs (present tense)"
           emit past    "Completion verbs (past tense)"
           emit tips    "Startup tips"; tips_check || true ;;
esac
