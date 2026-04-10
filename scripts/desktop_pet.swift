import AppKit
import Darwin
import Foundation

struct NutritionProfile: Codable {
    let label: String
    let satiety: Double
    let energy: Double
    let focus: Double
    let mood: Double
    let hygiene: Double
    let health: Double
    let bond: Double
    let growth: Double
    let toxicity: Double
    let archetypes: [String: Double]
}

struct Meal {
    let taskType: String
    let label: String
    let tokensSpent: Double
    let satiety: Double
    let energy: Double
    let focus: Double
    let mood: Double
    let hygiene: Double
    let health: Double
    let bond: Double
    let growth: Double
    let toxicity: Double
    let residue: Double
    let archetypes: [String: Double]
}

struct PetState: Codable {
    var stage: String
    var form: String
    var petName: String?
    var soulSignature: String?
    var speakingStyle: String?
    var appearanceHint: String?
    var firstImpression: String?
    var birthNarrative: String?
    var styleVector: [String: Double]?
    var identitySeed: Int?
    var identityGeneratedAt: Double?
    var identityVersion: Int?
    var firstBondAt: Double?
    var satiety: Double
    var energy: Double
    var focus: Double
    var mood: Double
    var hygiene: Double
    var health: Double
    var bond: Double
    var growth: Double
    var toxicity: Double
    var residue: Double
    var ageHours: Double
    var lastTaskType: String?
    var windowX: Double
    var windowY: Double
    var archetypeScore: [String: Double]
    var lastCodexEventID: String?
    var foodInventory: [String: Int]?
    var foodEnergyStock: [String: Double]?
    var currentActivity: String?
    var recentFoodLog: [String]?
    var pettingNeed: Double?
    var lastFoodName: String?
    var currentRequest: String?
    var currentRequestAt: Double?
    var currentRequestIgnoreLevel: Int?
    var petCombo: Int?
    var lastInteractionAt: Double?
    var rewardStars: Int?
    var unlockedForms: [String]?
    var lastConversionSummary: String?
    var lastCareSummary: String?
    var consumedEventIDs: [String]?
    var tokenLedger: [TokenLedgerEntry]?
    var growthPhaseImprint: [String: Double]?
    var affinityEnergy: Double?
    var agitationEnergy: Double?
    var lastImpactTier: Int?
    var lastImpactValence: String?
    var lastImpactAt: Double?
    var gentleImpactCount: Int?
    var mediumImpactCount: Int?
    var heavyImpactCount: Int?
    var affinityReleaseCount: Int?
    var agitationReleaseCount: Int?
    var activeFeedbackKey: String?
    var activeFeedbackSource: String?
    var activeFeedbackAt: Double?
    var activeFeedbackDuration: Double?
    var activeFeedbackPriority: Int?
    var lastResolvedRequestOutcome: String?
}

struct StageInfo {
    let name: String
    let minGrowth: Double
    let label: String
}

struct TraitProfile {
    let earStyle: String
    let tailStyle: String
    let markStyle: String
    let auraStyle: String
    let shortLabel: String
}

struct HabitProfile {
    let favoriteFood: String
    let comfortAction: String
    let shortLabel: String
}

struct ImpactFeedback {
    let tier: Int
    let valence: String
    let age: Double
}

struct ActiveFeedback {
    let key: String
    let source: String
    let age: Double
    let priority: Int
}

struct InteractionRequestProfile {
    let text: String?
    let desiredTier: Int?
    let desiredValence: String?
    let actionable: Bool
}

struct BubbleFeedbackStyle {
    let badge: String?
    let accentColor: NSColor
    let borderColor: NSColor
    let fillColor: NSColor
    let requestColor: NSColor
    let logColor: NSColor
    let accentWidth: CGFloat
    let tailShift: CGFloat
}

struct GrowthBalanceProfile {
    let title: String
    let note: String
    let growthMultiplier: Double
    let bondMultiplier: Double
    let mealMoodBias: Double
    let mealHealthBias: Double
    let toxicityMultiplier: Double
    let residueMultiplier: Double
    let affinityMultiplier: Double
    let agitationMultiplier: Double
    let moodDecayMultiplier: Double
    let pettingNeedMultiplier: Double
}

struct IdentityBlueprint {
    let petName: String
    let soulSignature: String
    let speakingStyle: String
    let appearanceHint: String
    let firstImpression: String
    let birthNarrative: String
    let styleVector: [String: Double]
    let seed: Int
}

struct IdentityVisualProfile {
    let label: String
    let silhouette: String
    let accessory: String
    let bodyWidthBias: CGFloat
    let bodyHeightBias: CGFloat
    let tailSwingBias: CGFloat
    let browTiltBias: CGFloat
}

struct FeedEvent: Codable {
    let id: String
    let timestamp: String?
    let source: String
    let session_path: String
    let cwd: String
    let task_type: String
    let quality: String
    let real_tokens: Double
    let input_tokens: Double
    let output_tokens: Double
    let reasoning_tokens: Double
    let user_text: String
}

struct FeedEnvelope: Codable {
    let latest_event_id: String?
    let events: [FeedEvent]
    let updated_at: String?
}

struct TokenLedgerEntry: Codable {
    let timestamp: String?
    let source: String
    let taskType: String
    let quality: String
    let realTokens: Double
    let food: String
    let servings: Int
    let petTokens: Double
    let autoAte: Bool
}

struct PetConfig: Codable {
    var autoEatEnabled: Bool
    var codexSourceEnabled: Bool
    var externalSourceEnabled: Bool
}

let qualityMultiplier: [String: Double] = [
    "breakthrough": 1.25,
    "solid": 1.0,
    "partial": 0.78,
    "waste": 0.45
]

let identityGeneratorVersion = 2

let stages: [StageInfo] = [
    StageInfo(name: "egg", minGrowth: 0, label: "宠物蛋"),
    StageInfo(name: "sprout", minGrowth: 25, label: "发芽期"),
    StageInfo(name: "child", minGrowth: 60, label: "幼年期"),
    StageInfo(name: "teen", minGrowth: 120, label: "成长期"),
    StageInfo(name: "adult", minGrowth: 220, label: "成熟体"),
    StageInfo(name: "mythic", minGrowth: 360, label: "传说体")
]

let formLabels: [String: String] = [
    "neutral": "中性",
    "builder": "建造型",
    "scholar": "学者型",
    "captain": "指挥型",
    "social": "社交型",
    "chaos": "混乱型"
]

let formColors: [String: NSColor] = [
    "neutral": NSColor(calibratedRed: 1.00, green: 0.48, blue: 0.35, alpha: 1.0),
    "builder": NSColor(calibratedRed: 0.94, green: 0.42, blue: 0.20, alpha: 1.0),
    "scholar": NSColor(calibratedRed: 1.00, green: 0.42, blue: 0.35, alpha: 1.0),
    "captain": NSColor(calibratedRed: 0.91, green: 0.36, blue: 0.36, alpha: 1.0),
    "social": NSColor(calibratedRed: 0.95, green: 0.61, blue: 0.20, alpha: 1.0),
    "chaos": NSColor(calibratedRed: 0.48, green: 0.36, blue: 0.95, alpha: 1.0)
]

let formBubble: [String: String] = [
    "neutral": "我还在观察你的工作习惯。",
    "builder": "开发餐让我越来越像一个会搭东西的小兽。",
    "scholar": "研究和写作让我脑子发亮，但也容易过劳。",
    "captain": "规划和评审让我很有秩序感。",
    "social": "支持别人会让我更亲人。",
    "chaos": "别再喂我空转和会议垃圾餐了。"
]

let taskPresets: [(title: String, taskType: String, tokens: Double, quality: String)] = [
    ("开发", "coding", 4200, "solid"),
    ("写作", "writing", 3600, "solid"),
    ("研究", "research", 5200, "breakthrough"),
    ("会议", "meeting", 2800, "partial"),
    ("空转", "idle", 2400, "waste")
]

let defaultState = PetState(
    stage: "egg",
    form: "neutral",
    petName: nil,
    soulSignature: nil,
    speakingStyle: nil,
    appearanceHint: nil,
    firstImpression: nil,
    birthNarrative: nil,
    styleVector: nil,
    identitySeed: nil,
    identityGeneratedAt: nil,
    identityVersion: nil,
    firstBondAt: nil,
    satiety: 45,
    energy: 55,
    focus: 50,
    mood: 55,
    hygiene: 60,
    health: 60,
    bond: 10,
    growth: 0,
    toxicity: 0,
    residue: 0,
    ageHours: 0,
    lastTaskType: nil,
    windowX: 1120,
    windowY: 160,
    archetypeScore: [
        "builder": 0,
        "scholar": 0,
        "captain": 0,
        "social": 0,
        "chaos": 0
    ],
    lastCodexEventID: nil,
    foodInventory: [:],
    foodEnergyStock: [:],
    currentActivity: "慢悠悠巡桌",
    recentFoodLog: [],
    pettingNeed: 18,
    lastFoodName: nil,
    currentRequest: nil,
    currentRequestAt: nil,
    currentRequestIgnoreLevel: 0,
    petCombo: 0,
    lastInteractionAt: nil,
    rewardStars: 0,
    unlockedForms: ["neutral"],
    lastConversionSummary: nil,
    lastCareSummary: "刚睡醒，正慢悠悠巡桌",
    consumedEventIDs: [],
    tokenLedger: [],
    growthPhaseImprint: ["节制": 0, "舒展": 0, "亢奋": 0, "压仓": 0],
    affinityEnergy: 8,
    agitationEnergy: 4,
    lastImpactTier: 0,
    lastImpactValence: "none",
    lastImpactAt: nil,
    gentleImpactCount: 0,
    mediumImpactCount: 0,
    heavyImpactCount: 0,
    affinityReleaseCount: 0,
    agitationReleaseCount: 0,
    activeFeedbackKey: nil,
    activeFeedbackSource: nil,
    activeFeedbackAt: nil,
    activeFeedbackDuration: nil,
    activeFeedbackPriority: nil,
    lastResolvedRequestOutcome: "none"
)

let defaultConfig = PetConfig(
    autoEatEnabled: true,
    codexSourceEnabled: true,
    externalSourceEnabled: true
)

func clamp(_ value: Double, minimum: Double = 0, maximum: Double = 100) -> Double {
    min(maximum, max(minimum, value))
}

func round1(_ value: Double) -> Double {
    (value * 10).rounded() / 10
}

func tokenUnits(_ tokensSpent: Double) -> Double {
    guard tokensSpent > 0 else { return 0 }
    return max(1, sqrt(tokensSpent / 1000) * 3)
}

func deriveStage(_ growth: Double) -> String {
    var current = stages[0]
    for stage in stages where growth >= stage.minGrowth {
        current = stage
    }
    return current.name
}

func stageLabel(for name: String) -> String {
    stages.first(where: { $0.name == name })?.label ?? name
}

func petDisplayName(_ state: PetState) -> String {
    state.petName ?? "阿在"
}

func petSoulSignature(_ state: PetState) -> String {
    state.soulSignature ?? "还在从你的工作流里慢慢长出灵魂。"
}

func petSpeakingStyle(_ state: PetState) -> String {
    state.speakingStyle ?? "说话方式还没完全定型。"
}

func petAppearanceHint(_ state: PetState) -> String {
    state.appearanceHint ?? "外观倾向还在慢慢浮出来。"
}

func petFirstImpression(_ state: PetState) -> String {
    state.firstImpression ?? "它还在观察你怎么跟 AI 说话。"
}

func birthBondCompleted(_ state: PetState) -> Bool {
    state.firstBondAt != nil
}

func isBirthBondPending(_ state: PetState) -> Bool {
    state.identityGeneratedAt != nil && !birthBondCompleted(state)
}

func styleVectorValue(_ state: PetState, key: String) -> Double {
    state.styleVector?[key] ?? 0
}

func styleVectorSummary(_ state: PetState) -> String {
    let pairs = [
        ("直接", styleVectorValue(state, key: "directness")),
        ("温和", styleVectorValue(state, key: "warmth")),
        ("探索", styleVectorValue(state, key: "exploration")),
        ("控制", styleVectorValue(state, key: "control")),
        ("耐心", styleVectorValue(state, key: "patience")),
        ("协作", styleVectorValue(state, key: "collaboration"))
    ]
    return pairs.map { "\($0.0) \(Int($0.1))" }.joined(separator: " / ")
}

func identityVisualProfile(_ state: PetState) -> IdentityVisualProfile {
    let vector = state.styleVector ?? [:]
    let styleKey = strongestStyleKey(from: vector)
    let seed = state.identitySeed ?? 1

    switch styleKey {
    case "warmth", "collaboration":
        return IdentityVisualProfile(
            label: "绒软型",
            silhouette: "soft",
            accessory: seed % 2 == 0 ? "scarf" : "cheek",
            bodyWidthBias: 8,
            bodyHeightBias: -4,
            tailSwingBias: 1.18,
            browTiltBias: -1.5
        )
    case "directness", "control":
        return IdentityVisualProfile(
            label: "利落型",
            silhouette: "brisk",
            accessory: seed % 2 == 0 ? "browband" : "chestplate",
            bodyWidthBias: -4,
            bodyHeightBias: 8,
            tailSwingBias: 0.92,
            browTiltBias: 2.5
        )
    case "exploration":
        return IdentityVisualProfile(
            label: "探路型",
            silhouette: "curious",
            accessory: seed % 2 == 0 ? "orbiter" : "cheek",
            bodyWidthBias: 2,
            bodyHeightBias: 4,
            tailSwingBias: 1.08,
            browTiltBias: 1.0
        )
    case "patience":
        return IdentityVisualProfile(
            label: "安定型",
            silhouette: "steady",
            accessory: seed % 2 == 0 ? "shawl" : "chestplate",
            bodyWidthBias: 4,
            bodyHeightBias: 0,
            tailSwingBias: 0.84,
            browTiltBias: -0.5
        )
    default:
        return IdentityVisualProfile(
            label: "原生型",
            silhouette: "default",
            accessory: "cheek",
            bodyWidthBias: 0,
            bodyHeightBias: 0,
            tailSwingBias: 1.0,
            browTiltBias: 0
        )
    }
}

func deriveForm(_ score: [String: Double]) -> String {
    guard let dominant = score.max(by: { $0.value < $1.value }) else { return "neutral" }
    return dominant.value < 10 ? "neutral" : dominant.key
}

func deriveMoodTag(_ state: PetState) -> String {
    if state.health < 30 || state.hygiene < 20 { return "sick" }
    if state.energy < 20 { return "sleepy" }
    if state.toxicity > 70 || state.residue > 50 { return "glitched" }
    if state.mood > 80 && state.bond > 70 { return "joyful" }
    if state.satiety < 20 { return "hungry" }
    return "steady"
}

func defaultBubble(for state: PetState) -> String {
    switch deriveMoodTag(state) {
    case "hungry":
        return "我饿了，最好给我一顿高质量任务餐。"
    case "sleepy":
        return "我有点困，你是不是最近透支得太狠了。"
    case "glitched":
        return "最近垃圾 Token 太多，我有点卡壳。"
    case "joyful":
        return "今天的饮食结构真不错，我很开心。"
    case "sick":
        return "再不清理和休息，我就要闹脾气了。"
    default:
        return formBubble[state.form] ?? formBubble["neutral"]!
    }
}

func normalizedPetTokens(from realTokens: Double) -> Double {
    let scaled = realTokens * 0.08
    return min(16000, max(700, round1(scaled)))
}

func taskTitle(for taskType: String) -> String {
    switch taskType {
    case "coding": return "开发"
    case "writing": return "写作"
    case "research": return "研究"
    case "review": return "评审"
    case "planning": return "规划"
    case "meeting": return "会议"
    case "support": return "支持"
    case "idle": return "空转"
    default: return taskType
    }
}

func moodAccent(for mood: String) -> NSColor {
    switch mood {
    case "joyful":
        return NSColor(calibratedRed: 1.00, green: 0.72, blue: 0.30, alpha: 1.0)
    case "hungry":
        return NSColor(calibratedRed: 0.94, green: 0.44, blue: 0.32, alpha: 1.0)
    case "sleepy":
        return NSColor(calibratedRed: 0.42, green: 0.57, blue: 0.92, alpha: 1.0)
    case "glitched":
        return NSColor(calibratedRed: 0.50, green: 0.35, blue: 0.95, alpha: 1.0)
    case "sick":
        return NSColor(calibratedRed: 0.83, green: 0.35, blue: 0.32, alpha: 1.0)
    default:
        return NSColor(calibratedRed: 0.18, green: 0.75, blue: 0.44, alpha: 1.0)
    }
}

func defaultInventory() -> [String: Int] {
    [:]
}

func defaultEnergyStock() -> [String: Double] {
    [:]
}

func defaultFoodLog() -> [String] {
    []
}

func defaultTokenLedger() -> [TokenLedgerEntry] {
    []
}

func defaultGrowthPhaseImprint() -> [String: Double] {
    ["节制": 0, "舒展": 0, "亢奋": 0, "压仓": 0]
}

func rewardStarCount(_ state: PetState) -> Int {
    state.rewardStars ?? 0
}

func unlockedFormsValue(_ state: PetState) -> [String] {
    state.unlockedForms ?? ["neutral"]
}

func consumedEventIDsValue(_ state: PetState) -> [String] {
    state.consumedEventIDs ?? []
}

func normalizedTokenLedger(_ state: PetState) -> [TokenLedgerEntry] {
    state.tokenLedger ?? defaultTokenLedger()
}

func normalizedGrowthPhaseImprint(_ state: PetState) -> [String: Double] {
    var imprint = state.growthPhaseImprint ?? defaultGrowthPhaseImprint()
    for key in ["节制", "舒展", "亢奋", "压仓"] {
        imprint[key] = imprint[key] ?? 0
    }
    return imprint
}

func normalizedInventory(_ state: PetState) -> [String: Int] {
    state.foodInventory ?? defaultInventory()
}

func normalizedEnergyStock(_ state: PetState) -> [String: Double] {
    state.foodEnergyStock ?? defaultEnergyStock()
}

func normalizedFoodLog(_ state: PetState) -> [String] {
    state.recentFoodLog ?? defaultFoodLog()
}

func currentPettingNeed(_ state: PetState) -> Double {
    state.pettingNeed ?? 16
}

func currentAffinityEnergy(_ state: PetState) -> Double {
    clamp(state.affinityEnergy ?? 0)
}

func currentAgitationEnergy(_ state: PetState) -> Double {
    clamp(state.agitationEnergy ?? 0)
}

func currentInteractionEnergy(_ state: PetState) -> Double {
    clamp(currentAffinityEnergy(state) + currentAgitationEnergy(state), minimum: 0, maximum: 200)
}

func gentleImpactCount(_ state: PetState) -> Int {
    state.gentleImpactCount ?? 0
}

func mediumImpactCount(_ state: PetState) -> Int {
    state.mediumImpactCount ?? 0
}

func heavyImpactCount(_ state: PetState) -> Int {
    state.heavyImpactCount ?? 0
}

func affinityReleaseCount(_ state: PetState) -> Int {
    state.affinityReleaseCount ?? 0
}

func agitationReleaseCount(_ state: PetState) -> Int {
    state.agitationReleaseCount ?? 0
}

func totalImpactCount(_ state: PetState) -> Int {
    gentleImpactCount(state) + mediumImpactCount(state) + heavyImpactCount(state)
}

func dominantImpactTier(_ state: PetState) -> Int {
    let gentle = gentleImpactCount(state)
    let medium = mediumImpactCount(state)
    let heavy = heavyImpactCount(state)
    if heavy >= medium && heavy >= gentle { return 3 }
    if medium >= gentle { return 2 }
    return 1
}

func impactTierLabel(_ tier: Int) -> String {
    switch tier {
    case 3: return "重拍"
    case 2: return "中拍"
    case 1: return "轻拍"
    default: return "未成拍"
    }
}

func availableInteractionTier(_ state: PetState) -> Int {
    let total = currentInteractionEnergy(state)
    if total < 12 { return 0 }
    if total < 28 { return 1 }
    if total < 56 { return 2 }
    return 3
}

func currentInteractionValence(_ state: PetState) -> String {
    currentAffinityEnergy(state) >= currentAgitationEnergy(state) ? "affinity" : "agitation"
}

func interactionDispositionShort(_ state: PetState) -> String {
    let total = totalImpactCount(state)
    guard total >= 4 else { return "拍养未定型" }

    let affinity = affinityReleaseCount(state)
    let agitation = agitationReleaseCount(state)
    let tier = dominantImpactTier(state)

    if affinity >= agitation + 3 {
        if tier == 1 { return "轻拍养熟" }
        if tier == 2 { return "回拍亲人" }
        return "热烈贴人"
    }

    if agitation >= affinity + 3 {
        if tier == 3 { return "重拍炸毛" }
        if tier == 2 { return "拍散躁劲" }
        return "慢慢卸劲"
    }

    if tier == 3 { return "烈性混生" }
    if tier == 1 { return "慢热混生" }
    return "拍养混成"
}

func interactionGrowthNote(_ state: PetState) -> String {
    let total = totalImpactCount(state)
    guard total >= 4 else { return "它还在记住你的手感，拍养关系还没定型。" }

    let affinity = affinityReleaseCount(state)
    let agitation = agitationReleaseCount(state)
    let gentle = gentleImpactCount(state)
    let heavy = heavyImpactCount(state)

    if affinity >= agitation + 3 && gentle >= heavy {
        return "你更常把它往亲和那边拍开，它正在长成一只会主动贴近你的宠物。"
    }
    if agitation >= affinity + 3 && heavy >= gentle {
        return "你更常把它体内的躁劲拍出来，它正在长成一只有脾气、但会自己泄压的小兽。"
    }
    if dominantImpactTier(state) == 2 {
        return "你和它正在形成一种稳定的拍击节奏，它会越来越懂得怎么回应你。"
    }
    return "它把你的互动方式和自己的能量混在一起，慢慢长出独特的相处气质。"
}

func interactionStrengthLabel(_ state: PetState) -> String {
    let total = currentInteractionEnergy(state)
    if total < 12 { return "未成拍" }
    if total < 28 { return "轻拍" }
    if total < 56 { return "中拍" }
    return "重拍"
}

func interactionHint(_ state: PetState) -> String {
    if isBirthBondPending(state) {
        return "初见中：先轻拍一下，让它记住你"
    }
    let total = currentInteractionEnergy(state)
    if total < 12 { return "它还在消化工作，拍劲还没长出来" }
    return "现在能拍：\(interactionStrengthLabel(state))"
}

func currentImpactFeedback(_ state: PetState) -> ImpactFeedback? {
    guard let at = state.lastImpactAt else { return nil }
    let age = Date().timeIntervalSince1970 - at
    guard age >= 0, age < 1.3 else { return nil }
    return ImpactFeedback(
        tier: max(0, state.lastImpactTier ?? 0),
        valence: state.lastImpactValence ?? "none",
        age: age
    )
}

func currentActiveFeedback(_ state: PetState, now: Double = Date().timeIntervalSince1970) -> ActiveFeedback? {
    guard let key = state.activeFeedbackKey,
          let source = state.activeFeedbackSource,
          let at = state.activeFeedbackAt,
          let duration = state.activeFeedbackDuration,
          let priority = state.activeFeedbackPriority else {
        return nil
    }
    let age = now - at
    guard age >= 0, age < duration else { return nil }
    return ActiveFeedback(key: key, source: source, age: age, priority: priority)
}

func clearActiveFeedback(_ state: inout PetState) {
    state.activeFeedbackKey = nil
    state.activeFeedbackSource = nil
    state.activeFeedbackAt = nil
    state.activeFeedbackDuration = nil
    state.activeFeedbackPriority = nil
}

func clearExpiredFeedback(_ state: inout PetState, now: Double = Date().timeIntervalSince1970) {
    guard state.activeFeedbackKey != nil else { return }
    guard currentActiveFeedback(state, now: now) == nil else { return }
    clearActiveFeedback(&state)
}

func pruneInvalidFeedback(_ state: inout PetState) {
    guard let key = state.activeFeedbackKey else { return }
    if key == "request_waiting" && state.currentRequest == nil {
        clearActiveFeedback(&state)
        return
    }
    if key == "birth_intro" && !isBirthBondPending(state) {
        clearActiveFeedback(&state)
    }
}

func canOverrideFeedback(_ state: PetState, withPriority newPriority: Int, at now: Double = Date().timeIntervalSince1970) -> Bool {
    guard let feedback = currentActiveFeedback(state, now: now) else { return true }
    return newPriority >= feedback.priority
}

@discardableResult
func setActiveFeedback(
    _ state: inout PetState,
    key: String,
    source: String,
    priority: Int,
    duration: Double,
    now: Double = Date().timeIntervalSince1970,
    resolvedOutcome: String? = nil,
    force: Bool = false
) -> Bool {
    clearExpiredFeedback(&state, now: now)
    if !force && !canOverrideFeedback(state, withPriority: priority, at: now) {
        return false
    }
    state.activeFeedbackKey = key
    state.activeFeedbackSource = source
    state.activeFeedbackAt = now
    state.activeFeedbackDuration = duration
    state.activeFeedbackPriority = priority
    if let resolvedOutcome {
        state.lastResolvedRequestOutcome = resolvedOutcome
    }
    return true
}

func bubbleFeedbackStyle(_ state: PetState) -> BubbleFeedbackStyle {
    let activity = currentActivityText(state)
    let ignoreLevel = currentRequestIgnoreLevel(state)
    if let feedback = currentActiveFeedback(state) {
        switch feedback.key {
        case "bond_complete":
            return BubbleFeedbackStyle(
                badge: "认主完成",
                accentColor: NSColor(calibratedRed: 0.96, green: 0.72, blue: 0.31, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.82, blue: 0.60, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.98, blue: 0.93, alpha: 0.96),
                requestColor: NSColor(calibratedRed: 0.69, green: 0.38, blue: 0.10, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.42, green: 0.28, blue: 0.14, alpha: 1.0),
                accentWidth: 62,
                tailShift: 0
            )
        case "birth_intro":
            return BubbleFeedbackStyle(
                badge: "初醒中",
                accentColor: NSColor(calibratedRed: 0.96, green: 0.72, blue: 0.31, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.94, green: 0.84, blue: 0.67, alpha: 0.96),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.99, blue: 0.95, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.66, green: 0.38, blue: 0.12, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.41, green: 0.29, blue: 0.14, alpha: 1.0),
                accentWidth: 44,
                tailShift: 0
            )
        case "interaction_offbeat":
            return BubbleFeedbackStyle(
                badge: "拍偏了一点",
                accentColor: NSColor(calibratedRed: 0.90, green: 0.54, blue: 0.24, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.82, blue: 0.70, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.98, blue: 0.95, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.63, green: 0.32, blue: 0.12, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.40, green: 0.27, blue: 0.18, alpha: 1.0),
                accentWidth: 42,
                tailShift: 7
            )
        case "interaction_matched_affinity":
            let badge = (state.lastImpactTier ?? 0) >= 3 ? "拍准重拍" : ((state.lastImpactTier ?? 0) == 2 ? "拍准中拍" : "拍准轻拍")
            return BubbleFeedbackStyle(
                badge: badge,
                accentColor: NSColor(calibratedRed: 0.91, green: 0.50, blue: 0.36, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.80, blue: 0.72, alpha: 0.98),
                fillColor: NSColor.white.withAlphaComponent(0.96),
                requestColor: NSColor(calibratedRed: 0.67, green: 0.25, blue: 0.18, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.40, green: 0.23, blue: 0.18, alpha: 1.0),
                accentWidth: (state.lastImpactTier ?? 0) >= 3 ? 58 : ((state.lastImpactTier ?? 0) == 2 ? 48 : 38),
                tailShift: (state.lastImpactTier ?? 0) >= 3 ? 10 : 4
            )
        case "interaction_matched_agitation":
            let badge = (state.lastImpactTier ?? 0) >= 3 ? "拍散躁劲" : ((state.lastImpactTier ?? 0) == 2 ? "拍开躁劲" : "拍松躁劲")
            return BubbleFeedbackStyle(
                badge: badge,
                accentColor: NSColor(calibratedRed: 0.56, green: 0.42, blue: 0.94, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.83, green: 0.79, blue: 0.94, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 0.98, green: 0.97, blue: 1.0, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.45, green: 0.28, blue: 0.73, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.30, green: 0.25, blue: 0.44, alpha: 1.0),
                accentWidth: (state.lastImpactTier ?? 0) >= 3 ? 58 : ((state.lastImpactTier ?? 0) == 2 ? 48 : 38),
                tailShift: (state.lastImpactTier ?? 0) >= 3 ? -10 : -4
            )
        case "request_missed_twice":
            return BubbleFeedbackStyle(
                badge: "等拍失落",
                accentColor: NSColor(calibratedRed: 0.63, green: 0.69, blue: 0.80, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.83, green: 0.86, blue: 0.92, alpha: 0.96),
                fillColor: NSColor(calibratedRed: 0.98, green: 0.99, blue: 1.0, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.41, green: 0.49, blue: 0.60, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.34, green: 0.38, blue: 0.46, alpha: 1.0),
                accentWidth: 34,
                tailShift: -8
            )
        case "request_missed_once":
            return BubbleFeedbackStyle(
                badge: "等拍落空",
                accentColor: NSColor(calibratedRed: 0.82, green: 0.63, blue: 0.34, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.93, green: 0.86, blue: 0.74, alpha: 0.96),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.99, blue: 0.96, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.57, green: 0.39, blue: 0.18, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.39, green: 0.31, blue: 0.22, alpha: 1.0),
                accentWidth: 36,
                tailShift: -4
            )
        case "meal_eaten":
            return BubbleFeedbackStyle(
                badge: "刚吃上一口",
                accentColor: NSColor(calibratedRed: 0.28, green: 0.72, blue: 0.45, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.80, green: 0.92, blue: 0.84, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 0.97, green: 1.0, blue: 0.97, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.19, green: 0.45, blue: 0.27, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.20, green: 0.34, blue: 0.22, alpha: 1.0),
                accentWidth: 36,
                tailShift: 0
            )
        case "request_waiting":
            return BubbleFeedbackStyle(
                badge: "在等你",
                accentColor: NSColor(calibratedRed: 0.93, green: 0.63, blue: 0.30, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.85, blue: 0.73, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.99, blue: 0.96, alpha: 0.95),
                requestColor: NSColor(calibratedRed: 0.58, green: 0.35, blue: 0.14, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.39, green: 0.28, blue: 0.20, alpha: 1.0),
                accentWidth: 34,
                tailShift: 2
            )
        default:
            break
        }
    }

    if let impact = currentImpactFeedback(state) {
        if impact.valence == "bond" {
            return BubbleFeedbackStyle(
                badge: "认主完成",
                accentColor: NSColor(calibratedRed: 0.96, green: 0.72, blue: 0.31, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.82, blue: 0.60, alpha: 0.98),
                fillColor: NSColor(calibratedRed: 1.0, green: 0.98, blue: 0.93, alpha: 0.96),
                requestColor: NSColor(calibratedRed: 0.69, green: 0.38, blue: 0.10, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.42, green: 0.28, blue: 0.14, alpha: 1.0),
                accentWidth: 62,
                tailShift: 0
            )
        }

        if impact.valence == "affinity" {
            let badge = impact.tier >= 3 ? "拍准重拍" : (impact.tier == 2 ? "拍准中拍" : "拍准轻拍")
            return BubbleFeedbackStyle(
                badge: badge,
                accentColor: NSColor(calibratedRed: 0.91, green: 0.50, blue: 0.36, alpha: 1.0),
                borderColor: NSColor(calibratedRed: 0.95, green: 0.80, blue: 0.72, alpha: 0.98),
                fillColor: NSColor.white.withAlphaComponent(0.96),
                requestColor: NSColor(calibratedRed: 0.67, green: 0.25, blue: 0.18, alpha: 1.0),
                logColor: NSColor(calibratedRed: 0.40, green: 0.23, blue: 0.18, alpha: 1.0),
                accentWidth: impact.tier >= 3 ? 58 : (impact.tier == 2 ? 48 : 38),
                tailShift: impact.tier >= 3 ? 10 : 4
            )
        }

        let badge = impact.tier >= 3 ? "拍散躁劲" : (impact.tier == 2 ? "拍开躁劲" : "拍松躁劲")
        return BubbleFeedbackStyle(
            badge: badge,
            accentColor: NSColor(calibratedRed: 0.56, green: 0.42, blue: 0.94, alpha: 1.0),
            borderColor: NSColor(calibratedRed: 0.83, green: 0.79, blue: 0.94, alpha: 0.98),
            fillColor: NSColor(calibratedRed: 0.98, green: 0.97, blue: 1.0, alpha: 0.95),
            requestColor: NSColor(calibratedRed: 0.45, green: 0.28, blue: 0.73, alpha: 1.0),
            logColor: NSColor(calibratedRed: 0.30, green: 0.25, blue: 0.44, alpha: 1.0),
            accentWidth: impact.tier >= 3 ? 58 : (impact.tier == 2 ? 48 : 38),
            tailShift: impact.tier >= 3 ? -10 : -4
        )
    }

    if ignoreLevel >= 2 || activity.contains("缩成一团") || activity.contains("消化躁劲") {
        return BubbleFeedbackStyle(
            badge: "等拍失落",
            accentColor: NSColor(calibratedRed: 0.63, green: 0.69, blue: 0.80, alpha: 1.0),
            borderColor: NSColor(calibratedRed: 0.83, green: 0.86, blue: 0.92, alpha: 0.96),
            fillColor: NSColor(calibratedRed: 0.98, green: 0.99, blue: 1.0, alpha: 0.95),
            requestColor: NSColor(calibratedRed: 0.41, green: 0.49, blue: 0.60, alpha: 1.0),
            logColor: NSColor(calibratedRed: 0.34, green: 0.38, blue: 0.46, alpha: 1.0),
            accentWidth: 34,
            tailShift: -8
        )
    }

    if ignoreLevel == 1 || activity.contains("等你回头") {
        return BubbleFeedbackStyle(
            badge: "等拍落空",
            accentColor: NSColor(calibratedRed: 0.82, green: 0.63, blue: 0.34, alpha: 1.0),
            borderColor: NSColor(calibratedRed: 0.93, green: 0.86, blue: 0.74, alpha: 0.96),
            fillColor: NSColor(calibratedRed: 1.0, green: 0.99, blue: 0.96, alpha: 0.95),
            requestColor: NSColor(calibratedRed: 0.57, green: 0.39, blue: 0.18, alpha: 1.0),
            logColor: NSColor(calibratedRed: 0.39, green: 0.31, blue: 0.22, alpha: 1.0),
            accentWidth: 36,
            tailShift: -4
        )
    }

    if activity.contains("歪头看你") || activity.contains("甩了下毛") || activity.contains("没完全拍透") {
        return BubbleFeedbackStyle(
            badge: "拍偏了一点",
            accentColor: NSColor(calibratedRed: 0.90, green: 0.54, blue: 0.24, alpha: 1.0),
            borderColor: NSColor(calibratedRed: 0.95, green: 0.82, blue: 0.70, alpha: 0.98),
            fillColor: NSColor(calibratedRed: 1.0, green: 0.98, blue: 0.95, alpha: 0.95),
            requestColor: NSColor(calibratedRed: 0.63, green: 0.32, blue: 0.12, alpha: 1.0),
            logColor: NSColor(calibratedRed: 0.40, green: 0.27, blue: 0.18, alpha: 1.0),
            accentWidth: 42,
            tailShift: 7
        )
    }

    if isBirthBondPending(state) {
        return BubbleFeedbackStyle(
            badge: "初见中",
            accentColor: NSColor(calibratedRed: 0.96, green: 0.72, blue: 0.31, alpha: 1.0),
            borderColor: NSColor(calibratedRed: 0.94, green: 0.84, blue: 0.67, alpha: 0.96),
            fillColor: NSColor(calibratedRed: 1.0, green: 0.99, blue: 0.95, alpha: 0.95),
            requestColor: NSColor(calibratedRed: 0.66, green: 0.38, blue: 0.12, alpha: 1.0),
            logColor: NSColor(calibratedRed: 0.41, green: 0.29, blue: 0.14, alpha: 1.0),
            accentWidth: 44,
            tailShift: 0
        )
    }

    return BubbleFeedbackStyle(
        badge: nil,
        accentColor: moodAccent(for: deriveMoodTag(state)),
        borderColor: NSColor(calibratedRed: 0.93, green: 0.88, blue: 0.80, alpha: 0.92),
        fillColor: NSColor.white.withAlphaComponent(0.94),
        requestColor: NSColor(calibratedRed: 0.60, green: 0.29, blue: 0.18, alpha: 1.0),
        logColor: NSColor(calibratedRed: 0.32, green: 0.27, blue: 0.22, alpha: 1.0),
        accentWidth: 34,
        tailShift: 0
    )
}

func sortedArchetypes(_ state: PetState) -> [(String, Double)] {
    state.archetypeScore.sorted { left, right in
        if left.value == right.value { return left.key < right.key }
        return left.value > right.value
    }
}

func wantsPetting(_ state: PetState) -> Bool {
    currentPettingNeed(state) >= 68
}

func foodName(for taskType: String) -> String {
    switch taskType {
    case "coding": return "机能肉粒"
    case "writing": return "字句奶酥"
    case "research": return "脑力浆果"
    case "review": return "校准薄荷"
    case "planning": return "路线饼干"
    case "meeting": return "会议泡芙"
    case "support": return "陪伴糖豆"
    case "idle": return "空转泡面"
    default: return "综合饲料"
    }
}

func foodVariantName(taskType: String, quality: String) -> String {
    let base = foodName(for: taskType)
    switch quality {
    case "breakthrough": return "特制\(base)"
    case "partial": return "半熟\(base)"
    case "waste": return "焦糊\(base)"
    default: return base
    }
}

func taskTypeForFood(_ foodName: String) -> String {
    let mapping = [
        "机能肉粒": "coding",
        "字句奶酥": "writing",
        "脑力浆果": "research",
        "校准薄荷": "review",
        "路线饼干": "planning",
        "会议泡芙": "meeting",
        "陪伴糖豆": "support",
        "空转泡面": "idle"
    ]

    for (key, value) in mapping where foodName.contains(key) {
        return value
    }
    return "coding"
}

func joinedUserTexts(_ events: [FeedEvent]) -> [String] {
    events
        .map { $0.user_text.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
}

func countKeywordHits(_ texts: [String], keywords: [String]) -> Double {
    texts.reduce(0) { partial, text in
        partial + Double(keywords.reduce(0) { count, keyword in
            count + (text.contains(keyword) ? 1 : 0)
        })
    }
}

func seedValue(from texts: [String], tasks: [String]) -> Int {
    let seedText = (texts + tasks).joined(separator: "|")
    return max(1, seedText.unicodeScalars.reduce(0) { partial, scalar in
        (partial * 33 + Int(scalar.value)) % 100_003
    })
}

func dominantTaskType(from events: [FeedEvent]) -> String {
    let weighted = events.reduce(into: [String: Double]()) { partial, event in
        partial[event.task_type, default: 0] += max(1, event.real_tokens)
    }
    return weighted.max(by: { $0.value < $1.value })?.key ?? "coding"
}

func styleVector(from events: [FeedEvent]) -> [String: Double] {
    let texts = joinedUserTexts(events)
    guard !texts.isEmpty else {
        return [
            "directness": 58,
            "warmth": 46,
            "exploration": 52,
            "control": 54,
            "patience": 50,
            "collaboration": 48
        ]
    }

    let avgLength = Double(texts.map(\.count).reduce(0, +)) / Double(max(texts.count, 1))
    let questionHits = Double(texts.filter { $0.contains("?") || $0.contains("？") }.count)
    let messageCount = Double(max(texts.count, 1))
    let directHits = countKeywordHits(texts, keywords: ["继续", "先", "直接", "改", "做", "开始", "收敛", "定下", "拍"]) / messageCount
    let warmHits = countKeywordHits(texts, keywords: ["请", "希望", "喜欢", "一起", "我们", "辛苦", "谢谢", "陪"]) / messageCount
    let exploreHits = countKeywordHits(texts, keywords: ["觉得", "是否", "能否", "看看", "也许", "如果", "思考", "考虑"]) / messageCount
    let controlHits = countKeywordHits(texts, keywords: ["只", "必须", "不要", "优先", "先", "定", "按", "收口"]) / messageCount
    let patienceHits = countKeywordHits(texts, keywords: ["继续", "慢慢", "逐步", "完善", "打磨", "后面", "下一步"]) / messageCount
    let collaborationHits = countKeywordHits(texts, keywords: ["我们", "一起", "帮我", "你觉得", "协同", "陪", "共"]) / messageCount
    let questionRate = questionHits / messageCount

    let directness = clamp(34 + (avgLength < 22 ? 12 : 4) + directHits * 14 + controlHits * 5, minimum: 0, maximum: 100)
    let warmth = clamp(24 + warmHits * 14 + collaborationHits * 6, minimum: 0, maximum: 100)
    let exploration = clamp(24 + exploreHits * 14 + questionRate * 10 + (avgLength > 28 ? 6 : 0), minimum: 0, maximum: 100)
    let control = clamp(26 + controlHits * 14 + directHits * 4, minimum: 0, maximum: 100)
    let patience = clamp(28 + patienceHits * 12 + (avgLength > 36 ? 8 : 0), minimum: 0, maximum: 100)
    let collaboration = clamp(24 + collaborationHits * 14 + warmHits * 4, minimum: 0, maximum: 100)

    return [
        "directness": round1(directness),
        "warmth": round1(warmth),
        "exploration": round1(exploration),
        "control": round1(control),
        "patience": round1(patience),
        "collaboration": round1(collaboration)
    ]
}

func strongestStyleKey(from vector: [String: Double]) -> String {
    vector.max(by: { $0.value < $1.value })?.key ?? "directness"
}

func petIdentityBlueprint(events: [FeedEvent], state: PetState) -> IdentityBlueprint {
    let vector = styleVector(from: events)
    let dominantTask = dominantTaskType(from: events)
    let texts = joinedUserTexts(events)
    let seed = seedValue(from: texts, tasks: events.map(\.task_type))
    let styleKey = strongestStyleKey(from: vector)

    let styleChars: [String: [String]] = [
        "directness": ["钉", "疾", "砾"],
        "warmth": ["绒", "暖", "茸"],
        "exploration": ["卷", "岚", "星"],
        "control": ["序", "尺", "栓"],
        "patience": ["缓", "眠", "团"],
        "collaboration": ["伴", "合", "同"]
    ]
    let taskChars: [String: [String]] = [
        "coding": ["匠", "搭", "铆"],
        "research": ["灯", "卷", "墨"],
        "writing": ["句", "笺", "字"],
        "planning": ["航", "阵", "谱"],
        "review": ["衡", "尺", "针"],
        "support": ["伴", "糖", "暖"],
        "meeting": ["咚", "团", "泡"],
        "idle": ["团", "面", "泡"]
    ]

    let firstChar = styleChars[styleKey]?[seed % 3] ?? "团"
    let secondOptions = taskChars[dominantTask] ?? ["团", "尾", "灯"]
    let secondChar = secondOptions[(seed / 3) % secondOptions.count]
    let name = "阿\(firstChar)\(secondChar)"

    let directness = vector["directness"] ?? 50
    let warmth = vector["warmth"] ?? 50
    let exploration = vector["exploration"] ?? 50
    let control = vector["control"] ?? 50
    let patience = vector["patience"] ?? 50
    let collaboration = vector["collaboration"] ?? 50

    let soulSignature: String
    if warmth >= 65 && collaboration >= 58 {
        soulSignature = "一只会先靠近你、再慢慢把工作气压消化掉的陪跑小兽"
    } else if directness >= 66 && control >= 60 {
        soulSignature = "一只节奏利落、会盯着你把事情往前推的小监工兽"
    } else if exploration >= 64 {
        soulSignature = "一只会从问题缝隙里钻出新路子的巡航小兽"
    } else if patience >= 62 {
        soulSignature = "一只不急着叫唤、会陪你慢慢把事情养熟的小团子"
    } else {
        soulSignature = "一只会从你的工作节奏里长出脾气和依恋的桌边小兽"
    }

    let speakingStyle: String
    if directness >= 66 {
        speakingStyle = "说话偏短句，反应快，常用很直接的请求来找你对节奏。"
    } else if warmth >= 60 {
        speakingStyle = "说话偏软，会先示好，再慢慢把自己的期待露出来。"
    } else if exploration >= 64 {
        speakingStyle = "说话带一点试探和观察感，像总在边上悄悄判断下一步。"
    } else {
        speakingStyle = "说话克制，但会在关键时刻突然把自己的意思抬出来。"
    }

    let appearanceHint: String
    switch dominantTask {
    case "coding":
        appearanceHint = control >= 60 ? "身体轮廓偏利落，耳尖、锤尾，像带着工坊小零件出壳。" : "整体偏工坊橙，耳尖尾厚，像一只刚从代码堆里钻出来的小兽。"
    case "research":
        appearanceHint = exploration >= 60 ? "耳形偏卷，尾巴轻长，身上会有像灯纹一样的亮斑。" : "外形偏轻，眼神亮，像总在盯着新线索。"
    case "writing":
        appearanceHint = warmth >= 58 ? "轮廓更柔和，尾巴像笔刷，身上有成片的句点斑纹。" : "额纹和尾尖更显眼，像字句在它身上留下了墨痕。"
    case "planning":
        appearanceHint = control >= 60 ? "旗耳和环尾会更明显，身体线条像带着秩序感的分段结构。" : "看起来更像一只总在排队列的小领航兽。"
    default:
        appearanceHint = "外观会带着\(taskTitle(for: dominantTask))的痕迹，但边角会继续被你们的关系磨出独特性。"
    }

    let firstImpression: String
    if directness >= 66 && warmth < 55 {
        firstImpression = "它觉得你和 AI 说话很利落，像总知道下一步该往哪里推。"
    } else if warmth >= 60 && collaboration >= 58 {
        firstImpression = "它觉得你和 AI 的关系不是命令，而更像一起把事养成。"
    } else if exploration >= 64 {
        firstImpression = "它觉得你不是只要答案，而是会拉着 AI 一起把方向试出来。"
    } else {
        firstImpression = "它觉得你身上有稳定的工作节奏，只是还在观察你会怎样对待它。"
    }

    let birthNarrative = "\(name) 是从你最近的\(taskTitle(for: dominantTask))节奏里醒来的。它先学会了你和 AI 说话的方式，再长出自己的第一层脾气和外形。"

    return IdentityBlueprint(
        petName: name,
        soulSignature: soulSignature,
        speakingStyle: speakingStyle,
        appearanceHint: appearanceHint,
        firstImpression: firstImpression,
        birthNarrative: birthNarrative,
        styleVector: vector,
        seed: seed
    )
}

func servingsCount(from realTokens: Double) -> Int {
    if realTokens > 120000 { return 4 }
    if realTokens > 65000 { return 3 }
    if realTokens > 18000 { return 2 }
    return 1
}

func pantrySummary(_ state: PetState) -> String {
    let inventory = normalizedInventory(state)
    if inventory.isEmpty {
        return "粮仓空空，等 Codex 再给它做几顿饭。"
    }

    let pieces = inventory
        .sorted { left, right in
            if left.value == right.value { return left.key < right.key }
            return left.value > right.value
        }
        .prefix(3)
        .map { key, value in "\(key)×\(value)" }

    return "粮仓：\(pieces.joined(separator: "  "))"
}

func appendFoodLog(_ state: inout PetState, entry: String) {
    var log = normalizedFoodLog(state)
    log.insert(entry, at: 0)
    state.recentFoodLog = Array(log.prefix(4))
}

func appendTokenLedger(_ state: inout PetState, entry: TokenLedgerEntry) {
    var ledger = normalizedTokenLedger(state)
    ledger.insert(entry, at: 0)
    state.tokenLedger = Array(ledger.prefix(18))
}

func applyGrowthPhaseImprint(_ state: inout PetState, phase: String, amount: Double) {
    var imprint = normalizedGrowthPhaseImprint(state)
    imprint[phase, default: 0] = round1(imprint[phase, default: 0] + amount)
    state.growthPhaseImprint = imprint
}

func dominantGrowthTendency(_ state: PetState) -> (title: String, note: String) {
    let imprint = normalizedGrowthPhaseImprint(state)
    let sorted = imprint.sorted { left, right in
        if left.value == right.value { return left.key < right.key }
        return left.value > right.value
    }
    guard let first = sorted.first else {
        return ("舒展型", "它还在慢慢形成自己的成长脾气")
    }

    switch first.key {
    case "节制":
        return ("细养型", "吃得克制，长得慢一些，但更敏感也更黏人")
    case "亢奋":
        return ("猛长型", "最近常在高代谢里长大，动作更猛，情绪更外放")
    case "压仓":
        return ("胀仓型", "常在仓压里长，容易囤、容易躁，也更需要整理自己")
    default:
        return ("舒展型", "大多数时间都在稳定长大，状态最匀，也最容易养熟")
    }
}

func identityVisualLabel(_ state: PetState) -> String {
    identityVisualProfile(state).label
}

func surpriseFoodForState(_ state: PetState) -> String {
    switch state.form {
    case "builder": return "特制机能肉粒"
    case "scholar": return "特制脑力浆果"
    case "captain": return "特制路线饼干"
    case "social": return "特制陪伴糖豆"
    case "chaos": return "半熟校准薄荷"
    default: return "字句奶酥"
    }
}

func addReward(_ state: inout PetState, amount: Int, reason: String) {
    let previous = rewardStarCount(state)
    let updated = previous + amount
    state.rewardStars = updated
    appendFoodLog(&state, entry: "掉落星屑 +\(amount)：\(reason)")

    if updated / 5 > previous / 5 {
        let bonusFood = surpriseFoodForState(state)
        var inventory = normalizedInventory(state)
        var energy = normalizedEnergyStock(state)
        inventory[bonusFood, default: 0] += 1
        energy[bonusFood, default: 0] += 1200
        state.foodInventory = inventory
        state.foodEnergyStock = energy
        state.currentActivity = "抱着惊喜加餐开心蹦跶"
        state.lastCareSummary = "它刚抱到一份星屑换来的惊喜加餐，兴奋得在原地蹦了两下"
        appendFoodLog(&state, entry: "惊喜掉落：\(bonusFood)×1")
    }
}

func unlockFormIfNeeded(_ state: inout PetState) {
    var unlocked = unlockedFormsValue(state)
    if !unlocked.contains(state.form) {
        unlocked.append(state.form)
        state.unlockedForms = unlocked
        addReward(&state, amount: 2, reason: "解锁了\(formLabels[state.form] ?? state.form)形态")
    }
}

func recentFoodSummary(_ state: PetState) -> String {
    let log = normalizedFoodLog(state)
    if log.isEmpty { return "最近还没有新的粮食动作。" }
    return log.prefix(2).joined(separator: "  ·  ")
}

func currentActivityText(_ state: PetState) -> String {
    state.currentActivity ?? deriveActivity(state)
}

func generatedTraitProfile(_ state: PetState) -> TraitProfile {
    let dominant = sortedArchetypes(state)
    let first = dominant.first?.0 ?? "neutral"
    let second = dominant.dropFirst().first?.0 ?? first
    let growthTendency = dominantGrowthTendency(state).title

    let earOptions = ["卷耳", "尖耳", "旗耳", "叶耳"]
    let tailOptions = ["环尾", "锤尾", "羽尾", "电尾"]
    let markOptions = ["星斑", "额纹", "面罩", "肩纹"]
    let auraOptions = ["星砂", "叶火", "轨迹", "碎光"]

    let relationSeed = Int((state.bond + Double(rewardStarCount(state)) * 3 + Double(state.petCombo ?? 0) * 2 + Double(affinityReleaseCount(state)) * 1.6).rounded())
    let metabolismSeed = Int((state.focus * 0.7 + state.toxicity * 0.6 + state.hygiene * 0.4 + state.growth * 0.08 + Double(agitationReleaseCount(state)) * 2.2 + Double(heavyImpactCount(state)) * 1.5).rounded())

    let earIndex: Int
    switch first {
    case "builder": earIndex = 1
    case "scholar": earIndex = 0
    case "captain": earIndex = 2
    case "social": earIndex = 3
    case "chaos": earIndex = 1 + (metabolismSeed % 2)
    default: earIndex = relationSeed % earOptions.count
    }

    let tailIndex: Int
    switch second {
    case "builder": tailIndex = 1
    case "scholar": tailIndex = 2
    case "captain": tailIndex = 0
    case "social": tailIndex = 2
    case "chaos": tailIndex = 3
    default: tailIndex = metabolismSeed % tailOptions.count
    }

    let markIndex = (relationSeed + metabolismSeed + first.count + second.count + gentleImpactCount(state) + heavyImpactCount(state) * 2) % markOptions.count
    let auraIndex: Int
    if growthTendency == "细养型" {
        auraIndex = 0
    } else if growthTendency == "猛长型" {
        auraIndex = 1
    } else if growthTendency == "胀仓型" {
        auraIndex = 3
    } else if affinityReleaseCount(state) >= agitationReleaseCount(state) + 3 {
        auraIndex = gentleImpactCount(state) >= mediumImpactCount(state) ? 0 : 1
    } else if agitationReleaseCount(state) >= affinityReleaseCount(state) + 3 {
        auraIndex = heavyImpactCount(state) >= mediumImpactCount(state) ? 3 : 2
    } else {
        auraIndex = (rewardStarCount(state) + Int(state.ageHours.rounded()) + Int(state.growth.rounded())) % auraOptions.count
    }

    return TraitProfile(
        earStyle: earOptions[earIndex],
        tailStyle: tailOptions[tailIndex],
        markStyle: markOptions[markIndex],
        auraStyle: auraOptions[auraIndex],
        shortLabel: "\(earOptions[earIndex])·\(tailOptions[tailIndex])"
    )
}

func generatedHabitProfile(_ state: PetState) -> HabitProfile {
    let sorted = sortedArchetypes(state)
    let first = sorted.first?.0 ?? "neutral"
    let second = sorted.dropFirst().first?.0 ?? first
    let growthTendency = dominantGrowthTendency(state).title

    let favoriteFood: String
    switch growthTendency {
    case "细养型":
        favoriteFood = state.bond > 72 ? "陪伴糖豆" : "字句奶酥"
    case "猛长型":
        favoriteFood = "特制机能肉粒"
    case "胀仓型":
        favoriteFood = "校准薄荷"
    default:
        switch first {
        case "builder": favoriteFood = "机能肉粒"
        case "scholar": favoriteFood = "脑力浆果"
        case "captain": favoriteFood = "路线饼干"
        case "social": favoriteFood = "陪伴糖豆"
        case "chaos": favoriteFood = "半熟校准薄荷"
        default:
            favoriteFood = state.bond > 80 ? "陪伴糖豆" : foodName(for: state.lastTaskType ?? "coding")
        }
    }

    let comfortAction: String
    if growthTendency == "细养型" {
        comfortAction = "爱安静贴着你等一会儿"
    } else if growthTendency == "猛长型" {
        comfortAction = "爱巡桌发劲后等你拍"
    } else if growthTendency == "胀仓型" {
        comfortAction = "爱先整理自己再靠近你"
    } else if affinityReleaseCount(state) >= agitationReleaseCount(state) + 3 && gentleImpactCount(state) >= mediumImpactCount(state) {
        comfortAction = "爱等你轻轻一拍"
    } else if agitationReleaseCount(state) >= affinityReleaseCount(state) + 3 && heavyImpactCount(state) >= mediumImpactCount(state) {
        comfortAction = "爱把躁劲拍散"
    } else if state.bond > 85 && currentPettingNeed(state) > 35 {
        comfortAction = "爱被顺毛"
    } else if state.focus > 88 && second == "scholar" {
        comfortAction = "爱安静发呆"
    } else if state.energy > 80 && second == "builder" {
        comfortAction = "爱绕圈巡桌"
    } else if state.hygiene < 50 {
        comfortAction = "爱先舔毛"
    } else if state.rewardStars ?? 0 > 12 {
        comfortAction = "爱叼惊喜粮"
    } else {
        comfortAction = "爱贴边蹭你"
    }

    return HabitProfile(
        favoriteFood: favoriteFood,
        comfortAction: comfortAction,
        shortLabel: "偏爱\(favoriteFood) / \(comfortAction) / \(interactionDispositionShort(state))"
    )
}

func drawIdentityAccessory(profile: IdentityVisualProfile, bodyOriginX: CGFloat, bodyOriginY: CGFloat, bodyWidth: CGFloat, bodyHeight: CGFloat, accent: NSColor, bodyColor: NSColor) {
    switch profile.accessory {
    case "scarf":
        let scarf = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.22, y: bodyOriginY + bodyHeight * 0.62, width: bodyWidth * 0.56, height: 10), xRadius: 5, yRadius: 5)
        NSColor(calibratedRed: 1.0, green: 0.90, blue: 0.78, alpha: 0.88).setFill()
        scarf.fill()
        let tail = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.63, y: bodyOriginY + bodyHeight * 0.68, width: 8, height: 18), xRadius: 4, yRadius: 4)
        accent.withAlphaComponent(0.65).setFill()
        tail.fill()
    case "cheek":
        NSColor.white.withAlphaComponent(0.28).setFill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.24, y: bodyOriginY + bodyHeight * 0.44, width: 10, height: 6)).fill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.66, y: bodyOriginY + bodyHeight * 0.44, width: 10, height: 6)).fill()
    case "browband":
        let band = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.28, y: bodyOriginY + bodyHeight * 0.18, width: bodyWidth * 0.44, height: 8), xRadius: 4, yRadius: 4)
        accent.withAlphaComponent(0.72).setFill()
        band.fill()
    case "chestplate":
        let plate = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.42, y: bodyOriginY + bodyHeight * 0.58, width: bodyWidth * 0.16, height: 16), xRadius: 5, yRadius: 5)
        NSColor.white.withAlphaComponent(0.80).setFill()
        plate.fill()
        accent.withAlphaComponent(0.45).setStroke()
        plate.lineWidth = 1
        plate.stroke()
    case "orbiter":
        let orbit = NSBezierPath(ovalIn: NSRect(x: bodyOriginX - 4, y: bodyOriginY + bodyHeight * 0.08, width: bodyWidth + 8, height: bodyHeight * 0.78))
        accent.withAlphaComponent(0.14).setStroke()
        orbit.lineWidth = 1.4
        orbit.stroke()
        let dot = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth - 2, y: bodyOriginY + bodyHeight * 0.28, width: 6, height: 6))
        accent.withAlphaComponent(0.60).setFill()
        dot.fill()
    case "shawl":
        let shawl = NSBezierPath()
        shawl.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.26, y: bodyOriginY + bodyHeight * 0.58))
        shawl.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY + bodyHeight * 0.74))
        shawl.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.74, y: bodyOriginY + bodyHeight * 0.58))
        shawl.close()
        NSColor(calibratedRed: 0.98, green: 0.92, blue: 0.84, alpha: 0.70).setFill()
        shawl.fill()
    default:
        break
    }
}

func activityHasAny(_ state: PetState, keywords: [String]) -> Bool {
    let activity = currentActivityText(state)
    return keywords.contains { activity.contains($0) }
}

func deriveActivity(_ state: PetState) -> String {
    let mood = deriveMoodTag(state)
    let phase = growthBalanceProfile(state)
    let tendency = dominantGrowthTendency(state).title
    if phase.title == "压仓" { return "守在粮仓边慢慢消化" }
    if phase.title == "节制" && state.satiety < 48 { return "缩着身子省着长" }
    if tendency == "细养型" && wantsPetting(state) { return "贴着边安静等你回头" }
    if tendency == "猛长型" && state.energy > 72 { return "巡着桌边蓄下一股劲" }
    if tendency == "胀仓型" && (state.residue > 44 || state.toxicity > 60) { return "先抖毛把自己理顺" }
    if currentAgitationEnergy(state) > 56 { return "体内躁劲鼓得满满的" }
    if currentAffinityEnergy(state) > 56 { return "拍劲涨得软乎乎的" }
    if wantsPetting(state) { return "绕着你撒娇" }
    if mood == "sleepy" { return "蜷着打盹" }
    if mood == "hungry" { return "闻着粮仓找吃的" }
    if mood == "joyful" { return "摇尾巴巡游" }
    if state.lastTaskType == "research" { return "啃脑力浆果" }
    if state.lastTaskType == "coding" { return "消化机能肉粒" }
    return "慢悠悠巡桌"
}

func interactionRequestProfile(_ state: PetState) -> InteractionRequestProfile {
    if isBirthBondPending(state) {
        return InteractionRequestProfile(
            text: "想先记住你的手感",
            desiredTier: 1,
            desiredValence: "affinity",
            actionable: true
        )
    }

    let tier = availableInteractionTier(state)
    let valence = currentInteractionValence(state)
    let totalHistory = totalImpactCount(state)
    let gentleBias = gentleImpactCount(state) >= max(mediumImpactCount(state), heavyImpactCount(state)) && totalHistory >= 4
    let heavyBias = heavyImpactCount(state) > max(gentleImpactCount(state), mediumImpactCount(state)) && totalHistory >= 4
    let affinityBias = affinityReleaseCount(state) >= agitationReleaseCount(state) + 3
    let agitationBias = agitationReleaseCount(state) >= affinityReleaseCount(state) + 3

    if tier == 0 {
        if let passive = passiveGrowthRequestText(state, heavyBias: heavyBias, gentleBias: gentleBias, affinityBias: affinityBias, agitationBias: agitationBias) {
            return InteractionRequestProfile(
                text: passive,
                desiredTier: nil,
                desiredValence: nil,
                actionable: false
            )
        }
        return InteractionRequestProfile(text: nil, desiredTier: nil, desiredValence: nil, actionable: false)
    }

    let text = activeGrowthRequestText(
        state,
        tier: tier,
        valence: valence,
        gentleBias: gentleBias,
        heavyBias: heavyBias,
        affinityBias: affinityBias,
        agitationBias: agitationBias
    )

    return InteractionRequestProfile(
        text: text,
        desiredTier: tier,
        desiredValence: valence,
        actionable: true
    )
}

func deriveRequest(_ state: PetState) -> String? {
    interactionRequestProfile(state).text
}

func requestHint(_ request: String?) -> String {
    guard let request else { return "状态稳定" }
    return "现在最想：\(request)"
}

func compactStageLabel(for stage: String) -> String {
    switch stage {
    case "egg": return "蛋"
    case "sprout": return "芽"
    case "child": return "幼"
    case "teen": return "长"
    case "adult": return "成"
    case "mythic": return "传说"
    default: return stageLabel(for: stage)
    }
}

func compactFoodDisplayName(_ food: String) -> String {
    switch food {
    case "特制机能肉粒": return "特制肉粒"
    case "机能肉粒": return "肉粒"
    case "脑力浆果": return "浆果"
    case "字句奶酥": return "奶酥"
    case "校准薄荷": return "薄荷"
    case "路线饼干": return "饼干"
    case "会议泡芙": return "泡芙"
    case "陪伴糖豆": return "糖豆"
    case "空转泡面": return "泡面"
    default: return food
    }
}

func compactQualityLabel(_ quality: String) -> String {
    switch quality {
    case "breakthrough": return "高质"
    case "solid": return "稳定"
    case "partial": return "偏薄"
    case "waste": return "空耗"
    default: return quality
    }
}

func compactLedgerTime(_ timestamp: String?) -> String {
    guard let timestamp, !timestamp.isEmpty else { return "--:--" }
    if let timeRange = timestamp.range(of: #"T(\d{2}:\d{2})"#, options: .regularExpression) {
        return String(timestamp[timeRange]).replacingOccurrences(of: "T", with: "")
    }
    if timestamp.count >= 16 {
        let start = timestamp.index(timestamp.startIndex, offsetBy: 11)
        let end = timestamp.index(start, offsetBy: 5, limitedBy: timestamp.endIndex) ?? timestamp.endIndex
        return String(timestamp[start..<end])
    }
    return timestamp
}

func inventoryServingCount(_ state: PetState) -> Int {
    normalizedInventory(state).values.reduce(0, +)
}

func growthBalanceProfile(_ state: PetState) -> GrowthBalanceProfile {
    let inventoryLoad = inventoryServingCount(state)

    if state.toxicity > 70 || state.residue > 45 || inventoryLoad > 260 {
        return GrowthBalanceProfile(
            title: "压仓",
            note: "粮进得太快，正在猛长，但吸收开始发胀失衡",
            growthMultiplier: 0.84,
            bondMultiplier: 0.88,
            mealMoodBias: -2.6,
            mealHealthBias: -1.8,
            toxicityMultiplier: 1.18,
            residueMultiplier: 1.22,
            affinityMultiplier: 0.78,
            agitationMultiplier: 1.24,
            moodDecayMultiplier: 1.15,
            pettingNeedMultiplier: 1.10
        )
    }

    if inventoryLoad > 40 || state.energy > 82 || state.satiety > 80 {
        return GrowthBalanceProfile(
            title: "亢奋",
            note: "最近吃得足，长得更快，也更容易躁起来",
            growthMultiplier: 1.18,
            bondMultiplier: 0.95,
            mealMoodBias: 1.8,
            mealHealthBias: 0.4,
            toxicityMultiplier: 1.06,
            residueMultiplier: 1.08,
            affinityMultiplier: 1.02,
            agitationMultiplier: 1.10,
            moodDecayMultiplier: 1.02,
            pettingNeedMultiplier: 0.96
        )
    }

    if inventoryLoad < 8 && state.satiety < 48 {
        return GrowthBalanceProfile(
            title: "节制",
            note: "吃得少一点，长得慢一些，但会更细腻敏感",
            growthMultiplier: 0.76,
            bondMultiplier: 1.18,
            mealMoodBias: -0.4,
            mealHealthBias: 0.8,
            toxicityMultiplier: 0.72,
            residueMultiplier: 0.72,
            affinityMultiplier: 1.16,
            agitationMultiplier: 0.76,
            moodDecayMultiplier: 0.94,
            pettingNeedMultiplier: 1.14
        )
    }

    return GrowthBalanceProfile(
        title: "舒展",
        note: "吃得刚好，长得最稳，关系也最容易养熟",
        growthMultiplier: 1.06,
        bondMultiplier: 1.08,
        mealMoodBias: 0.8,
        mealHealthBias: 1.0,
        toxicityMultiplier: 0.92,
        residueMultiplier: 0.90,
        affinityMultiplier: 1.10,
        agitationMultiplier: 0.90,
        moodDecayMultiplier: 0.92,
        pettingNeedMultiplier: 0.94
    )
}

func metabolismPhase(_ state: PetState) -> (title: String, note: String) {
    let profile = growthBalanceProfile(state)
    return (profile.title, profile.note)
}

func compactPetPhrase(_ text: String) -> String {
    var next = text
    let replacements = [
        "现在最想：": "",
        "今天更想": "想",
        "想让你": "想被",
        "想和你来个": "",
        "回合": "",
        "先轻拍一下，让它认住你": "先轻拍，让它认住你",
        "想被你拍到软乎乎地贴过来": "想被你拍软乎",
        "想被你拍到翻肚皮": "想被你拍到翻肚皮",
        "想把一大股躁劲重重拍散": "想把躁劲重拍散",
        "想把一大股躁劲拍出来": "想把躁劲拍出来",
        "想把憋着的躁劲拍开": "想把躁劲拍开",
        "想把一点躁劲拍松": "想把躁劲拍松",
        "正在攒下一次拍劲": "正在攒拍劲",
        "正在自己慢慢整理": "正在慢慢整理"
    ]
    for (source, target) in replacements {
        next = next.replacingOccurrences(of: source, with: target)
    }
    return next
}

func minimalistHeaderText(_ state: PetState) -> String {
    "\(petDisplayName(state)) · \(compactStageLabel(for: state.stage))"
}

func minimalistGrowthText(_ state: PetState) -> String {
    "长势·\(metabolismPhase(state).title)"
}

func mealActivityText(taskType: String, phase: GrowthBalanceProfile) -> String {
    let food = foodName(for: taskType)
    switch phase.title {
    case "压仓":
        return "鼓着肚子慢慢消化\(food)"
    case "亢奋":
        return "狠狠干嚼着\(food)"
    case "节制":
        return "小口省着吃\(food)"
    default:
        return "舒舒服服嚼着\(food)"
    }
}

func requestPromptPrefix(_ state: PetState) -> String {
    switch dominantGrowthTendency(state).title {
    case "细养型":
        return "它安静贴着边看你，像是在轻声说："
    case "猛长型":
        return "它刚巡了一圈又站住，抬头冲你发劲："
    case "胀仓型":
        return "它先抖了抖毛，再慢慢偏头朝你示意："
    default:
        return "它站住抬头看着你，像是在说："
    }
}

func passiveGrowthRequestText(_ state: PetState, heavyBias: Bool, gentleBias: Bool, affinityBias: Bool, agitationBias: Bool) -> String? {
    let tendency = dominantGrowthTendency(state).title
    if heavyBias || agitationBias {
        switch tendency {
        case "胀仓型": return "正在抖毛消化肚里那股躁劲"
        case "猛长型": return "正鼓着劲等你来拍开一截"
        default: return "正在憋一记能把躁劲拍散的回合"
        }
    }
    if gentleBias || affinityBias {
        switch tendency {
        case "细养型": return "正安静贴着边等你回头轻拍"
        case "猛长型": return "巡完一圈后，正等你补上一拍"
        default: return "正在等你早点来一记轻拍"
        }
    }
    if state.satiety < 42 {
        return tendency == "细养型" ? "正在省着把下一点拍劲攒起来" : "正在攒下一次拍劲"
    }
    if state.hygiene < 28 || state.residue > 60 {
        return tendency == "胀仓型" ? "正在先把自己整理顺" : "正在自己慢慢整理"
    }
    return nil
}

func activeGrowthRequestText(_ state: PetState, tier: Int, valence: String, gentleBias: Bool, heavyBias: Bool, affinityBias: Bool, agitationBias: Bool) -> String {
    let tendency = dominantGrowthTendency(state).title
    if valence == "affinity" {
        switch tier {
        case 1:
            if tendency == "细养型" { return "想被你轻轻碰一下就好" }
            return gentleBias ? "今天更想让你轻轻拍开" : "想让你轻轻拍一下"
        case 2:
            if tendency == "猛长型" { return "想接你一记利落的中拍" }
            if tendency == "细养型" { return "想被你顺手拍得更靠近一点" }
            return gentleBias ? "拍劲涨大了，但还是想被你顺手拍开" : "想和你来个顺手的中拍回合"
        default:
            if tendency == "猛长型" { return "今天想被你拍得整只都发亮" }
            if tendency == "细养型" { return "想被你拍到软软贴过来" }
            return heavyBias ? "今天想被你拍到翻肚皮" : "想被你拍到软乎乎地贴过来"
        }
    }

    switch tier {
    case 1:
        if tendency == "胀仓型" { return "想先把肚里一点闷劲拍松" }
        return gentleBias ? "想先把一点躁劲轻轻拍松" : "想把一点躁劲拍松"
    case 2:
        if tendency == "猛长型" { return "想把鼓起来的躁劲利落拍开" }
        if tendency == "胀仓型" { return "想把憋住那截躁劲拍散一点" }
        return agitationBias ? "想把躁劲拍散一截" : "想把憋着的躁劲拍开"
    default:
        if tendency == "胀仓型" { return "想把整团闷躁重重拍散" }
        if tendency == "猛长型" { return "想把涨满那股劲狠狠干散" }
        return heavyBias ? "想把一大股躁劲重重拍散" : "想把一大股躁劲拍出来"
    }
}

func minimalistStatusText(_ state: PetState, badge: String?) -> String {
    if let badge {
        return badge
    }
    if isBirthBondPending(state) {
        return "先轻拍，让它认住你"
    }
    if let request = state.currentRequest {
        return compactPetPhrase(request)
    }
    return compactPetPhrase(currentActivityText(state))
}

func currentRequestIgnoreLevel(_ state: PetState) -> Int {
    state.currentRequestIgnoreLevel ?? 0
}

func currentRequestAge(_ state: PetState) -> Double {
    guard let at = state.currentRequestAt else { return 0 }
    return max(0, Date().timeIntervalSince1970 - at)
}

func applyMissedRequestFeedback(_ state: inout PetState, profile: InteractionRequestProfile) -> String? {
    guard profile.actionable else { return nil }
    let now = Date().timeIntervalSince1970
    let age = currentRequestAge(state)
    let level = currentRequestIgnoreLevel(state)
    guard age >= 12 else { return nil }

    if level == 0 {
        state.currentRequestIgnoreLevel = 1
        if profile.desiredValence == "affinity" {
            state.mood = clamp(state.mood - 3)
            state.bond = clamp(state.bond - 1.5)
            _ = setActiveFeedback(&state, key: "request_missed_once", source: "background", priority: 60, duration: 2.8, now: now, resolvedOutcome: "missed_once")
            if dominantGrowthTendency(state).title == "细养型" {
                state.currentActivity = "悄悄贴回边上继续等"
                state.lastCareSummary = "它轻轻往边上贴了贴，像是还想再等你一下"
                appendFoodLog(&state, entry: "等拍落空：安静贴回边上")
                return "它没催你，只是悄悄贴回桌边，像还想再等你主动回头。"
            }
            state.currentActivity = "趴在边上等你回头"
            state.lastCareSummary = "它等了你一会儿，见你没拍它，就慢慢趴回桌边"
            appendFoodLog(&state, entry: "等拍落空：它轻轻缩回去了")
            return "它本来在等你那一下，等了一会儿又自己慢慢趴回去了。"
        }

        state.agitationEnergy = clamp(currentAgitationEnergy(state) + 6)
        _ = setActiveFeedback(&state, key: "request_missed_once", source: "background", priority: 60, duration: 2.8, now: now, resolvedOutcome: "missed_once")
        if dominantGrowthTendency(state).title == "胀仓型" {
            state.currentActivity = "抖了抖毛，把闷劲压回去"
            state.lastCareSummary = "它想把闷着那口劲放掉，却又自己压回去了"
            appendFoodLog(&state, entry: "等拍落空：闷劲又压回肚里")
            return "它本来想把那口闷劲交给你拍散，没等到，就又自己压回肚子里了。"
        }
        state.currentActivity = "把躁劲又憋回肚子里"
        state.lastCareSummary = "它想把躁劲拍散，却没等到，只好自己绷着毛"
        appendFoodLog(&state, entry: "等拍落空：躁劲又鼓回来了")
        return "它本来想把躁劲拍出来，没等到你，身上的毛又慢慢绷起来了。"
    }

    guard level == 1, age >= 24 else { return nil }
    state.currentRequestIgnoreLevel = 2
    if profile.desiredValence == "affinity" {
        state.mood = clamp(state.mood - 5)
        state.bond = clamp(state.bond - 2.5)
        state.pettingNeed = clamp(currentPettingNeed(state) + 12)
        _ = setActiveFeedback(&state, key: "request_missed_twice", source: "background", priority: 65, duration: 3.4, now: now, resolvedOutcome: "missed_twice")
        state.currentActivity = "背过身自己缩成一团"
        state.lastCareSummary = "它等到有点失落，干脆自己缩成一团消化情绪"
        appendFoodLog(&state, entry: "等拍失落：缩成一团自己消化")
        return "它等得有点失落了，背过身把自己缩成一团，像是在慢慢消化心情。"
    }

    state.agitationEnergy = clamp(currentAgitationEnergy(state) + 10)
    state.toxicity = clamp(state.toxicity + 3)
    _ = setActiveFeedback(&state, key: "request_missed_twice", source: "background", priority: 65, duration: 3.4, now: now, resolvedOutcome: "missed_twice")
    state.currentActivity = "抖着毛自己消化躁劲"
    state.lastCareSummary = "它没等到想要的那一下，只能自己抖毛硬消化躁劲"
    appendFoodLog(&state, entry: "等拍别扭：自己抖毛消化躁劲")
    return "它没等到那一下，开始自己抖毛消化躁劲，整只兽都显得有点别扭。"
}

func applyOffBeatInteractionFeedback(_ state: inout PetState, profile: InteractionRequestProfile, actualTier: Int, actualValence: String) -> String? {
    guard profile.actionable, actualTier > 0 else { return nil }
    let matched = profile.desiredTier == actualTier && profile.desiredValence == actualValence
    guard !matched else { return nil }
    let now = Date().timeIntervalSince1970
    _ = setActiveFeedback(&state, key: "interaction_offbeat", source: "interaction", priority: 70, duration: 2.0, now: now, resolvedOutcome: "offbeat")

    if profile.desiredValence == "affinity" {
        state.mood = clamp(state.mood - 1.5)
        state.currentActivity = "歪头看你，像还想再试一次"
        state.lastCareSummary = "它有回应你，但像是觉得这一下还没完全拍在点上"
        appendFoodLog(&state, entry: "拍偏了一点：它还想再对上节奏")
        return "它有回应你，但眼神里像是在说，这一下还没完全拍在它想要的点上。"
    }

    state.agitationEnergy = clamp(currentAgitationEnergy(state) + 2)
    state.currentActivity = "甩了下毛，像还没完全拍透"
    state.lastCareSummary = "它抖了抖毛，像是还有一点躁劲没被拍透"
    appendFoodLog(&state, entry: "拍偏了一点：躁劲还剩下一截")
    return "它确实被你拍动了，但像还有一小截躁劲没完全被拍开。"
}

func rewardForMatchedRequest(_ state: inout PetState, profile: InteractionRequestProfile, actualTier: Int, actualValence: String) -> Bool {
    let matched = profile.actionable
        && actualTier > 0
        && profile.desiredTier == actualTier
        && profile.desiredValence == actualValence

    if matched {
        let feedbackKey = actualValence == "affinity" ? "interaction_matched_affinity" : "interaction_matched_agitation"
        _ = setActiveFeedback(&state, key: feedbackKey, source: "interaction", priority: 70, duration: 2.2, resolvedOutcome: "matched")
        addReward(&state, amount: 1, reason: "满足了它的请求")
        state.currentRequest = nil
    }
    return matched
}

func temperamentTitle(_ state: PetState) -> String {
    let baseTitle: String
    switch state.form {
    case "builder":
        if state.stage == "mythic" { baseTitle = "工坊总管" }
        else if state.bond > 80 { baseTitle = "机巧监工" }
        else { baseTitle = "搭建小兽" }
    case "scholar":
        if state.stage == "mythic" { baseTitle = "灯塔学士" }
        else if state.focus > 80 { baseTitle = "卷轴守望者" }
        else { baseTitle = "啃书团子" }
    case "captain":
        if state.stage == "mythic" { baseTitle = "领航总督" }
        else if state.bond > 70 { baseTitle = "队列指挥官" }
        else { baseTitle = "小队长" }
    case "social":
        if state.stage == "mythic" { baseTitle = "心火使者" }
        else if state.bond > 85 { baseTitle = "暖场团长" }
        else { baseTitle = "贴贴精灵" }
    case "chaos":
        if state.stage == "mythic" { baseTitle = "裂隙异兽" }
        else if state.toxicity > 70 { baseTitle = "故障恶作剧家" }
        else { baseTitle = "毛边团子" }
    default:
        if state.stage == "mythic" { baseTitle = "传说幼灵" }
        else if state.growth > 120 { baseTitle = "成长期小兽" }
        else { baseTitle = "桌边小团子" }
    }

    let total = totalImpactCount(state)
    guard total >= 4 else { return baseTitle }

    let affinity = affinityReleaseCount(state)
    let agitation = agitationReleaseCount(state)
    let tier = dominantImpactTier(state)

    if affinity >= agitation + 3 {
        if tier == 1 { return "亲手养熟的\(baseTitle)" }
        if tier == 2 { return "会回拍的\(baseTitle)" }
        return "热烈黏人的\(baseTitle)" }
    if agitation >= affinity + 3 {
        if tier == 3 { return "炸毛烈性的\(baseTitle)" }
        if tier == 2 { return "会抖劲的\(baseTitle)" }
        return "慢热别扭的\(baseTitle)" }
    if tier == 3 { return "性子很烈的\(baseTitle)" }
    if tier == 1 { return "慢慢养熟的\(baseTitle)" }
    return "节奏独特的\(baseTitle)"
}

final class PetStore {
    let nutritionProfiles: [String: NutritionProfile]
    let stateURL: URL
    let feedURL: URL
    let externalFeedURL: URL
    let configURL: URL
    let runtimeDir: URL
    let scriptsDir: URL
    let instancePIDURL: URL
    let bridgeScriptURL: URL
    let bridgePIDURL: URL
    let bridgeLogURL: URL

    init() throws {
        let executableURL = URL(fileURLWithPath: CommandLine.arguments[0]).resolvingSymlinksInPath()
        runtimeDir = executableURL.deletingLastPathComponent()
        let pluginDir = runtimeDir.deletingLastPathComponent()
        scriptsDir = pluginDir.appendingPathComponent("scripts")
        let profileURL = scriptsDir.appendingPathComponent("nutrition-profile.json")
        stateURL = runtimeDir.appendingPathComponent("pet-state.json")
        feedURL = runtimeDir.appendingPathComponent("codex-feed.json")
        externalFeedURL = runtimeDir.appendingPathComponent("external-feed.json")
        configURL = runtimeDir.appendingPathComponent("pet-config.json")
        instancePIDURL = runtimeDir.appendingPathComponent("desktop-pet.pid")
        bridgeScriptURL = scriptsDir.appendingPathComponent("codex_usage_bridge.py")
        bridgePIDURL = runtimeDir.appendingPathComponent("codex-bridge.pid")
        bridgeLogURL = runtimeDir.appendingPathComponent("codex-bridge.log")
        let data = try Data(contentsOf: profileURL)
        nutritionProfiles = try JSONDecoder().decode([String: NutritionProfile].self, from: data)
    }

    func isPIDAlive(_ pid: Int32) -> Bool {
        pid > 0 && kill(pid, 0) == 0
    }

    func cleanupBridgePIDFileIfNeeded() {
        guard let rawPID = try? String(contentsOf: bridgePIDURL, encoding: .utf8)
            .trimmingCharacters(in: .whitespacesAndNewlines),
              let pid = Int32(rawPID) else {
            return
        }

        if !isPIDAlive(pid) {
            try? FileManager.default.removeItem(at: bridgePIDURL)
        }
    }

    func ensureBridgeRunning() {
        cleanupBridgePIDFileIfNeeded()

        if let rawPID = try? String(contentsOf: bridgePIDURL, encoding: .utf8)
            .trimmingCharacters(in: .whitespacesAndNewlines),
           let existingPID = Int32(rawPID),
           isPIDAlive(existingPID) {
            return
        }

        try? FileManager.default.createDirectory(at: runtimeDir, withIntermediateDirectories: true, attributes: nil)
        FileManager.default.createFile(atPath: bridgeLogURL.path, contents: nil, attributes: nil)

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["python3", "-u", bridgeScriptURL.path]
        process.currentDirectoryURL = scriptsDir

        if let logHandle = try? FileHandle(forWritingTo: bridgeLogURL) {
            _ = try? logHandle.seekToEnd()
            process.standardOutput = logHandle
            process.standardError = logHandle
        }

        do {
            try process.run()
            try? "\(process.processIdentifier)\n".write(to: bridgePIDURL, atomically: true, encoding: .utf8)
        } catch {
            let message = "[bridge] failed to start: \(error.localizedDescription)\n"
            if let data = message.data(using: .utf8) {
                if let logHandle = try? FileHandle(forWritingTo: bridgeLogURL) {
                    _ = try? logHandle.seekToEnd()
                    try? logHandle.write(contentsOf: data)
                } else {
                    try? data.write(to: bridgeLogURL)
                }
            }
        }
    }

    func hydratedState(_ state: PetState) -> PetState {
        var next = state
        next.petName = next.petName ?? nil
        next.soulSignature = next.soulSignature ?? nil
        next.speakingStyle = next.speakingStyle ?? nil
        next.appearanceHint = next.appearanceHint ?? nil
        next.firstImpression = next.firstImpression ?? nil
        next.birthNarrative = next.birthNarrative ?? nil
        next.styleVector = next.styleVector ?? nil
        next.identitySeed = next.identitySeed ?? nil
        next.identityGeneratedAt = next.identityGeneratedAt ?? nil
        next.identityVersion = next.identityVersion ?? nil
        next.firstBondAt = next.firstBondAt ?? nil
        if next.petName != nil,
           next.firstBondAt == nil,
           next.lastInteractionAt != nil,
           (next.rewardStars ?? 0) > 0 {
            next.firstBondAt = next.identityGeneratedAt ?? next.lastInteractionAt
            if next.currentRequest == "想先记住你的手感" {
                next.currentRequest = nil
                next.currentRequestAt = nil
                next.currentRequestIgnoreLevel = 0
            }
        }
        next.foodInventory = next.foodInventory ?? [:]
        next.foodEnergyStock = next.foodEnergyStock ?? [:]
        next.recentFoodLog = next.recentFoodLog ?? []
        next.rewardStars = next.rewardStars ?? 0
        next.unlockedForms = next.unlockedForms ?? ["neutral"]
        next.consumedEventIDs = next.consumedEventIDs ?? []
        next.tokenLedger = next.tokenLedger ?? []
        next.growthPhaseImprint = next.growthPhaseImprint ?? defaultGrowthPhaseImprint()
        next.affinityEnergy = next.affinityEnergy ?? 0
        next.agitationEnergy = next.agitationEnergy ?? 0
        next.currentRequestAt = next.currentRequestAt ?? nil
        next.currentRequestIgnoreLevel = next.currentRequestIgnoreLevel ?? 0
        next.lastImpactTier = next.lastImpactTier ?? 0
        next.lastImpactValence = next.lastImpactValence ?? "none"
        next.gentleImpactCount = next.gentleImpactCount ?? 0
        next.mediumImpactCount = next.mediumImpactCount ?? 0
        next.heavyImpactCount = next.heavyImpactCount ?? 0
        next.affinityReleaseCount = next.affinityReleaseCount ?? 0
        next.agitationReleaseCount = next.agitationReleaseCount ?? 0
        next.activeFeedbackKey = next.activeFeedbackKey ?? nil
        next.activeFeedbackSource = next.activeFeedbackSource ?? nil
        next.activeFeedbackAt = next.activeFeedbackAt ?? nil
        next.activeFeedbackDuration = next.activeFeedbackDuration ?? nil
        next.activeFeedbackPriority = next.activeFeedbackPriority ?? nil
        next.lastResolvedRequestOutcome = next.lastResolvedRequestOutcome ?? "none"
        return next
    }

    func loadState() -> PetState {
        guard let data = try? Data(contentsOf: stateURL),
              let state = try? JSONDecoder().decode(PetState.self, from: data) else {
            return defaultState
        }
        return hydratedState(state)
    }

    func saveState(_ state: PetState) {
        let directory = stateURL.deletingLastPathComponent()
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        if let data = try? JSONEncoder().encode(state) {
            try? data.write(to: stateURL)
        }
    }

    func buildMeal(taskType: String, tokensSpent: Double, quality: String) -> Meal {
        let profile = nutritionProfiles[taskType] ?? nutritionProfiles["idle"]!
        let units = tokenUnits(tokensSpent)
        let multiplier = qualityMultiplier[quality] ?? 1.0
        let residue = max(0, profile.toxicity * units * (2 - multiplier))
        return Meal(
            taskType: taskType,
            label: profile.label,
            tokensSpent: tokensSpent,
            satiety: round1(profile.satiety * units * multiplier),
            energy: round1(profile.energy * units * multiplier),
            focus: round1(profile.focus * units * multiplier),
            mood: round1(profile.mood * units * multiplier),
            hygiene: round1(profile.hygiene * units),
            health: round1(profile.health * units * multiplier),
            bond: round1(profile.bond * units * multiplier),
            growth: round1(profile.growth * units * multiplier),
            toxicity: round1(profile.toxicity * units * (1.2 - multiplier * 0.2)),
            residue: round1(residue),
            archetypes: profile.archetypes
        )
    }

    func loadFeed() -> FeedEnvelope? {
        guard let data = try? Data(contentsOf: feedURL) else { return nil }
        return try? JSONDecoder().decode(FeedEnvelope.self, from: data)
    }

    func loadExternalFeed() -> FeedEnvelope? {
        guard let data = try? Data(contentsOf: externalFeedURL) else { return nil }
        return try? JSONDecoder().decode(FeedEnvelope.self, from: data)
    }

    func loadMergedFeed(config: PetConfig) -> FeedEnvelope? {
        var events: [FeedEvent] = []
        if config.codexSourceEnabled, let codexFeed = loadFeed() {
            events.append(contentsOf: codexFeed.events)
        }
        if config.externalSourceEnabled, let externalFeed = loadExternalFeed() {
            events.append(contentsOf: externalFeed.events)
        }
        if events.isEmpty { return nil }

        let deduped = Array(
            Dictionary(uniqueKeysWithValues: events.map { ($0.id, $0) }).values
        ).sorted { left, right in
            let leftTS = left.timestamp ?? ""
            let rightTS = right.timestamp ?? ""
            if leftTS == rightTS { return left.id < right.id }
            return leftTS < rightTS
        }

        return FeedEnvelope(
            latest_event_id: deduped.last?.id,
            events: deduped,
            updated_at: deduped.last?.timestamp
        )
    }

    func loadConfig() -> PetConfig {
        guard let data = try? Data(contentsOf: configURL),
              let config = try? JSONDecoder().decode(PetConfig.self, from: data) else {
            return defaultConfig
        }
        return config
    }

    func saveConfig(_ config: PetConfig) {
        let directory = configURL.deletingLastPathComponent()
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        if let data = try? JSONEncoder().encode(config) {
            try? data.write(to: configURL)
        }
    }

    func claimSingleInstance() {
        let currentPID = getpid()

        if let rawPID = try? String(contentsOf: instancePIDURL, encoding: .utf8)
            .trimmingCharacters(in: .whitespacesAndNewlines),
           let existingPID = Int32(rawPID),
           existingPID > 0,
           existingPID != currentPID,
           kill(existingPID, 0) == 0 {
            kill(existingPID, SIGTERM)
            usleep(400_000)
            if kill(existingPID, 0) == 0 {
                kill(existingPID, SIGKILL)
                usleep(150_000)
            }
        }

        try? "\(currentPID)\n".write(to: instancePIDURL, atomically: true, encoding: .utf8)
    }

    func releaseSingleInstance() {
        let currentPID = "\(getpid())"
        if let rawPID = try? String(contentsOf: instancePIDURL, encoding: .utf8)
            .trimmingCharacters(in: .whitespacesAndNewlines),
           rawPID == currentPID {
            try? FileManager.default.removeItem(at: instancePIDURL)
        }
    }
}

enum PetEngine {
    static func applyMeal(_ state: PetState, meal: Meal) -> PetState {
        var next = state
        let balance = growthBalanceProfile(state)
        next.satiety = clamp(next.satiety + meal.satiety)
        next.energy = clamp(next.energy + meal.energy)
        next.focus = clamp(next.focus + meal.focus)
        next.mood = clamp(next.mood + meal.mood + balance.mealMoodBias)
        next.hygiene = clamp(next.hygiene + meal.hygiene)
        next.health = clamp(next.health + meal.health - meal.toxicity * 0.4 + balance.mealHealthBias)
        next.bond = clamp(next.bond + meal.bond * balance.bondMultiplier)
        next.growth = round1(next.growth + meal.growth * balance.growthMultiplier)
        next.toxicity = clamp(next.toxicity + meal.toxicity * balance.toxicityMultiplier)
        next.residue = clamp(next.residue + meal.residue * balance.residueMultiplier)
        next.lastTaskType = meal.taskType
        next.currentActivity = mealActivityText(taskType: meal.taskType, phase: balance)
        next.lastFoodName = foodName(for: meal.taskType)
        next.pettingNeed = clamp(currentPettingNeed(next) - 8)
        let affinityGain = max(0, meal.mood + meal.bond + meal.health * 0.5 - meal.toxicity * 0.8) * 0.32 * balance.affinityMultiplier
        let agitationGain = max(0, meal.toxicity * 0.9 + meal.residue * 0.5 - meal.mood * 0.2) * 0.24 * balance.agitationMultiplier
        next.affinityEnergy = clamp(currentAffinityEnergy(next) + affinityGain)
        next.agitationEnergy = clamp(currentAgitationEnergy(next) + agitationGain)
        for (name, score) in meal.archetypes {
            next.archetypeScore[name, default: 0] = round1(next.archetypeScore[name, default: 0] + score * tokenUnits(meal.tokensSpent))
        }
        applyGrowthPhaseImprint(&next, phase: balance.title, amount: max(0.6, meal.growth * 0.18))
        next.stage = deriveStage(next.growth)
        next.form = deriveForm(next.archetypeScore)
        return next
    }

    static func decay(_ state: PetState, hours: Double) -> PetState {
        var next = state
        let balance = growthBalanceProfile(state)
        next.ageHours = round1(next.ageHours + hours)
        next.satiety = clamp(next.satiety - hours * 3.5)
        next.energy = clamp(next.energy - hours * 2.6)
        next.focus = clamp(next.focus - hours * 1.8)
        next.mood = clamp(next.mood - (hours * 1.6 + state.residue * 0.03) * balance.moodDecayMultiplier)
        next.hygiene = clamp(next.hygiene - hours * 1.4 - state.toxicity * 0.02)
        next.health = clamp(next.health - max(0, state.toxicity - 40) * 0.03 * hours)
        next.toxicity = clamp(next.toxicity - hours * 0.6)
        next.pettingNeed = clamp(currentPettingNeed(next) + (hours * 5.5 - next.bond * 0.02) * balance.pettingNeedMultiplier)
        next.affinityEnergy = clamp(currentAffinityEnergy(next) - hours * 2.1 + max(0, next.bond - 60) * 0.02)
        next.agitationEnergy = clamp(currentAgitationEnergy(next) - hours * 1.2 + max(0, 40 - next.hygiene) * 0.10 + max(0, 35 - next.satiety) * 0.08)
        next.currentActivity = deriveActivity(next)
        applyGrowthPhaseImprint(&next, phase: balance.title, amount: max(0.3, hours * 0.7))
        next.stage = deriveStage(next.growth)
        next.form = deriveForm(next.archetypeScore)
        return next
    }

    static func clean(_ state: PetState) -> PetState {
        var next = state
        next.residue = clamp(next.residue - 12)
        next.hygiene = clamp(next.hygiene + 10)
        next.mood = clamp(next.mood + 3)
        next.health = clamp(next.health + 2)
        next.currentActivity = "抖抖毛做清洁"
        return next
    }

    static func play(_ state: PetState) -> PetState {
        var next = state
        next.mood = clamp(next.mood + 8)
        next.bond = clamp(next.bond + 6)
        next.energy = clamp(next.energy - 4)
        next.satiety = clamp(next.satiety - 3)
        next.currentActivity = "追着尾巴乱跑"
        next.pettingNeed = clamp(currentPettingNeed(next) - 14)
        return next
    }

    static func sleep(_ state: PetState) -> PetState {
        var next = state
        next.energy = clamp(next.energy + 42)
        next.health = clamp(next.health + 12)
        next.focus = clamp(next.focus + 10)
        next.mood = clamp(next.mood + 6)
        next.satiety = clamp(next.satiety - 10)
        next.currentActivity = "抱着尾巴睡觉"
        next.pettingNeed = clamp(currentPettingNeed(next) - 10)
        return next
    }

    static func pet(_ state: PetState) -> PetState {
        var next = state
        let need = currentPettingNeed(next)
        let bonus = need > 68 ? 1.7 : 1.0
        next.mood = clamp(next.mood + 6 * bonus)
        next.bond = clamp(next.bond + 8 * bonus)
        next.health = clamp(next.health + 1.5 * bonus)
        next.energy = clamp(next.energy + 1.2 * bonus)
        next.pettingNeed = clamp(need - 22 * bonus)
        next.currentActivity = bonus > 1.2 ? "贴着你蹭蹭撒娇" : "被摸得呼噜呼噜"
        return next
    }

    static func interact(_ state: PetState) -> (PetState, String, Int, String) {
        var next = state
        let affinity = currentAffinityEnergy(next)
        let agitation = currentAgitationEnergy(next)
        let total = affinity + agitation
        guard total >= 12 else {
            next.currentActivity = "歪头看你，但还没攒够拍劲"
            return (next, "它还在消化工作，暂时拍不出什么反应。", 0, "none")
        }

        let release: Double
        let tier: Int
        if total < 28 {
            release = 12
            tier = 1
        } else if total < 56 {
            release = 24
            tier = 2
        } else {
            release = 40
            tier = 3
        }

        let affinityShare = total > 0 ? affinity / total : 0
        let usedAffinity = min(affinity, release * affinityShare)
        let usedAgitation = min(agitation, release - usedAffinity)
        next.affinityEnergy = clamp(affinity - usedAffinity)
        next.agitationEnergy = clamp(agitation - usedAgitation)

        if usedAffinity >= usedAgitation {
            next.mood = clamp(next.mood + Double(tier) * 5)
            next.bond = clamp(next.bond + Double(tier) * 6)
            next.health = clamp(next.health + Double(tier) * 1.4)
            next.currentActivity = tier >= 3 ? "被拍得翻肚皮乱蹭" : (tier == 2 ? "被你拍得开心打转" : "被你轻拍后贴近了些")
            next.archetypeScore["social", default: 0] = round1(next.archetypeScore["social", default: 0] + Double(tier) * 0.8)
            next.affinityReleaseCount = affinityReleaseCount(next) + 1
            if tier == 1 { next.gentleImpactCount = gentleImpactCount(next) + 1 }
            if tier == 2 { next.mediumImpactCount = mediumImpactCount(next) + 1 }
            if tier == 3 { next.heavyImpactCount = heavyImpactCount(next) + 1 }
            let message = tier >= 3 ? "这一下拍得它直接翻肚皮了，整只兽都软下来蹭你。" : (tier == 2 ? "它被你拍得开心打转，尾巴晃得更快了。" : "你轻轻拍了它一下，它靠近你蹭了蹭。")
            return (next, message, tier, "affinity")
        } else {
            next.mood = clamp(next.mood - Double(tier) * 2 + Double(tier) * 1.4)
            next.energy = clamp(next.energy + Double(tier) * 3)
            next.toxicity = clamp(next.toxicity - Double(tier) * 2.2)
            next.currentActivity = tier >= 3 ? "被拍得炸毛乱窜" : (tier == 2 ? "被拍后抖毛甩掉躁气" : "被你拍醒后抖了一下")
            next.archetypeScore["chaos", default: 0] = round1(next.archetypeScore["chaos", default: 0] + Double(tier) * 0.7)
            next.archetypeScore["captain", default: 0] = round1(next.archetypeScore["captain", default: 0] + Double(tier) * 0.3)
            next.agitationReleaseCount = agitationReleaseCount(next) + 1
            if tier == 1 { next.gentleImpactCount = gentleImpactCount(next) + 1 }
            if tier == 2 { next.mediumImpactCount = mediumImpactCount(next) + 1 }
            if tier == 3 { next.heavyImpactCount = heavyImpactCount(next) + 1 }
            let message = tier >= 3 ? "这一下把它体内的躁动全拍出来了，它炸毛乱窜后反而轻快了一点。" : (tier == 2 ? "你这一拍把它憋着的躁气拍散了一些，它抖了抖毛。" : "你拍了它一下，它惊了一下，但躁劲也松开了一点。")
            return (next, message, tier, "agitation")
        }
    }
}

final class PetSceneView: NSView {
    var state = defaultState {
        didSet { needsDisplay = true }
    }
    var animationPhase: CGFloat = 0 {
        didSet { needsDisplay = true }
    }
    var onPetTap: (() -> Void)?
    var onDoubleClick: (() -> Void)?

    override var isFlipped: Bool { true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.clear.setFill()
        dirtyRect.fill()

        let activity = currentActivityText(state)
        let growthTendency = dominantGrowthTendency(state).title
        let identityVisual = identityVisualProfile(state)
        let birthPending = isBirthBondPending(state)
        let ignoreLevel = currentRequestIgnoreLevel(state)
        let isSleeping = activityHasAny(state, keywords: ["睡", "补眠", "打盹", "回窝"])
        let isRunning = activityHasAny(state, keywords: ["巡桌", "乱跑", "转圈", "热身"])
        let isSnuggling = activityHasAny(state, keywords: ["撒娇", "呼噜", "摸", "蹭"])
        let isCleaning = activityHasAny(state, keywords: ["清洁", "整理", "舔毛", "梳"])
        let isCelebrating = activityHasAny(state, keywords: ["星屑", "开心", "转圈", "翻肚皮"])
        let isWaiting = ignoreLevel == 1 || activity.contains("等你回头")
        let isSulking = ignoreLevel >= 2 || activity.contains("缩成一团") || activity.contains("消化躁劲")
        let isOffBeat = activity.contains("歪头看你") || activity.contains("甩了下毛") || activity.contains("没完全拍透")
        let isTender = growthTendency == "细养型"
        let isBursting = growthTendency == "猛长型"
        let isStuffy = growthTendency == "胀仓型"
        let impact = currentImpactFeedback(state)

        let bobBase = sin(animationPhase) * 7
        let postureTuck: CGFloat = (isSulking ? 10 : (isWaiting ? 4 : 0)) + (isTender ? 2 : 0) + (isStuffy ? 3 : 0)
        let bobScale: CGFloat = isSleeping ? 0.35 : (isRunning ? (isBursting ? 1.55 : 1.35) : (isSulking ? 0.32 : (isStuffy ? 0.78 : (isTender ? 0.82 : 1.0))))
        let bob = bobBase * bobScale - postureTuck
        let wagBase: CGFloat = isSulking ? 3 : (isWaiting ? 5 : (isSnuggling ? 15 : 10))
        let wagScale: CGFloat = (isTender ? 0.72 : (isBursting ? 1.28 : (isStuffy ? 0.66 : 1.0))) * identityVisual.tailSwingBias
        let wag = sin(animationPhase * (isRunning ? (isBursting ? 3.0 : 2.5) : (isTender ? 1.35 : 1.7))) * (wagBase * wagScale)
        let blink = abs(sin(animationPhase * 0.55)) < 0.08
        let mood = deriveMoodTag(state)
        let bodyColor = formColors[state.form] ?? formColors["neutral"]!
        let accent = moodAccent(for: mood)
        let trait = generatedTraitProfile(state)
        let pawLift = birthPending ? CGFloat(6 + abs(sin(animationPhase * 2.0)) * 4) : (isSnuggling ? CGFloat((isTender ? 6 : 8) + abs(sin(animationPhase * 2.1)) * (isBursting ? 8 : 6)) : 0)
        let dash = isRunning ? CGFloat(abs(sin(animationPhase * (isBursting ? 3.0 : 2.6))) * (isBursting ? 12 : 8)) : 0
        let impactPower = impact.map { max(0, 1.0 - $0.age / 1.3) } ?? 0
        let impactShift = CGFloat((impact?.valence == "agitation" ? 1 : -1) * Int(round((impactPower) * Double((impact?.tier ?? 0) * 4))))
        let earTilt: CGFloat = (isSulking ? 12 : (isWaiting ? 6 : (birthPending ? -6 : 0))) + (isStuffy ? 4 : 0) - (isBursting ? 3 : 0)
        let headTilt: CGFloat = (isOffBeat ? 6 : (isSulking ? -5 : 0)) + (isTender ? -2 : 0) + (isBursting ? 2 : 0) + identityVisual.browTiltBias
        let tailDrop: CGFloat = (isSulking ? 18 : (isWaiting ? 10 : 0)) + (isStuffy ? 8 : 0) - (isBursting ? 4 : 0)
        let stageScale: CGFloat
        switch state.stage {
        case "egg": stageScale = 0.78
        case "sprout": stageScale = 0.88
        case "child": stageScale = 0.96
        case "teen": stageScale = 1.02
        case "adult": stageScale = 1.08
        default: stageScale = 1.14
        }
        let bodyWidthAdjust: CGFloat = (isTender ? -6 : (isStuffy ? 8 : (isBursting ? 4 : 0))) + identityVisual.bodyWidthBias
        let bodyHeightAdjust: CGFloat = (isTender ? -2 : (isStuffy ? 4 : 0)) + identityVisual.bodyHeightBias

        let shadowRect = NSRect(
            x: 62 - dash * 0.3 + impactShift * 0.4 + (isOffBeat ? 4 : 0),
            y: 182 + (isSulking ? 5 : 0),
            width: 102 + dash * 0.6 + CGFloat(impact?.tier ?? 0) * CGFloat(impactPower) * 4 - (isSulking ? 18 : (isWaiting ? 8 : 0)) + (isStuffy ? 8 : (isTender ? -6 : 0)),
            height: isSleeping ? 14 : (isSulking ? 12 : 18)
        )
        let shadowPath = NSBezierPath(ovalIn: shadowRect)
        NSColor.black.withAlphaComponent(0.12).setFill()
        shadowPath.fill()

        let haloRect = NSRect(x: 42, y: 52 + bob * 0.3, width: 142, height: 142)
        let haloColor: NSColor
        if birthPending {
            haloColor = NSColor(calibratedRed: 1.0, green: 0.87, blue: 0.60, alpha: 0.30)
        } else if isSulking {
            haloColor = NSColor(calibratedRed: 0.73, green: 0.76, blue: 0.88, alpha: 0.14)
        } else if isWaiting {
            haloColor = NSColor(calibratedRed: 0.98, green: 0.84, blue: 0.66, alpha: 0.16)
        } else {
            haloColor = NSColor(calibratedRed: 1.0, green: 0.81, blue: 0.55, alpha: 0.18)
        }
        haloColor.setFill()
        NSBezierPath(ovalIn: haloRect).fill()

        let bodyWidth: CGFloat = 112 * stageScale + bodyWidthAdjust
        let bodyHeight: CGFloat = 116 * stageScale + bodyHeightAdjust
        let bodyOriginX: CGFloat = 114 - bodyWidth / 2 + impactShift
        let bodyOriginY: CGFloat = 100 + bob - bodyHeight / 2 + (isSleeping ? 10 : 0) - CGFloat(impact?.tier ?? 0) * CGFloat(impactPower) * 1.5

        if state.stage == "egg" {
            let egg = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + 10, y: bodyOriginY + 6, width: bodyWidth - 20, height: bodyHeight))
            NSColor(calibratedRed: 1.0, green: 0.93, blue: 0.82, alpha: 0.98).setFill()
            egg.fill()
            NSColor(calibratedRed: 0.94, green: 0.80, blue: 0.58, alpha: 1.0).setStroke()
            egg.lineWidth = 2
            egg.stroke()

            let crack = NSBezierPath()
            crack.move(to: NSPoint(x: bodyOriginX + 48, y: bodyOriginY + 62))
            crack.line(to: NSPoint(x: bodyOriginX + 60, y: bodyOriginY + 72))
            crack.line(to: NSPoint(x: bodyOriginX + 70, y: bodyOriginY + 62))
            crack.line(to: NSPoint(x: bodyOriginX + 82, y: bodyOriginY + 72))
            crack.lineWidth = 3
            NSColor(calibratedRed: 0.86, green: 0.67, blue: 0.42, alpha: 1.0).setStroke()
            crack.stroke()
            return
        }

        let body = NSBezierPath(roundedRect: NSRect(x: bodyOriginX, y: bodyOriginY, width: bodyWidth, height: bodyHeight), xRadius: 48 * stageScale, yRadius: 48 * stageScale)
        bodyColor.setFill()
        body.fill()

        let tail = NSBezierPath()
        tail.move(to: NSPoint(x: bodyOriginX + bodyWidth - 15, y: bodyOriginY + bodyHeight * 0.66 + tailDrop * 0.3))
        tail.curve(
            to: NSPoint(x: bodyOriginX + bodyWidth + 18 + wag * 0.35, y: bodyOriginY + bodyHeight * 0.50 + tailDrop),
            controlPoint1: NSPoint(x: bodyOriginX + bodyWidth + 6, y: bodyOriginY + bodyHeight * 0.64 + tailDrop * 0.4),
            controlPoint2: NSPoint(x: bodyOriginX + bodyWidth + 14 + wag * 0.45, y: bodyOriginY + bodyHeight * 0.64 + tailDrop * 0.8)
        )
        tail.lineWidth = 10
        tail.lineCapStyle = .round
        bodyColor.withAlphaComponent(0.92).setStroke()
        tail.stroke()

        NSColor(calibratedRed: 1.0, green: 0.79, blue: 0.48, alpha: 1.0).setFill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + 8, y: bodyOriginY - 14 * stageScale + (isRunning ? dash * 0.4 : 0), width: 28 * stageScale, height: 44 * stageScale)).fill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth - 36 * stageScale, y: bodyOriginY - 14 * stageScale + (isRunning ? -dash * 0.25 : 0), width: 28 * stageScale, height: 44 * stageScale)).fill()

        let frontPawLeft = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.24, y: bodyOriginY + bodyHeight - 10 - pawLift, width: 16 * stageScale, height: 24 * stageScale), xRadius: 9, yRadius: 9)
        let frontPawRight = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.58, y: bodyOriginY + bodyHeight - 10 + (isRunning ? dash * 0.35 : 0), width: 16 * stageScale, height: 24 * stageScale), xRadius: 9, yRadius: 9)
        bodyColor.withAlphaComponent(0.98).setFill()
        frontPawLeft.fill()
        frontPawRight.fill()

        let earLeft = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + 13, y: bodyOriginY - 4 * stageScale + earTilt, width: 22 * stageScale, height: max(24, 42 * stageScale - abs(earTilt) * 0.8)), xRadius: 12, yRadius: 12)
        let earRight = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth - 35 * stageScale, y: bodyOriginY - 4 * stageScale + earTilt, width: 22 * stageScale, height: max(24, 42 * stageScale - abs(earTilt) * 0.8)), xRadius: 12, yRadius: 12)
        earLeft.fill()
        earRight.fill()

        drawGeneratedTraits(profile: trait, bodyOriginX: bodyOriginX, bodyOriginY: bodyOriginY, bodyWidth: bodyWidth, bodyHeight: bodyHeight, accent: accent, bodyColor: bodyColor, stageScale: stageScale, wag: wag)
        drawIdentityAccessory(profile: identityVisual, bodyOriginX: bodyOriginX, bodyOriginY: bodyOriginY, bodyWidth: bodyWidth, bodyHeight: bodyHeight, accent: accent, bodyColor: bodyColor)

        NSColor(calibratedRed: 1.0, green: 0.86, blue: 0.67, alpha: 0.86).setFill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.33 + headTilt * 0.2, y: bodyOriginY + bodyHeight * 0.50, width: 40 * stageScale, height: 28 * stageScale)).fill()

        let eyeY: CGFloat = bodyOriginY + bodyHeight * 0.31
        NSColor(calibratedRed: 0.15, green: 0.12, blue: 0.10, alpha: 1.0).setFill()
        let leftEyeX = bodyOriginX + bodyWidth * 0.33 + headTilt * 0.2
        let rightEyeX = bodyOriginX + bodyWidth * 0.58 + headTilt * 0.2
        let leftEyeY = eyeY + (isOffBeat ? 2 : 0)
        let rightEyeY = eyeY + (isSulking ? 3 : 0)
        if blink || mood == "sleepy" {
            NSBezierPath(rect: NSRect(x: leftEyeX, y: leftEyeY + 6, width: 10, height: 2)).fill()
            NSBezierPath(rect: NSRect(x: rightEyeX, y: rightEyeY + 6, width: 10, height: 2)).fill()
        } else if isWaiting || isSulking {
            let leftEye = NSBezierPath()
            leftEye.move(to: NSPoint(x: leftEyeX - 1, y: leftEyeY + 9))
            leftEye.curve(to: NSPoint(x: leftEyeX + 11, y: leftEyeY + 9), controlPoint1: NSPoint(x: leftEyeX + 3, y: leftEyeY + 13), controlPoint2: NSPoint(x: leftEyeX + 7, y: leftEyeY + 13))
            leftEye.lineWidth = 2.4
            leftEye.stroke()

            let rightEye = NSBezierPath()
            rightEye.move(to: NSPoint(x: rightEyeX - 1, y: rightEyeY + 9))
            rightEye.curve(to: NSPoint(x: rightEyeX + 11, y: rightEyeY + 9), controlPoint1: NSPoint(x: rightEyeX + 3, y: rightEyeY + 13), controlPoint2: NSPoint(x: rightEyeX + 7, y: rightEyeY + 13))
            rightEye.lineWidth = 2.4
            rightEye.stroke()
        } else {
            NSBezierPath(ovalIn: NSRect(x: leftEyeX, y: leftEyeY, width: 10, height: isOffBeat ? 12 : 14)).fill()
            NSBezierPath(ovalIn: NSRect(x: rightEyeX, y: rightEyeY, width: 10, height: isSulking ? 12 : 14)).fill()
        }

        let mouth = NSBezierPath()
        if isSulking {
            mouth.appendArc(withCenter: NSPoint(x: bodyOriginX + bodyWidth * 0.50 + headTilt * 0.15, y: bodyOriginY + bodyHeight * 0.61), radius: 10, startAngle: 25, endAngle: 155)
        } else if isWaiting {
            mouth.appendArc(withCenter: NSPoint(x: bodyOriginX + bodyWidth * 0.50 + headTilt * 0.15, y: bodyOriginY + bodyHeight * 0.59), radius: 8, startAngle: 15, endAngle: 165)
        } else if isOffBeat {
            mouth.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.41 + headTilt * 0.3, y: bodyOriginY + bodyHeight * 0.59))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.47 + headTilt * 0.3, y: bodyOriginY + bodyHeight * 0.56))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.57 + headTilt * 0.3, y: bodyOriginY + bodyHeight * 0.60))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.63 + headTilt * 0.3, y: bodyOriginY + bodyHeight * 0.57))
        } else if mood == "hungry" {
            mouth.appendArc(withCenter: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY + bodyHeight * 0.58), radius: 9, startAngle: 210, endAngle: 330)
        } else if mood == "glitched" {
            mouth.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.40, y: bodyOriginY + bodyHeight * 0.58))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.48, y: bodyOriginY + bodyHeight * 0.63))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.56, y: bodyOriginY + bodyHeight * 0.56))
            mouth.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.64, y: bodyOriginY + bodyHeight * 0.61))
        } else {
            mouth.appendArc(withCenter: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY + bodyHeight * 0.55), radius: 12, startAngle: 200, endAngle: 340)
        }
        mouth.lineWidth = 3
        mouth.lineCapStyle = .round
        mouth.stroke()

        if isRunning {
            let lineColor = accent.withAlphaComponent(0.45)
            lineColor.setStroke()
            for index in 0..<3 {
                let speedLine = NSBezierPath()
                let y = bodyOriginY + 26 + CGFloat(index) * 18
                speedLine.move(to: NSPoint(x: bodyOriginX - 22 - CGFloat(index) * 3, y: y))
                speedLine.line(to: NSPoint(x: bodyOriginX - 8, y: y - 2))
                speedLine.lineWidth = 2
                speedLine.stroke()
            }
        }

        if isCleaning {
            for index in 0..<3 {
                let bubbleSize = CGFloat(8 + index * 4)
                let offset = CGFloat(index) * 18
                let bubbleRect = NSRect(x: bodyOriginX - 8 + offset, y: bodyOriginY + 10 + CGFloat(index % 2) * 12, width: bubbleSize, height: bubbleSize)
                NSColor.white.withAlphaComponent(0.75).setFill()
                NSBezierPath(ovalIn: bubbleRect).fill()
            }
        }

        drawFormOverlay(form: state.form, bodyOriginX: bodyOriginX, bodyOriginY: bodyOriginY, bodyWidth: bodyWidth, bodyHeight: bodyHeight, accent: accent, stageScale: stageScale)

        if let impact, impact.tier > 0 {
            drawImpactFeedback(impact: impact, bodyOriginX: bodyOriginX, bodyOriginY: bodyOriginY, bodyWidth: bodyWidth, bodyHeight: bodyHeight, accent: accent)
        }

        accent.setFill()
        NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth - 22, y: bodyOriginY - 8, width: 34, height: 34)).fill()
        let tokenText = NSAttributedString(
            string: "+T",
            attributes: [
                .font: NSFont.boldSystemFont(ofSize: 13),
                .foregroundColor: NSColor.white
            ]
        )
        tokenText.draw(at: NSPoint(x: bodyOriginX + bodyWidth - 14, y: bodyOriginY + 1))

        if mood == "joyful" {
            let star = NSBezierPath()
            star.move(to: NSPoint(x: bodyOriginX - 8, y: bodyOriginY + 34))
            star.line(to: NSPoint(x: bodyOriginX - 4, y: bodyOriginY + 46))
            star.line(to: NSPoint(x: bodyOriginX + 8, y: bodyOriginY + 50))
            star.line(to: NSPoint(x: bodyOriginX - 4, y: bodyOriginY + 54))
            star.line(to: NSPoint(x: bodyOriginX - 8, y: bodyOriginY + 66))
            star.line(to: NSPoint(x: bodyOriginX - 12, y: bodyOriginY + 54))
            star.line(to: NSPoint(x: bodyOriginX - 24, y: bodyOriginY + 50))
            star.line(to: NSPoint(x: bodyOriginX - 12, y: bodyOriginY + 46))
            star.close()
            accent.withAlphaComponent(0.85).setFill()
            star.fill()
        }

        if isCelebrating {
            for index in 0..<4 {
                let sparkleX = bodyOriginX - 18 + CGFloat(index) * 36
                let sparkleY = bodyOriginY - 4 + CGFloat((index % 2) * 20)
                let sparkle = NSBezierPath()
                sparkle.move(to: NSPoint(x: sparkleX, y: sparkleY + 6))
                sparkle.line(to: NSPoint(x: sparkleX + 4, y: sparkleY + 14))
                sparkle.line(to: NSPoint(x: sparkleX + 12, y: sparkleY + 18))
                sparkle.line(to: NSPoint(x: sparkleX + 4, y: sparkleY + 22))
                sparkle.line(to: NSPoint(x: sparkleX, y: sparkleY + 30))
                sparkle.line(to: NSPoint(x: sparkleX - 4, y: sparkleY + 22))
                sparkle.line(to: NSPoint(x: sparkleX - 12, y: sparkleY + 18))
                sparkle.line(to: NSPoint(x: sparkleX - 4, y: sparkleY + 14))
                sparkle.close()
                accent.withAlphaComponent(0.6 + Double(index) * 0.08).setFill()
                sparkle.fill()
            }
        }

        if birthPending {
            let seedPulse = CGFloat(abs(sin(animationPhase * 1.8)))
            let seedRect = NSRect(x: bodyOriginX - 18, y: bodyOriginY + 20 - seedPulse * 4, width: 24, height: 24)
            let seed = NSBezierPath(ovalIn: seedRect)
            NSColor(calibratedRed: 1.0, green: 0.87, blue: 0.62, alpha: 0.82).setFill()
            seed.fill()

            let sprout = NSBezierPath()
            sprout.move(to: NSPoint(x: seedRect.midX, y: seedRect.minY + 8))
            sprout.line(to: NSPoint(x: seedRect.midX, y: seedRect.minY - 6))
            sprout.move(to: NSPoint(x: seedRect.midX, y: seedRect.minY + 2))
            sprout.curve(to: NSPoint(x: seedRect.midX - 8, y: seedRect.minY - 2), controlPoint1: NSPoint(x: seedRect.midX - 2, y: seedRect.minY - 6), controlPoint2: NSPoint(x: seedRect.midX - 7, y: seedRect.minY - 4))
            sprout.move(to: NSPoint(x: seedRect.midX, y: seedRect.minY + 2))
            sprout.curve(to: NSPoint(x: seedRect.midX + 8, y: seedRect.minY - 2), controlPoint1: NSPoint(x: seedRect.midX + 2, y: seedRect.minY - 6), controlPoint2: NSPoint(x: seedRect.midX + 7, y: seedRect.minY - 4))
            sprout.lineWidth = 2
            NSColor.white.withAlphaComponent(0.92).setStroke()
            sprout.stroke()
        }

        if isWaiting {
            let dotAlpha = 0.32 + abs(sin(animationPhase * 1.8)) * 0.24
            for index in 0..<3 {
                let dotRect = NSRect(x: bodyOriginX - 18 + CGFloat(index) * 10, y: bodyOriginY + 10 - CGFloat(index) * 3, width: 5, height: 5)
                NSColor(calibratedWhite: 1.0, alpha: dotAlpha - Double(index) * 0.06).setFill()
                NSBezierPath(ovalIn: dotRect).fill()
            }
        }

        if isTender && (isWaiting || isSnuggling) {
            let sweep = NSBezierPath()
            sweep.move(to: NSPoint(x: bodyOriginX - 18, y: bodyOriginY + bodyHeight * 0.70))
            sweep.curve(
                to: NSPoint(x: bodyOriginX - 36, y: bodyOriginY + bodyHeight * 0.78),
                controlPoint1: NSPoint(x: bodyOriginX - 26, y: bodyOriginY + bodyHeight * 0.72),
                controlPoint2: NSPoint(x: bodyOriginX - 32, y: bodyOriginY + bodyHeight * 0.82)
            )
            sweep.lineWidth = 2
            accent.withAlphaComponent(0.28).setStroke()
            sweep.stroke()
        }

        if isBursting && (isRunning || isWaiting) {
            for index in 0..<2 {
                let spark = NSBezierPath()
                let x = bodyOriginX + bodyWidth + 10 + CGFloat(index) * 8
                let y = bodyOriginY + 24 + CGFloat(index) * 20
                spark.move(to: NSPoint(x: x, y: y))
                spark.line(to: NSPoint(x: x + 8, y: y - 5))
                spark.line(to: NSPoint(x: x + 2, y: y + 6))
                spark.lineWidth = 2
                accent.withAlphaComponent(0.36).setStroke()
                spark.stroke()
            }
        }

        if isStuffy && (state.residue > 44 || state.toxicity > 60) {
            for index in 0..<2 {
                let wave = NSBezierPath()
                let x = bodyOriginX + bodyWidth * 0.32 + CGFloat(index) * 16
                let y = bodyOriginY + bodyHeight * 0.78 + CGFloat(index) * 4
                wave.move(to: NSPoint(x: x, y: y))
                wave.curve(
                    to: NSPoint(x: x + 16, y: y + 2),
                    controlPoint1: NSPoint(x: x + 4, y: y - 5),
                    controlPoint2: NSPoint(x: x + 12, y: y + 8)
                )
                wave.lineWidth = 2
                NSColor(calibratedRed: 0.93, green: 0.80, blue: 0.56, alpha: 0.26).setStroke()
                wave.stroke()
            }
        }

        if isSulking {
            let cloud = NSBezierPath()
            cloud.move(to: NSPoint(x: bodyOriginX - 8, y: bodyOriginY + 18))
            cloud.curve(to: NSPoint(x: bodyOriginX - 18, y: bodyOriginY + 6), controlPoint1: NSPoint(x: bodyOriginX - 16, y: bodyOriginY + 18), controlPoint2: NSPoint(x: bodyOriginX - 20, y: bodyOriginY + 12))
            cloud.curve(to: NSPoint(x: bodyOriginX - 4, y: bodyOriginY - 2), controlPoint1: NSPoint(x: bodyOriginX - 16, y: bodyOriginY), controlPoint2: NSPoint(x: bodyOriginX - 10, y: bodyOriginY - 4))
            cloud.curve(to: NSPoint(x: bodyOriginX + 10, y: bodyOriginY + 6), controlPoint1: NSPoint(x: bodyOriginX + 2, y: bodyOriginY - 2), controlPoint2: NSPoint(x: bodyOriginX + 10, y: bodyOriginY))
            cloud.curve(to: NSPoint(x: bodyOriginX - 8, y: bodyOriginY + 18), controlPoint1: NSPoint(x: bodyOriginX + 10, y: bodyOriginY + 14), controlPoint2: NSPoint(x: bodyOriginX + 2, y: bodyOriginY + 20))
            NSColor(calibratedRed: 0.62, green: 0.67, blue: 0.80, alpha: 0.28).setFill()
            cloud.fill()
        } else if isOffBeat {
            let tiltSpark = NSBezierPath()
            tiltSpark.move(to: NSPoint(x: bodyOriginX + bodyWidth + 8, y: bodyOriginY + 14))
            tiltSpark.line(to: NSPoint(x: bodyOriginX + bodyWidth + 18, y: bodyOriginY + 20))
            tiltSpark.line(to: NSPoint(x: bodyOriginX + bodyWidth + 12, y: bodyOriginY + 28))
            tiltSpark.line(to: NSPoint(x: bodyOriginX + bodyWidth + 22, y: bodyOriginY + 34))
            tiltSpark.lineWidth = 2.5
            accent.withAlphaComponent(0.42).setStroke()
            tiltSpark.stroke()
        }

        if wantsPetting(state) {
            let heart = NSBezierPath()
            heart.move(to: NSPoint(x: 54, y: bodyOriginY + 18))
            heart.curve(to: NSPoint(x: 44, y: bodyOriginY + 8), controlPoint1: NSPoint(x: 48, y: bodyOriginY + 6), controlPoint2: NSPoint(x: 44, y: bodyOriginY + 12))
            heart.curve(to: NSPoint(x: 54, y: bodyOriginY - 2), controlPoint1: NSPoint(x: 44, y: bodyOriginY + 2), controlPoint2: NSPoint(x: 48, y: bodyOriginY - 2))
            heart.curve(to: NSPoint(x: 64, y: bodyOriginY + 8), controlPoint1: NSPoint(x: 60, y: bodyOriginY - 2), controlPoint2: NSPoint(x: 64, y: bodyOriginY + 2))
            heart.curve(to: NSPoint(x: 54, y: bodyOriginY + 18), controlPoint1: NSPoint(x: 64, y: bodyOriginY + 12), controlPoint2: NSPoint(x: 60, y: bodyOriginY + 6))
            moodAccent(for: "joyful").withAlphaComponent(0.85).setFill()
            heart.fill()
        }

        if isSleeping {
            let zAttributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.boldSystemFont(ofSize: 12),
                .foregroundColor: NSColor(calibratedRed: 0.42, green: 0.57, blue: 0.92, alpha: 0.88)
            ]
            NSAttributedString(string: "z", attributes: zAttributes).draw(at: NSPoint(x: bodyOriginX + bodyWidth + 4, y: bodyOriginY + 2))
            NSAttributedString(string: "Z", attributes: zAttributes).draw(at: NSPoint(x: bodyOriginX + bodyWidth + 14, y: bodyOriginY - 14))
        }

        if isSnuggling {
            let pawPad = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.22, y: bodyOriginY + bodyHeight + 2 - pawLift, width: 12, height: 12))
            NSColor.white.withAlphaComponent(0.55).setFill()
            pawPad.fill()
        }
    }

    func drawImpactFeedback(impact: ImpactFeedback, bodyOriginX: CGFloat, bodyOriginY: CGFloat, bodyWidth: CGFloat, bodyHeight: CGFloat, accent: NSColor) {
        let power = max(0, 1.0 - impact.age / 1.3)
        let tierScale = CGFloat(impact.tier)

        if impact.valence == "bond" {
            let coreRadius = CGFloat(28 + impact.tier * 7) + CGFloat(1 - power) * 16
            let coreRect = NSRect(
                x: bodyOriginX + bodyWidth * 0.5 - coreRadius / 2,
                y: bodyOriginY + bodyHeight * 0.52 - coreRadius / 2,
                width: coreRadius,
                height: coreRadius
            )
            let core = NSBezierPath(ovalIn: coreRect)
            NSColor(calibratedRed: 1.0, green: 0.90, blue: 0.70, alpha: 0.22 * power).setFill()
            core.fill()

            for index in 0..<(impact.tier + 2) {
                let radius = CGFloat(24 + index * 14) + CGFloat(1 - power) * 10
                let ringRect = NSRect(
                    x: bodyOriginX + bodyWidth * 0.5 - radius / 2,
                    y: bodyOriginY + bodyHeight * 0.52 - radius / 2,
                    width: radius,
                    height: radius * 0.92
                )
                let ring = NSBezierPath(ovalIn: ringRect)
                NSColor(calibratedRed: 1.0, green: 0.86, blue: 0.62, alpha: (0.45 - Double(index) * 0.06) * power).setStroke()
                ring.lineWidth = index == 0 ? 3 : 2
                ring.stroke()
            }

            for index in 0..<5 {
                let angle = CGFloat(index) * (.pi * 0.4) + animationPhase * 0.15
                let distance = CGFloat(34 + index * 6) + CGFloat(1 - power) * 14
                let hx = bodyOriginX + bodyWidth * 0.5 + cos(angle) * distance
                let hy = bodyOriginY + bodyHeight * 0.52 + sin(angle) * distance * 0.7
                let heart = NSBezierPath()
                heart.move(to: NSPoint(x: hx, y: hy + 10))
                heart.curve(to: NSPoint(x: hx - 9, y: hy + 1), controlPoint1: NSPoint(x: hx - 5, y: hy - 1), controlPoint2: NSPoint(x: hx - 9, y: hy + 5))
                heart.curve(to: NSPoint(x: hx, y: hy - 7), controlPoint1: NSPoint(x: hx - 9, y: hy - 4), controlPoint2: NSPoint(x: hx - 5, y: hy - 7))
                heart.curve(to: NSPoint(x: hx + 9, y: hy + 1), controlPoint1: NSPoint(x: hx + 5, y: hy - 7), controlPoint2: NSPoint(x: hx + 9, y: hy - 4))
                heart.curve(to: NSPoint(x: hx, y: hy + 10), controlPoint1: NSPoint(x: hx + 9, y: hy + 5), controlPoint2: NSPoint(x: hx + 5, y: hy))
                NSColor.white.withAlphaComponent(0.58 * power).setFill()
                heart.fill()
            }
        } else if impact.valence == "affinity" {
            for index in 0..<(impact.tier + 1) {
                let radius = CGFloat(16 + index * 10) + CGFloat(1 - power) * 8
                let ringRect = NSRect(
                    x: bodyOriginX + bodyWidth * 0.5 - radius / 2,
                    y: bodyOriginY + bodyHeight * 0.54 - radius / 2,
                    width: radius,
                    height: radius * 0.8
                )
                let ring = NSBezierPath(ovalIn: ringRect)
                accent.withAlphaComponent((impact.tier >= 3 ? 0.48 : 0.35) * power).setStroke()
                ring.lineWidth = impact.tier >= 3 && index == 0 ? 3 : 2
                ring.stroke()
            }

            if impact.tier == 1 {
                let glowRect = NSRect(x: bodyOriginX + bodyWidth * 0.5 - 12, y: bodyOriginY + bodyHeight * 0.54 - 8, width: 24, height: 16)
                let glow = NSBezierPath(ovalIn: glowRect)
                accent.withAlphaComponent(0.18 * power).setFill()
                glow.fill()
            }

            if impact.tier >= 2 {
                let heart = NSBezierPath()
                let hx = bodyOriginX + bodyWidth + 12
                let hy = bodyOriginY + 12 - CGFloat(1 - power) * 10
                heart.move(to: NSPoint(x: hx, y: hy + 12))
                heart.curve(to: NSPoint(x: hx - 10, y: hy + 2), controlPoint1: NSPoint(x: hx - 6, y: hy), controlPoint2: NSPoint(x: hx - 10, y: hy + 6))
                heart.curve(to: NSPoint(x: hx, y: hy - 8), controlPoint1: NSPoint(x: hx - 10, y: hy - 4), controlPoint2: NSPoint(x: hx - 6, y: hy - 8))
                heart.curve(to: NSPoint(x: hx + 10, y: hy + 2), controlPoint1: NSPoint(x: hx + 6, y: hy - 8), controlPoint2: NSPoint(x: hx + 10, y: hy - 4))
                heart.curve(to: NSPoint(x: hx, y: hy + 12), controlPoint1: NSPoint(x: hx + 10, y: hy + 6), controlPoint2: NSPoint(x: hx + 6, y: hy))
                accent.withAlphaComponent(0.50 * power).setFill()
                heart.fill()
            }

            if impact.tier >= 3 {
                for index in 0..<3 {
                    let starX = bodyOriginX - 8 + CGFloat(index) * 16
                    let starY = bodyOriginY + 6 + CGFloat(index % 2) * 10
                    let star = NSBezierPath()
                    star.move(to: NSPoint(x: starX, y: starY + 4))
                    star.line(to: NSPoint(x: starX + 2, y: starY + 10))
                    star.line(to: NSPoint(x: starX + 8, y: starY + 12))
                    star.line(to: NSPoint(x: starX + 2, y: starY + 14))
                    star.line(to: NSPoint(x: starX, y: starY + 20))
                    star.line(to: NSPoint(x: starX - 2, y: starY + 14))
                    star.line(to: NSPoint(x: starX - 8, y: starY + 12))
                    star.line(to: NSPoint(x: starX - 2, y: starY + 10))
                    star.close()
                    accent.withAlphaComponent((0.34 - Double(index) * 0.06) * power).setFill()
                    star.fill()
                }
            }
        } else {
            for index in 0..<(impact.tier + 2) {
                let burst = NSBezierPath()
                let bx = bodyOriginX + bodyWidth * 0.5
                let by = bodyOriginY + bodyHeight * 0.5
                let length = CGFloat(12 + index * 4) * power + tierScale * 3
                burst.move(to: NSPoint(x: bx - length, y: by + CGFloat(index * 3 - 6)))
                burst.line(to: NSPoint(x: bx - length * 0.3, y: by + CGFloat(index * 5 - 4)))
                burst.line(to: NSPoint(x: bx + length, y: by + CGFloat(index * 2 - 8)))
                burst.lineWidth = impact.tier >= 3 ? 3 : 2
                accent.withAlphaComponent((impact.tier >= 3 ? 0.58 : 0.45) * power).setStroke()
                burst.stroke()
            }

            let shock = NSBezierPath()
            let sx = bodyOriginX + bodyWidth * 0.5
            let sy = bodyOriginY - 6
            shock.move(to: NSPoint(x: sx - 18, y: sy + 4))
            shock.line(to: NSPoint(x: sx - 6, y: sy - 4))
            shock.line(to: NSPoint(x: sx + 2, y: sy + 6))
            shock.line(to: NSPoint(x: sx + 16, y: sy - 2))
            shock.lineWidth = 3
            accent.withAlphaComponent(0.55 * power).setStroke()
            shock.stroke()

            if impact.tier >= 2 {
                for index in 0..<impact.tier {
                    let fragment = NSBezierPath()
                    let fx = bodyOriginX + bodyWidth - 4 + CGFloat(index) * 6
                    let fy = bodyOriginY + 4 + CGFloat(index % 2) * 12
                    fragment.move(to: NSPoint(x: fx, y: fy))
                    fragment.line(to: NSPoint(x: fx + 5, y: fy + 3))
                    fragment.line(to: NSPoint(x: fx + 2, y: fy + 9))
                    fragment.close()
                    accent.withAlphaComponent((0.32 - Double(index) * 0.05) * power).setFill()
                    fragment.fill()
                }
            }
        }
    }

    func drawGeneratedTraits(profile: TraitProfile, bodyOriginX: CGFloat, bodyOriginY: CGFloat, bodyWidth: CGFloat, bodyHeight: CGFloat, accent: NSColor, bodyColor: NSColor, stageScale: CGFloat, wag: CGFloat) {
        switch profile.earStyle {
        case "卷耳":
            let curlLeft = NSBezierPath()
            curlLeft.move(to: NSPoint(x: bodyOriginX + 22, y: bodyOriginY + 8))
            curlLeft.curve(to: NSPoint(x: bodyOriginX + 18, y: bodyOriginY - 8), controlPoint1: NSPoint(x: bodyOriginX + 8, y: bodyOriginY + 2), controlPoint2: NSPoint(x: bodyOriginX + 10, y: bodyOriginY - 10))
            curlLeft.lineWidth = 3
            bodyColor.withAlphaComponent(0.9).setStroke()
            curlLeft.stroke()

            let curlRight = NSBezierPath()
            curlRight.move(to: NSPoint(x: bodyOriginX + bodyWidth - 22, y: bodyOriginY + 8))
            curlRight.curve(to: NSPoint(x: bodyOriginX + bodyWidth - 18, y: bodyOriginY - 8), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth - 8, y: bodyOriginY + 2), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth - 10, y: bodyOriginY - 10))
            curlRight.lineWidth = 3
            curlRight.stroke()
        case "尖耳":
            let tipLeft = NSBezierPath()
            tipLeft.move(to: NSPoint(x: bodyOriginX + 18, y: bodyOriginY - 4))
            tipLeft.line(to: NSPoint(x: bodyOriginX + 24, y: bodyOriginY - 20))
            tipLeft.line(to: NSPoint(x: bodyOriginX + 30, y: bodyOriginY - 2))
            tipLeft.close()
            accent.withAlphaComponent(0.8).setFill()
            tipLeft.fill()

            let tipRight = NSBezierPath()
            tipRight.move(to: NSPoint(x: bodyOriginX + bodyWidth - 30, y: bodyOriginY - 2))
            tipRight.line(to: NSPoint(x: bodyOriginX + bodyWidth - 24, y: bodyOriginY - 20))
            tipRight.line(to: NSPoint(x: bodyOriginX + bodyWidth - 18, y: bodyOriginY - 4))
            tipRight.close()
            tipRight.fill()
        case "旗耳":
            let ribbonLeft = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + 10, y: bodyOriginY + 6, width: 7, height: 18), xRadius: 3, yRadius: 3)
            accent.withAlphaComponent(0.85).setFill()
            ribbonLeft.fill()
            let ribbonRight = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth - 17, y: bodyOriginY + 6, width: 7, height: 18), xRadius: 3, yRadius: 3)
            ribbonRight.fill()
        case "叶耳":
            let leafLeft = NSBezierPath()
            leafLeft.move(to: NSPoint(x: bodyOriginX + 20, y: bodyOriginY - 6))
            leafLeft.curve(to: NSPoint(x: bodyOriginX + 8, y: bodyOriginY + 8), controlPoint1: NSPoint(x: bodyOriginX + 6, y: bodyOriginY - 2), controlPoint2: NSPoint(x: bodyOriginX + 4, y: bodyOriginY + 6))
            leafLeft.curve(to: NSPoint(x: bodyOriginX + 20, y: bodyOriginY + 18), controlPoint1: NSPoint(x: bodyOriginX + 10, y: bodyOriginY + 18), controlPoint2: NSPoint(x: bodyOriginX + 16, y: bodyOriginY + 18))
            leafLeft.close()
            NSColor(calibratedRed: 0.62, green: 0.80, blue: 0.42, alpha: 0.9).setFill()
            leafLeft.fill()

            let leafRight = NSBezierPath()
            leafRight.move(to: NSPoint(x: bodyOriginX + bodyWidth - 20, y: bodyOriginY - 6))
            leafRight.curve(to: NSPoint(x: bodyOriginX + bodyWidth - 8, y: bodyOriginY + 8), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth - 6, y: bodyOriginY - 2), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth - 4, y: bodyOriginY + 6))
            leafRight.curve(to: NSPoint(x: bodyOriginX + bodyWidth - 20, y: bodyOriginY + 18), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth - 10, y: bodyOriginY + 18), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth - 16, y: bodyOriginY + 18))
            leafRight.close()
            leafRight.fill()
        default:
            break
        }

        switch profile.tailStyle {
        case "环尾":
            let ring = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth + 14 + wag * 0.2, y: bodyOriginY + bodyHeight * 0.46, width: 12, height: 12))
            accent.withAlphaComponent(0.85).setStroke()
            ring.lineWidth = 3
            ring.stroke()
        case "锤尾":
            let tip = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth + 8 + wag * 0.25, y: bodyOriginY + bodyHeight * 0.44, width: 18, height: 18))
            bodyColor.withAlphaComponent(0.95).setFill()
            tip.fill()
        case "羽尾":
            for index in 0..<3 {
                let feather = NSBezierPath()
                let startX = bodyOriginX + bodyWidth + 6 + wag * 0.2
                let startY = bodyOriginY + bodyHeight * 0.52 + CGFloat(index - 1) * 8
                feather.move(to: NSPoint(x: startX, y: startY))
                feather.curve(to: NSPoint(x: startX + 18, y: startY - 6), controlPoint1: NSPoint(x: startX + 8, y: startY - 1), controlPoint2: NSPoint(x: startX + 12, y: startY - 6))
                feather.lineWidth = 2
                accent.withAlphaComponent(0.75).setStroke()
                feather.stroke()
            }
        case "电尾":
            let bolt = NSBezierPath()
            bolt.move(to: NSPoint(x: bodyOriginX + bodyWidth + 8, y: bodyOriginY + bodyHeight * 0.48))
            bolt.line(to: NSPoint(x: bodyOriginX + bodyWidth + 18, y: bodyOriginY + bodyHeight * 0.44))
            bolt.line(to: NSPoint(x: bodyOriginX + bodyWidth + 12, y: bodyOriginY + bodyHeight * 0.56))
            bolt.line(to: NSPoint(x: bodyOriginX + bodyWidth + 24, y: bodyOriginY + bodyHeight * 0.52))
            bolt.lineWidth = 3
            accent.setStroke()
            bolt.stroke()
        default:
            break
        }

        switch profile.markStyle {
        case "星斑":
            for index in 0..<3 {
                let spot = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.28 + CGFloat(index) * 16, y: bodyOriginY + bodyHeight * 0.16 + CGFloat(index % 2) * 8, width: 6, height: 6))
                NSColor.white.withAlphaComponent(0.58).setFill()
                spot.fill()
            }
        case "额纹":
            let stripe = NSBezierPath()
            stripe.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY + 6))
            stripe.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY + 24))
            stripe.lineWidth = 4
            accent.withAlphaComponent(0.45).setStroke()
            stripe.stroke()
        case "面罩":
            let mask = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.24, y: bodyOriginY + bodyHeight * 0.25, width: bodyWidth * 0.52, height: 24), xRadius: 12, yRadius: 12)
            accent.withAlphaComponent(0.18).setFill()
            mask.fill()
        case "肩纹":
            let shoulder = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.18, y: bodyOriginY + bodyHeight * 0.68, width: 18, height: 10), xRadius: 5, yRadius: 5)
            accent.withAlphaComponent(0.42).setFill()
            shoulder.fill()
            let shoulderRight = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.64, y: bodyOriginY + bodyHeight * 0.68, width: 18, height: 10), xRadius: 5, yRadius: 5)
            shoulderRight.fill()
        default:
            break
        }

        switch profile.auraStyle {
        case "星砂":
            for index in 0..<4 {
                let spark = NSBezierPath(ovalIn: NSRect(x: bodyOriginX - 16 + CGFloat(index) * 34, y: bodyOriginY + bodyHeight * 0.10 + CGFloat(index % 2) * 18, width: 4, height: 4))
                accent.withAlphaComponent(0.55).setFill()
                spark.fill()
            }
        case "叶火":
            for index in 0..<3 {
                let leaf = NSBezierPath()
                let x = bodyOriginX - 8 + CGFloat(index) * 38
                let y = bodyOriginY + bodyHeight * 0.82 - CGFloat(index % 2) * 8
                leaf.move(to: NSPoint(x: x, y: y))
                leaf.curve(to: NSPoint(x: x - 6, y: y + 10), controlPoint1: NSPoint(x: x - 6, y: y + 2), controlPoint2: NSPoint(x: x - 8, y: y + 8))
                leaf.curve(to: NSPoint(x: x + 8, y: y + 8), controlPoint1: NSPoint(x: x - 1, y: y + 12), controlPoint2: NSPoint(x: x + 5, y: y + 10))
                leaf.close()
                NSColor(calibratedRed: 0.68, green: 0.84, blue: 0.40, alpha: 0.55).setFill()
                leaf.fill()
            }
        case "轨迹":
            let orbit = NSBezierPath(ovalIn: NSRect(x: bodyOriginX - 8, y: bodyOriginY + 14, width: bodyWidth + 16, height: bodyHeight - 18))
            accent.withAlphaComponent(0.16).setStroke()
            orbit.lineWidth = 1.5
            orbit.stroke()
        case "碎光":
            for index in 0..<3 {
                let shard = NSBezierPath()
                let x = bodyOriginX - 10 + CGFloat(index) * 44
                let y = bodyOriginY + bodyHeight * 0.24 + CGFloat(index) * 10
                shard.move(to: NSPoint(x: x, y: y))
                shard.line(to: NSPoint(x: x + 4, y: y - 6))
                shard.line(to: NSPoint(x: x + 10, y: y))
                shard.close()
                accent.withAlphaComponent(0.45).setFill()
                shard.fill()
            }
        default:
            break
        }
    }

    func drawFormOverlay(form: String, bodyOriginX: CGFloat, bodyOriginY: CGFloat, bodyWidth: CGFloat, bodyHeight: CGFloat, accent: NSColor, stageScale: CGFloat) {
        switch form {
        case "builder":
            let helmet = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.28, y: bodyOriginY - 6, width: bodyWidth * 0.44, height: 16), xRadius: 8, yRadius: 8)
            NSColor(calibratedRed: 0.98, green: 0.74, blue: 0.27, alpha: 1.0).setFill()
            helmet.fill()
            let stripe = NSBezierPath(rect: NSRect(x: bodyOriginX + bodyWidth * 0.46, y: bodyOriginY - 10, width: 8, height: 22))
            NSColor.white.withAlphaComponent(0.9).setFill()
            stripe.fill()
            let toolbox = NSBezierPath(roundedRect: NSRect(x: bodyOriginX - 18, y: bodyOriginY + bodyHeight * 0.64, width: 22, height: 16), xRadius: 5, yRadius: 5)
            NSColor(calibratedRed: 0.71, green: 0.43, blue: 0.18, alpha: 0.95).setFill()
            toolbox.fill()
            let handle = NSBezierPath(roundedRect: NSRect(x: bodyOriginX - 10, y: bodyOriginY + bodyHeight * 0.60, width: 8, height: 5), xRadius: 2.5, yRadius: 2.5)
            NSColor.white.withAlphaComponent(0.9).setFill()
            handle.fill()
        case "scholar":
            NSColor(calibratedRed: 0.22, green: 0.20, blue: 0.18, alpha: 1.0).setStroke()
            let leftGlass = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.29, y: bodyOriginY + bodyHeight * 0.29, width: 18, height: 18))
            let rightGlass = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.53, y: bodyOriginY + bodyHeight * 0.29, width: 18, height: 18))
            leftGlass.lineWidth = 2
            rightGlass.lineWidth = 2
            leftGlass.stroke()
            rightGlass.stroke()
            let bridge = NSBezierPath()
            bridge.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.45, y: bodyOriginY + bodyHeight * 0.37))
            bridge.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.53, y: bodyOriginY + bodyHeight * 0.37))
            bridge.lineWidth = 2
            bridge.stroke()
            let page = NSBezierPath(roundedRect: NSRect(x: bodyOriginX - 14, y: bodyOriginY + bodyHeight * 0.62, width: 18, height: 22), xRadius: 4, yRadius: 4)
            NSColor.white.withAlphaComponent(0.88).setFill()
            page.fill()
            NSColor(calibratedRed: 0.67, green: 0.55, blue: 0.34, alpha: 0.9).setStroke()
            page.lineWidth = 1
            page.stroke()
            for index in 0..<3 {
                let noteLine = NSBezierPath()
                let y = bodyOriginY + bodyHeight * 0.68 + CGFloat(index) * 4
                noteLine.move(to: NSPoint(x: bodyOriginX - 10, y: y))
                noteLine.line(to: NSPoint(x: bodyOriginX + 0, y: y))
                noteLine.lineWidth = 1
                noteLine.stroke()
            }
        case "captain":
            let band = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + bodyWidth * 0.22, y: bodyOriginY + 2, width: bodyWidth * 0.56, height: 12), xRadius: 6, yRadius: 6)
            NSColor(calibratedRed: 0.93, green: 0.33, blue: 0.28, alpha: 1.0).setFill()
            band.fill()
            let cape = NSBezierPath()
            cape.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.38, y: bodyOriginY + bodyHeight - 6))
            cape.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.22, y: bodyOriginY + bodyHeight + 18))
            cape.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.56, y: bodyOriginY + bodyHeight + 6))
            cape.close()
            NSColor(calibratedRed: 0.96, green: 0.47, blue: 0.36, alpha: 0.95).setFill()
            cape.fill()
            let badge = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth - 12, y: bodyOriginY + bodyHeight * 0.70, width: 16, height: 16))
            NSColor(calibratedRed: 1.0, green: 0.83, blue: 0.33, alpha: 1.0).setFill()
            badge.fill()
            let badgeStar = NSAttributedString(
                string: "★",
                attributes: [
                    .font: NSFont.systemFont(ofSize: 9, weight: .bold),
                    .foregroundColor: NSColor(calibratedRed: 0.65, green: 0.22, blue: 0.18, alpha: 1.0)
                ]
            )
            badgeStar.draw(at: NSPoint(x: bodyOriginX + bodyWidth - 9, y: bodyOriginY + bodyHeight * 0.70 + 1))
        case "social":
            accent.withAlphaComponent(0.55).setFill()
            NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.23, y: bodyOriginY + bodyHeight * 0.45, width: 12, height: 10)).fill()
            NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.67, y: bodyOriginY + bodyHeight * 0.45, width: 12, height: 10)).fill()
            let heart = NSBezierPath()
            heart.move(to: NSPoint(x: bodyOriginX + bodyWidth + 18, y: bodyOriginY + 24))
            heart.curve(to: NSPoint(x: bodyOriginX + bodyWidth + 8, y: bodyOriginY + 14), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth + 12, y: bodyOriginY + 12), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth + 8, y: bodyOriginY + 18))
            heart.curve(to: NSPoint(x: bodyOriginX + bodyWidth + 18, y: bodyOriginY + 4), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth + 8, y: bodyOriginY + 8), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth + 12, y: bodyOriginY + 4))
            heart.curve(to: NSPoint(x: bodyOriginX + bodyWidth + 28, y: bodyOriginY + 14), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth + 24, y: bodyOriginY + 4), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth + 28, y: bodyOriginY + 8))
            heart.curve(to: NSPoint(x: bodyOriginX + bodyWidth + 18, y: bodyOriginY + 24), controlPoint1: NSPoint(x: bodyOriginX + bodyWidth + 28, y: bodyOriginY + 18), controlPoint2: NSPoint(x: bodyOriginX + bodyWidth + 24, y: bodyOriginY + 12))
            accent.setFill()
            heart.fill()
            for index in 0..<3 {
                let orbit = NSBezierPath(ovalIn: NSRect(x: bodyOriginX + bodyWidth * 0.20 + CGFloat(index) * 18, y: bodyOriginY - 18 + CGFloat(index % 2) * 8, width: 10, height: 10))
                accent.withAlphaComponent(0.35 + Double(index) * 0.12).setFill()
                orbit.fill()
            }
        case "chaos":
            accent.withAlphaComponent(0.18).setFill()
            let ghostBody = NSBezierPath(roundedRect: NSRect(x: bodyOriginX + 8, y: bodyOriginY + 6, width: bodyWidth, height: bodyHeight), xRadius: 48 * stageScale, yRadius: 48 * stageScale)
            ghostBody.fill()
            let glitch = NSBezierPath()
            glitch.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.18, y: bodyOriginY + 8))
            glitch.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.30, y: bodyOriginY - 4))
            glitch.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.42, y: bodyOriginY + 10))
            glitch.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.56, y: bodyOriginY - 6))
            glitch.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.70, y: bodyOriginY + 8))
            glitch.lineWidth = 4
            accent.setStroke()
            glitch.stroke()
            for index in 0..<3 {
                let shard = NSBezierPath()
                let x = bodyOriginX + bodyWidth * (0.18 + CGFloat(index) * 0.22)
                let y = bodyOriginY + bodyHeight * (0.18 + CGFloat(index % 2) * 0.18)
                shard.move(to: NSPoint(x: x, y: y))
                shard.line(to: NSPoint(x: x + 6, y: y - 8))
                shard.line(to: NSPoint(x: x + 12, y: y))
                shard.close()
                accent.withAlphaComponent(0.55).setFill()
                shard.fill()
            }
        default:
            break
        }

        if state.stage == "mythic" {
            let crown = NSBezierPath()
            crown.move(to: NSPoint(x: bodyOriginX + bodyWidth * 0.33, y: bodyOriginY - 12))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.40, y: bodyOriginY - 2))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.50, y: bodyOriginY - 14))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.60, y: bodyOriginY - 2))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.67, y: bodyOriginY - 12))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.67, y: bodyOriginY))
            crown.line(to: NSPoint(x: bodyOriginX + bodyWidth * 0.33, y: bodyOriginY))
            crown.close()
            NSColor(calibratedRed: 1.0, green: 0.83, blue: 0.33, alpha: 0.96).setFill()
            crown.fill()
        }
    }

    override func mouseDown(with event: NSEvent) {
        if event.clickCount == 2 {
            onDoubleClick?()
        } else if event.clickCount == 1 {
            onPetTap?()
        } else {
            super.mouseDown(with: event)
        }
    }
}

final class BubbleView: NSView {
    var accentColor: NSColor = NSColor(calibratedRed: 0.18, green: 0.75, blue: 0.44, alpha: 1.0) {
        didSet { needsDisplay = true }
    }
    var borderColor: NSColor = NSColor(calibratedRed: 0.93, green: 0.88, blue: 0.80, alpha: 0.92) {
        didSet { needsDisplay = true }
    }
    var fillColor: NSColor = NSColor.white.withAlphaComponent(0.94) {
        didSet { needsDisplay = true }
    }
    var accentWidth: CGFloat = 34 {
        didSet { needsDisplay = true }
    }
    var tailShift: CGFloat = 0 {
        didSet { needsDisplay = true }
    }

    override var isFlipped: Bool { true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.clear.setFill()
        dirtyRect.fill()

        let bubbleRect = NSRect(x: 8, y: 6, width: bounds.width - 16, height: bounds.height - 20)
        let bubble = NSBezierPath(roundedRect: bubbleRect, xRadius: 18, yRadius: 18)
        fillColor.setFill()
        bubble.fill()

        borderColor.setStroke()
        bubble.lineWidth = 1.5
        bubble.stroke()

        let tail = NSBezierPath()
        let midX = bounds.midX - 6 + tailShift
        tail.move(to: NSPoint(x: midX, y: bounds.height - 18))
        tail.line(to: NSPoint(x: midX + 12, y: bounds.height - 18))
        tail.line(to: NSPoint(x: midX + 3, y: bounds.height - 4))
        tail.close()
        fillColor.setFill()
        tail.fill()
        borderColor.setStroke()
        tail.stroke()

        let accentBar = NSBezierPath(roundedRect: NSRect(x: 20, y: 14, width: accentWidth, height: 6), xRadius: 3, yRadius: 3)
        accentColor.setFill()
        accentBar.fill()
    }
}

final class PantryChipsView: NSView {
    var items: [(String, Int)] = [] {
        didSet { needsDisplay = true }
    }

    override var isFlipped: Bool { true }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.clear.setFill()
        dirtyRect.fill()

        var x: CGFloat = 0
        var y: CGFloat = 0
        let chipHeight: CGFloat = 22
        let lineLimit = max(bounds.width - 4, 40)

        for (name, count) in items.prefix(4) {
            let text = "\(name)×\(count)"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.systemFont(ofSize: 10, weight: .medium),
                .foregroundColor: NSColor(calibratedRed: 0.34, green: 0.28, blue: 0.22, alpha: 1.0)
            ]
            let textSize = (text as NSString).size(withAttributes: attributes)
            let chipWidth = textSize.width + 20

            if x + chipWidth > lineLimit {
                x = 0
                y += chipHeight + 6
            }

            let chipRect = NSRect(x: x, y: y, width: chipWidth, height: chipHeight)
            let chipPath = NSBezierPath(roundedRect: chipRect, xRadius: 11, yRadius: 11)
            NSColor.white.withAlphaComponent(0.84).setFill()
            chipPath.fill()
            NSColor(calibratedRed: 0.93, green: 0.88, blue: 0.80, alpha: 0.92).setStroke()
            chipPath.lineWidth = 1
            chipPath.stroke()

            (text as NSString).draw(
                at: NSPoint(x: chipRect.minX + 10, y: chipRect.minY + 5),
                withAttributes: attributes
            )

            x += chipWidth + 6
        }
    }
}

final class CapsuleButton: NSButton {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isBordered = false
        bezelStyle = .regularSquare
        font = NSFont.boldSystemFont(ofSize: 10)
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.backgroundColor = NSColor.white.withAlphaComponent(0.86).cgColor
        layer?.borderWidth = 1
        layer?.borderColor = NSColor(calibratedRed: 0.93, green: 0.88, blue: 0.80, alpha: 0.92).cgColor
        contentTintColor = NSColor(calibratedRed: 0.35, green: 0.29, blue: 0.22, alpha: 1.0)
    }
}

final class PetWindowPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

final class PetContainerView: NSView {
    let bubbleView = BubbleView(frame: .zero)
    let bubbleLabel = NSTextField(labelWithString: "")
    let metaLabel = NSTextField(labelWithString: "")
    let sceneView = PetSceneView(frame: .zero)
    let metricsLabel = NSTextField(labelWithString: "")
    let requestLabel = NSTextField(labelWithString: "")
    let rewardLabel = NSTextField(labelWithString: "")
    let conversionLabel = NSTextField(labelWithString: "")
    let pantryTitleLabel = NSTextField(labelWithString: "粮仓")
    let pantryView = PantryChipsView(frame: .zero)
    let logLabel = NSTextField(labelWithString: "")
    let hintLabel = NSTextField(labelWithString: "点它拍一下，力度由它吃出来的互动能源决定")
    let interactButton = CapsuleButton(frame: .zero)
    var interactHandler: (() -> Void)?
    var decayHandler: (() -> Void)?
    var showInfoHandler: (() -> Void)?
    var toggleAutoEatHandler: (() -> Void)?

    override var isFlipped: Bool { true }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor

        addSubview(bubbleView)
        addSubview(sceneView)
        addSubview(pantryView)

        [bubbleLabel, metaLabel, metricsLabel, requestLabel, rewardLabel, conversionLabel, pantryTitleLabel, logLabel, hintLabel].forEach {
            $0.isBezeled = false
            $0.drawsBackground = false
            $0.isEditable = false
            $0.isSelectable = false
            $0.wantsLayer = true
            addSubview($0)
        }
        setupLabels()
        setupButtons()

        sceneView.onPetTap = { [weak self] in self?.interactHandler?() }
        sceneView.onDoubleClick = { [weak self] in self?.interactHandler?() }
        let contextMenu = buildContextMenu()
        menu = contextMenu
        sceneView.menu = contextMenu
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabels() {
        bubbleLabel.font = NSFont.systemFont(ofSize: 11, weight: .semibold)
        bubbleLabel.textColor = NSColor(calibratedRed: 0.21, green: 0.17, blue: 0.12, alpha: 1.0)
        bubbleLabel.alignment = .center
        bubbleLabel.maximumNumberOfLines = 2
        bubbleLabel.lineBreakMode = .byWordWrapping

        metaLabel.font = NSFont.boldSystemFont(ofSize: 11)
        metaLabel.textColor = NSColor(calibratedRed: 0.70, green: 0.29, blue: 0.18, alpha: 1.0)
        metaLabel.alignment = .center

        metricsLabel.isHidden = true

        requestLabel.font = NSFont.systemFont(ofSize: 10, weight: .semibold)
        requestLabel.textColor = NSColor(calibratedRed: 0.60, green: 0.29, blue: 0.18, alpha: 1.0)
        requestLabel.alignment = .center
        requestLabel.maximumNumberOfLines = 1

        rewardLabel.isHidden = true

        conversionLabel.isHidden = true

        pantryTitleLabel.font = NSFont.systemFont(ofSize: 10, weight: .semibold)
        pantryTitleLabel.textColor = NSColor(calibratedRed: 0.54, green: 0.42, blue: 0.29, alpha: 0.82)
        pantryTitleLabel.alignment = .center
        pantryView.isHidden = true

        logLabel.isHidden = true

        hintLabel.isHidden = true

        [bubbleLabel, metaLabel, metricsLabel, requestLabel, rewardLabel, conversionLabel, pantryTitleLabel, logLabel, hintLabel].forEach {
            $0.layer?.shadowColor = NSColor.white.withAlphaComponent(0.3).cgColor
            $0.layer?.shadowOpacity = 1
            $0.layer?.shadowRadius = 1.2
            $0.layer?.shadowOffset = CGSize(width: 0, height: -0.5)
        }
    }

    func setupButtons() {
        interactButton.title = "拍"
        interactButton.target = self
        interactButton.action = #selector(interactPet)
        interactButton.frame = NSRect(x: 112, y: 346, width: 54, height: 24)
        addSubview(interactButton)
    }

    func buildContextMenu() -> NSMenu {
        let contextMenu = NSMenu()

        let interact = NSMenuItem(title: "拍一下它", action: #selector(interactPet), keyEquivalent: "")
        interact.target = self
        contextMenu.addItem(interact)

        let decay = NSMenuItem(title: "时间流逝 3 小时", action: #selector(decayPet), keyEquivalent: "")
        decay.target = self
        contextMenu.addItem(decay)

        let info = NSMenuItem(title: "打开图鉴/状态", action: #selector(showInfo), keyEquivalent: "")
        info.target = self
        contextMenu.addItem(info)

        let autoEat = NSMenuItem(title: "切换自动吃粮", action: #selector(toggleAutoEat), keyEquivalent: "")
        autoEat.target = self
        contextMenu.addItem(autoEat)

        contextMenu.addItem(.separator())
        let quit = NSMenuItem(title: "退出桌宠", action: #selector(quitPet), keyEquivalent: "")
        quit.target = self
        contextMenu.addItem(quit)
        return contextMenu
    }

    override func layout() {
        super.layout()
        bubbleView.frame = NSRect(x: 20, y: 10, width: bounds.width - 40, height: 102)
        bubbleLabel.frame = NSRect(x: 36, y: 30, width: bounds.width - 72, height: 28)
        metaLabel.frame = NSRect(x: 28, y: 68, width: bounds.width - 56, height: 18)
        requestLabel.frame = NSRect(x: 28, y: 86, width: bounds.width - 56, height: 16)
        sceneView.frame = NSRect(x: 18, y: 118, width: bounds.width - 36, height: 192)
        pantryTitleLabel.frame = NSRect(x: 24, y: 320, width: bounds.width - 48, height: 14)
        pantryView.frame = .zero
        metricsLabel.frame = .zero
        rewardLabel.frame = .zero
        conversionLabel.frame = .zero
        logLabel.frame = .zero
        hintLabel.frame = .zero
    }

    @objc func interactPet() { interactHandler?() }
    @objc func decayPet() { decayHandler?() }
    @objc func showInfo() { showInfoHandler?() }
    @objc func toggleAutoEat() { toggleAutoEatHandler?() }
    @objc func quitPet() { NSApp.terminate(nil) }
}

final class PetInfoViewController: NSViewController {
    let titleLabel = NSTextField(labelWithString: "阿在图鉴")
    let detailView = NSTextView(frame: .zero)

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 344, height: 388))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(calibratedRed: 0.99, green: 0.97, blue: 0.93, alpha: 1.0).cgColor

        titleLabel.font = NSFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = NSColor(calibratedRed: 0.43, green: 0.25, blue: 0.15, alpha: 1.0)
        titleLabel.frame = NSRect(x: 20, y: 18, width: 200, height: 24)
        view.addSubview(titleLabel)

        let scrollView = NSScrollView(frame: NSRect(x: 18, y: 52, width: 308, height: 314))
        scrollView.borderType = .noBorder
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.autohidesScrollers = true

        detailView.isEditable = false
        detailView.isSelectable = true
        detailView.drawsBackground = true
        detailView.backgroundColor = NSColor.white.withAlphaComponent(0.9)
        detailView.textColor = NSColor(calibratedRed: 0.24, green: 0.20, blue: 0.16, alpha: 1.0)
        detailView.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        detailView.textContainerInset = NSSize(width: 10, height: 12)
        scrollView.documentView = detailView
        view.addSubview(scrollView)
    }

    func update(state: PetState, config: PetConfig) {
        titleLabel.stringValue = "\(petDisplayName(state)) 图鉴"
        let traits = generatedTraitProfile(state)
        let habits = generatedHabitProfile(state)
        let unlocked = unlockedFormsValue(state)
        let metabolism = metabolismPhase(state)
        let growthTendency = dominantGrowthTendency(state)
        let inventory = normalizedInventory(state)
            .sorted { left, right in
                if left.value == right.value { return left.key < right.key }
                return left.value > right.value
            }
            .prefix(5)
            .map { "\($0.key)×\($0.value)" }
            .joined(separator: "、")
        let ledgerLines = normalizedTokenLedger(state)
            .prefix(8)
            .map { entry in
                let source = entry.source.uppercased()
                let task = taskTitle(for: entry.taskType)
                let status = entry.autoAte ? "已先吃" : "入仓"
                return "\(compactLedgerTime(entry.timestamp)) | \(source) | \(task) | \(Int(entry.realTokens))T -> \(entry.food)×\(entry.servings) | \(Int(entry.petTokens))粮 | \(compactQualityLabel(entry.quality)) | \(status)"
            }
            .joined(separator: "\n")

        let lines = [
            "【它是谁】",
            "名字：\(petDisplayName(state))",
            "灵魂：\(petSoulSignature(state))",
            "说话口吻：\(petSpeakingStyle(state))",
            "外观倾向：\(petAppearanceHint(state))",
            "对你的第一印象：\(petFirstImpression(state))",
            "初见状态：\(birthBondCompleted(state) ? "已认主" : "待你完成第一次轻拍")",
            "诞生描述：\(state.birthNarrative ?? "它还在慢慢形成自己的出生叙事。")",
            "",
            "【成长与关系】",
            "阶段：\(stageLabel(for: state.stage))",
            "称号：\(temperamentTitle(state))",
            "主形态：\(formLabels[state.form] ?? state.form)",
            "形象基调：\(identityVisualLabel(state))",
            "生成特征：\(traits.earStyle)、\(traits.tailStyle)、\(traits.markStyle)、\(traits.auraStyle)",
            "小习惯：\(habits.shortLabel)",
            "长势状态：\(metabolism.title)｜\(metabolism.note)",
            "成长偏向：\(growthTendency.title)｜\(growthTendency.note)",
            "互动能源：亲和 \(Int(currentAffinityEnergy(state))) / 躁动 \(Int(currentAgitationEnergy(state))) / 当前 \(interactionStrengthLabel(state))",
            "拍养关系：\(interactionDispositionShort(state))",
            "拍养备注：\(interactionGrowthNote(state))",
            "拍击历史：轻拍 \(gentleImpactCount(state)) / 中拍 \(mediumImpactCount(state)) / 重拍 \(heavyImpactCount(state))",
            "最常活动：\(currentActivityText(state))",
            "当前请求：\(state.currentRequest ?? "无")",
            "沟通风格摘要：\(styleVectorSummary(state))",
            "",
            "【粮仓与 Token】",
            "粮仓概览：\(inventory.isEmpty ? "暂无存粮" : inventory)",
            "当前仓压：\(inventoryServingCount(state)) 份",
            "最新转粮：\(state.lastConversionSummary ?? "最近还没有新的转粮")",
            "Token 来源：Codex 已接入，外部标准事件已可接入",
            "自动吃粮：\(config.autoEatEnabled ? "开启" : "关闭")",
            "Codex 来源：\(config.codexSourceEnabled ? "开启" : "关闭")",
            "外部标准来源：\(config.externalSourceEnabled ? "开启" : "关闭")",
            "",
            "最近 Token 账表：",
            ledgerLines.isEmpty ? "暂无记录" : ledgerLines,
            "",
            "【收集】",
            "星屑：\(rewardStarCount(state))",
            "已解锁图鉴：\(unlocked.joined(separator: "、"))"
        ]

        detailView.string = lines.joined(separator: "\n")
    }
}

final class PetAppController: NSObject, NSApplicationDelegate {
    let store: PetStore
    var state: PetState
    var config: PetConfig
    let window: PetWindowPanel
    let contentView: PetContainerView
    let infoController = PetInfoViewController()
    var visibilityRepairDelays: [TimeInterval] = [0.35, 1.1]
    var lastSoftRevealAt: TimeInterval = 0
    lazy var infoWindow: PetWindowPanel = {
        let panel = PetWindowPanel(
            contentRect: NSRect(x: 240, y: 180, width: 344, height: 388),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        panel.title = "阿在图鉴"
        panel.isFloatingPanel = true
        panel.level = .floating
        panel.contentViewController = infoController
        return panel
    }()
    var stateTimer: Timer?
    var animationTimer: Timer?
    var feedTimer: Timer?

    init(store: PetStore) {
        self.store = store
        self.state = store.loadState()
        self.config = store.loadConfig()
        self.contentView = PetContainerView(frame: NSRect(x: 0, y: 0, width: 278, height: 386))
        self.window = PetWindowPanel(
            contentRect: NSRect(x: state.windowX, y: state.windowY, width: 278, height: 386),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        super.init()
        setupWindow()
        wireActions()
        let birthMessage = bootstrapIdentityIfNeeded()
        backfillTokenLedgerIfNeeded()
        refresh(message: birthMessage ?? defaultBubble(for: state))
    }

    func bootstrapIdentityIfNeeded() -> String? {
        let needsIdentity = state.petName == nil || state.birthNarrative == nil || state.soulSignature == nil
        let needsUpgrade = (state.identityVersion ?? 0) < identityGeneratorVersion
        guard needsIdentity || needsUpgrade else {
            return nil
        }

        let mergedFeed = store.loadMergedFeed(config: config)
        let recentEvents = Array((mergedFeed?.events ?? []).suffix(20))
        let blueprint = petIdentityBlueprint(events: recentEvents, state: state)
        state.petName = blueprint.petName
        state.soulSignature = blueprint.soulSignature
        state.speakingStyle = blueprint.speakingStyle
        state.appearanceHint = blueprint.appearanceHint
        state.firstImpression = blueprint.firstImpression
        state.birthNarrative = blueprint.birthNarrative
        state.styleVector = blueprint.styleVector
        state.identitySeed = blueprint.seed
        let now = Date().timeIntervalSince1970
        state.identityGeneratedAt = now
        state.identityVersion = identityGeneratorVersion
        if needsIdentity {
            state.firstBondAt = nil
            state.affinityEnergy = max(currentAffinityEnergy(state), 18)
            state.currentRequest = "想先记住你的手感"
            state.currentRequestAt = now
            state.currentRequestIgnoreLevel = 0
            state.currentActivity = "刚从你的工作流里睁开眼"
            state.lastCareSummary = "它刚刚出生，正在试着认你"
            _ = setActiveFeedback(&state, key: "birth_intro", source: "bootstrap", priority: 40, duration: 3.5, now: now, resolvedOutcome: "none", force: true)
            appendFoodLog(&state, entry: "诞生完成：\(blueprint.petName) 被唤醒了")
            return blueprint.birthNarrative
        }

        if state.firstBondAt == nil {
            state.firstBondAt = now
        }
        state.lastCareSummary = "\(blueprint.petName) 把自己的名字和气质重新整理清楚了，但它还是认得你"
        appendFoodLog(&state, entry: "身份更新：\(blueprint.petName) 的轮廓更清晰了")
        return "\(blueprint.petName) 把自己的名字和脾气重新理顺了一遍，但它没有把你忘掉。"
    }

    func backfillTokenLedgerIfNeeded() {
        guard normalizedTokenLedger(state).isEmpty,
              let mergedFeed = store.loadMergedFeed(config: config) else {
            return
        }

        let recentEntries = mergedFeed.events
            .suffix(8)
            .reversed()
            .map { event in
                TokenLedgerEntry(
                    timestamp: event.timestamp,
                    source: event.source,
                    taskType: event.task_type,
                    quality: event.quality,
                    realTokens: event.real_tokens,
                    food: foodVariantName(taskType: event.task_type, quality: event.quality),
                    servings: servingsCount(from: event.real_tokens),
                    petTokens: normalizedPetTokens(from: event.real_tokens),
                    autoAte: false
                )
            }

        state.tokenLedger = Array(recentEntries)
    }

    func setupWindow() {
        window.isOpaque = false
        window.backgroundColor = .clear
        window.isFloatingPanel = true
        window.level = .floating
        window.hasShadow = false
        window.hidesOnDeactivate = false
        window.isReleasedWhenClosed = false
        window.isMovableByWindowBackground = true
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary]
        window.contentView = contentView
        window.ignoresMouseEvents = false
        window.alphaValue = 1
    }

    func wireActions() {
        contentView.interactHandler = { [weak self] in self?.performInteraction() }
        contentView.decayHandler = { [weak self] in self?.applyDecay() }
        contentView.showInfoHandler = { [weak self] in self?.showInfoPanel() }
        contentView.toggleAutoEatHandler = { [weak self] in self?.toggleAutoEat() }
    }

    func applicationWillFinishLaunching(_ notification: Notification) {
        store.claimSingleInstance()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        store.claimSingleInstance()
        store.ensureBridgeRunning()
        NSApp.setActivationPolicy(.accessory)
        installVisibilityObservers()
        snapWindowToVisibleFrame()
        forceRevealWindow()
        scheduleVisibilityRepairs()

        stateTimer = Timer.scheduledTimer(withTimeInterval: 45, repeats: true) { [weak self] _ in
            self?.backgroundTick()
        }

        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.contentView.sceneView.animationPhase += 0.22
        }

        feedTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] _ in
            self?.consumeFeedEvents()
        }
        consumeFeedEvents()
    }

    func applicationWillTerminate(_ notification: Notification) {
        uninstallVisibilityObservers()
        persistWindowPosition()
        store.saveState(state)
        store.saveConfig(config)
        store.releaseSingleInstance()
    }

    func persistWindowPosition() {
        let origin = window.frame.origin
        state.windowX = origin.x
        state.windowY = origin.y
    }

    func snapWindowToVisibleFrame() {
        let currentFrame = window.frame
        let currentScreens = NSScreen.screens
        let frameIsOnScreen = currentScreens.contains { screen in
            screen.visibleFrame.intersects(currentFrame) || screen.frame.contains(currentFrame.origin)
        }

        guard let screen = currentScreens.first(where: { $0.visibleFrame.intersects(currentFrame) || $0.frame.contains(currentFrame.origin) })
            ?? preferredPresentationScreen()
            ?? currentScreens.first else {
            return
        }

        let visible = screen.visibleFrame
        var frame = currentFrame

        if !frameIsOnScreen {
            frame.origin.x = visible.maxX - frame.width - 18
            frame.origin.y = visible.minY + 36
        }

        frame.origin.x = min(max(frame.origin.x, visible.minX), visible.maxX - frame.width)
        frame.origin.y = min(max(frame.origin.y, visible.minY), visible.maxY - frame.height)

        let leftDistance = abs(frame.minX - visible.minX)
        let rightDistance = abs(visible.maxX - frame.maxX)
        if min(leftDistance, rightDistance) < 64 {
            frame.origin.x = leftDistance < rightDistance ? visible.minX + 6 : visible.maxX - frame.width - 6
        }

        if visible.maxY - frame.maxY < 48 {
            frame.origin.y = visible.maxY - frame.height - 12
        }

        if frame.minY - visible.minY < 36 {
            frame.origin.y = visible.minY + 24
        }

        window.setFrame(frame, display: true)
        persistWindowPosition()
    }

    func preferredPresentationScreen() -> NSScreen? {
        let mouseLocation = NSEvent.mouseLocation
        return NSScreen.screens.first(where: { $0.frame.contains(mouseLocation) })
            ?? NSScreen.main
            ?? NSScreen.screens.first
    }

    func installVisibilityObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleVisibilityRelevantEvent),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(handleVisibilityRelevantEvent),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil
        )
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(handleVisibilityRelevantEvent),
            name: NSWorkspace.didWakeNotification,
            object: nil
        )
    }

    func uninstallVisibilityObservers() {
        NotificationCenter.default.removeObserver(self)
        NSWorkspace.shared.notificationCenter.removeObserver(self)
    }

    @objc func handleVisibilityRelevantEvent(_ notification: Notification) {
        snapWindowToVisibleFrame()
        softRevealWindow()
    }

    func scheduleVisibilityRepairs() {
        for delay in visibilityRepairDelays {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let self else { return }
                self.snapWindowToVisibleFrame()
                self.softRevealWindow()
            }
        }
    }

    func forceRevealWindow() {
        let shouldRestoreAccessory = NSApp.activationPolicy() != .regular
        if shouldRestoreAccessory {
            NSApp.setActivationPolicy(.regular)
        }

        window.alphaValue = 1
        window.level = .floating
        window.order(.above, relativeTo: 0)
        window.orderFrontRegardless()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        if shouldRestoreAccessory {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                NSApp.setActivationPolicy(.accessory)
            }
        }
    }

    func softRevealWindow() {
        let now = Date().timeIntervalSince1970
        if now - lastSoftRevealAt < 0.6 {
            return
        }
        lastSoftRevealAt = now

        window.alphaValue = 1
        window.level = .floating
        if !window.isVisible {
            window.orderFrontRegardless()
        } else {
            window.orderFront(nil)
        }
    }

    func showInfoPanel() {
        infoController.update(state: state, config: config)
        infoWindow.orderFrontRegardless()
        NSApp.activate(ignoringOtherApps: true)
    }

    func toggleAutoEat() {
        config.autoEatEnabled.toggle()
        store.saveConfig(config)
        refresh(message: config.autoEatEnabled ? "它会继续根据状态自动吃粮。" : "自动吃粮已关闭，现在主要等你手动喂它。")
    }

    func backgroundTick() {
        store.ensureBridgeRunning()
        clearExpiredFeedback(&state)
        state = PetEngine.decay(state, hours: 1)
        if let routineMessage = performAutonomousRoutine() {
            refresh(message: routineMessage)
            return
        }
        let growthPhase = growthBalanceProfile(state)
        let inventoryLoad = inventoryServingCount(state)
        let shouldAutoMetabolize =
            config.autoEatEnabled &&
            !normalizedInventory(state).isEmpty &&
            (
                state.satiety < 40 ||
                state.energy < 45 ||
                growthPhase.title == "压仓" ||
                (growthPhase.title == "亢奋" && inventoryLoad > 18 && state.satiety < 88)
            )

        if shouldAutoMetabolize {
            let reason: String
            switch growthPhase.title {
            case "压仓":
                reason = "它囤得太满，忍不住自己慢慢消化了一口。"
            case "亢奋":
                reason = "它最近长势正猛，自己又补了一小口。"
            default:
                reason = "它饿了，自己翻出粮仓里的小零食吃了一口。"
            }

            if eatFromInventory(reason: reason) {
                return
            }
        }

        let profile = interactionRequestProfile(state)
        if let missedMessage = applyMissedRequestFeedback(&state, profile: profile) {
            refresh(message: missedMessage)
            return
        }

        if let request = deriveRequest(state) {
            let prompt = request.contains("拍") ? "\(requestPromptPrefix(state))\(request)" : "它现在有点\(request)。"
            refresh(message: prompt)
        } else {
            refresh(message: defaultBubble(for: state))
        }
    }

    func feedPreset(_ index: Int) {
        let preset = taskPresets[index]
        let meal = store.buildMeal(taskType: preset.taskType, tokensSpent: preset.tokens, quality: preset.quality)
        state = PetEngine.applyMeal(state, meal: meal)
        refresh(message: "吃了\(meal.label)餐，成长 +\(Int(meal.growth))。")
    }

    func stashFood(taskType: String, realTokens: Double, quality: String) {
        let food = foodVariantName(taskType: taskType, quality: quality)
        let servings = servingsCount(from: realTokens)
        let petTokens = normalizedPetTokens(from: realTokens)
        var inventory = normalizedInventory(state)
        var energyStock = normalizedEnergyStock(state)
        inventory[food, default: 0] += servings
        energyStock[food, default: 0] += petTokens
        state.foodInventory = inventory
        state.foodEnergyStock = energyStock
        state.lastConversionSummary = "\(Int(realTokens)) Token -> \(food)×\(servings) / \(Int(petTokens)) 粮值"
        if quality == "breakthrough" {
            state.currentActivity = "叼着特制粮开心转圈"
            state.lastCareSummary = "刚收到一批特制粮，正忍不住围着它打转"
        } else {
            state.currentActivity = "趴在粮仓边闻新粮"
            state.lastCareSummary = "刚听见新粮落仓，正凑过去认真闻味道"
        }
        appendFoodLog(&state, entry: "新粮到仓：\(food)×\(servings)")
        if quality == "breakthrough" {
            addReward(&state, amount: 1, reason: "高质量任务做出了特制粮食")
        }
    }

    func eatFromInventory(preferredTaskType: String? = nil, quality: String = "solid", reason: String = "它自己啃了一口库存粮。") -> Bool {
        var inventory = normalizedInventory(state)
        var energyStock = normalizedEnergyStock(state)

        let preferredBaseFood = preferredTaskType.map(foodName(for:))
        let selectedFood: String?

        if let preferredBaseFood {
            selectedFood = inventory
                .filter { $0.value > 0 && $0.key.contains(preferredBaseFood) }
                .sorted { left, right in
                    if left.value == right.value { return left.key < right.key }
                    return left.value > right.value
                }
                .first?
                .key
        } else {
            selectedFood = inventory
                .filter { $0.value > 0 }
                .sorted { left, right in
                    if left.value == right.value { return left.key < right.key }
                    return left.value > right.value
                }
                .first?
                .key
        }

        guard let food = selectedFood, let count = inventory[food], count > 0 else {
            return false
        }

        let totalEnergy = energyStock[food, default: 0]
        let perServingTokens = max(700, totalEnergy / Double(max(count, 1)))
        inventory[food] = count - 1
        energyStock[food] = max(0, totalEnergy - perServingTokens)
        if inventory[food] == 0 {
            inventory.removeValue(forKey: food)
            energyStock.removeValue(forKey: food)
        }

        state.foodInventory = inventory
        state.foodEnergyStock = energyStock

        let meal = store.buildMeal(taskType: taskTypeForFood(food), tokensSpent: perServingTokens, quality: quality)
        state = PetEngine.applyMeal(state, meal: meal)
        _ = setActiveFeedback(&state, key: "meal_eaten", source: "feed", priority: 50, duration: 2.4)
        state.lastCareSummary = "刚吃了\(food)，正在\(state.currentActivity ?? "慢悠悠巡桌")"
        appendFoodLog(&state, entry: "自动吃掉：\(food)")
        refresh(message: reason)
        return true
    }

    func applyDecay() {
        state = PetEngine.decay(state, hours: 3)
        state.lastCareSummary = "自己在桌边晃了一阵，状态慢慢起伏"
        refresh(message: "时间过去了一会儿，状态在自然变化。")
    }

    func performInteraction() {
        let now = Date().timeIntervalSince1970
        clearExpiredFeedback(&state, now: now)
        let last = state.lastInteractionAt ?? 0
        let combo = now - last < 6 ? min((state.petCombo ?? 0) + 1, 6) : 1
        let birthPending = isBirthBondPending(state)
        let requestProfile = interactionRequestProfile(state)
        let result = PetEngine.interact(state)
        state = result.0
        state.petCombo = combo
        state.lastInteractionAt = now
        state.lastImpactTier = result.2
        state.lastImpactValence = result.3
        state.lastImpactAt = result.2 > 0 ? now : nil
        let rewarded = rewardForMatchedRequest(&state, profile: requestProfile, actualTier: result.2, actualValence: result.3)

        if combo >= 3 && result.2 > 0 {
            state.currentActivity = currentAffinityEnergy(state) >= currentAgitationEnergy(state) ? "被连拍后开心乱蹭" : "被连拍后把躁劲甩了出来"
        }
        if combo >= 4 && result.2 >= 2 {
            addReward(&state, amount: 1, reason: "拍击节奏和它的能量状态合上了")
        }

        var finalMessage = result.1
        if result.2 == 0 {
            state.lastCareSummary = "它还没长出足够的拍劲，只是抬头看了看你"
            appendFoodLog(&state, entry: "拍它一下：还在积攒互动能量")
        } else {
            state.lastCareSummary = "你把它攒出来的互动能量拍开了，它的状态也跟着改了一点"
            appendFoodLog(&state, entry: "拍它一下：释放了\(impactTierLabel(result.2))级互动能")
            if let offBeat = applyOffBeatInteractionFeedback(&state, profile: requestProfile, actualTier: result.2, actualValence: result.3) {
                finalMessage = offBeat
            }
        }
        if rewarded && result.2 > 0 {
            finalMessage = "\(result.1) 这一下正好拍在它最想要的节奏上。"
        }
        if birthPending && result.2 > 0 {
            state.firstBondAt = now
            state.bond = clamp(state.bond + 8)
            state.mood = clamp(state.mood + 6)
            state.currentActivity = "把你的手感认真记住了"
            state.lastCareSummary = "\(petDisplayName(state)) 刚把你的第一下轻拍记了下来，像是正式认住你了"
            state.lastImpactTier = 4
            state.lastImpactValence = "bond"
            state.lastImpactAt = now
            _ = setActiveFeedback(&state, key: "bond_complete", source: "interaction", priority: 90, duration: 4.2, now: now, resolvedOutcome: "bond_complete", force: true)
            addReward(&state, amount: 2, reason: "完成了第一次认主")
            appendFoodLog(&state, entry: "第一次认主：它记住了你的手感")
            finalMessage = "\(petDisplayName(state)) 轻轻贴过来，把你的手感记进了自己身体里。现在，它正式开始跟着你一起长大了。"
        }
        refresh(message: finalMessage)
    }

    func performAutonomousRoutine() -> String? {
        let tendency = dominantGrowthTendency(state).title
        if state.energy < 18 {
            state.energy = clamp(state.energy + 10)
            state.health = clamp(state.health + 2)
            if tendency == "细养型" {
                state.currentActivity = "贴着边角蜷成小小一团"
                state.lastCareSummary = "它悄悄贴着边角补了个很轻的小觉"
                appendFoodLog(&state, entry: "自己补眠：贴边安静回神")
                return "它悄悄贴着角落蜷了一会儿，像怕吵到你似的补了个小觉。"
            }
            state.currentActivity = "自己缩成一团补眠"
            state.lastCareSummary = "它自己缩成一团补了个小觉"
            appendFoodLog(&state, entry: "自己补眠：恢复了一点活力")
            return "它困得不行，自己缩进尾巴里补了个小觉。"
        }

        if state.residue > 58 || state.hygiene < 24 {
            state.residue = clamp(state.residue - 8)
            state.hygiene = clamp(state.hygiene + 6)
            if tendency == "胀仓型" {
                state.currentActivity = "认真抖毛把自己一寸寸理顺"
                state.lastCareSummary = "它正一寸寸把自己理顺，像要先把胀意收回去"
                appendFoodLog(&state, entry: "自己整理：先把胀仓的毛理顺")
                return "它停下来认真抖毛整理自己，像是在先把胀着的那股劲收回去。"
            }
            state.currentActivity = "低头舔毛做整理"
            state.lastCareSummary = "它刚自己舔毛整理了一会儿"
            appendFoodLog(&state, entry: "自己整理：残渣稍微变少")
            return "它自己低头舔了舔毛，把身上整理干净了一点。"
        }

        if state.mood < 38 && state.energy > 34 {
            state.mood = clamp(state.mood + 6)
            state.energy = clamp(state.energy - 3)
            state.bond = clamp(state.bond + 1)
            if tendency == "猛长型" {
                state.currentActivity = "自己巡桌发了一小圈劲"
                state.lastCareSummary = "它刚自己巡桌蓄了一圈劲，情绪往上抬了一点"
                appendFoodLog(&state, entry: "自己热身：巡桌把劲提起来")
                return "它自己巡着桌边冲了一圈，像是在把劲重新蓄起来。"
            }
            state.currentActivity = "自己追着尾巴热身"
            state.lastCareSummary = "它刚自己跑了一小圈，心情回升了一点"
            appendFoodLog(&state, entry: "自己热身：心情稍微回暖")
            return "它自己绕着尾巴跑了一圈，像是在给自己打气。"
        }

        if state.bond > 78 && wantsPetting(state) {
            if tendency == "细养型" {
                state.currentActivity = "贴着边轻轻拿尾巴扫你一下"
                state.lastCareSummary = "它没闹，只是轻轻拿尾巴尖碰了碰你"
                return "它没有扑过来，只是轻轻拿尾巴尖蹭了你一下，像在问你有没有空理它。"
            }
            if tendency == "猛长型" {
                state.currentActivity = "巡到你跟前停住，抬头等你拍"
                state.lastCareSummary = "它刚巡到你跟前站住，劲都攒在眼睛里了"
                return "它巡到你跟前猛地站住，抬头盯着你，像在等你把这股劲接过去。"
            }
            if tendency == "胀仓型" {
                state.currentActivity = "抖顺毛后慢慢朝你偏过来"
                state.lastCareSummary = "它先整理了自己一下，才慢慢朝你偏过来"
                return "它先把毛抖顺了一点，才慢慢朝你这边偏过来，像在确认自己现在适不适合靠近你。"
            }
            state.currentActivity = "伸爪爪朝你讨摸摸"
            state.lastCareSummary = "它刚把小爪子举起来，像是在向你撒娇"
            return "它抬起一只小爪朝你挥了挥，明显是在求你摸它。"
        }

        return nil
    }

    func refresh(message: String) {
        clearExpiredFeedback(&state)
        let previousRequest = state.currentRequest
        state.stage = deriveStage(state.growth)
        state.form = deriveForm(state.archetypeScore)
        unlockFormIfNeeded(&state)
        state.currentRequest = deriveRequest(state)
        if state.currentRequest != previousRequest {
            state.currentRequestAt = state.currentRequest == nil ? nil : Date().timeIntervalSince1970
            state.currentRequestIgnoreLevel = 0
            if state.currentRequest != nil {
                _ = setActiveFeedback(&state, key: "request_waiting", source: "background", priority: 30, duration: 2.2)
            }
        } else if state.currentRequest == nil {
            state.currentRequestAt = nil
            state.currentRequestIgnoreLevel = 0
        }
        pruneInvalidFeedback(&state)
        let feedbackStyle = bubbleFeedbackStyle(state)
        let statusText = minimalistStatusText(state, badge: feedbackStyle.badge)
        contentView.sceneView.state = state
        contentView.bubbleView.accentColor = feedbackStyle.accentColor
        contentView.bubbleView.borderColor = feedbackStyle.borderColor
        contentView.bubbleView.fillColor = feedbackStyle.fillColor
        contentView.bubbleView.accentWidth = feedbackStyle.accentWidth
        contentView.bubbleView.tailShift = feedbackStyle.tailShift
        contentView.bubbleLabel.stringValue = message
        contentView.metaLabel.stringValue = minimalistHeaderText(state)
        contentView.metricsLabel.stringValue = "饱腹 \(Int(state.satiety))  活力 \(Int(state.energy))  亲和能 \(Int(currentAffinityEnergy(state)))  躁动能 \(Int(currentAgitationEnergy(state)))"
        contentView.requestLabel.textColor = feedbackStyle.requestColor
        contentView.requestLabel.stringValue = statusText
        contentView.rewardLabel.stringValue = "星屑 \(rewardStarCount(state))  图鉴 \(unlockedFormsValue(state).count)/\(formLabels.count)  连拍 \(state.petCombo ?? 0)  \(interactionDispositionShort(state))"
        contentView.interactButton.title = isBirthBondPending(state) ? "认" : (interactionStrengthLabel(state) == "未成拍" ? "养" : "拍")
        let conversionText = state.lastConversionSummary ?? "最新转粮会显示在这里"
        contentView.conversionLabel.stringValue = conversionText
        contentView.pantryTitleLabel.stringValue = minimalistGrowthText(state)
        contentView.pantryView.items = []
        let careSummary = state.lastCareSummary ?? "它正在桌边慢悠悠地晃来晃去"
        contentView.logLabel.textColor = feedbackStyle.logColor
        contentView.logLabel.stringValue = "\(careSummary)\n\(recentFoodSummary(state))"
        contentView.hintLabel.stringValue = isBirthBondPending(state) ? "现在先轻拍一次，它会把你的手感记成自己的第一段关系。" : "点它拍一下，力度由它吃出来的互动能源决定"
        infoController.update(state: state, config: config)
        persistWindowPosition()
        store.saveState(state)
        store.saveConfig(config)
    }

    func consumeFeedEvents() {
        guard let feed = store.loadMergedFeed(config: config), !feed.events.isEmpty else { return }

        let consumedIDs = Set(consumedEventIDsValue(state))
        let pendingEvents = feed.events.filter { !consumedIDs.contains($0.id) }
        guard !pendingEvents.isEmpty else { return }

        for event in pendingEvents {
            stashFood(taskType: event.task_type, realTokens: event.real_tokens, quality: event.quality)
            var consumed = consumedEventIDsValue(state)
            consumed.append(event.id)
            state.consumedEventIDs = Array(consumed.suffix(120))
            state.lastCodexEventID = event.id
            let food = foodVariantName(taskType: event.task_type, quality: event.quality)
            let servings = servingsCount(from: event.real_tokens)
            let converted = Int(normalizedPetTokens(from: event.real_tokens))
            let sourceLabel = event.source.uppercased()
            let summary = "\(sourceLabel) 把 \(Int(event.real_tokens)) Token 转成了 \(food)×\(servings)，可喂 \(converted) 宠物粮。"

            let shouldAutoEat =
                (config.autoEatEnabled && state.satiety < 76) ||
                (config.autoEatEnabled && state.energy < 45) ||
                (config.autoEatEnabled && growthBalanceProfile(state).title == "压仓") ||
                (config.autoEatEnabled && growthBalanceProfile(state).title == "亢奋" && inventoryServingCount(state) > 24) ||
                event.quality == "breakthrough"

            let didAutoEat: Bool
            if shouldAutoEat {
                didAutoEat = eatFromInventory(preferredTaskType: event.task_type, quality: event.quality, reason: "它闻到\(event.source)送来的新鲜\(food)，自己先吃了一口。")
            } else {
                didAutoEat = false
                refresh(message: summary)
            }

            appendTokenLedger(&state, entry: TokenLedgerEntry(
                timestamp: event.timestamp,
                source: event.source,
                taskType: event.task_type,
                quality: event.quality,
                realTokens: event.real_tokens,
                food: food,
                servings: servings,
                petTokens: Double(converted),
                autoAte: didAutoEat
            ))
        }
    }
}

do {
    let store = try PetStore()
    let app = NSApplication.shared
    let delegate = PetAppController(store: store)
    app.delegate = delegate
    app.run()
} catch {
    let alert = NSAlert()
    alert.messageText = "阿在桌宠启动失败"
    alert.informativeText = error.localizedDescription
    alert.runModal()
}
