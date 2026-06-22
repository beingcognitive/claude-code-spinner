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

# Startup tips. IMPORTANT: tips are NOT stored with a "Tip: " prefix — that's
# added by the renderer. A naive `grep '^Tip: '` misses the real tips entirely.
# The genuine tips live in a contiguous text region (from the first tip to the
# `tipsHistory` config key). Three things make a clean extraction hard, and this
# function handles all three:
#   1. No "Tip: " prefix          → slice the region by content anchors.
#   2. Runtime-assembled tips      → keep FILE ORDER (sorting scrambles the
#      ("Hit " + key + " to cycle…")  fragments and the list looks truncated).
#   3. MIXED ENCODINGS             → most tips are single-byte ASCII, but a few
#      (plugin-disuse, team-onboarding) are UTF-16LE, so an ASCII-only `strings`
#      drops their tails. We decode BOTH and merge by byte offset.
# Output is still fragmentary by nature (assembled tips span several lines) —
# see TIPS.md for the fully reconstructed, complete sentences.
#
# QA anchor: the "shift+tab … cycle between default mode" tip MUST appear here.
# Two anchors guard the two extraction paths:
#   ASCII  — the visible shift+tab tip
#   UTF-16 — a plugin-disuse tip (proves the 16-bit decode still works)
TIPS_QA_ANCHOR='to cycle between default mode'
TIPS_QA_ANCHOR_UTF16='startup and context cost'
tips() {
  # Dual-encoding, offset-ordered extraction of the tips region.
  perl -0777 -e '
    open(my $fh, "<:raw", $ARGV[0]) or die; local $/; my $data = <$fh>;
    my $start = index($data, "New to Claude Code? Run", 190_000_000);
    exit 0 if $start < 0;
    my $end = index($data, "tipsHistory", $start); $end = length($data) if $end < 0;
    my $r = substr($data, $start, $end - $start);
    my @hits;
    while ($r =~ /([\x20-\x7e]{6,})/g)            { push @hits, [pos($r)-length($1), $1]; }       # ASCII
    while ($r =~ /((?:[\x20-\x7e]\x00){6,})/g)    { my $s=$1; (my $t=$s)=~s/\x00//g;
                                                    push @hits, [pos($r)-length($s), $t]; }        # UTF-16LE
    @hits = sort { $a->[0] <=> $b->[0] } @hits;
    print "$_->[1]\n" for @hits;
  ' "$BIN" \
    | grep -aE '[a-z].* [a-z]' \
    | grep -avE '^[a-z0-9]+([-_/:][a-z0-9]+)*$' \
    | grep -avE '^https?://|^/[a-z]|^suggestion$|^the Claude mobile app$' \
    | grep -avE '\\b|\[\^|fs/promises|\.claude/|\.json$|\.lock$' \
    | grep -avE 'Cannot destructure|null or undefined|^Failed to |auto-update'
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
