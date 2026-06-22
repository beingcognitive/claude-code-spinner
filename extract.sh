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
# added by the renderer. A naive `grep '^Tip: '` misses the real tips entirely
# (it only catches a few incidental, unrelated "Tip:" strings). The genuine tips
# live in a contiguous text array; we slice the region from the first tip to the
# config-key block, then drop the obvious non-tips (telemetry slugs, config
# keys, URLs, error messages). Some tips are assembled at runtime from a
# keybinding + fragment, so leading-space fragments are kept (faithful but ugly)
# — see TIPS.md for the curated, reconstructed list.
#
# QA anchor: the "shift+tab … cycle between default mode" tip MUST appear here.
# If a future version breaks the region anchors, that assertion fails loudly.
TIPS_QA_ANCHOR='to cycle between default mode'
tips() {
  # IMPORTANT: keep FILE ORDER (no sort). Tips are assembled from consecutive
  # fragments ("Hit " + keybinding + " to cycle…"); sorting scrambles them so
  # the list looks broken from line 1. Order-preserving output keeps each tip's
  # fragments adjacent. The raw output is still fragmentary by nature — see
  # TIPS.md for the fully reconstructed, complete sentences.
  strings -n 6 "$BIN" \
    | awk '/New to Claude Code\? Run/{g=1} g{print} /^tipsHistory$/{if(g)exit}' \
    | grep -aE '[a-z].* [a-z]' \
    | grep -avE '^[a-z0-9]+([-_/:][a-z0-9]+)*$' \
    | grep -avE '^https?://|^/[a-z]|^suggestion$|^the Claude mobile app$' \
    | grep -avE '\\b|\[\^|fs/promises|\.claude/|\.json$|\.lock$' \
    | grep -avE 'Cannot destructure|null or undefined|^Failed to |auto-update'
}

# Verify the QA anchor is present; print a warning to stderr if not.
tips_check() {
  if tips | grep -qF "$TIPS_QA_ANCHOR"; then
    echo "# tips QA: OK (shift+tab tip present)" >&2
  else
    echo "# tips QA: FAILED — '$TIPS_QA_ANCHOR' not found; region anchors may have moved" >&2
    return 1
  fi
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
