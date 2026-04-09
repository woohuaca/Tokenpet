#!/usr/bin/env python3

import json
import math
from pathlib import Path
import tkinter as tk


BASE_DIR = Path(__file__).resolve().parent
PROFILE_PATH = BASE_DIR / "nutrition-profile.json"
STATE_DIR = BASE_DIR.parent / "runtime"
STATE_PATH = STATE_DIR / "pet-state.json"


DEFAULT_STATE = {
    "stage": "egg",
    "form": "neutral",
    "satiety": 45,
    "energy": 55,
    "focus": 50,
    "mood": 55,
    "hygiene": 60,
    "health": 60,
    "bond": 10,
    "growth": 0,
    "toxicity": 0,
    "residue": 0,
    "ageHours": 0,
    "lastTaskType": None,
    "windowX": 1120,
    "windowY": 120,
    "archetypeScore": {
        "builder": 0,
        "scholar": 0,
        "captain": 0,
        "social": 0,
        "chaos": 0,
    },
}


QUALITY_MULTIPLIER = {
    "breakthrough": 1.25,
    "solid": 1.0,
    "partial": 0.78,
    "waste": 0.45,
}


STAGES = [
    {"name": "egg", "minGrowth": 0, "label": "宠物蛋"},
    {"name": "sprout", "minGrowth": 25, "label": "发芽期"},
    {"name": "child", "minGrowth": 60, "label": "幼年期"},
    {"name": "teen", "minGrowth": 120, "label": "成长期"},
    {"name": "adult", "minGrowth": 220, "label": "成熟体"},
    {"name": "mythic", "minGrowth": 360, "label": "传说体"},
]


FORM_LABEL = {
    "neutral": "中性",
    "builder": "建造型",
    "scholar": "学者型",
    "captain": "指挥型",
    "social": "社交型",
    "chaos": "混乱型",
}


FORM_COLOR = {
    "neutral": "#ff7a59",
    "builder": "#f06a34",
    "scholar": "#ff6b59",
    "captain": "#e85b5b",
    "social": "#f39b34",
    "chaos": "#7a5cf1",
}


FORM_BUBBLE = {
    "neutral": "我还在观察你的工作习惯。",
    "builder": "开发餐让我越来越像一个会搭东西的小兽。",
    "scholar": "研究和写作让我脑子发亮，但也容易过劳。",
    "captain": "规划和评审让我很有秩序感。",
    "social": "支持别人会让我更亲人。",
    "chaos": "别再喂我空转和会议垃圾餐了。",
}


TASK_PRESETS = [
    ("开发", "coding", 4200, "solid"),
    ("写作", "writing", 3600, "solid"),
    ("研究", "research", 5200, "breakthrough"),
    ("会议", "meeting", 2800, "partial"),
    ("空转", "idle", 2400, "waste"),
]


with PROFILE_PATH.open("r", encoding="utf-8") as handle:
    NUTRITION_PROFILE = json.load(handle)


def clamp(value, minimum=0, maximum=100):
    return max(minimum, min(maximum, value))


def round1(value):
    return round(value, 1)


def token_units(tokens_spent):
    if not tokens_spent or tokens_spent <= 0:
        return 0
    return max(1, math.sqrt(tokens_spent / 1000) * 3)


def derive_stage(growth):
    current = STAGES[0]
    for stage in STAGES:
        if growth >= stage["minGrowth"]:
            current = stage
    return current["name"]


def derive_form(archetype_score):
    dominant = sorted(archetype_score.items(), key=lambda item: item[1], reverse=True)[0]
    if dominant[1] < 10:
        return "neutral"
    return dominant[0]


def derive_mood_tag(state):
    if state["health"] < 30 or state["hygiene"] < 20:
        return "sick"
    if state["energy"] < 20:
        return "sleepy"
    if state["toxicity"] > 70 or state["residue"] > 50:
        return "glitched"
    if state["mood"] > 80 and state["bond"] > 70:
        return "joyful"
    if state["satiety"] < 20:
        return "hungry"
    return "steady"


def build_meal(task_type, tokens_spent, output_quality):
    profile = NUTRITION_PROFILE.get(task_type, NUTRITION_PROFILE["idle"])
    units = token_units(tokens_spent)
    multiplier = QUALITY_MULTIPLIER.get(output_quality, 1.0)
    residue = max(0, profile["toxicity"] * units * (2 - multiplier))
    return {
        "taskType": task_type,
        "label": profile["label"],
        "tokensSpent": tokens_spent,
        "outputQuality": output_quality,
        "satiety": round1(profile["satiety"] * units * multiplier),
        "energy": round1(profile["energy"] * units * multiplier),
        "focus": round1(profile["focus"] * units * multiplier),
        "mood": round1(profile["mood"] * units * multiplier),
        "hygiene": round1(profile["hygiene"] * units),
        "health": round1(profile["health"] * units * multiplier),
        "bond": round1(profile["bond"] * units * multiplier),
        "growth": round1(profile["growth"] * units * multiplier),
        "toxicity": round1(profile["toxicity"] * units * (1.2 - multiplier * 0.2)),
        "residue": round1(residue),
        "archetypes": profile.get("archetypes", {}),
    }


def apply_meal(state, meal):
    next_state = json.loads(json.dumps(state))
    next_state["satiety"] = clamp(next_state["satiety"] + meal["satiety"])
    next_state["energy"] = clamp(next_state["energy"] + meal["energy"])
    next_state["focus"] = clamp(next_state["focus"] + meal["focus"])
    next_state["mood"] = clamp(next_state["mood"] + meal["mood"])
    next_state["hygiene"] = clamp(next_state["hygiene"] + meal["hygiene"])
    next_state["health"] = clamp(next_state["health"] + meal["health"] - meal["toxicity"] * 0.4)
    next_state["bond"] = clamp(next_state["bond"] + meal["bond"])
    next_state["growth"] = round1(next_state["growth"] + meal["growth"])
    next_state["toxicity"] = clamp(next_state["toxicity"] + meal["toxicity"])
    next_state["residue"] = clamp(next_state["residue"] + meal["residue"])
    next_state["lastTaskType"] = meal["taskType"]

    for name, score in meal["archetypes"].items():
        next_state["archetypeScore"][name] = round1(
            next_state["archetypeScore"].get(name, 0) + score * token_units(meal["tokensSpent"])
        )

    next_state["stage"] = derive_stage(next_state["growth"])
    next_state["form"] = derive_form(next_state["archetypeScore"])
    return next_state


def decay_state(state, hours):
    next_state = json.loads(json.dumps(state))
    next_state["ageHours"] = round1(next_state["ageHours"] + hours)
    next_state["satiety"] = clamp(next_state["satiety"] - hours * 3.5)
    next_state["energy"] = clamp(next_state["energy"] - hours * 2.6)
    next_state["focus"] = clamp(next_state["focus"] - hours * 1.8)
    next_state["mood"] = clamp(next_state["mood"] - hours * 1.6 - state["residue"] * 0.03)
    next_state["hygiene"] = clamp(next_state["hygiene"] - hours * 1.4 - state["toxicity"] * 0.02)
    next_state["health"] = clamp(next_state["health"] - max(0, state["toxicity"] - 40) * 0.03 * hours)
    next_state["toxicity"] = clamp(next_state["toxicity"] - hours * 0.6)
    next_state["stage"] = derive_stage(next_state["growth"])
    next_state["form"] = derive_form(next_state["archetypeScore"])
    return next_state


def clean_residue(state):
    next_state = json.loads(json.dumps(state))
    next_state["residue"] = clamp(next_state["residue"] - 12)
    next_state["hygiene"] = clamp(next_state["hygiene"] + 10)
    next_state["mood"] = clamp(next_state["mood"] + 3)
    next_state["health"] = clamp(next_state["health"] + 2)
    return next_state


def play_with_pet(state):
    next_state = json.loads(json.dumps(state))
    next_state["mood"] = clamp(next_state["mood"] + 8)
    next_state["bond"] = clamp(next_state["bond"] + 6)
    next_state["energy"] = clamp(next_state["energy"] - 4)
    next_state["satiety"] = clamp(next_state["satiety"] - 3)
    return next_state


def sleep_pet(state):
    next_state = json.loads(json.dumps(state))
    next_state["energy"] = clamp(next_state["energy"] + 42)
    next_state["health"] = clamp(next_state["health"] + 12)
    next_state["focus"] = clamp(next_state["focus"] + 10)
    next_state["mood"] = clamp(next_state["mood"] + 6)
    next_state["satiety"] = clamp(next_state["satiety"] - 10)
    return next_state


def load_state():
    if STATE_PATH.exists():
        with STATE_PATH.open("r", encoding="utf-8") as handle:
            data = json.load(handle)
        merged = json.loads(json.dumps(DEFAULT_STATE))
        merged.update({key: value for key, value in data.items() if key != "archetypeScore"})
        merged["archetypeScore"].update(data.get("archetypeScore", {}))
        return merged
    return json.loads(json.dumps(DEFAULT_STATE))


def save_state(state):
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    with STATE_PATH.open("w", encoding="utf-8") as handle:
        json.dump(state, handle, ensure_ascii=False, indent=2)
        handle.write("\n")


class DesktopPet:
    def __init__(self):
        self.state = load_state()
        self.drag_origin = None
        self.tick_counter = 0

        self.root = tk.Tk()
        self.root.title("阿在 Token Pet")
        self.root.overrideredirect(True)
        self.root.attributes("-topmost", True)
        self.root.configure(bg="#f7efe1")
        self.root.geometry(f"260x312+{self.state['windowX']}+{self.state['windowY']}")

        self.canvas = tk.Canvas(
            self.root,
            width=260,
            height=312,
            highlightthickness=0,
            bg="#f7efe1",
        )
        self.canvas.pack(fill="both", expand=True)

        self._build_ui()
        self._bind_drag()
        self._render()
        self._schedule_tick()

    def _build_ui(self):
        self.canvas.create_oval(18, 12, 242, 294, fill="#fff8ef", outline="#eedfcd", width=2, tags="card")
        self.canvas.create_text(130, 28, text="阿在 Token Pet", font=("PingFang SC", 13, "bold"), fill="#5d4a39", tags="title")
        self.canvas.create_text(130, 52, text="", font=("PingFang SC", 10), fill="#8a7864", width=190, tags="bubble")
        self.canvas.create_text(130, 84, text="", font=("PingFang SC", 11, "bold"), fill="#d25d41", tags="meta")
        self.canvas.create_text(130, 112, text="", font=("PingFang SC", 10), fill="#7b6858", tags="mood")
        self.canvas.create_oval(66, 132, 194, 260, fill="#ff7a59", outline="", tags="body")
        self.canvas.create_oval(78, 118, 108, 154, fill="#ffc06f", outline="", tags="ear_left")
        self.canvas.create_oval(152, 118, 182, 154, fill="#ffc06f", outline="", tags="ear_right")
        self.canvas.create_oval(108, 196, 152, 228, fill="#ffdcb2", outline="", tags="belly")
        self.canvas.create_oval(104, 172, 112, 186, fill="#29211b", outline="", tags="eye_left")
        self.canvas.create_oval(148, 172, 156, 186, fill="#29211b", outline="", tags="eye_right")
        self.canvas.create_arc(115, 192, 145, 214, start=200, extent=140, style="arc", outline="#29211b", width=3, tags="mouth")
        self.canvas.create_oval(184, 124, 224, 164, fill="#2fbf71", outline="", tags="token")
        self.canvas.create_text(204, 144, text="+T", font=("Avenir Next", 13, "bold"), fill="white", tags="token_text")
        self.canvas.create_text(130, 274, text="拖拽移动 | 双击喂食 | 右键菜单", font=("PingFang SC", 9), fill="#9a8976", tags="hint")

        self.btn_frame = tk.Frame(self.root, bg="#f7efe1")
        self.btn_frame.place(x=18, y=288, width=224, height=24)

        small_font = ("PingFang SC", 9, "bold")
        buttons = [
            ("开", lambda: self.feed_preset(0)),
            ("写", lambda: self.feed_preset(1)),
            ("研", lambda: self.feed_preset(2)),
            ("扫", self.clean_action),
            ("玩", self.play_action),
            ("睡", self.sleep_action),
        ]

        for label, command in buttons:
            button = tk.Button(
                self.btn_frame,
                text=label,
                command=command,
                font=small_font,
                bd=0,
                relief="flat",
                bg="#fff8ef",
                fg="#5d4a39",
                activebackground="#ffe6cc",
                activeforeground="#5d4a39",
                width=3,
                height=1,
                cursor="hand2",
            )
            button.pack(side="left", padx=2)

        self.menu = tk.Menu(self.root, tearoff=0)
        for index, (label, _, _, _) in enumerate(TASK_PRESETS):
            self.menu.add_command(label=f"喂{label}餐", command=lambda idx=index: self.feed_preset(idx))
        self.menu.add_separator()
        self.menu.add_command(label="清理残渣", command=self.clean_action)
        self.menu.add_command(label="陪它玩耍", command=self.play_action)
        self.menu.add_command(label="安排睡觉", command=self.sleep_action)
        self.menu.add_command(label="时间流逝 3 小时", command=self.decay_action)
        self.menu.add_separator()
        self.menu.add_command(label="退出桌宠", command=self.shutdown)

        self.canvas.bind("<Double-Button-1>", lambda _: self.feed_preset(0))
        self.canvas.bind("<Button-3>", self.show_menu)
        self.canvas.bind("<Button-2>", self.show_menu)

    def _bind_drag(self):
        self.canvas.bind("<ButtonPress-1>", self.start_drag)
        self.canvas.bind("<B1-Motion>", self.do_drag)
        self.canvas.bind("<ButtonRelease-1>", self.end_drag)

    def start_drag(self, event):
        self.drag_origin = (event.x_root, event.y_root)

    def do_drag(self, event):
        if not self.drag_origin:
            return
        delta_x = event.x_root - self.drag_origin[0]
        delta_y = event.y_root - self.drag_origin[1]
        x = self.root.winfo_x() + delta_x
        y = self.root.winfo_y() + delta_y
        self.root.geometry(f"+{x}+{y}")
        self.drag_origin = (event.x_root, event.y_root)

    def end_drag(self, _event):
        self.drag_origin = None
        self.state["windowX"] = self.root.winfo_x()
        self.state["windowY"] = self.root.winfo_y()
        save_state(self.state)

    def show_menu(self, event):
        self.menu.tk_popup(event.x_root, event.y_root)

    def feed_preset(self, index):
        _, task_type, tokens_spent, quality = TASK_PRESETS[index]
        meal = build_meal(task_type, tokens_spent, quality)
        self.state = apply_meal(self.state, meal)
        self._say(f"吃了{meal['label']}餐，成长 +{meal['growth']}。")
        self._render()
        save_state(self.state)

    def clean_action(self):
        self.state = clean_residue(self.state)
        self._say("清理完残渣了，终于没那么脏了。")
        self._render()
        save_state(self.state)

    def play_action(self):
        self.state = play_with_pet(self.state)
        self._say("陪我玩一下，我就更愿意跟着你干活。")
        self._render()
        save_state(self.state)

    def sleep_action(self):
        self.state = sleep_pet(self.state)
        self._say("我补了一觉，精神好多了。")
        self._render()
        save_state(self.state)

    def decay_action(self):
        self.state = decay_state(self.state, 3)
        self._say("时间过去了一会儿，我的状态在自然变化。")
        self._render()
        save_state(self.state)

    def _schedule_tick(self):
        self.root.after(45000, self._background_tick)

    def _background_tick(self):
        self.tick_counter += 1
        self.state = decay_state(self.state, 1)
        if self.tick_counter % 4 == 0:
            self._say(self._default_line())
        self._render()
        save_state(self.state)
        self._schedule_tick()

    def _default_line(self):
        mood = derive_mood_tag(self.state)
        if mood == "hungry":
            return "我饿了，最好给我一顿高质量任务餐。"
        if mood == "sleepy":
            return "我有点困，你是不是最近透支得太狠了。"
        if mood == "glitched":
            return "最近垃圾 Token 太多，我有点卡壳。"
        if mood == "joyful":
            return "今天的饮食结构真不错，我很开心。"
        if mood == "sick":
            return "再不清理和休息，我就要闹脾气了。"
        return FORM_BUBBLE.get(self.state["form"], FORM_BUBBLE["neutral"])

    def _say(self, text):
        self.canvas.itemconfigure("bubble", text=text)

    def _render(self):
        stage_label = next((item["label"] for item in STAGES if item["name"] == self.state["stage"]), self.state["stage"])
        mood = derive_mood_tag(self.state)
        color = FORM_COLOR.get(self.state["form"], FORM_COLOR["neutral"])

        self.canvas.itemconfigure("body", fill=color)
        self.canvas.itemconfigure(
            "meta",
            text=f"{stage_label} / {FORM_LABEL.get(self.state['form'], '中性')}"
        )
        self.canvas.itemconfigure(
            "mood",
            text=(
                f"{mood} | 饱腹 {int(self.state['satiety'])} | 活力 {int(self.state['energy'])} | "
                f"清洁 {int(self.state['hygiene'])}"
            ),
        )
        if not self.canvas.itemcget("bubble", "text"):
            self._say(self._default_line())

        if mood == "sleepy":
            self.canvas.coords("eye_left", 104, 178, 112, 181)
            self.canvas.coords("eye_right", 148, 178, 156, 181)
        else:
            self.canvas.coords("eye_left", 104, 172, 112, 186)
            self.canvas.coords("eye_right", 148, 172, 156, 186)

        if mood == "hungry":
            self.canvas.coords("mouth", 118, 198, 142, 208)
        else:
            self.canvas.coords("mouth", 115, 192, 145, 214)

        token_color = "#7a5cf1" if mood == "glitched" else "#2fbf71"
        self.canvas.itemconfigure("token", fill=token_color)

        if mood == "joyful":
            self.canvas.move("body", 0, -1)
            self.root.after(120, lambda: self.canvas.move("body", 0, 1))

    def shutdown(self):
        self.state["windowX"] = self.root.winfo_x()
        self.state["windowY"] = self.root.winfo_y()
        save_state(self.state)
        self.root.destroy()

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    DesktopPet().run()
