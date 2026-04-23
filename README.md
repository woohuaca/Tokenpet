# 吞金兽 Token Pet

吞金兽 Token Pet 是一只把 AI 工作流中的 Token 消耗，变成可喂养、可成长、可进化反馈的桌面电子宠物。

它的中文名叫“吞金兽”。  
这个名字强调的是：AI 工作里的 Token 消耗不是抽象数字，而是一只会把成本吃下去、消化掉、长出性格和关系的小兽。

当前首发范围：

- `Codex-first`
- `macOS companion`
- `v1.0.0` 正式首发版

## 快速入口

- 仓库：`https://github.com/woohuaca/Tokenpet`
- 公开下载包：`builds/azai-token-pet-v1.0.0-public-share.zip`
- Codex 正式版包：`builds/azai-token-pet-v1.0.0-codex-macos.zip`
- 公开分发说明：`PUBLIC_DISTRIBUTION.md`
- 最短安装说明：`docs/v1-release-install-quickstart.md`
- 5 分钟发版清单：`docs/v1-release-5min-checklist.md`
- 隐私说明：`PRIVACY.md`
- 条款说明：`TERMS.md`
- 问题反馈：GitHub Issues

## 三句话理解它

1. 它吃的不是普通饲料，而是你真实花掉的 Token。
2. 它长得怎样，不只看花了多少，还看花在哪类工作、长期饮食结构和你怎么回应它。
3. 它不是一个统计面板，而是一只会在桌边慢慢长出关系感的小兽。

## 产品命名

- 中文名：`吞金兽`
- 英文 / 技术识别名：`Token Pet`
- 当前包名：`azai-token-pet`

对外推荐使用：`吞金兽 Token Pet`。  
仓库、插件包和脚本路径暂时继续保留 `azai-token-pet`，避免破坏已发布安装链路。

## 适合谁

- 长时间在 Codex 里工作的人
- 想把 Token 消耗变成更直观反馈的人
- 愿意在 macOS 上运行本地桌宠 companion 的人

## 反馈入口

如果你下载后遇到问题，建议直接通过 GitHub Issues 反馈。

当前仓库已经准备了：

- `Bug Report`
- `Feature Request`

## 当前发布边界

- 已经按正式版口径进入 Codex 发布链
- 当前正式范围仍限定在 `Codex + macOS`
- 这不等于已经进入官方公共插件商店

## 最快安装

### 方式一：从下载包开始

1. 下载 `azai-token-pet-v1.0.0-public-share.zip` 或 `azai-token-pet-v1.0.0-codex-macos.zip`
2. 解压后进入插件目录
3. 运行 `start.command`

### 方式二：从源码仓库开始

1. 克隆 `https://github.com/woohuaca/Tokenpet`
2. 进入仓库根目录
3. 运行 `start.command`

## 系统要求

- macOS
- `xcrun`
- `python3`

## 这个插件是什么

阿在 Token Pet 是一个虚拟电子宠物插件。

它把用户在 AI 工作中花掉的 Token 变成宠物吃下去的食物，并根据任务类型、产出质量和长期饮食结构，实时改变宠物的：

- 饱腹度
- 活力
- 心情
- 清洁度
- 健康度
- 亲密度
- 成长阶段
- 进化形态

## 设计原则

这个插件参考的是经典电子宠物 `Tamagotchi`，但做了面向 AI 工作流的重写。

保留的经典特征有：

- 喂养
- 情绪反馈
- 清洁
- 睡眠与恢复
- 生病风险
- 成长
- 进化
- 互动奖励

面向 AI 工作的改写有：

- 食物不再是普通饲料，而是 Token
- 营养不再只看数量，而是看任务类型和质量
- 清洁不再是清理排泄物，而是清理低效 Token 产生的噪声残渣
- 生病不再来自忘记喂食，而是来自长期垃圾饮食和透支使用

这个版本还新增了一条更关键的原则：

- AI 不只是配文工具，而是宠物的灵魂与外观生成器
- 规则系统负责它怎么生长，AI 负责它是谁、怎么看你、会长出怎样的气质

## V1 目标

V1 的目标不是把所有玩法一次做完，而是先做出第一只真正成立的“AI 协同养成宠物”。

一句话定义：

- 一只由真实 Token 喂养、由规则系统稳定生长、由 AI 赋予灵魂与外观倾向、并在与你的关系中逐渐长成独特个体的桌面宠物

V1 当前聚焦四件事：

- 真实 Token 稳定转粮并驱动宠物生长
- 首次初始化时结合工作结构与沟通风格生成“这一只是谁”
- 只保留一个核心互动动作：拍一下
- 它会记住你怎么回应它，并慢慢长出独特关系和气质

在 AI 初始化阶段，推荐输入不是原始长对话堆叠，而是先提炼后的风格特征，例如：

- 直接度
- 温和度
- 探索性
- 控制感
- 耐心度
- 反馈密度

这样做更省 Token、更稳定，也更符合“珍惜资源”的产品初心。

## 当前发布定位

当前这版已经不再按 `developer preview` 对外表述，而是收口为：

- `Codex-first`
- `macOS companion`
- `Codex 范围内正式首发`

## 当前目录

- `.codex-plugin/plugin.json`
  Codex 插件清单
- `.app.json`
  多宿主适配规划
- `demo/index.html`
  可直接打开的交互原型
- `demo/codex-launchpad.html`
  面向 Codex 安装后的启动引导页
- `scripts/desktop_pet.py`
  Tk 版本桌宠原型
- `scripts/desktop_pet.swift`
  macOS 原生桌宠 companion
- `start.command`
  安装后最直接的启动入口
- `stop.command`
  安装后最直接的关闭入口
- `reset.command`
  安装后最直接的重置入口
- `PUBLIC_DISTRIBUTION.md`
  公开仓库 / 下载包分发说明
- `PRIVACY.md`
  公开分发版隐私说明
- `TERMS.md`
  公开分发版使用条款说明
- `scripts/codex_usage_bridge.py`
  把 Codex 会话日志转换成桌宠可消费的自动喂养事件
- `scripts/launch_desktop_pet.command`
  启动桌宠的本地脚本
- `scripts/install_autostart.command`
  安装开机自启
- `scripts/uninstall_autostart.command`
  取消开机自启
- `scripts/stop_desktop_pet.command`
  关闭桌宠和 Codex bridge
- `scripts/reset_pet_data.command`
  停止桌宠并清空当前运行态数据
- `scripts/build_dev_preview_bundle.command`
  生成历史 `v0.1.0-dev-preview` 预览包
- `scripts/build_codex_release_bundle.command`
  生成 `v1.0.0` Codex 正式发布包
- `scripts/build_public_share_bundle.command`
  生成可对外分享下载的公开分发包
- `scripts/publish_to_codex.command`
  按正式版口径发布到当前机器的 Codex 插件体系
- `scripts/unpublish_from_codex.command`
  从当前机器的 Codex 本地插件体系移除
- `scripts/nutrition-profile.json`
  不同任务类型的 Token 营养值
- `scripts/pet-core.js`
  宠物状态机与演算核心
- `assets/icon.svg`
  插件图标
- `assets/logo.svg`
  插件 Logo
- `docs/design-principles.md`
  宠物设计理念与玩法原则
- `docs/pet-motion-emotion-design.md`
  宠物动作、表情、声音与情绪表达设计稿
- `docs/v1-definition.md`
  V1 版本目标、范围与执行分解
- `docs/v1-initialization.md`
  V1 首次诞生初始化方案
- `docs/v1-design-checklist.md`
  V1 设计取舍与是否进入当前版本的判断清单
- `docs/v1-acceptance-checklist.md`
  V1 私测前逐项验收的发布检查表
- `docs/v1-validation-template.md`
  V1 私测记录模板，可直接按项填写通过与问题
- `docs/v1-validation-2026-04-08-round-01.md`
  当前版本的首轮真实验证记录
- `docs/v1-validation-2026-04-08-round-02.md`
  针对启动、关闭与单实例链路的第二轮验证记录
- `docs/v1-validation-2026-04-08-round-03.md`
  针对短周期重复启停回归的第三轮验证记录
- `docs/v1-release-plan.md`
  当前版本路线、发布门槛与后续演进顺序
- `docs/v1-next-iteration-focus.md`
  `吞金兽 Token Pet` 下一阶段精进方向：完整账本、生长养成、情绪价值、调试验证和分发体验
- `docs/v1-core-loop-optimization-plan.md`
  生命代谢线：从 Token 到生长养成的持续优化方案
- `docs/v1-emotional-value-optimization-plan.md`
  情绪价值线：从第一印象到个体关系感的持续优化方案
- `docs/v1-dual-track-priority-board.md`
  双线并进的 `P0 / P1 / P2` 版本级优先级看板
- `docs/v1-1-development-task-board.md`
  `v1.1.x` 的双线开发任务清单、开发顺序与最小交付面
- `docs/v1-1-first-batch-implementation-plan.md`
  `v1.1.x` 第一批三项 `P0` 任务的实现子项与协同接口
- `docs/v1-1-state-definition-table.md`
  `v1.1.x` 第一批 7 个关键状态的动作、特效、文案统一定义表
- `docs/v1-1-state-copy-candidates.md`
  `v1.1.x` 第一批 7 个关键状态的文案候选表与语气建议
- `docs/v1-1-state-transition-rules.md`
  `v1.1.x` 第一批 7 个关键状态的进入、退出、时长与冲突规则表
- `docs/v1-1-state-validation-cases.md`
  `v1.1.x` 第一批 7 个关键状态与冲突场景的验证用例表
- `docs/v1-1-state-implementation-mapping.md`
  `v1.1.x` 第一批 7 个关键状态到代码字段、触发入口、反馈入口与验证入口的映射表
- `docs/v1-1-state-field-and-event-schema.md`
  `v1.1.x` 第一批状态继续沿用哪些派生字段、哪些需要补显式事件字段的 schema
- `docs/v1-1-schema-code-refactor-task-list.md`
  `v1.1.x` 把状态 schema 真正落到 `desktop_pet.swift` 的代码改造任务单与推荐顺序
- `docs/v1-1-requirement-package.md`
  `v1.1.x` 的五模块需求包与验收标准
- `docs/v1-dev-preview-package.md`
  `v0.1.0-dev-preview` 的发布包内容清单
- `docs/v1-dev-preview-artifact-spec.md`
  `v0.1.0-dev-preview` 的命名与打包目录规范
- `docs/v1-dev-preview-release-notes.md`
  历史 `dev preview` 发布说明
- `docs/v1-codex-release-notes.md`
  `v1.0.0` Codex 首发正式版发布说明
- `docs/v1-known-limitations-and-feedback.md`
  当前已知限制与正式首发反馈重点
- `docs/v1-codex-publish.md`
  发布到 Codex 的正式操作说明
- `docs/v1-private-beta-quickstart.md`
  面向 Codex 首发用户的最小上手卡

## 任务类型与营养定义

当前定义了 8 类主要任务：

- `coding`
- `writing`
- `research`
- `review`
- `planning`
- `meeting`
- `support`
- `idle`

每种任务会把 Token 映射成不同的营养结果，包括：

- `satiety`
- `energy`
- `focus`
- `mood`
- `hygiene`
- `health`
- `bond`
- `growth`
- `toxicity`

其中 `toxicity` 越高，越容易产生噪声残渣；`growth` 越高，越容易推动进化。

## 跨宿主策略

这个版本的结构刻意把规则层独立出来，原因是：

- Codex 可以先作为首个可安装宿主
- CC 和 Cursor 的事件接入方式可能不同
- 只要 Token 事件和任务标签能接进来，宠物核心逻辑就可以复用

推荐后续实现顺序：

1. 先接 Codex
2. 再补 Cursor 适配器
3. 最后做 CC 适配器和共享周报

## 交互原型

直接打开 `demo/index.html`，可以体验第一版核心循环：

- 选择任务类型
- 输入本次消耗 Token
- 选择产出质量
- 喂养宠物并观察状态变化
- 执行清理、陪玩、睡眠
- 查看当前进化方向和饮食日志

## 桌面桌宠

现在这个插件还带了一个本地桌宠 companion。

启动方式：

1. 运行 `scripts/launch_desktop_pet.command`
2. 或执行 `xcrun swift scripts/desktop_pet.swift`

当前启动会优先保证：

- 桌宠按桌面方式打开
- 桌宠自身做单实例保护，避免重复多开
- bridge 由桌宠本体自行拉起并在后台自愈

桌宠特征：

- 自动监听 Codex 会话中的真实 Token 用量
- 根据最近用户任务描述自动推断任务类型并转成不同粮食
- 始终置顶
- 可拖拽移动
- 靠近屏幕边缘时自动吸附
- 透明悬浮外观，更像真正桌宠而不是面板
- 轻微呼吸和漂浮动画
- 会随时间衰减状态
- 会显示最新一笔 Token 如何转成粮食、粮仓里存了哪些粮
- 会显示当前成长阶段、形态、活动、互动能源和最近动态
- 用户交互收敛成一个动作：拍一下它
- 右键可打开图鉴/状态面板，查看称号、生成特征、偏好和粮仓概览
- 会自己补眠、舔毛整理、追尾巴热身
- 吃完粮食后会逐步积累亲和能与躁动能，拍击会把这些能量释放成不同反馈
- 它会记住你更常怎么拍，逐渐形成不同的拍养关系、称号语气和安抚偏好
- 它会主动长出“这会儿想被怎么拍”的期待，等久了会失落，拍偏了也会表现出没被拍在点上
- 初见待认主、等待回应、失落缩回去、拍偏别扭时，已经有明显不同的姿态和小特效
- 第一次认主的那一下，会有独立的完成演出，不再和普通亲和拍混在一起
- 气泡顶部色条、边框和尾巴位置也会跟着认主、拍准、拍偏、等拍状态变化
- 连续拍击会掉落星屑奖励并解锁图鉴形态
- 星屑累积到阶段节点时会掉落一份惊喜加餐
- 不同进化路线会长出更明显的身份部件和称号
- 一些耳朵、尾巴、斑纹和气场特征会根据长期饮食与关系动态生成
- 它还会逐渐形成偏爱的粮食和安抚方式，作为独特小习惯显示出来
- 会根据长期饮食结构改变形态和台词
- 会根据用户的沟通风格摘要形成不同的形象基调与身份部件，不同人养出来的会更不像同一只默认模板

当前 macOS 默认优先使用原生 `Swift/AppKit` 版本启动；`Python/Tk` 版本保留作逻辑原型。

## 最小安装与启动

如果是第一次在本机体验这只桌宠，建议按下面顺序来：

1. 确认你在 macOS 上，并且本机有 `xcrun` 与 `python3`
2. 确认 `plugins/azai-token-pet/` 目录完整存在
3. 优先直接运行根目录的 `start.command`
4. 第一次启动会自动编译桌宠本体，并由桌宠本体自行唤起 `codex_usage_bridge.py`
5. 桌宠出现后，先让它自然吃一点 Token，再完成第一次轻拍认主

当前版本已经通过一轮短周期重复启停回归：

- 连续 3 轮 `停止 -> 启动 -> 等待` 后，均稳定恢复为 `1` 只桌宠 + `1` 条 bridge
- `desktop-pet.pid` 与 `codex-bridge.pid` 都能和真实进程保持一致

这份启动脚本会自动处理：

- 缺失时编译原生桌宠
- 只保留一只桌宠实例
- 打开桌面 companion

而 `Codex Token bridge` 的守护已经改为由桌宠本体负责，这样启动链更接近真实桌面 companion 的产品形态，也更稳。

如果只是想再次打开已经编好的桌宠，仍然直接运行 `scripts/launch_desktop_pet.command` 即可。

如果你是通过 Codex 本地插件方式安装的，最简单的理解是：

- 启动：`start.command`
- 关闭：`stop.command`
- 重置：`reset.command`

而在 Codex 插件入口里，这一版也已经把第一条 starter prompt 收成了：

- `启动阿在 Token Pet 桌宠`

当前更接近的使用方式是：

- 在 Codex 里点这条 starter prompt
- 或先打开插件里的启动引导页，再点 `启动桌宠`
- 或直接运行插件根目录里的 `start.command`

## 关闭与重置

### 关闭桌宠

如果你只是想把它关掉，而不清空当前养成状态，运行：

- `scripts/stop_desktop_pet.command`

它会关闭：

- 桌宠本体
- Codex bridge 进程

当前状态会保留，下次重新运行 `scripts/launch_desktop_pet.command` 会从现有状态继续。

### 重置当前这只

如果你想从头生成一只新的宠物，运行：

- `scripts/reset_pet_data.command`

它会先停止当前桌宠，然后清空这些运行态文件：

- `runtime/pet-state.json`
- `runtime/pet-config.json`
- `runtime/codex-feed.json`
- `runtime/external-feed.json`
- `runtime/codex-bridge-state.json`

这一步会清掉当前宠物的成长、关系、库存和本地缓存事件。重置后再运行 `scripts/launch_desktop_pet.command`，会生成一只新的宠物。

## 自动喂养

桌宠启动后会自行确保 `codex_usage_bridge.py` 常驻，自动监听 `~/.codex/sessions` 下最新会话日志里的 `token_count` 事件。

当前自动喂养逻辑是：

- 读取真实 Token 增量
- 用最近一条用户消息和当前工作目录推断任务类型
- 先将真实 Token 转成对应类型的粮食库存，再按宠物尺度压缩成可食用粮值
- 宠物会在饿、累或碰到高质量任务餐时自动从粮仓里吃一口
- 现在还支持外部标准事件源，可从 `runtime/external-feed.json` 一起并入消费

这是第一版真实接入，目标是先让宠物和真实工作流绑定起来。后续还可以继续提高任务分类精度。

## 外部来源接入

如果你自己的 API 调用链也想接进来，可以使用：

- `scripts/external_usage_ingest.py`

它会把外部来源统一写成桌宠可消费的标准事件。示例：

```bash
python3 scripts/external_usage_ingest.py \
  --source openai-api \
  --task-type coding \
  --quality solid \
  --real-tokens 24000 \
  --user-text "外部代理里的真实调用"
```

写入后，桌宠会和 Codex 来源一起消费。

## 开机自启

如果希望它每次开机自动弹出：

1. 运行 `scripts/install_autostart.command`
2. 如果以后不想自启，再运行 `scripts/uninstall_autostart.command`

## 本地数据与隐私

当前 `V1` 默认是本地运行态，不依赖远端数据库。

主要本地文件包括：

- `runtime/pet-state.json`
  宠物状态、成长、关系、图鉴、位置
- `runtime/pet-config.json`
  本地开关配置
- `runtime/codex-feed.json`
  从 Codex 会话转换来的喂养事件
- `runtime/external-feed.json`
  外部来源事件
- `runtime/codex-bridge-state.json`
  bridge 的消费游标与跟踪状态
- `runtime/codex-bridge.log`
  bridge 运行日志

当前实现的原则是：

- 优先读取本机已有的 Codex 会话信息
- 优先使用提炼后的风格和事件，不把宠物设计成依赖远端长对话上传
- 桌宠状态默认落在插件目录下的 `runtime/` 中，便于你查看、备份和删除

当前正式版仍然采用本地优先的数据边界，隐私上要明确理解为：

- 它会读取本机 `~/.codex/sessions` 中与 Token 使用有关的事件
- 它会把这些事件转成本地喂养记录
- 当前版本没有把这些运行态数据自动上传到外部服务

如果你不希望它继续读取实时 Token，可以直接关闭桌宠，或在后续设置里关闭来源开关。

## 已知限制

当前 `V1` 还存在这些边界：

- 首发以 `Codex + macOS companion` 为主，其他宿主还不是完整正式接入
- 目前任务分类仍然有启发式成分，不是完全精确语义理解
- 首次诞生的“迎接感”已经建立，但还能继续加强
- 当前已经是 Codex 首发正式版，但发布级安装器还没做，仍以脚本启动为主
- `reset_pet_data.command` 会直接清空当前运行态，不会自动做备份
