#!/usr/bin/env bash
#
# auto-snapshot.sh — unattended snapshot runner (for cron / launchd).
#
# Runs snapshot.sh over the installed Claude Code versions, refreshes the
# "latest" words.txt, and — only if something actually changed (a new version
# folder, or a moved word/tip) — commits and pushes.
#
# Designed to be safe to run on a schedule:
#   • commits ONLY the archive + generated files (versions/, words.txt)
#   • no-ops silently when there's nothing new
#   • all output is appended to auto-snapshot.log (gitignored)
#
# Install via launchd (macOS) — see install-schedule.sh.
#
set -eu

# launchd gives a minimal PATH; make sure tools resolve.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"
LOG="$HERE/auto-snapshot.log"
ts() { date '+%Y-%m-%d %H:%M:%S'; }

{
  echo "----- $(ts) auto-snapshot start -----"

  # Stay in sync with the remote (best effort; don't abort on failure).
  git pull --quiet --rebase --autostash origin main 2>&1 || echo "warn: git pull failed, continuing"

  # Rebuild the per-version archive from installed binaries.
  ./snapshot.sh 2>&1

  # Refresh the "latest" words.txt from the newest snapshot, if any.
  NEWEST="$(ls -1d versions/*/ 2>/dev/null | sort -V | tail -1 || true)"
  if [[ -n "$NEWEST" && -f "${NEWEST}spinner.txt" ]]; then
    cp "${NEWEST}spinner.txt" words.txt
  fi

  # Stage only the data we own.
  git add versions words.txt 2>/dev/null || true

  if git diff --cached --quiet; then
    echo "$(ts): no changes — nothing to commit"
    echo "----- $(ts) auto-snapshot end -----"
    exit 0
  fi

  # Describe which versions are involved in this change.
  CHANGED_VERS="$(git diff --cached --name-only | grep '^versions/' | cut -d/ -f2 | sort -u | tr '\n' ' ' || true)"
  echo "$(ts): changes detected in versions: ${CHANGED_VERS:-<words.txt only>}"

  git commit -q -m "chore: auto-snapshot $(date +%Y-%m-%d) — versions: ${CHANGED_VERS:-words.txt}

Automated snapshot of Claude Code UI word lists. If a word/tip actually moved,
update CHANGELOG.md with a human-written diff note."

  if git push -q origin main 2>&1; then
    echo "$(ts): pushed"
  else
    echo "$(ts): push FAILED (committed locally; will retry next run)"
  fi

  echo "----- $(ts) auto-snapshot end -----"
} >> "$LOG" 2>&1
