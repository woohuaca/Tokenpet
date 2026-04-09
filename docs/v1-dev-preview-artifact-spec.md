# 阿在 Token Pet `v0.1.0-dev-preview` 产物命名与目录规范

## 这份规范解决什么问题

这份规范回答的是：

- 我们这次私测包到底叫什么
- 打包目录应该长什么样
- 压缩包里必须有哪些内容

目标是让 `dev preview` 的发布不再靠临时命名和手工整理。

## 版本命名

当前版本名固定为：

- `v0.1.0-dev-preview`

这个命名代表：

- `v0.1.0`
  当前仍处在正式 `1.0` 之前
- `dev-preview`
  当前是开发者预览，而不是正式稳定版

## 渠道命名

当前首发渠道固定为：

- `codex-macos`

原因：

- 首发宿主是 Codex
- 当前桌面 companion 主体运行在 macOS

## 发布目录命名

当前建议统一使用：

- `azai-token-pet-v0.1.0-dev-preview-codex-macos`

目录结构示例：

```text
plugins/azai-token-pet/builds/
└── azai-token-pet-v0.1.0-dev-preview-codex-macos/
    ├── .codex-plugin/
    ├── assets/
    ├── docs/
    ├── runtime/
    ├── scripts/
    ├── README.md
    └── RELEASE.txt
```

对应压缩包建议为：

- `azai-token-pet-v0.1.0-dev-preview-codex-macos.zip`

## builds 目录约定

所有私测包产物统一放在：

- `plugins/azai-token-pet/builds/`

这样做的原因：

- 不污染运行态目录
- 不混进源码目录主视线
- 后续不同版本产物可以并列保留

## 当前必须进入压缩包的内容

### 一、运行主体

- `.codex-plugin/`
- `assets/`
- `scripts/codex_usage_bridge.py`
- `scripts/nutrition-profile.json`
- `scripts/launch_desktop_pet.command`
- `scripts/stop_desktop_pet.command`
- `scripts/reset_pet_data.command`
- `scripts/install_autostart.command`
- `scripts/uninstall_autostart.command`
- `runtime/azai-token-pet-desktop`

### 二、说明文档

- `README.md`
- `docs/v1-private-beta-quickstart.md`
- `docs/v1-release-plan.md`
- `docs/v1-dev-preview-package.md`
- `docs/v1-dev-preview-release-notes.md`
- `docs/v1-known-limitations-and-feedback.md`
- `docs/v1-validation-2026-04-08-round-03.md`

### 三、包内顶层说明

- `RELEASE.txt`

作用是：

- 让人解压后第一眼知道版本名
- 知道启动、关闭、重置入口
- 知道这份包适用什么环境

## 当前不进入压缩包的内容

不建议打进这次 `dev preview` 包里的内容：

- `runtime/` 下的状态缓存文件
- 当前机器上的宠物存档
- 临时日志
- demo 原型文件
- 与当前私测无关的设计草稿

## 打包脚本入口

当前打包脚本统一为：

- `scripts/build_dev_preview_bundle.command`

它会负责：

1. 确保桌宠 companion 二进制已编译
2. 生成标准命名的发布目录
3. 拷贝必须文件
4. 写出 `RELEASE.txt`
5. 生成标准命名的 zip 包

## 当前判断

这套命名和目录规范已经足够支撑 `v0.1.0-dev-preview` 私测发布。

后续如果进入下一阶段，版本号和渠道名可以继续沿这套规则扩展，而不需要重新定义发布产物结构。
