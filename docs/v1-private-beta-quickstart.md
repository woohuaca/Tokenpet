# 阿在 Token Pet V1 Codex 上手卡

## 适用范围

这张卡面向当前 `V1` 的 Codex 首发正式版：

- 宿主：Codex
- 系统：macOS
- 形态：本地插件入口 + 桌面 companion

## 三步跑起来

1. 进入 `plugins/azai-token-pet/`
2. 运行 `scripts/launch_desktop_pet.command`
3. 等桌宠弹出后，先让它吃到一点真实 Token，再轻拍一次完成认主

当前启动链说明：

- 启动脚本会先拉起桌宠本体
- bridge 会由桌宠本体自行唤起并在后台自愈
- 当前版本已经通过短周期重复启停回归

## 你会看到什么

- 真实 Token 会先转成粮食库存
- 宠物会自动吃，慢慢积累互动能源
- 它会告诉你“这会儿想被怎么拍”
- 你只有一个动作：拍一下它
- 拍准、拍偏、错过、认主，反馈都不一样

## 常用操作

启动：

- `scripts/launch_desktop_pet.command`

关闭但保留存档：

- `scripts/stop_desktop_pet.command`

开机自启：

- `scripts/install_autostart.command`

取消自启：

- `scripts/uninstall_autostart.command`

从头生成一只新的：

- `scripts/reset_pet_data.command`

## 重置前请先知道

`scripts/reset_pet_data.command` 会清空：

- 当前宠物成长
- 关系与认主状态
- 粮仓和本地缓存事件

如果你还想继续养当前这只，不要运行重置。

## 本地数据说明

当前 `V1` 的运行态主要在 `runtime/`：

- `pet-state.json`
- `pet-config.json`
- `codex-feed.json`
- `external-feed.json`
- `codex-bridge-state.json`

当前版本默认不把这些运行态自动上传到外部服务。

## 当前边界

- 这是 Codex 首发正式版，但当前正式范围仍限定在 `Codex + macOS`
- 目前以 `Codex + macOS` 为主
- 任务分类仍有启发式成分
- 重置不会自动备份
