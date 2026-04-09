#!/bin/zsh

PLIST_PATH="$HOME/Library/LaunchAgents/com.azai.tokenpet.desktop.plist"

launchctl unload "$PLIST_PATH" >/dev/null 2>&1 || true
rm -f "$PLIST_PATH"
echo "Removed autostart: $PLIST_PATH"
