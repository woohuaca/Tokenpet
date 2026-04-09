#!/bin/zsh

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
PLUGIN_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
BUILD_ROOT="$PLUGIN_DIR/builds"
PLUGIN_VERSION="$(PLUGIN_DIR="$PLUGIN_DIR" python3 - <<'PY'
import json
import os
from pathlib import Path

plugin_json = Path(os.environ["PLUGIN_DIR"]) / ".codex-plugin" / "plugin.json"
print(json.loads(plugin_json.read_text(encoding="utf-8"))["version"])
PY
)"
CHANNEL="codex-macos"
RELEASE_NAME="azai-token-pet-v${PLUGIN_VERSION}-${CHANNEL}"
STAGE_DIR="$BUILD_ROOT/$RELEASE_NAME"
ARCHIVE_PATH="$BUILD_ROOT/${RELEASE_NAME}.zip"
RUNTIME_DIR="$PLUGIN_DIR/runtime"
BIN_PATH="$RUNTIME_DIR/azai-token-pet-desktop"
SOURCE_PATH="$SCRIPT_DIR/desktop_pet.swift"
PROFILE_PATH="$SCRIPT_DIR/nutrition-profile.json"
MODULE_CACHE_PATH="${TMPDIR:-/tmp}/azai-token-pet-clang-cache"

mkdir -p "$BUILD_ROOT"
mkdir -p "$RUNTIME_DIR"
mkdir -p "$MODULE_CACHE_PATH"

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

rm -rf "$STAGE_DIR" "$ARCHIVE_PATH"
mkdir -p "$STAGE_DIR"

copy_into_stage() {
  local source_rel="$1"
  local source_path="$PLUGIN_DIR/$source_rel"
  local target_path="$STAGE_DIR/$source_rel"
  mkdir -p "$(dirname -- "$target_path")"
  if [[ -d "$source_path" ]]; then
    cp -R "$source_path" "$target_path"
  else
    cp "$source_path" "$target_path"
  fi
}

copy_into_stage ".codex-plugin"
copy_into_stage ".app.json"
copy_into_stage "README.md"
copy_into_stage "demo"
copy_into_stage "start.command"
copy_into_stage "stop.command"
copy_into_stage "reset.command"
copy_into_stage "assets"
copy_into_stage "scripts/codex_usage_bridge.py"
copy_into_stage "scripts/desktop_pet.swift"
copy_into_stage "scripts/nutrition-profile.json"
copy_into_stage "scripts/launch_desktop_pet.command"
copy_into_stage "scripts/stop_desktop_pet.command"
copy_into_stage "scripts/reset_pet_data.command"
copy_into_stage "scripts/publish_to_codex.command"
copy_into_stage "scripts/unpublish_from_codex.command"
copy_into_stage "scripts/install_autostart.command"
copy_into_stage "scripts/uninstall_autostart.command"
copy_into_stage "runtime/azai-token-pet-desktop"
copy_into_stage "docs/v1-private-beta-quickstart.md"
copy_into_stage "docs/v1-release-plan.md"
copy_into_stage "docs/v1-codex-release-notes.md"
copy_into_stage "docs/v1-codex-publish.md"
copy_into_stage "docs/v1-known-limitations-and-feedback.md"

cat > "$STAGE_DIR/RELEASE.txt" <<EOF
阿在 Token Pet
Version: v${PLUGIN_VERSION}
Channel: $CHANNEL
Bundle: $RELEASE_NAME

发布定位:
- Codex 首发正式版
- macOS companion
- 本地插件入口 + 桌面 companion

启动:
- start.command
- scripts/launch_desktop_pet.command

关闭:
- stop.command
- scripts/stop_desktop_pet.command

重置:
- reset.command
- scripts/reset_pet_data.command
EOF

cd "$BUILD_ROOT"
ditto -c -k --sequesterRsrc --keepParent "$RELEASE_NAME" "$ARCHIVE_PATH"

echo "Built Codex release bundle:"
echo "$ARCHIVE_PATH"
