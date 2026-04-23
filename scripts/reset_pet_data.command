#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
RUNTIME_DIR="$SCRIPT_DIR/../runtime"

"$SCRIPT_DIR/stop_desktop_pet.command"

rm -f "$RUNTIME_DIR/pet-state.json"
rm -f "$RUNTIME_DIR/pet-config.json"
rm -f "$RUNTIME_DIR/codex-feed.json"
rm -f "$RUNTIME_DIR/external-feed.json"
rm -f "$RUNTIME_DIR/codex-bridge-state.json"
rm -f "$RUNTIME_DIR/codex-bridge.pid"
rm -f "$RUNTIME_DIR/desktop-pet.pid"

echo "Reset 吞金兽 Token Pet runtime data."
echo "Run scripts/launch_desktop_pet.command to generate a fresh pet."
