#!/usr/bin/env bash
#
# extract.sh — Pull the full list of Claude Code "spinner" verbs out of the
# installed CLI binary and print them as a clean, numbered, alphabetical list.
#
# These are the whimsical present-tense verbs (Thinking…, Pondering…, Brewing…)
# that Claude Code shows at the bottom of the screen while it works. They are
# baked into the compiled binary as a contiguous, alphabetically-sorted array of
# plain strings — from "Accomplishing" to "Zigzagging" — so we slice out exactly
# that block and tidy it up.
#
# Usage:
#   ./extract.sh                       # auto-detect newest installed version
#   ./extract.sh /path/to/claude/bin   # point at a specific binary
#
set -euo pipefail

# 1) Locate the Claude Code binary -------------------------------------------
BIN="${1:-}"
if [[ -z "${BIN}" ]]; then
  # Newest version under the standard install location
  BIN="$(ls -1d "$HOME"/.local/share/claude/versions/* 2>/dev/null | sort -V | tail -1 || true)"
fi
if [[ -z "${BIN}" || ! -f "${BIN}" ]]; then
  echo "Could not find the Claude Code binary." >&2
  echo "Pass it explicitly:  ./extract.sh /path/to/claude/versions/<ver>" >&2
  exit 1
fi
echo "# Source binary: ${BIN}" >&2

# 2) Slice out the contiguous spinner block, clean, number -------------------
#    - `strings` dumps every embedded string in file order.
#    - `awk` keeps the first contiguous run from Accomplishing … Zigzagging.
#    - Accented words get truncated by `strings` (multi-byte é), so restore the
#      two known ones: Flamb -> Flambéing, Saut -> Sautéing.
#    - `sort -u` de-duplicates (the binary stores two copies) and orders them.
strings -n 4 "${BIN}" \
  | awk '/^Accomplishing$/ {grab=1} grab {print} /^Zigzagging$/ {if (grab) exit}' \
  | sed 's/^Flamb$/Flambéing/; s/^Saut$/Sautéing/' \
  | sort -u \
  | nl -w3 -s'. '
