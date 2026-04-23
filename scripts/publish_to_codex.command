#!/bin/zsh

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
PLUGIN_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
PLUGIN_NAME="azai-token-pet"
PLUGIN_VERSION="$(PLUGIN_DIR="$PLUGIN_DIR" python3 - <<'PY'
import json
import os
from pathlib import Path

plugin_json = Path(os.environ["PLUGIN_DIR"]) / ".codex-plugin" / "plugin.json"
print(json.loads(plugin_json.read_text(encoding="utf-8"))["version"])
PY
)"
HOME_PLUGIN_ROOT="$HOME/plugins"
TARGET_PLUGIN_PATH="$HOME_PLUGIN_ROOT/$PLUGIN_NAME"
MARKETPLACE_DIR="$HOME/.agents/plugins"
MARKETPLACE_PATH="$MARKETPLACE_DIR/marketplace.json"
CODEX_CACHE_ROOT="$HOME/.codex/plugins/cache/azai-lab/$PLUGIN_NAME/local"
OFFICIAL_RELEASE_ARCHIVE_REL="builds/azai-token-pet-v${PLUGIN_VERSION}-codex-macos.zip"
LEGACY_PREVIEW_ARCHIVE_REL="builds/azai-token-pet-v0.1.0-dev-preview-codex-macos.zip"
LEGACY_PREVIEW_DIR_REL="builds/azai-token-pet-v0.1.0-dev-preview-codex-macos"

mkdir -p "$HOME_PLUGIN_ROOT"
mkdir -p "$MARKETPLACE_DIR"

if [[ -L "$TARGET_PLUGIN_PATH" ]]; then
  CURRENT_TARGET="$(readlink "$TARGET_PLUGIN_PATH")"
  if [[ "$CURRENT_TARGET" != "$PLUGIN_DIR" ]]; then
    rm -f "$TARGET_PLUGIN_PATH"
    ln -s "$PLUGIN_DIR" "$TARGET_PLUGIN_PATH"
  fi
elif [[ -e "$TARGET_PLUGIN_PATH" ]]; then
  echo "Codex plugin path already exists and is not a symlink:"
  echo "$TARGET_PLUGIN_PATH"
  echo "Please move it away before publishing this build."
  exit 1
else
  ln -s "$PLUGIN_DIR" "$TARGET_PLUGIN_PATH"
fi

MARKETPLACE_PATH="$MARKETPLACE_PATH" python3 - <<'PY'
import json
import os
from pathlib import Path

marketplace_path = Path(os.environ["MARKETPLACE_PATH"])
entry = {
    "name": "azai-token-pet",
    "source": {
        "source": "local",
        "path": "./plugins/azai-token-pet"
    },
    "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
    },
    "category": "Productivity"
}

if marketplace_path.exists():
    data = json.loads(marketplace_path.read_text(encoding="utf-8"))
else:
    data = {
        "name": "azai-local",
        "interface": {
            "displayName": "阿在本地插件"
        },
        "plugins": []
    }

plugins = data.setdefault("plugins", [])
replaced = False
for index, plugin in enumerate(plugins):
    if plugin.get("name") == "azai-token-pet":
        plugins[index] = entry
        replaced = True
        break

if not replaced:
    plugins.append(entry)

marketplace_path.write_text(
    json.dumps(data, ensure_ascii=False, indent=2) + "\n",
    encoding="utf-8"
)
PY

mkdir -p "$CODEX_CACHE_ROOT"
rm -rf "$CODEX_CACHE_ROOT/$LEGACY_PREVIEW_ARCHIVE_REL" "$CODEX_CACHE_ROOT/$LEGACY_PREVIEW_DIR_REL"

copy_into_cache() {
  local source_rel="$1"
  local source_path="$PLUGIN_DIR/$source_rel"
  local target_path="$CODEX_CACHE_ROOT/$source_rel"
  mkdir -p "$(dirname -- "$target_path")"
  rm -rf "$target_path"
  if [[ -d "$source_path" ]]; then
    cp -R "$source_path" "$target_path"
  else
    cp "$source_path" "$target_path"
  fi
}

copy_optional_into_cache() {
  local source_rel="$1"
  local source_path="$PLUGIN_DIR/$source_rel"
  if [[ -e "$source_path" ]]; then
    copy_into_cache "$source_rel"
  fi
}

copy_into_cache ".codex-plugin"
copy_into_cache ".app.json"
copy_into_cache "README.md"
copy_into_cache "assets"
copy_into_cache "demo"
copy_into_cache "start.command"
copy_into_cache "stop.command"
copy_into_cache "reset.command"
copy_into_cache "scripts"
copy_into_cache "docs"
copy_into_cache "runtime/azai-token-pet-desktop"
copy_optional_into_cache "$OFFICIAL_RELEASE_ARCHIVE_REL"

echo "Published 吞金兽 Token Pet to Codex local marketplace."
echo "Plugin path: $TARGET_PLUGIN_PATH"
echo "Marketplace: $MARKETPLACE_PATH"
echo "Codex cache: $CODEX_CACHE_ROOT"
echo "Release archive: $PLUGIN_DIR/$OFFICIAL_RELEASE_ARCHIVE_REL"
echo "Start: $TARGET_PLUGIN_PATH/start.command"
echo "Stop: $TARGET_PLUGIN_PATH/stop.command"
echo "Reset: $TARGET_PLUGIN_PATH/reset.command"
