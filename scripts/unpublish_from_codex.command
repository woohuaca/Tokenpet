#!/bin/zsh

set -euo pipefail

PLUGIN_NAME="azai-token-pet"
TARGET_PLUGIN_PATH="$HOME/plugins/$PLUGIN_NAME"
MARKETPLACE_PATH="$HOME/.agents/plugins/marketplace.json"
CODEX_CACHE_ROOT="$HOME/.codex/plugins/cache/azai-lab/$PLUGIN_NAME"

if [[ -L "$TARGET_PLUGIN_PATH" ]]; then
  rm -f "$TARGET_PLUGIN_PATH"
fi

if [[ -f "$MARKETPLACE_PATH" ]]; then
  MARKETPLACE_PATH="$MARKETPLACE_PATH" python3 - <<'PY'
import json
import os
from pathlib import Path

marketplace_path = Path(os.environ["MARKETPLACE_PATH"])
data = json.loads(marketplace_path.read_text(encoding="utf-8"))
plugins = data.get("plugins", [])
data["plugins"] = [plugin for plugin in plugins if plugin.get("name") != "azai-token-pet"]
marketplace_path.write_text(
    json.dumps(data, ensure_ascii=False, indent=2) + "\n",
    encoding="utf-8"
)
PY
fi

rm -rf "$CODEX_CACHE_ROOT"

echo "Removed 阿在 Token Pet from Codex local marketplace."
