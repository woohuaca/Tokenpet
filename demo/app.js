(async function bootstrap() {
  const response = await fetch("../scripts/nutrition-profile.json");
  const nutritionProfiles = await response.json();

  const QUALITY_MULTIPLIER = {
    breakthrough: 1.25,
    solid: 1,
    partial: 0.78,
    waste: 0.45
  };

  const STAGES = [
    { name: "egg", minGrowth: 0, label: "宠物蛋" },
    { name: "sprout", minGrowth: 25, label: "发芽期" },
    { name: "child", minGrowth: 60, label: "幼年期" },
    { name: "teen", minGrowth: 120, label: "成长期" },
    { name: "adult", minGrowth: 220, label: "成熟体" },
    { name: "mythic", minGrowth: 360, label: "传说体" }
  ];

  const FORM_LABEL = {
    neutral: "中性",
    builder: "建造型",
    scholar: "学者型",
    captain: "指挥型",
    social: "社交型",
    chaos: "混乱型"
  };

  const FORM_NARRATIVE = {
    neutral: "它还在观察你。现在最重要的不是多花 Token，而是让饮食结构尽快形成稳定偏好。",
    builder: "它明显偏爱开发型任务，属于高蛋白成长路线。只要别连续喂太多空转餐，就会越长越能打。",
    scholar: "它已经被研究和写作喂出了脑力型气质。优点是成长值高，风险是容易过劳，需要配合休息和清理。",
    captain: "它更像一个会统筹全局的指挥型宠物。规划和评审给了它秩序感，但如果缺少真正产出，会显得有点空心。",
    social: "它越来越像会在关系和支持工作里获得满足的陪伴体。优点是亲密度高，缺点是过多支持型消耗容易拖低专注。",
    chaos: "它已经在垃圾饮食边缘徘徊。会议和空转把它喂得有点失控，需要尽快用高质量任务把结构拉回来。"
  };

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

  let currentQuality = "solid";
  let state = structuredClone(DEFAULT_STATE);
  let mealHistory = [];

  const taskTypeSelect = document.querySelector("#task-type");
  const tokenSlider = document.querySelector("#token-slider");
  const tokenValue = document.querySelector("#token-value");
  const qualityButtons = Array.from(document.querySelectorAll("[data-quality]"));
  const feedForm = document.querySelector("#feed-form");
  const mealPreviewGrid = document.querySelector("#meal-preview-grid");
  const petScene = document.querySelector("#pet-scene");
  const moodPill = document.querySelector("#mood-pill");
  const stageLabel = document.querySelector("#stage-label");
  const formLabel = document.querySelector("#form-label");
  const ageLabel = document.querySelector("#age-label");
  const statsGrid = document.querySelector("#stats-grid");
  const warningList = document.querySelector("#warning-list");
  const archetypeList = document.querySelector("#archetype-list");
  const narrativeText = document.querySelector("#narrative-text");
  const mealLog = document.querySelector("#meal-log");
  const actionButtons = Array.from(document.querySelectorAll("[data-action]"));

  init();

  function init() {
    buildTaskOptions();
    attachListeners();
    render();
  }

  function attachListeners() {
    taskTypeSelect.addEventListener("change", renderMealPreview);
    tokenSlider.addEventListener("input", () => {
      tokenValue.textContent = tokenSlider.value;
      renderMealPreview();
    });

    qualityButtons.forEach((button) => {
      button.addEventListener("click", () => {
        currentQuality = button.dataset.quality;
        qualityButtons.forEach((item) => item.classList.toggle("is-active", item === button));
        renderMealPreview();
      });
    });

    feedForm.addEventListener("submit", (event) => {
      event.preventDefault();
      const meal = buildMeal(taskTypeSelect.value, Number(tokenSlider.value), currentQuality);
      state = applyMeal(state, meal);
      mealHistory = [meal, ...mealHistory].slice(0, 8);
      render();
    });

    actionButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const action = button.dataset.action;

        if (action === "clean") {
          state = cleanResidue(state, 1);
        }

        if (action === "play") {
          state = playWithPet(state, 1);
        }

        if (action === "sleep") {
          state = sleepPet(state, 6);
        }

        if (action === "tick") {
          state = decayState(state, 3);
        }

        render();
      });
    });
  }

  function buildTaskOptions() {
    Object.entries(nutritionProfiles).forEach(([taskType, profile]) => {
      const option = document.createElement("option");
      option.value = taskType;
      option.textContent = `${profile.label} / ${taskType}`;
      taskTypeSelect.appendChild(option);
    });

    taskTypeSelect.value = "coding";
    tokenValue.textContent = tokenSlider.value;
    renderMealPreview();
  }

  function tokenUnits(tokensSpent) {
    if (!tokensSpent || tokensSpent <= 0) {
      return 0;
    }

    return Math.max(1, Math.sqrt(tokensSpent / 1000) * 3);
  }

  function clamp(value, min = 0, max = 100) {
    return Math.max(min, Math.min(max, value));
  }

  function round(value) {
    return Math.round(value * 10) / 10;
  }

  function getProfile(taskType) {
    return nutritionProfiles[taskType] || nutritionProfiles.idle;
  }

  function buildMeal(taskType, tokensSpent, outputQuality) {
    const profile = getProfile(taskType);
    const units = tokenUnits(tokensSpent);
    const qualityMultiplier = QUALITY_MULTIPLIER[outputQuality] || QUALITY_MULTIPLIER.solid;
    const residue = Math.max(0, profile.toxicity * units * (2 - qualityMultiplier));

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
      residue: round(residue),
      archetypes: profile.archetypes
    };
  }

  function applyMeal(prevState, meal) {
    const next = {
      ...prevState,
      archetypeScore: {
        ...prevState.archetypeScore
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

  function decayState(prevState, hours) {
    const next = {
      ...prevState,
      ageHours: round(prevState.ageHours + hours)
    };

    next.satiety = clamp(next.satiety - hours * 3.5);
    next.energy = clamp(next.energy - hours * 2.6);
    next.focus = clamp(next.focus - hours * 1.8);
    next.mood = clamp(next.mood - hours * 1.6 - prevState.residue * 0.03);
    next.hygiene = clamp(next.hygiene - hours * 1.4 - prevState.toxicity * 0.02);
    next.health = clamp(next.health - Math.max(0, prevState.toxicity - 40) * 0.03 * hours);
    next.toxicity = clamp(next.toxicity - hours * 0.6);
    next.stage = deriveStage(next.growth);
    next.form = deriveForm(next.archetypeScore);
    return next;
  }

  function cleanResidue(prevState, effort) {
    return {
      ...prevState,
      residue: clamp(prevState.residue - effort * 12),
      hygiene: clamp(prevState.hygiene + effort * 10),
      mood: clamp(prevState.mood + effort * 3),
      health: clamp(prevState.health + effort * 2)
    };
  }

  function playWithPet(prevState, intensity) {
    return {
      ...prevState,
      mood: clamp(prevState.mood + intensity * 8),
      bond: clamp(prevState.bond + intensity * 6),
      energy: clamp(prevState.energy - intensity * 4),
      satiety: clamp(prevState.satiety - intensity * 3)
    };
  }

  function sleepPet(prevState, hours) {
    return {
      ...prevState,
      energy: clamp(prevState.energy + hours * 8),
      health: clamp(prevState.health + hours * 2),
      focus: clamp(prevState.focus + hours * 2),
      mood: clamp(prevState.mood + hours),
      satiety: clamp(prevState.satiety - hours * 2)
    };
  }

  function deriveStage(growth) {
    let current = STAGES[0];

    STAGES.forEach((stage) => {
      if (growth >= stage.minGrowth) {
        current = stage;
      }
    });

    return current.name;
  }

  function deriveForm(archetypeScore) {
    const ranked = Object.entries(archetypeScore).sort((left, right) => right[1] - left[1]);
    const dominant = ranked[0];

    if (!dominant || dominant[1] < 10) {
      return "neutral";
    }

    return dominant[0];
  }

  function deriveMoodTag(currentState) {
    if (currentState.health < 30 || currentState.hygiene < 20) {
      return "sick";
    }

    if (currentState.energy < 20) {
      return "sleepy";
    }

    if (currentState.toxicity > 70 || currentState.residue > 50) {
      return "glitched";
    }

    if (currentState.mood > 80 && currentState.bond > 70) {
      return "joyful";
    }

    if (currentState.satiety < 20) {
      return "hungry";
    }

    return "steady";
  }

  function getWarnings(currentState) {
    return [
      currentState.satiety < 25 ? "它有点饿，最近高价值 Token 不够稳定。" : null,
      currentState.energy < 25 ? "它开始疲惫，说明连续高强度使用后没有恢复。" : null,
      currentState.residue > 35 ? "噪声残渣偏多，说明最近低效 Token 积累明显。" : null,
      currentState.toxicity > 60 ? "饮食结构失衡，会议或空转类 Token 占比过高。" : null
    ].filter(Boolean);
  }

  function renderMealPreview() {
    const meal = buildMeal(taskTypeSelect.value, Number(tokenSlider.value), currentQuality);
    const previewMetrics = [
      { label: "成长", value: meal.growth },
      { label: "心情", value: meal.mood },
      { label: "专注", value: meal.focus },
      { label: "健康", value: meal.health },
      { label: "毒性", value: meal.toxicity },
      { label: "残渣", value: meal.residue }
    ];

    mealPreviewGrid.innerHTML = "";
    previewMetrics.forEach((metric) => {
      const item = document.createElement("div");
      item.className = "preview-item";
      item.innerHTML = `<span>${metric.label}</span><strong>${metric.value}</strong>`;
      mealPreviewGrid.appendChild(item);
    });
  }

  function renderStats() {
    const metrics = [
      ["饱腹度", state.satiety],
      ["活力", state.energy],
      ["专注", state.focus],
      ["心情", state.mood],
      ["清洁度", state.hygiene],
      ["健康度", state.health],
      ["亲密度", state.bond],
      ["成长值", Math.min(state.growth / 3.6, 100)]
    ];

    statsGrid.innerHTML = "";
    metrics.forEach(([label, value]) => {
      const card = document.createElement("article");
      card.className = "stat-card";
      card.innerHTML = `
        <header>
          <span>${label}</span>
          <strong>${round(value)}</strong>
        </header>
        <div class="bar-track">
          <div class="bar-fill" style="width:${clamp(value)}%"></div>
        </div>
      `;
      statsGrid.appendChild(card);
    });
  }

  function renderWarnings() {
    const warnings = getWarnings(state);
    warningList.innerHTML = "";

    if (!warnings.length) {
      const item = document.createElement("li");
      item.className = "warning-empty";
      item.textContent = "状态稳定，当前饮食结构没有明显风险。";
      warningList.appendChild(item);
      return;
    }

    warnings.forEach((warning) => {
      const item = document.createElement("li");
      item.textContent = warning;
      warningList.appendChild(item);
    });
  }

  function renderArchetypes() {
    const entries = Object.entries(state.archetypeScore).sort((left, right) => right[1] - left[1]);
    const max = Math.max(...entries.map(([, value]) => value), 1);
    archetypeList.innerHTML = "";

    entries.forEach(([key, value]) => {
      const item = document.createElement("article");
      item.className = "archetype-item";
      item.innerHTML = `
        <header>
          <span>${FORM_LABEL[key]}</span>
          <strong>${round(value)}</strong>
        </header>
        <div class="bar-track">
          <div class="bar-fill" style="width:${(value / max) * 100}%"></div>
        </div>
      `;
      archetypeList.appendChild(item);
    });
  }

  function renderMealLog() {
    mealLog.innerHTML = "";

    if (!mealHistory.length) {
      const empty = document.createElement("div");
      empty.className = "meal-entry";
      empty.innerHTML = "<strong>还没有投喂记录</strong><span>先用一顿任务餐把它喂醒。</span>";
      mealLog.appendChild(empty);
      return;
    }

    mealHistory.forEach((meal) => {
      const item = document.createElement("div");
      item.className = "meal-entry";
      item.innerHTML = `
        <strong>${meal.label} / ${meal.tokensSpent} Token / ${meal.outputQuality}</strong>
        <span>成长 +${meal.growth}，毒性 +${meal.toxicity}，残渣 +${meal.residue}</span>
      `;
      mealLog.appendChild(item);
    });
  }

  function renderNarrative() {
    const warnings = getWarnings(state);
    const narrative = [];

    narrative.push(FORM_NARRATIVE[state.form] || FORM_NARRATIVE.neutral);

    if (state.lastTaskType) {
      narrative.push(`最近一餐来自“${getProfile(state.lastTaskType).label}”，它正在根据你的工作结构重新塑形。`);
    }

    if (warnings.length) {
      narrative.push(`当前最需要关注的是：${warnings[0]}`);
    } else {
      narrative.push("短期状态稳定，可以继续观察哪类任务最能推动成长与进化。");
    }

    narrativeText.textContent = narrative.join(" ");
  }

  function renderMeta() {
    const currentMood = deriveMoodTag(state);
    const stageItem = STAGES.find((item) => item.name === state.stage) || STAGES[0];

    petScene.dataset.form = state.form;
    petScene.dataset.mood = currentMood;
    moodPill.textContent = currentMood;
    stageLabel.textContent = stageItem.label;
    formLabel.textContent = FORM_LABEL[state.form] || FORM_LABEL.neutral;
    ageLabel.textContent = `${round(state.ageHours)}h`;
  }

  function render() {
    renderMealPreview();
    renderMeta();
    renderStats();
    renderWarnings();
    renderArchetypes();
    renderNarrative();
    renderMealLog();
  }
})();
