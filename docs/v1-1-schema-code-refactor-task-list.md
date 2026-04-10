# 阿在 Token Pet `v1.1.x` 状态 Schema 代码改造任务单

## 结论

`v1.1.x` 下一阶段最合理的推进方式，不是直接大改整套桌宠逻辑，而是围绕 [desktop_pet.swift](/Users/woohuaca/Library/CloudStorage/OneDrive-Personal/Ruijie%20Work/2026-new%20AI/plugins/azai-token-pet/scripts/desktop_pet.swift) 做一轮有边界的 schema 收口。

这轮代码改造任务可以压成 4 组：

1. 数据结构补字段
2. 事件写入链路收口
3. 渲染读取链路收口
4. 验证与回归收口

核心目标不是“让代码更像状态机”，而是：

- 不再主要靠字符串猜拍偏和错过
- 让认主、拍准、拍偏、错过有统一事件壳层
- 让后续动作、文案、特效能挂在同一组事件字段上

## 一、任务拆分原则

### 1. 先收数据，再收表现

- 先补 `PetState` 字段和 hydration
- 再补写入逻辑
- 最后再改 `bubbleFeedbackStyle(_:)` 和 `refresh(message:)`

### 2. 先收脆弱点，再收锦上添花

P0 先处理：

- 拍偏
- 错过
- 认主优先级

P1 再处理：

- 进食短时反馈
- 等待短时反馈

### 3. 每次改动都必须可验证

- 每一组改动都要能对应到现有验证用例
- 不允许出现“字段加了，但验证层还看不到”的半完成状态

## 二、代码触点总表

当前主要触点集中在：

- `struct PetState`
- `func hydratedState(_:)`
- `func bootstrapIdentityIfNeeded()`
- `func eatFromInventory(...)`
- `func applyMissedRequestFeedback(...)`
- `func performInteraction()`
- `func bubbleFeedbackStyle(_:)`
- `func refresh(message:)`

这意味着第一轮代码改造不需要拆文件，先在单文件内完成一致性收口即可。

## 三、P0 任务单

### 任务 1：给 `PetState` 增加显式反馈字段

目标：

- 让短时反馈有统一事件壳层

修改位置：

- `struct PetState`
- `defaultState`
- `hydratedState(_:)`

建议新增字段：

- `activeFeedbackKey: String?`
- `activeFeedbackSource: String?`
- `activeFeedbackAt: Double?`
- `activeFeedbackDuration: Double?`
- `activeFeedbackPriority: Int?`
- `lastResolvedRequestOutcome: String?`

验收标准：

- 旧存档可正常加载
- 新字段缺失时会被安全补默认值
- 不影响当前启动与存档读写

### 任务 2：补一组统一反馈写入助手

目标：

- 避免每个入口函数手写一套重复字段赋值

修改位置：

- `desktop_pet.swift` 新增 helper 函数，建议放在状态辅助函数区域

建议新增函数：

- `setActiveFeedback(...)`
- `clearExpiredFeedback(...)`
- `canOverrideFeedback(...)`

函数职责：

- `setActiveFeedback(...)`
  统一写 `key/source/at/duration/priority`
- `clearExpiredFeedback(...)`
  在过期后清掉当前反馈壳层
- `canOverrideFeedback(...)`
  用优先级判断当前反馈是否允许被新反馈覆盖

验收标准：

- 新增反馈不需要在多处手工散写同样字段
- 覆盖顺序可以统一判断，而不是分散在 if 里硬编码

### 任务 3：把认主写进显式反馈链路

目标：

- 让认主不再只靠 `lastImpactValence = "bond"` 撑全链路

修改位置：

- `performInteraction()`

具体改造：

- 在 `birthPending && result.2 > 0` 分支里写入：
  `activeFeedbackKey = bond_complete`
- 写入：
  `activeFeedbackSource = interaction`
  `activeFeedbackDuration`
  `activeFeedbackPriority`
  `lastResolvedRequestOutcome = bond_complete`

验收标准：

- 认主时能稳定命中统一反馈壳层
- 后续即使改文案，认主视觉与验证都不失真
- 与 [v1-1-state-validation-cases.md](/Users/woohuaca/Library/CloudStorage/OneDrive-Personal/Ruijie%20Work/2026-new%20AI/plugins/azai-token-pet/docs/v1-1-state-validation-cases.md) 用例 2、8、10 对齐

### 任务 4：把拍偏从字符串推断改成显式反馈

目标：

- 解决目前拍偏主要靠 `currentActivity.contains(...)` 猜状态的问题

修改位置：

- `applyOffBeatInteractionFeedback(...)`
- `performInteraction()`
- `bubbleFeedbackStyle(_:)`

具体改造：

- 在拍偏成立时写入：
  `activeFeedbackKey = interaction_offbeat`
- 在 `bubbleFeedbackStyle(_:)` 中优先读这个 key
- 保留旧字符串判断作为短期兜底，但优先级降到后面

验收标准：

- 拍偏气泡样式不再依赖特定文案字符串
- 后续修改拍偏文案不需要同步改视觉条件
- 与验证用例 6、9 对齐

### 任务 5：把错过反馈升级成显式事件

目标：

- 区分“请求已被忽略到第几层”和“当前应该播哪种落空反馈”

修改位置：

- `applyMissedRequestFeedback(...)`
- `bubbleFeedbackStyle(_:)`
- `refresh(message:)`

具体改造：

- 第一次落空写入：
  `request_missed_once`
- 第二次失落写入：
  `request_missed_twice`
- `bubbleFeedbackStyle(_:)` 先读显式 key，再回退到 `ignoreLevel`

验收标准：

- 错过样式可由事件 key 直接判断
- `ignoreLevel` 继续保留为请求生命周期字段，不再同时肩负表现层职责
- 与验证用例 7、9 对齐

## 四、P1 任务单

### 任务 6：给拍准补统一事件 key

目标：

- 让拍准的视觉和验证也接入统一反馈壳层

修改位置：

- `performInteraction()`
- `rewardForMatchedRequest(...)`
- `bubbleFeedbackStyle(_:)`

具体改造：

- 亲和命中：
  `interaction_matched_affinity`
- 躁劲命中：
  `interaction_matched_agitation`

验收标准：

- 拍准不再只依赖 `lastImpactValence + tier` 间接推断
- 与验证用例 5、8 对齐

### 任务 7：给进食补短时反馈 key

目标：

- 让进食从“只有摘要和文案变化”升级成可识别短时状态

修改位置：

- `eatFromInventory(...)`
- `consumeFeedEvents()`
- `bubbleFeedbackStyle(_:)`

具体改造：

- 真正吃掉库存时写入：
  `activeFeedbackKey = meal_eaten`

验收标准：

- 进食能有自己的一段短时反馈窗口
- 不需要和认主、拍准抢优先级时序
- 与验证用例 3、10 对齐

### 任务 8：给等待补轻量显式反馈 key

目标：

- 让等待不仅存在于请求文本，也存在于统一反馈框架里

修改位置：

- `backgroundTick()`
- `refresh(message:)`

具体改造：

- 当 `currentRequest` 新生成且没有更高优先级反馈时，写入：
  `activeFeedbackKey = request_waiting`

验收标准：

- 等待可被更稳定地识别
- 但不能因此把等待做成高优先级强覆盖态

## 五、P2 任务单

### 任务 9：把出生也接进事件壳层

目标：

- 让出生与“未认主阶段”从结构上更清晰

修改位置：

- `bootstrapIdentityIfNeeded()`
- `bubbleFeedbackStyle(_:)`

具体改造：

- 初始化时写入：
  `activeFeedbackKey = birth_intro`

验收标准：

- 出生开场可单独控制持续时间和样式
- 不影响当前认主逻辑

### 任务 10：补反馈过期与清理规则

目标：

- 避免短时反馈长期滞留

修改位置：

- `refresh(message:)`
- `backgroundTick()`

具体改造：

- 每次渲染或 tick 前清理过期反馈
- 过期后退回普通派生逻辑

验收标准：

- 不出现“已经结束的拍偏/错过/进食样式还挂着”

## 六、推荐开发顺序

### 第一轮

1. 任务 1
2. 任务 2
3. 任务 3
4. 任务 4
5. 任务 5

目标：

- 先把最脆弱、最影响情绪反馈可信度的几条线收住

### 第二轮

1. 任务 6
2. 任务 7
3. 任务 8

目标：

- 让统一反馈壳层从“补漏洞”升级成“统一框架”

### 第三轮

1. 任务 9
2. 任务 10

目标：

- 收尾出生和反馈过期逻辑，补完整性

## 七、每轮完成后必须做的回归

### 基础回归

- 能正常启动桌宠
- 能正常保存和加载存档
- 旧存档不会因新字段崩掉

### 行为回归

- 首次启动进入出生
- 首次拍中进入认主
- 拍偏不会误判成拍准
- 拍偏后同一轮不会立刻又触发错过
- 错过能区分 `落空` 和 `失落`
- 进食不会盖掉认主

### 文档回归

- [v1-1-state-validation-cases.md](/Users/woohuaca/Library/CloudStorage/OneDrive-Personal/Ruijie%20Work/2026-new%20AI/plugins/azai-token-pet/docs/v1-1-state-validation-cases.md) 对应验收项可继续沿用
- [v1-1-state-field-and-event-schema.md](/Users/woohuaca/Library/CloudStorage/OneDrive-Personal/Ruijie%20Work/2026-new%20AI/plugins/azai-token-pet/docs/v1-1-state-field-and-event-schema.md) 的字段约束没有被绕开

## 八、明确不建议的做法

- 不建议先重写成完整 enum 状态机
- 不建议先拆多个文件再重构逻辑
- 不建议先上动画特效，再回头补字段
- 不建议继续增加更多 `activity.contains(...)` 判断

## 九、最终建议

这轮最应该做的，是把 schema 从“文档正确”推进到“代码入口一致”。

因此下一步最优先的实际开发顺序是：

1. 先补字段
2. 再补统一写入 helper
3. 先收认主、拍偏、错过
4. 再收拍准、进食、等待

这样做，能以最小改动把 `v1.1.x` 的生命反馈和情绪反馈一起拉稳。
