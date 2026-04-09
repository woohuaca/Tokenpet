#!/usr/bin/env python3

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
PLUGIN_DIR = SCRIPT_DIR.parent
RUNTIME_DIR = PLUGIN_DIR / "runtime"
RUNTIME_DIR.mkdir(parents=True, exist_ok=True)
FEED_PATH = RUNTIME_DIR / "external-feed.json"


def utc_now():
    return datetime.now(timezone.utc).isoformat()


def load_feed():
    if not FEED_PATH.exists():
        return {"latest_event_id": None, "events": [], "updated_at": None}
    try:
        return json.loads(FEED_PATH.read_text(encoding="utf-8"))
    except Exception:
        return {"latest_event_id": None, "events": [], "updated_at": None}


def save_feed(feed):
    FEED_PATH.write_text(json.dumps(feed, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def normalize_event(payload):
    source = payload.get("source", "external")
    timestamp = payload.get("timestamp") or utc_now()
    task_type = payload.get("task_type", "coding")
    real_tokens = float(payload.get("real_tokens", 0))
    quality = payload.get("quality", "solid")
    event_id = payload.get("id") or f"{source}:{task_type}:{int(real_tokens)}:{timestamp}"

    return {
        "id": event_id,
        "timestamp": timestamp,
        "source": source,
        "session_path": payload.get("session_path", ""),
        "cwd": payload.get("cwd", ""),
        "task_type": task_type,
        "quality": quality,
        "real_tokens": real_tokens,
        "input_tokens": float(payload.get("input_tokens", 0)),
        "output_tokens": float(payload.get("output_tokens", 0)),
        "reasoning_tokens": float(payload.get("reasoning_tokens", 0)),
        "user_text": payload.get("user_text", "")[:280],
    }


def append_event(event):
    feed = load_feed()
    feed["events"] = [item for item in feed.get("events", []) if item.get("id") != event["id"]]
    feed["events"].append(event)
    feed["events"] = feed["events"][-120:]
    feed["latest_event_id"] = event["id"]
    feed["updated_at"] = utc_now()
    save_feed(feed)


def parse_args():
    parser = argparse.ArgumentParser(description="Append an external usage event for 阿在 Token Pet")
    parser.add_argument("--source", default="external")
    parser.add_argument("--task-type", default="coding")
    parser.add_argument("--quality", default="solid")
    parser.add_argument("--real-tokens", type=float, required=True)
    parser.add_argument("--input-tokens", type=float, default=0)
    parser.add_argument("--output-tokens", type=float, default=0)
    parser.add_argument("--reasoning-tokens", type=float, default=0)
    parser.add_argument("--user-text", default="")
    parser.add_argument("--cwd", default="")
    parser.add_argument("--session-path", default="")
    parser.add_argument("--id", dest="event_id", default="")
    parser.add_argument("--stdin-json", action="store_true")
    return parser.parse_args()


def main():
    args = parse_args()
    if args.stdin_json:
        payload = json.load(sys.stdin)
    else:
        payload = {
            "id": args.event_id,
            "source": args.source,
            "task_type": args.task_type,
            "quality": args.quality,
            "real_tokens": args.real_tokens,
            "input_tokens": args.input_tokens,
            "output_tokens": args.output_tokens,
            "reasoning_tokens": args.reasoning_tokens,
            "user_text": args.user_text,
            "cwd": args.cwd,
            "session_path": args.session_path,
        }

    event = normalize_event(payload)
    append_event(event)
    print(json.dumps({"ok": True, "event_id": event["id"], "feed_path": str(FEED_PATH)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
