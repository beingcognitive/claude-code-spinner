#!/usr/bin/env bash
#
# snapshot.sh — Build the per-version archive under ./versions/.
#
# For every installed Claude Code version (or a binary you pass), this writes:
#
#   versions/<ver>/spinner.txt   present-tense spinner verbs
#   versions/<ver>/past.txt      past-tense completion verbs
#   versions/<ver>/tips.txt      startup "Tip:" lines
#
# Re-run it after upgrading Claude Code to capture a new version, then commit
# the new versions/<ver>/ folder. Over time this becomes a history of how the
# Claude Code UI vocabulary evolves.
#
# Usage:
#   ./snapshot.sh                 # snapshot every installed version
#   ./snapshot.sh 2.1.185 ...     # snapshot specific installed versions
#
set -eu

HERE="$(cd "$(dirname "$0")" && pwd)"
VERS_DIR="$HOME/.local/share/claude/versions"

# Which versions?
if [[ "$#" -gt 0 ]]; then
  VERSIONS=("$@")
else
  VERSIONS=()
  for d in "$VERS_DIR"/*; do [[ -f "$d" ]] && VERSIONS+=("$(basename "$d")"); done
fi

for v in "${VERSIONS[@]}"; do
  BIN="$VERS_DIR/$v"
  if [[ ! -f "$BIN" ]]; then
    echo "skip: $v (no binary at $BIN)" >&2
    continue
  fi
  OUT="$HERE/versions/$v"
  mkdir -p "$OUT"
  "$HERE/extract.sh" --present --plain "$BIN" 2>/dev/null > "$OUT/spinner.txt"
  "$HERE/extract.sh" --past    --plain "$BIN" 2>/dev/null > "$OUT/past.txt"
  "$HERE/extract.sh" --tips    --plain "$BIN" 2>/dev/null > "$OUT/tips.txt"
  printf "%-9s  spinner=%s  past=%s  tips=%s\n" "$v" \
    "$(grep -c . "$OUT/spinner.txt")" \
    "$(grep -c . "$OUT/past.txt")" \
    "$(grep -c . "$OUT/tips.txt")"
done
