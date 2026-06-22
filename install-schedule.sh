#!/usr/bin/env bash
#
# install-schedule.sh — install (or remove) the daily launchd job that runs
# auto-snapshot.sh on macOS.
#
# Usage:
#   ./install-schedule.sh            # install + load (runs daily at 10:00)
#   ./install-schedule.sh --hour 9   # install at a different hour (0-23)
#   ./install-schedule.sh --uninstall
#
set -eu

LABEL="com.beingcognitive.claude-spinner-snapshot"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
HERE="$(cd "$(dirname "$0")" && pwd)"
HOUR=10

while [[ "${1:-}" ]]; do
  case "$1" in
    --hour) HOUR="$2"; shift 2 ;;
    --uninstall)
      launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || launchctl unload "$PLIST" 2>/dev/null || true
      rm -f "$PLIST"
      echo "Uninstalled $LABEL"
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

mkdir -p "$(dirname "$PLIST")"
cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$HERE/auto-snapshot.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>$HOUR</integer>
    <key>Minute</key><integer>0</integer>
  </dict>
  <key>RunAtLoad</key>
  <false/>
  <key>StandardOutPath</key>
  <string>$HERE/auto-snapshot.log</string>
  <key>StandardErrorPath</key>
  <string>$HERE/auto-snapshot.log</string>
</dict>
</plist>
PLIST

# Reload cleanly.
launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST" 2>/dev/null \
  || launchctl load "$PLIST"

echo "Installed $LABEL — runs daily at ${HOUR}:00"
echo "Plist: $PLIST"
echo "Run now to test:  launchctl kickstart -k gui/$(id -u)/$LABEL"
