# 阿在 Token Pet 发布到 Codex 的正式流程

## 这份文档解决什么问题

这份文档不回答“产品值不值得发”，而回答：

- 当前这只桌宠如何按 Codex 本地插件方式发布
- 哪个脚本负责把它挂进 Codex
- 发布完成后如何判断它已经被 Codex 正确发现

## 当前发布定位

当前所谓“正式发布到 Codex”，指的是：

- 按正式版口径发布到当前机器的 Codex 插件体系
- 通过 `~/plugins/` 与 `~/.agents/plugins/marketplace.json` 被 Codex 发现
- 产物、版本号和发布说明不再沿用 `dev preview` 命名

这仍不是“官方公开插件商店发布”，而是：

- Codex 内正式可安装
- Codex 内正式可发现
- 当前首发范围限定在 `Codex + macOS`

## 当前入口脚本

发布到 Codex 的主脚本：

- `scripts/publish_to_codex.command`

从 Codex 本地下架：

- `scripts/unpublish_from_codex.command`

## `publish_to_codex.command` 会做什么

它会按下面顺序执行：

1. 确保 `~/plugins/` 存在
2. 确保 `~/.agents/plugins/` 存在
3. 把当前插件目录挂到 `~/plugins/azai-token-pet`
4. 创建或更新 `~/.agents/plugins/marketplace.json`
5. 写入 `azai-token-pet` 的本地 marketplace 条目

当前写入的 marketplace 入口是：

```json
{
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
```

## 发布后如何判断已经成功

发布成功后，至少应满足：

1. `~/plugins/azai-token-pet` 存在，并指向当前插件目录
2. `~/.agents/plugins/marketplace.json` 中存在 `azai-token-pet`
3. Codex 重启后，可以在本地插件列表里看到 `阿在 Token Pet`
4. 插件根目录中可以直接看到并运行：
   - `start.command`
   - `stop.command`
   - `reset.command`
5. Codex 插件入口里第一条 starter prompt 为：
   - `启动阿在 Token Pet 桌宠`

## 当前建议流程

### 1. 先生成正式发布包

运行：

- `scripts/build_codex_release_bundle.command`

目的：

- 固定正式版要发的版本内容
- 生成稳定命名的 `v1.0.0` Codex 发布包
- 保证 companion 二进制和文档已经处于可发状态

### 2. 再发布到 Codex 本地插件体系

运行：

- `scripts/publish_to_codex.command`

### 3. 最后在 Codex 中人工确认

检查：

- 插件列表里是否出现 `阿在 Token Pet`
- 插件详情或对话入口里是否出现 `启动阿在 Token Pet 桌宠`
- 安装后是否能直接通过 `start.command` 启动桌宠
- 桌宠能否正常启动
- 启动后是否仍维持 `1` 只桌宠 + `1` 条 bridge

## 当前判断

基于当前结构，阿在 Token Pet 已经具备“按正式版口径发布到 Codex”的条件。

当前更重要的不是继续停留在 `dev preview` 叙事，而是：

1. 做完正式发布后的人工 UI 确认
2. 用正式版口径继续收敛安装与显示层体验
