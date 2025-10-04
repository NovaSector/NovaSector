/datum/storyteller/mia_chill
    name = "Mia'Chill"
    desc = "A young Avali drifting through the stars, weaving tales of quiet introspection  \
	and fleeting wonders, where chaos yields to the soft hush of cosmic peace."

    base_cost_multiplier = 1.6  // High cost for events, ensuring rarity
    threat_growth_rate = 0.4    // Very slow threat accumulation
    adaptation_decay_rate = 0.12 // Quick adaptation to foster calm
    target_tension = 25         // Ultra-low tension for relaxed pacing
    grace_period = 12 MINUTES   // Extended breaks for roleplay immersion
    difficulty_multiplier = 0.7 // Gentle overall difficulty
    repetition_penalty = 0.9    // Strong penalty to avoid any repetition
    player_antag_balance = 75   // Strong crew favoritism


/datum/storyteller/cas_classic
    name = "Cas'Classic"
    desc = "A battle-hardened human chronicler of inevitable doom, escalating whispers \
	of unrest into symphonies of destruction, where every victory sows the seeds of the next fall."

    base_cost_multiplier = 1.15 // Moderate costs for steady buildup
    threat_growth_rate = 1.6    // Accelerated threat growth
    adaptation_decay_rate = 0.015 // Slow recovery, no mercy
    target_tension = 65         // Elevated tension for constant pressure
    grace_period = 2.5 MINUTES  // Brief pauses to heighten anticipation
    difficulty_multiplier = 1.25 // Heightened baseline challenge
    repetition_penalty = 0.65   // Moderate penalty for varied escalations
    player_antag_balance = 35   // Antag lean for survival tests


/datum/storyteller/randall_gambit
    name = "Randall's Gambit"
    desc = "A shadowy trickster rolling the dice of doom, where fortunes flip on a whim—banal bureaucracy one moment, biblical apocalypse the next, all in the name of capricious fate."

    base_cost_multiplier = 0.75 // Low costs for frequent rolls
    threat_growth_rate = 2.2    // Erratic, explosive growth
    adaptation_factor = 0.15    // Minimal adaptation to keep the gamble alive
    target_tension = 45         // Variable tension, swinging wildly
    grace_period = 45 SECONDS   // Minimal breaks for back-to-back chaos
    repetition_penalty = 0.25   // Low penalty; repeats fuel the folly
    difficulty_multiplier = 1.05 // Slight edge for unpredictability
    player_antag_balance = 50   // Neutral, but randomized per cycle

/datum/storyteller/nick_catastrophe
    name = "Nick Catastrophe"
    desc = "A storm-wreathed human doomsayer unleashing twin tempests of ruin, where the \
	station crumbles under dual waves of havoc—destruction doubled, mercy forsaken."

    base_cost_multiplier = 0.9  // Affordable for non-stop barrages
    threat_growth_rate = 2.5    // Hyper-aggressive accumulation
    adaptation_decay_rate = 0.01 // Near-zero recovery; wounds fester
    target_tension = 85         // Crushing tension levels
    grace_period = 1 MINUTES     // Scant respite amid the storm
    max_threat_scale = 6.5      // Overcapped threats for total overwhelm
    difficulty_multiplier = 1.6 // Extreme baseline escalation
    repetition_penalty = 0.4    // Light penalty; redundancy amplifies ruin
    player_antag_balance = 20   // Heavy antag dominance, crew as prey


/datum/storyteller/mia_nic_challenge
    name = "Mia & Nic'Challenge"
    desc = "A paradoxical pact between Avali serenity and human fury, blending tranquil lulls into escalating \
	trials where balance teeters on the edge of beautiful catastrophe."

    base_cost_multiplier = 1.0  // Balanced costs for hybrid pacing
    threat_growth_rate = 1.8    // Starts slow, ramps to explosive
    adaptation_decay_rate = 0.04 // Gradual decay, building unyielding pressure
    target_tension = 60         // Rising from low to peak strain
    grace_period = 4 MINUTES    // Variable breaks that shorten over time
    difficulty_multiplier = 1.4 // Progressive high challenge
    repetition_penalty = 0.55   // Balanced penalty for evolving variety
    player_antag_balance = 50   // Perfect equilibrium, but hyper-tuned for tension
