# 阿在 Token Pet 宿主接入协议

目标回答的 Charter 问题：How

## 结论

要同时支持 Codex、CC、Cursor，最稳妥的方式不是先绑死某一个宿主 API，而是定义统一事件协议，让所有宿主都把数据翻译成同一类宠物事件。

## 一、统一输入事件

宿主层最终只需要向核心引擎提交四类事件：

### 1. token_usage

表示一次可被喂养的 Token 消耗。

建议字段：

```json
{
  "type": "token_usage",
  "taskType": "coding",
  "tokensSpent": 4200,
  "outputQuality": "solid",
  "timestamp": "2026-04-07T20:30:00+08:00",
  "sessionId": "session-123",
  "source": "codex"
}
```

### 2. time_decay

表示一段时间流逝，用于触发饱腹度、活力和清洁度衰减。

```json
{
  "type": "time_decay",
  "hours": 3
}
```

### 3. care_action

表示用户主动照料宠物。

```json
{
  "type": "care_action",
  "action": "clean"
}
```

可选值：

- `clean`
- `play`
- `sleep`

### 4. weekly_summary

用于生成周报、挑战结果和进化解释。

```json
{
  "type": "weekly_summary",
  "periodStart": "2026-04-01",
  "periodEnd": "2026-04-07"
}
```

## 二、任务类型标准化

不同宿主原始标签会不同，但进入核心引擎前应统一归一成以下 8 类：

- `coding`
- `writing`
- `research`
- `review`
- `planning`
- `meeting`
- `support`
- `idle`

这样做的原因是：

- MVP 阶段先保证高可信解释，而不是追求无限细分
- 进化路线和营养逻辑可以稳定复用
- 多宿主数据可以横向比较

## 三、宿主职责边界

### 宿主适配层负责

- 读取原始 Token 数据
- 推断任务类型
- 评估产出质量
- 把数据映射为统一事件
- 将状态结果回写 UI

### 核心引擎负责

- 计算营养结果
- 更新宠物状态
- 推导情绪标签
- 推导成长阶段
- 推导进化形态
- 输出周度解释

## 四、各宿主建议接法

### Codex

优先接入，因为插件形态最直接。

建议能力：

- 会话级 Token 使用量
- Prompt 或任务标签
- 侧边栏宠物面板
- 周报卡片

### Cursor

重点观察编辑器侧 UI 与 Webview 面板。

建议能力：

- Chat Token 使用量
- 当前工作区上下文
- 命令触发照料动作

### CC

建议先走轻量模式，只做会话后总结和周报，不抢第一版实时体验。

建议能力：

- 会话 Token 汇总
- 会话类型标签
- 面板化状态展示

## 五、MVP 接入原则

第一版必须坚持以下原则：

- 自动喂养优先，减少手动输入
- 分类准确优先于分类精细
- 解释可信优先于动画复杂
- 先做单宠物，再考虑多宠物或宠物社交

## 六、后续扩展

当 MVP 验证通过后，可以继续增加：

- 宠物图鉴
- 不同人格初始蛋
- 团队宠物
- 周挑战和成就系统
- Token 预算模式
