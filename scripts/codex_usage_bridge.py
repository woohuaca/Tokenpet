#!/usr/bin/env python3

import json
import os
import time
from datetime import datetime, timezone
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
PLUGIN_DIR = SCRIPT_DIR.parent
RUNTIME_DIR = PLUGIN_DIR / "runtime"
RUNTIME_DIR.mkdir(parents=True, exist_ok=True)

SESSIONS_ROOT = Path.home() / ".codex" / "sessions"
STATE_PATH = RUNTIME_DIR / "codex-bridge-state.json"
FEED_PATH = RUNTIME_DIR / "codex-feed.json"
PID_PATH = RUNTIME_DIR / "codex-bridge.pid"


KEYWORD_GROUPS = {
    "coding": [
        "代码", "插件", "脚本", "运行", "编译", "修复", "前端", "后端", "swift",
        "python", "js", "javascript", "typescript", "cursor", "codex", "cc", "桌宠",
        "ui", "界面", "bug", "功能"
    ],
    "writing": [
        "README", "文档", "说明", "草案", "charter", "介绍", "描述", "文案", "markdown"
    ],
    "research": [
        "研究", "调研", "参考", "分析", "对比", "看看", "找一下", "查一下"
    ],
    "review": [
        "评审", "review", "检查", "审阅", "风险", "找问题"
    ],
    "planning": [
        "计划", "路线图", "下一步", "方案", "设计", "规划", "mvp"
    ],
    "meeting": [
        "会议", "同步", "讨论会", "纪要"
    ],
    "support": [
        "打开", "帮我", "本地", "看看效果", "安装", "启动"
    ],
}


def utc_now():
    return datetime.now(timezone.utc).isoformat()


def default_state():
    return {
        "session_path": None,
        "offset": 0,
        "last_total_tokens": 0,
        "last_user_text": "",
        "last_cwd": "",
        "initialized": False,
    }


def load_json(path, fallback):
    if path.exists():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            return fallback
    return fallback


def save_json(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def find_latest_session():
    candidates = list(SESSIONS_ROOT.rglob("*.jsonl"))
    if not candidates:
        return None
    return max(candidates, key=lambda item: item.stat().st_mtime)


def extract_text_from_message(payload):
    parts = payload.get("content", [])
    values = []
    for part in parts:
        if part.get("type") in {"input_text", "output_text"}:
            values.append(part.get("text", ""))
    return "\n".join(values).strip()


def is_meaningful_user_text(text):
    stripped = (text or "").strip()
    if len(stripped) < 4:
        return False
    if stripped.isdigit():
        return False
    return True


def classify_task(text, cwd):
    haystack = f"{text}\n{cwd}".lower()

    if "charter" in haystack or "README".lower() in haystack or "markdown" in haystack:
        return "writing"

    for task_type, keywords in KEYWORD_GROUPS.items():
        for keyword in keywords:
            if keyword.lower() in haystack:
                return task_type

    if any(token in haystack for token in [".py", ".js", ".ts", "plugin", "runtime", "scripts"]):
        return "coding"

    return "coding"


def classify_quality(task_type, last_usage):
    total_tokens = (last_usage or {}).get("total_tokens", 0)
    output_tokens = (last_usage or {}).get("output_tokens", 0)
    reasoning_tokens = (last_usage or {}).get("reasoning_output_tokens", 0)

    if task_type == "idle":
        return "waste"
    if task_type == "meeting":
        return "partial"
    if output_tokens + reasoning_tokens > 5000 or total_tokens > 90000:
        return "breakthrough"
    if total_tokens > 18000:
        return "solid"
    if total_tokens > 4000:
        return "partial"
    return "partial"


def load_feed():
    return load_json(FEED_PATH, {"latest_event_id": None, "events": [], "updated_at": None})


def append_feed_event(event):
    feed = load_feed()
    feed["events"] = [item for item in feed.get("events", []) if item.get("id") != event["id"]]
    feed["events"].append(event)
    feed["events"] = feed["events"][-60:]
    feed["latest_event_id"] = event["id"]
    feed["updated_at"] = utc_now()
    save_json(FEED_PATH, feed)


def initialize_state_from_existing_session(session_path, state):
    last_user_text = state.get("last_user_text", "")
    last_cwd = state.get("last_cwd", "")
    last_total_tokens = state.get("last_total_tokens", 0)

    with session_path.open("r", encoding="utf-8") as handle:
        for line in handle:
            try:
                obj = json.loads(line)
            except Exception:
                continue

            if obj.get("type") == "turn_context":
                last_cwd = obj.get("payload", {}).get("cwd", last_cwd)

            if obj.get("type") == "response_item":
                payload = obj.get("payload", {})
                if payload.get("type") == "message" and payload.get("role") == "user":
                    text = extract_text_from_message(payload)
                    if is_meaningful_user_text(text):
                        last_user_text = text

            if obj.get("type") == "event_msg":
                payload = obj.get("payload", {})
                if payload.get("type") == "token_count" and payload.get("info"):
                    total = payload["info"].get("total_token_usage", {}).get("total_tokens", last_total_tokens)
                    if total:
                        last_total_tokens = total

    state.update(
        {
            "session_path": str(session_path),
            "offset": session_path.stat().st_size,
            "last_total_tokens": last_total_tokens,
            "last_user_text": last_user_text,
            "last_cwd": last_cwd,
            "initialized": True,
        }
    )
    save_json(STATE_PATH, state)


def process_session_updates(session_path, state):
    last_user_text = state.get("last_user_text", "")
    last_cwd = state.get("last_cwd", "")
    last_total_tokens = state.get("last_total_tokens", 0)
    offset = state.get("offset", 0)

    current_size = session_path.stat().st_size
    if current_size < offset:
        offset = 0

    with session_path.open("r", encoding="utf-8") as handle:
        handle.seek(offset)
        for line in handle:
            try:
                obj = json.loads(line)
            except Exception:
                continue

            if obj.get("type") == "turn_context":
                last_cwd = obj.get("payload", {}).get("cwd", last_cwd)
                continue

            if obj.get("type") == "response_item":
                payload = obj.get("payload", {})
                if payload.get("type") == "message" and payload.get("role") == "user":
                    text = extract_text_from_message(payload)
                    if is_meaningful_user_text(text):
                        last_user_text = text
                continue

            if obj.get("type") != "event_msg":
                continue

            payload = obj.get("payload", {})
            if payload.get("type") != "token_count" or not payload.get("info"):
                continue

            total_usage = payload["info"].get("total_token_usage", {})
            last_usage = payload["info"].get("last_token_usage", {})
            total_tokens = total_usage.get("total_tokens", last_total_tokens)
            if not total_tokens or total_tokens <= last_total_tokens:
                continue

            task_type = classify_task(last_user_text, last_cwd)
            quality = classify_quality(task_type, last_usage)
            event_id = f"{session_path.name}:{total_tokens}"
            event = {
                "id": event_id,
                "timestamp": obj.get("timestamp"),
                "source": "codex",
                "session_path": str(session_path),
                "cwd": last_cwd,
                "task_type": task_type,
                "quality": quality,
                "real_tokens": last_usage.get("total_tokens", 0),
                "input_tokens": last_usage.get("input_tokens", 0),
                "output_tokens": last_usage.get("output_tokens", 0),
                "reasoning_tokens": last_usage.get("reasoning_output_tokens", 0),
                "user_text": last_user_text[:280],
            }
            append_feed_event(event)
            last_total_tokens = total_tokens

        offset = handle.tell()

    state.update(
        {
            "session_path": str(session_path),
            "offset": offset,
            "last_total_tokens": last_total_tokens,
            "last_user_text": last_user_text,
            "last_cwd": last_cwd,
            "initialized": True,
        }
    )
    save_json(STATE_PATH, state)


def main():
    PID_PATH.write_text(str(os.getpid()), encoding="utf-8")
    state = load_json(STATE_PATH, default_state())

    while True:
        latest_session = find_latest_session()
        if latest_session is None:
            time.sleep(3)
            continue

        if state.get("session_path") != str(latest_session):
            initialize_state_from_existing_session(latest_session, state)
        elif not is_meaningful_user_text(state.get("last_user_text", "")):
            initialize_state_from_existing_session(latest_session, state)
        elif not state.get("initialized"):
            initialize_state_from_existing_session(latest_session, state)
        else:
            process_session_updates(latest_session, state)

        time.sleep(3)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
