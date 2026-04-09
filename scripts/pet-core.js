const nutritionProfiles = require("./nutrition-profile.json");

const QUALITY_MULTIPLIER = {
  breakthrough: 1.25,
  solid: 1,
  partial: 0.78,
  waste: 0.45
};

const LIFECYCLE_STAGES = [
  { name: "egg", minGrowth: 0 },
  { name: "sprout", minGrowth: 25 },
  { name: "child", minGrowth: 60 },
  { name: "teen", minGrowth: 120 },
  { name: "adult", minGrowth: 220 },
  { name: "mythic", minGrowth: 360 }
];

const DEFAULT_STATE = {
  stage: "egg",
  form: "neutral",
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
  lastTaskType: null,
  archetypeScore: {
    builder: 0,
    scholar: 0,
    captain: 0,
    social: 0,
    chaos: 0
  }
};

function clamp(value, min = 0, max = 100) {
  return Math.max(min, Math.min(max, value));
}

function round(value) {
  return Math.round(value * 10) / 10;
}

function tokenUnits(tokensSpent) {
  if (!tokensSpent || tokensSpent <= 0) {
    return 0;
  }

  return Math.max(1, Math.sqrt(tokensSpent / 1000) * 3);
}

function getProfile(taskType) {
  return nutritionProfiles[taskType] || nutritionProfiles.idle;
}

function buildMeal(taskType, tokensSpent, outputQuality = "solid") {
  const profile = getProfile(taskType);
  const units = tokenUnits(tokensSpent);
  const qualityMultiplier = QUALITY_MULTIPLIER[outputQuality] || QUALITY_MULTIPLIER.solid;
  const residueDelta = Math.max(0, profile.toxicity * units * (2 - qualityMultiplier));

  return {
    taskType,
    label: profile.label,
    tokensSpent,
    outputQuality,
    satiety: round(profile.satiety * units * qualityMultiplier),
    energy: round(profile.energy * units * qualityMultiplier),
    focus: round(profile.focus * units * qualityMultiplier),
    mood: round(profile.mood * units * qualityMultiplier),
    hygiene: round(profile.hygiene * units),
    health: round(profile.health * units * qualityMultiplier),
    bond: round(profile.bond * units * qualityMultiplier),
    growth: round(profile.growth * units * qualityMultiplier),
    toxicity: round(profile.toxicity * units * (1.2 - qualityMultiplier * 0.2)),
    residue: round(residueDelta),
    archetypes: profile.archetypes
  };
}

function applyMeal(state, meal) {
  const next = {
    ...state,
    archetypeScore: {
      ...state.archetypeScore
    }
  };

  next.satiety = clamp(next.satiety + meal.satiety);
  next.energy = clamp(next.energy + meal.energy);
  next.focus = clamp(next.focus + meal.focus);
  next.mood = clamp(next.mood + meal.mood);
  next.hygiene = clamp(next.hygiene + meal.hygiene);
  next.health = clamp(next.health + meal.health - meal.toxicity * 0.4);
  next.bond = clamp(next.bond + meal.bond);
  next.growth = round(next.growth + meal.growth);
  next.toxicity = clamp(next.toxicity + meal.toxicity);
  next.residue = clamp(next.residue + meal.residue);
  next.lastTaskType = meal.taskType;

  Object.entries(meal.archetypes || {}).forEach(([name, score]) => {
    next.archetypeScore[name] = round(next.archetypeScore[name] + score * tokenUnits(meal.tokensSpent));
  });

  next.stage = deriveStage(next.growth);
  next.form = deriveForm(next.archetypeScore);
  return next;
}

function decayState(state, hours = 1) {
  const next = {
    ...state,
    ageHours: round(state.ageHours + hours)
  };

  next.satiety = clamp(next.satiety - hours * 3.5);
  next.energy = clamp(next.energy - hours * 2.6);
  next.focus = clamp(next.focus - hours * 1.8);
  next.mood = clamp(next.mood - hours * 1.6 - state.residue * 0.03);
  next.hygiene = clamp(next.hygiene - hours * 1.4 - state.toxicity * 0.02);
  next.health = clamp(next.health - Math.max(0, state.toxicity - 40) * 0.03 * hours);
  next.toxicity = clamp(next.toxicity - hours * 0.6);
  next.stage = deriveStage(next.growth);
  next.form = deriveForm(next.archetypeScore);
  return next;
}

function cleanResidue(state, effort = 1) {
  return {
    ...state,
    residue: clamp(state.residue - effort * 12),
    hygiene: clamp(state.hygiene + effort * 10),
    mood: clamp(state.mood + effort * 3),
    health: clamp(state.health + effort * 2)
  };
}

function playWithPet(state, intensity = 1) {
  return {
    ...state,
    mood: clamp(state.mood + intensity * 8),
    bond: clamp(state.bond + intensity * 6),
    energy: clamp(state.energy - intensity * 4),
    satiety: clamp(state.satiety - intensity * 3)
  };
}

function sleepPet(state, hours = 6) {
  return {
    ...state,
    energy: clamp(state.energy + hours * 8),
    health: clamp(state.health + hours * 2),
    focus: clamp(state.focus + hours * 2),
    mood: clamp(state.mood + hours),
    satiety: clamp(state.satiety - hours * 2)
  };
}

function deriveStage(growth) {
  let result = LIFECYCLE_STAGES[0].name;

  for (const stage of LIFECYCLE_STAGES) {
    if (growth >= stage.minGrowth) {
      result = stage.name;
    }
  }

  return result;
}

function deriveForm(archetypeScore) {
  const ranked = Object.entries(archetypeScore).sort((a, b) => b[1] - a[1]);
  const dominant = ranked[0];

  if (!dominant || dominant[1] < 10) {
    return "neutral";
  }

  return dominant[0];
}

function deriveMoodTag(state) {
  if (state.health < 30 || state.hygiene < 20) {
    return "sick";
  }

  if (state.energy < 20) {
    return "sleepy";
  }

  if (state.toxicity > 70 || state.residue > 50) {
    return "glitched";
  }

  if (state.mood > 80 && state.bond > 70) {
    return "joyful";
  }

  if (state.satiety < 20) {
    return "hungry";
  }

  return "steady";
}

function summarizeState(state) {
  return {
    stage: state.stage,
    form: state.form,
    moodTag: deriveMoodTag(state),
    warnings: [
      state.satiety < 25 ? "宠物饿了" : null,
      state.energy < 25 ? "宠物需要休息" : null,
      state.residue > 35 ? "噪声残渣过多" : null,
      state.toxicity > 60 ? "饮食结构失衡" : null
    ].filter(Boolean)
  };
}

module.exports = {
  DEFAULT_STATE,
  QUALITY_MULTIPLIER,
  buildMeal,
  applyMeal,
  decayState,
  cleanResidue,
  playWithPet,
  sleepPet,
  deriveStage,
  deriveForm,
  deriveMoodTag,
  summarizeState
};
