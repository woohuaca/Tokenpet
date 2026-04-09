#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
RUNTIME_DIR="$SCRIPT_DIR/../runtime"
BIN_PATH="$RUNTIME_DIR/azai-token-pet-desktop"
SOURCE_PATH="$SCRIPT_DIR/desktop_pet.swift"
PROFILE_PATH="$SCRIPT_DIR/nutrition-profile.json"
MODULE_CACHE_PATH="${TMPDIR:-/tmp}/azai-token-pet-clang-cache"
PET_PID_PATH="$RUNTIME_DIR/desktop-pet.pid"
PET_LOG_PATH="$RUNTIME_DIR/desktop-pet.log"

mkdir -p "$RUNTIME_DIR"
mkdir -p "$MODULE_CACHE_PATH"

cleanup_pid_file() {
  local pid_path="$1"
  if [[ -f "$pid_path" ]]; then
    local existing_pid
    existing_pid="$(cat "$pid_path" 2>/dev/null)"
    if [[ -z "$existing_pid" ]] || ! kill -0 "$existing_pid" >/dev/null 2>&1; then
      rm -f "$pid_path"
    fi
  fi
}

wait_for_pid_file() {
  local pid_path="$1"
  local attempts="${2:-20}"
  local interval="${3:-0.2}"
  local candidate_pid

  for ((i = 0; i < attempts; i++)); do
    if [[ -f "$pid_path" ]]; then
      candidate_pid="$(cat "$pid_path" 2>/dev/null | tr -d '[:space:]')"
      if [[ -n "$candidate_pid" ]]; then
        return 0
      fi
    fi
    sleep "$interval"
  done

  return 1
}

wait_for_process_exit() {
  local pattern="$1"
  local attempts=0
  while pgrep -f "$pattern" >/dev/null 2>&1; do
    sleep 0.2
    attempts=$((attempts + 1))
    if [[ "$attempts" -ge 25 ]]; then
      pkill -9 -f "$pattern" >/dev/null 2>&1 || true
      break
    fi
  done
}

cleanup_pid_file "$PET_PID_PATH"

resolve_swift_sdk() {
  local target_line=""
  local sdk_path=""

  target_line="$(swiftc -version 2>/dev/null | sed -n 's/^Target: .*macosx\([0-9][0-9]*\)\..*$/\1/p' | head -n 1)"
  if [[ -n "$target_line" ]]; then
    sdk_path="/Library/Developer/CommandLineTools/SDKs/MacOSX${target_line}.sdk"
    if [[ -d "$sdk_path" ]]; then
      echo "$sdk_path"
      return 0
    fi
  fi

  xcrun --show-sdk-path
}

if [[ ! -x "$BIN_PATH" || "$SOURCE_PATH" -nt "$BIN_PATH" || "$PROFILE_PATH" -nt "$BIN_PATH" ]]; then
  SDK_PATH="$(resolve_swift_sdk)"
  CLANG_MODULE_CACHE_PATH="$MODULE_CACHE_PATH" xcrun swiftc -sdk "$SDK_PATH" -framework AppKit "$SOURCE_PATH" -o "$BIN_PATH"
fi

if [[ -f "$PET_PID_PATH" ]]; then
  EXISTING_PET_PID="$(cat "$PET_PID_PATH" 2>/dev/null)"
  if [[ -n "$EXISTING_PET_PID" ]] && kill -0 "$EXISTING_PET_PID" >/dev/null 2>&1; then
    kill "$EXISTING_PET_PID" >/dev/null 2>&1 || true
  fi
fi

pkill -f "$BIN_PATH" >/dev/null 2>&1 || true
wait_for_process_exit "$BIN_PATH"
rm -f "$PET_PID_PATH"

sleep 1
if ! open "$BIN_PATH" >/dev/null 2>&1; then
  nohup "$BIN_PATH" >> "$PET_LOG_PATH" 2>&1 &
fi
rm -f "$PET_PID_PATH"

if wait_for_pid_file "$PET_PID_PATH" 25 0.2; then
  exit 0
fi

ACTUAL_PET_PID="$(pgrep -f "$BIN_PATH" | tail -n 1)"
if [[ -n "$ACTUAL_PET_PID" ]]; then
  echo "$ACTUAL_PET_PID" > "$PET_PID_PATH"
  exit 0
fi

exit 1
