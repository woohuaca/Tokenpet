#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
RUNTIME_DIR="$SCRIPT_DIR/../runtime"
BIN_PATH="$RUNTIME_DIR/azai-token-pet-desktop"
BRIDGE_PATH="$SCRIPT_DIR/codex_usage_bridge.py"
BRIDGE_PID_PATH="$RUNTIME_DIR/codex-bridge.pid"
PET_PID_PATH="$RUNTIME_DIR/desktop-pet.pid"

stop_pid_file() {
  local pid_path="$1"
  if [[ -f "$pid_path" ]]; then
    local pid
    pid="$(cat "$pid_path" 2>/dev/null)"
    if [[ -n "$pid" ]] && kill -0 "$pid" >/dev/null 2>&1; then
      kill "$pid" >/dev/null 2>&1 || true
    fi
    rm -f "$pid_path"
  fi
}

wait_for_pattern_exit() {
  local pattern="$1"
  local attempts="${2:-15}"

  for ((i = 0; i < attempts; i++)); do
    pgrep -f "$pattern" >/dev/null 2>&1 || return 0
    sleep 0.2
  done

  return 1
}

stop_pid_file "$BRIDGE_PID_PATH"
stop_pid_file "$PET_PID_PATH"

pkill -f "$BIN_PATH" >/dev/null 2>&1 || true
pkill -f "$BRIDGE_PATH" >/dev/null 2>&1 || true

wait_for_pattern_exit "$BIN_PATH" 15 || true
wait_for_pattern_exit "$BRIDGE_PATH" 15 || true

pkill -9 -f "$BIN_PATH" >/dev/null 2>&1 || true
pkill -9 -f "$BRIDGE_PATH" >/dev/null 2>&1 || true

wait_for_pattern_exit "$BIN_PATH" 10 || true
wait_for_pattern_exit "$BRIDGE_PATH" 10 || true

rm -f "$PET_PID_PATH" "$BRIDGE_PID_PATH"

echo "Stopped 阿在 Token Pet and bridge."
