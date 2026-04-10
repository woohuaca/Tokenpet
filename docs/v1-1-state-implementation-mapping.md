# 阿在 Token Pet `v1.1.x` 第一批状态实现映射表

## 结论

`v1.1.x` 第一批 7 个关键状态，已经可以统一落到同一套实现骨架里：

1. 用 `PetState` 作为唯一状态真源
2. 用 `bootstrapIdentityIfNeeded()`、`consumeFeedEvents()`、`backgroundTick()`、`performInteraction()` 作为主要触发入口
3. 用 `refresh(message:)` 作为统一渲染入口
4. 用 `bubbleFeedbackStyle(_:)`、`deriveRequest(_:)`、`lastCareSummary` 作为视觉与文案分发层

这意味着 `v1.1.x` 先不新增一套平行状态机。  
先把“字段、触发、反馈、验证”四层映射收紧，让出生、认主、进食、等待、拍准、拍偏、错过都能在当前架构内稳定实现。

## 实现原则

### 1. 单一真源

- 所有状态判断优先落在 `PetState`
- 不在视图层再维护一套独立状态
- 动作、文案、样式都从同一份状态派生

### 2. 单一渲染入口

- 所有状态收尾都进入 `refresh(message:)`
- 不绕开 `refresh(message:)` 直接改气泡、按钮或提示语
- `refresh(message:)` 负责把状态同步到 `sceneView`、气泡、轻提示、日志区和图鉴面板

### 3. 轻状态机，重优先级

- `v1.1.x` 不急着重写成完整显式状态机
- 先通过触发入口和优先级规则收住行为冲突
- 冲突优先级当前按 `认主 > 拍准/拍偏 > 进食 > 等待 > 普通待机` 执行

## 统一实现骨架

代码主文件：

- `scripts/desktop_pet.swift`

统一映射维度：

1. 主字段：状态依赖的 `PetState` 字段
2. 触发入口：状态从哪里进入
3. 反馈入口：动作、气泡、按钮、提示从哪里刷新
4. 文案入口：核心短句和状态摘要从哪里出
5. 验证入口：当前用哪条验收用例兜底

## 一、出生

### 实现映射

- 主字段：
  `petName`、`birthNarrative`、`soulSignature`、`firstBondAt`、`affinityEnergy`、`currentRequest`、`currentRequestAt`、`currentRequestIgnoreLevel`、`currentActivity`、`lastCareSummary`
- 触发入口：
  `bootstrapIdentityIfNeeded()`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `bubbleFeedbackStyle(_:)` 中的 `isBirthBondPending(state)` 分支
- 文案入口：
  `blueprint.birthNarrative`、`state.currentRequest = "想先记住你的手感"`、`state.lastCareSummary = "它刚刚出生，正在试着认你"`
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 1

### 开发说明

- 出生不是单独的视图模式，而是“未认主阶段”的一组状态字段组合
- 出生态下按钮标题会被 `refresh(message:)` 自动切成 `认`
- 出生态下轻提示也会被统一切成“先轻拍一次，它会把你的手感记成自己的第一段关系”

## 二、认主

### 实现映射

- 主字段：
  `firstBondAt`、`bond`、`mood`、`lastImpactTier`、`lastImpactValence`、`lastImpactAt`、`currentActivity`、`lastCareSummary`
- 触发入口：
  `performInteraction()` 里的 `birthPending && result.2 > 0` 分支
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `bubbleFeedbackStyle(_:)` 中 `impact.valence == "bond"` 分支
- 文案入口：
  `finalMessage = "\(petDisplayName(state)) 轻轻贴过来，把你的手感记进了自己身体里。现在，它正式开始跟着你一起长大了。"`
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 2、用例 8、用例 10

### 开发说明

- 认主不是普通拍准的文案变体，而是一次更高优先级的关系事件
- 代码层已经通过 `lastImpactValence = "bond"` 把它和普通 `affinity/agitation` 反馈隔开
- `v1.1.x` 后续如果要补认主余波，优先继续扩这里，不要塞进普通拍准分支

## 三、进食

### 实现映射

- 主字段：
  `foodInventory`、`foodEnergyStock`、`lastConversionSummary`、`lastCareSummary`、`currentActivity`、`satiety`、`energy`、`mood`
- 触发入口：
  `consumeFeedEvents()`、`stashFood(...)`、`eatFromInventory(...)`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `contentView.conversionLabel`、`contentView.logLabel`、`contentView.sceneView.state`
- 文案入口：
  转粮摘要 `summary`、库存摘要 `state.lastConversionSummary`、进食反馈 `reason`
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 3、用例 10

### 开发说明

- “转粮”与“进食”在代码里是两步，不要混成一个状态
- `stashFood(...)` 负责把 Token 变成库存和转化摘要
- `eatFromInventory(...)` 负责真正吃掉库存并刷新动作与文案
- `v1.1.x` 如果要做更明显的进食动作，最好落在 `currentActivity` 和 `sceneView.state` 的组合表现上

## 四、等待

### 实现映射

- 主字段：
  `currentRequest`、`currentRequestAt`、`currentRequestIgnoreLevel`、`pettingNeed`、`affinityEnergy`、`agitationEnergy`
- 触发入口：
  `backgroundTick()`、`deriveRequest(_:)`、`interactionRequestProfile(_:)`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `contentView.requestLabel`、`contentView.hintLabel`、`minimalistStatusText(_:, badge:)`
- 文案入口：
  `activeGrowthRequestText(...)`、`passiveGrowthRequestText(...)`、`requestPromptPrefix(_:)`
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 4

### 开发说明

- 等待不是“没事发生”，而是“已经有期待，但还没被接住”
- 等待态的核心不是大动作，而是 `currentRequest` 和请求年龄
- `refresh(message:)` 已经在请求变化时自动更新 `currentRequestAt` 与忽略等级，这就是等待态后续能进入错过的基础

## 五、拍准

### 实现映射

- 主字段：
  `lastInteractionAt`、`petCombo`、`lastImpactTier`、`lastImpactValence`、`lastImpactAt`、`lastCareSummary`、`affinityEnergy`、`agitationEnergy`
- 触发入口：
  `performInteraction()`、`PetEngine.interact(_:)`、`rewardForMatchedRequest(...)`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `bubbleFeedbackStyle(_:)` 中 `impact.valence == "affinity"` 或躁劲释放分支、`contentView.rewardLabel`
- 文案入口：
  `PetEngine.interact(_:)` 返回的拍击反馈文案、`rewardForMatchedRequest(...)` 命中后的补句
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 5、用例 8

### 开发说明

- 拍准是否成立，当前不是看“有没有拍”，而是看 `desiredTier/desiredValence` 是否与实际释放结果一致
- 这条链已经把“轻拍 / 中拍 / 重拍”与“亲和释放 / 躁劲释放”放在同一个判断里
- `v1.1.x` 后续如果要补互动特效，优先跟 `lastImpactTier` 和 `lastImpactValence` 绑定

## 六、拍偏

### 实现映射

- 主字段：
  `lastCareSummary`、`currentActivity`、`mood`、`agitationEnergy`
- 触发入口：
  `performInteraction()` 后调用 `applyOffBeatInteractionFeedback(...)`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `bubbleFeedbackStyle(_:)` 中 `activity.contains("歪头看你")` 或 `activity.contains("甩了下毛")` 分支
- 文案入口：
  `applyOffBeatInteractionFeedback(...)` 返回文案
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 6、用例 9

### 开发说明

- 拍偏当前不是新状态字段，而是一次“未完全命中请求”的收尾反馈
- 它依赖 `desiredTier/desiredValence` 与实际释放不一致来成立
- `v1.1.x` 如果后面发现拍偏表现不稳，优先考虑补一个显式标记字段，而不是在视图层继续用文案猜状态

## 七、错过

### 实现映射

- 主字段：
  `currentRequestIgnoreLevel`、`currentRequestAt`、`bond`、`mood`、`pettingNeed`、`agitationEnergy`、`toxicity`、`currentActivity`、`lastCareSummary`
- 触发入口：
  `backgroundTick()` 后调用 `applyMissedRequestFeedback(...)`
- 反馈入口：
  `refresh(message:)`
- 视图表现入口：
  `bubbleFeedbackStyle(_:)` 中 `ignoreLevel == 1` 和 `ignoreLevel >= 2` 分支
- 文案入口：
  `applyMissedRequestFeedback(...)` 返回文案
- 验证入口：
  `docs/v1-1-state-validation-cases.md` 用例 7、用例 9

### 开发说明

- 错过依赖“等待持续时间”和“忽略等级”递进，不是单次即时失败
- 当前已经分成两层：
  第一次落空是 `等拍落空`
  第二次升级是 `等拍失落`
- `v1.1.x` 要保持这条递进关系，不要让拍偏和错过在同一轮里连续触发

## 八、统一代码入口对照

### 触发层

- `bootstrapIdentityIfNeeded()`
  负责出生初始化
- `consumeFeedEvents()`
  负责新 Token 转粮和自动触发进食
- `backgroundTick()`
  负责等待推进、错过触发、自主行为和自动代谢
- `performInteraction()`
  负责认主、拍准、拍偏和连拍奖励

### 渲染层

- `refresh(message:)`
  负责统一刷新气泡、状态文案、轻提示、日志、按钮、图鉴和存档
- `bubbleFeedbackStyle(_:)`
  负责把认主、拍准、拍偏、错过映射成不同反馈样式

### 文案层

- `defaultBubble(for:)`
  负责普通待机文案
- `deriveRequest(_:)`
  负责等待请求文案
- `applyMissedRequestFeedback(...)`
  负责错过文案
- `applyOffBeatInteractionFeedback(...)`
  负责拍偏文案

## 九、当前最值得补的实现空位

### P0

- 给拍偏增加显式标记字段，减少只靠 `currentActivity` 猜状态的隐性耦合
- 给进食增加短时可识别的动作反馈，而不只是文案和摘要变化
- 给认主增加一个短余波窗口，让它与普通拍准的时间感更明显拉开

### P1

- 给等待补更明确的轻动作节奏，而不是主要靠请求文案承载期待感
- 给出生补一段更稳定的首屏动作收束，让“刚醒来”更直观

## 十、落地顺序建议

1. 先保证这 7 个状态都只通过现有主入口进入
2. 再补显式字段，减少通过文案和动作字符串猜状态
3. 最后再补更细的动作、特效和节奏差异

这样做的好处是，`v1.1.x` 可以先把解释性和稳定性守住，再继续把情绪价值做深。
