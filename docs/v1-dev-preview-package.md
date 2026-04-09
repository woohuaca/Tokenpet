# 阿在 Token Pet V1 Dev Preview 发布包清单

## 这份清单解决什么问题

这份清单不回答“产品要不要做”，而回答：

- 我们准备发出的 `v0.1.0-dev-preview` 到底要带哪些内容
- 哪些文件属于必须项
- 哪些说明必须在私测前讲清楚

目标是把发布从“口头准备好了”推进到“包内容已经收清楚”。

当前产物命名与目录规范见：`docs/v1-dev-preview-artifact-spec.md`

## 发布包定位

当前发布包定位为：

- Codex-first
- macOS
- 本地插件入口 + 桌面 companion
- 小范围私测

一句话定义：

- 这不是正式稳定版，而是一份用于验证“真实 Token 养成桌宠”主体验是否成立的开发者预览包

## 发布包必须包含

### 一、运行主体

1. `plugins/azai-token-pet/.codex-plugin/plugin.json`
2. `plugins/azai-token-pet/scripts/desktop_pet.swift`
3. `plugins/azai-token-pet/scripts/codex_usage_bridge.py`
4. `plugins/azai-token-pet/scripts/nutrition-profile.json`
5. `plugins/azai-token-pet/scripts/launch_desktop_pet.command`
6. `plugins/azai-token-pet/scripts/stop_desktop_pet.command`
7. `plugins/azai-token-pet/scripts/reset_pet_data.command`
8. `plugins/azai-token-pet/scripts/publish_to_codex.command`
9. `plugins/azai-token-pet/scripts/unpublish_from_codex.command`

### 二、可选但建议附带

1. `plugins/azai-token-pet/scripts/install_autostart.command`
2. `plugins/azai-token-pet/scripts/uninstall_autostart.command`
3. `plugins/azai-token-pet/assets/icon.svg`
4. `plugins/azai-token-pet/assets/logo.svg`

### 三、说明文档

1. `plugins/azai-token-pet/README.md`
2. `plugins/azai-token-pet/docs/v1-private-beta-quickstart.md`
3. `plugins/azai-token-pet/docs/v1-release-plan.md`
4. `plugins/azai-token-pet/docs/v1-dev-preview-release-notes.md`
5. `plugins/azai-token-pet/docs/v1-known-limitations-and-feedback.md`
6. `plugins/azai-token-pet/docs/v1-validation-2026-04-08-round-03.md`
7. `plugins/azai-token-pet/docs/v1-codex-publish.md`

## 私测前必须明确写清的内容

### 1. 适用范围

- 当前只面向 `Codex + macOS`
- 当前形态是本地插件入口 + 桌面 companion

### 2. 已成立能力

- 真实 Token 转粮
- 桌宠自动吃粮
- 单一交互“拍一下”
- 首次诞生与认主
- 关系沉淀与成长偏向
- 单实例与短周期重复启停回归

### 3. 已知边界

- 当前仍是 `developer preview`
- 任务分类仍带启发式成分
- 长时稳定性还在继续观察
- 重置不会自动备份
- 当前主要覆盖 Codex 来源，其他来源仍是后续扩展项

### 4. 本地数据与隐私

- 运行态主要保存在 `runtime/`
- 当前默认不自动上传运行态数据到外部服务
- Token 来源读取依赖本机会话日志

## 发布包不应包含

以下内容不建议作为 `dev preview` 必备内容：

- 历史运行态缓存
- 私人存档
- 临时调试日志
- 未确认稳定的实验脚本
- 与当前 `V1` 无关的概念草稿

## 发布前最后核对

### 一、运行核对

1. `launch_desktop_pet.command` 可以从零拉起桌宠
2. 桌宠启动后会自行拉起 bridge
3. `stop_desktop_pet.command` 可以清空真实进程
4. 再次启动后仍保持 `1` 只桌宠 + `1` 条 bridge

### 二、体验核对

1. 第一次出现时具备出生感
2. 吃到真实 Token 后会转粮并自动代谢
3. 会明确表达“这会儿想被怎么拍”
4. 拍准、拍偏、错过有明显差异

### 三、说明核对

1. 用户知道怎么启动
2. 用户知道怎么关闭
3. 用户知道怎么重置
4. 用户知道当前边界与风险

## 当前判断

基于现有验证记录，这份发布包已经具备进入小范围私测准备的条件。

接下来更重要的，不是继续往包里塞功能，而是：

1. 做一轮长时观察
2. 明确私测对象
3. 收集第一批真实用户反馈
