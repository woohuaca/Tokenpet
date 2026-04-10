# 阿在 Token Pet `v1.1.x` 第一批状态字段与事件 Schema

## 结论

`v1.1.x` 第一批状态实现，最适合采用这套轻量 schema：

1. 继续用 `PetState` 作为唯一持久化真源
2. 继续让“出生 / 等待 / 进食”主要由现有字段派生
3. 给“认主 / 拍准 / 拍偏 / 错过”补最少量的显式事件字段
4. 不引入完整平行状态机，不引入自由形 `extraState` 之类的兜底字段

一句话说，就是：  
生命状态继续靠 `PetState`，瞬时反馈改为“显式事件壳层”，这样既不推翻当前架构，也能把最脆弱的情绪反馈收稳。

## 这份 Schema 要解决什么

这份文档服务的是两个实际问题：

1. 现在部分状态还在靠 `currentActivity` 或文案内容反推
2. 瞬时反馈没有统一事件壳层，导致动作、气泡、验证容易分叉

`v1.1.x` 需要的不是更复杂的状态机，而是更清楚的边界：

- 什么属于长期生命状态
- 什么属于短时互动事件
- 哪些继续派生
- 哪些必须显式记录

## 一、Schema 总原则

### 1. 长期状态不重复存

- 身体、成长、关系、库存、请求这些长期状态继续存在 `PetState`
- 不再为它们复制一套 `currentVisualState` 或 `currentMoodState`

### 2. 瞬时反馈要显式化

- 认主、拍准、拍偏、错过这些“短时但重要”的反馈，要有显式事件标记
- 不能继续主要靠文案字符串或 `currentActivity` 内容猜测

### 3. 字段尽量扁平

- `v1.1.x` 先不引入复杂嵌套对象
- 优先使用少量可迁移、可回填、可序列化的扁平可选字段

### 4. 不引入自由形扩展字段

- 不加 `metadata: [String: Any]`
- 不加 `debugState`
- 不加“先塞 JSON 再说”的临时方案

## 二、字段分层

### A. 生命底座层

这些字段继续作为生命系统真源，不新增平替：

- 身体与成长：
  `satiety`、`energy`、`focus`、`mood`、`hygiene`、`health`、`bond`、`growth`、`toxicity`、`residue`、`ageHours`
- 身份与个体：
  `petName`、`soulSignature`、`speakingStyle`、`appearanceHint`、`firstImpression`、`birthNarrative`、`styleVector`、`identitySeed`、`identityGeneratedAt`、`identityVersion`
- 长势与个体分化：
  `stage`、`form`、`archetypeScore`、`growthPhaseImprint`
- 粮仓与转化：
  `foodInventory`、`foodEnergyStock`、`lastConversionSummary`
- 关系与互动积累：
  `firstBondAt`、`pettingNeed`、`affinityEnergy`、`agitationEnergy`

### B. 请求生命周期层

这些字段继续承接“等待 -> 被接住 / 被错过”的主线：

- `currentRequest`
- `currentRequestAt`
- `currentRequestIgnoreLevel`

判断规则：

- `currentRequest != nil` 说明宠物此刻有明确期待
- `currentRequestAt` 说明这轮期待从何时开始
- `currentRequestIgnoreLevel` 说明这轮期待已经被忽略到哪一层

### C. 互动释放层

这些字段继续承接“拍出了什么”：

- `lastInteractionAt`
- `petCombo`
- `lastImpactTier`
- `lastImpactValence`
- `lastImpactAt`
- `gentleImpactCount`
- `mediumImpactCount`
- `heavyImpactCount`
- `affinityReleaseCount`
- `agitationReleaseCount`

判断规则：

- 这层负责“拍击结果”
- 不负责“这次结果在情绪上算拍准、拍偏还是认主”
- 情绪意义需要通过请求命中关系和事件壳层补足

## 三、`v1.1.x` 建议新增的显式字段

### P0 新增字段

建议只补这 6 个字段：

- `activeFeedbackKey: String?`
- `activeFeedbackSource: String?`
- `activeFeedbackAt: Double?`
- `activeFeedbackDuration: Double?`
- `activeFeedbackPriority: Int?`
- `lastResolvedRequestOutcome: String?`

### 每个字段的职责

`activeFeedbackKey`

- 当前短时反馈是什么
- 用于驱动气泡样式、动作反馈和验证断言
- 取值必须来自固定枚举，不接受自由文本

`activeFeedbackSource`

- 这次反馈由哪个主入口触发
- 只允许：
  `bootstrap`、`feed`、`background`、`interaction`

`activeFeedbackAt`

- 反馈开始时间
- 用于控制短时状态样式、过期和回收

`activeFeedbackDuration`

- 反馈建议持续时长
- 用于认主余波、拍准余波、拍偏停顿、错过落空的时间控制

`activeFeedbackPriority`

- 反馈优先级
- 用于冲突解决
- `v1.1.x` 先统一：
  `认主 90`
  `拍准/拍偏 70`
  `进食 50`
  `等待 30`
  `普通待机 0`

`lastResolvedRequestOutcome`

- 本轮请求最终怎么收尾
- 这不是长期心情，而是最近一次请求的结果标签

## 四、固定枚举值

### `activeFeedbackKey`

`v1.1.x` 第一批先固定为：

- `birth_intro`
- `bond_complete`
- `meal_eaten`
- `request_waiting`
- `interaction_matched_affinity`
- `interaction_matched_agitation`
- `interaction_offbeat`
- `request_missed_once`
- `request_missed_twice`

### `lastResolvedRequestOutcome`

- `none`
- `bond_complete`
- `matched`
- `offbeat`
- `missed_once`
- `missed_twice`

### `activeFeedbackSource`

- `bootstrap`
- `feed`
- `background`
- `interaction`

## 五、7 个关键状态的字段策略

| 状态 | 主要方式 | 继续沿用的现有字段 | 需要新增显式字段 |
| --- | --- | --- | --- |
| 出生 | 以派生为主 | `birthNarrative` `firstBondAt` `currentRequest` | 可选补 `activeFeedbackKey = birth_intro` |
| 认主 | 派生 + 显式事件 | `firstBondAt` `lastImpactValence` `lastImpactAt` | `activeFeedbackKey` `lastResolvedRequestOutcome = bond_complete` |
| 进食 | 以派生为主 | `foodInventory` `foodEnergyStock` `lastConversionSummary` `lastCareSummary` | `activeFeedbackKey = meal_eaten` |
| 等待 | 以派生为主 | `currentRequest` `currentRequestAt` `currentRequestIgnoreLevel` | 可选补 `activeFeedbackKey = request_waiting` |
| 拍准 | 派生 + 显式事件 | `lastImpactTier` `lastImpactValence` `lastImpactAt` | `activeFeedbackKey = interaction_matched_*` `lastResolvedRequestOutcome = matched` |
| 拍偏 | 显式事件为主 | `currentActivity` `lastCareSummary` | `activeFeedbackKey = interaction_offbeat` `lastResolvedRequestOutcome = offbeat` |
| 错过 | 派生 + 显式事件 | `currentRequestIgnoreLevel` `currentRequestAt` | `activeFeedbackKey = request_missed_once/twice` `lastResolvedRequestOutcome = missed_*` |

## 六、为什么拍偏和错过必须显式化

### 拍偏

当前拍偏主要靠：

- `applyOffBeatInteractionFeedback(...)` 改 `currentActivity`
- `bubbleFeedbackStyle(_:)` 再用 `activity.contains(...)` 猜

这个方式的问题是：

- 文案一改，视觉判断就可能失真
- 动作一改，验证条件就可能失真
- 很难给拍偏单独加持续时间和优先级

所以 `v1.1.x` 应该把拍偏从“字符串推断态”升级为“显式事件态”。

### 错过

错过虽然已有 `currentRequestIgnoreLevel`，但它只说明“被忽略到第几层”，不等于“当前正在播哪种反馈”。

还缺的是：

- 这次错过反馈有没有刚触发
- 当前应该播 `落空` 还是 `失落`
- 这段反馈要持续多久

因此错过也需要 `activeFeedbackKey` 这层壳来做统一渲染。

## 七、建议写入规则

### `bootstrapIdentityIfNeeded()`

写入：

- `activeFeedbackKey = birth_intro`
- `activeFeedbackSource = bootstrap`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 3.5`
- `activeFeedbackPriority = 40`
- `lastResolvedRequestOutcome = none`

### `eatFromInventory(...)`

写入：

- `activeFeedbackKey = meal_eaten`
- `activeFeedbackSource = feed`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 2.4`
- `activeFeedbackPriority = 50`

### `performInteraction()`

如果认主：

- `activeFeedbackKey = bond_complete`
- `activeFeedbackSource = interaction`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 4.2`
- `activeFeedbackPriority = 90`
- `lastResolvedRequestOutcome = bond_complete`

如果拍准：

- `activeFeedbackKey = interaction_matched_affinity` 或 `interaction_matched_agitation`
- `activeFeedbackSource = interaction`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 2.2`
- `activeFeedbackPriority = 70`
- `lastResolvedRequestOutcome = matched`

如果拍偏：

- `activeFeedbackKey = interaction_offbeat`
- `activeFeedbackSource = interaction`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 2.0`
- `activeFeedbackPriority = 70`
- `lastResolvedRequestOutcome = offbeat`

### `applyMissedRequestFeedback(...)`

第一次落空：

- `activeFeedbackKey = request_missed_once`
- `activeFeedbackSource = background`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 2.8`
- `activeFeedbackPriority = 60`
- `lastResolvedRequestOutcome = missed_once`

第二次失落：

- `activeFeedbackKey = request_missed_twice`
- `activeFeedbackSource = background`
- `activeFeedbackAt = now`
- `activeFeedbackDuration = 3.4`
- `activeFeedbackPriority = 65`
- `lastResolvedRequestOutcome = missed_twice`

## 八、建议读取规则

### `refresh(message:)`

负责：

- 读取 `activeFeedbackKey`
- 在反馈未过期时优先使用事件壳层
- 反馈过期后再退回普通派生逻辑

### `bubbleFeedbackStyle(_:)`

优先级应改为：

1. 先看 `activeFeedbackKey`
2. 再看 `lastImpactValence` 等短时冲击字段
3. 最后才回退到 `currentActivity` 与默认情绪色

### 验证层

验收时优先断言：

- `activeFeedbackKey`
- `lastResolvedRequestOutcome`
- 对应持续时长和优先级

而不是只断言一条气泡文案。

## 九、明确不做什么

`v1.1.x` 这轮先不做：

- 不新增完整 `enum PetVisualState`
- 不把 7 个状态都硬塞成单一互斥枚举
- 不引入复杂事件队列
- 不把所有反馈都改成嵌套对象
- 不允许用自由文本充当枚举值

## 十、迁移策略

### 1. 旧存档兼容

- 新字段全部使用可选字段
- `hydratedState(_:)` 负责补默认值
- 旧存档没有这些字段也能正常加载

### 2. 新字段回填

首版不要求历史回放，只要求：

- 新触发的反馈都写入新字段
- 老存档在首次新互动后自然进入新轨道

### 3. 开发顺序

1. 先在 `PetState` 补字段
2. 再改 `performInteraction()` 与 `applyMissedRequestFeedback(...)` 写事件壳层
3. 再改 `bubbleFeedbackStyle(_:)` 优先读事件壳层
4. 最后补验证脚本和状态验收

## 十一、最终建议

`v1.1.x` 第一批最重要的不是把状态系统做大，而是把它做准。

因此这轮 schema 的最佳策略是：

- 长期状态继续派生
- 短时反馈显式化
- 字段保持扁平
- 事件枚举保持收敛

这样既能守住“Token 到宠物”的解释性，也能把“情绪价值反馈”真正做稳。
