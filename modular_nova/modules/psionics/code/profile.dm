/datum/quirk_constant_data/psionic_gift
	associated_typepath = /datum/quirk/psionic_gift
	customization_options = list(/datum/preference/choiced/psionic_rank)

GLOBAL_LIST_INIT(psionic_rank_order, list(
	PSIONIC_RANK_LAMBDA = 1,
	PSIONIC_RANK_EPSILON = 2,
	PSIONIC_RANK_GAMMA = 3,
	PSIONIC_RANK_DELTA = 4,
	PSIONIC_RANK_BETA = 5,
	PSIONIC_RANK_ALPHA = 6,
))

GLOBAL_LIST_INIT(psionic_rank_points, list(
	PSIONIC_RANK_LAMBDA = 0,
	PSIONIC_RANK_EPSILON = 1,
	PSIONIC_RANK_GAMMA = PSIONIC_DEFAULT_POINTS,
	PSIONIC_RANK_DELTA = 5,
	PSIONIC_RANK_BETA = 7,
	PSIONIC_RANK_ALPHA = 9,
))

GLOBAL_LIST_INIT(psionic_rank_max_strain, list(
	PSIONIC_RANK_LAMBDA = PSIONIC_DEFAULT_MAX_STRAIN,
	PSIONIC_RANK_EPSILON = PSIONIC_DEFAULT_MAX_STRAIN,
	PSIONIC_RANK_GAMMA = PSIONIC_DEFAULT_MAX_STRAIN,
	PSIONIC_RANK_DELTA = PSIONIC_DEFAULT_MAX_STRAIN,
	PSIONIC_RANK_BETA = PSIONIC_DEFAULT_MAX_STRAIN,
	PSIONIC_RANK_ALPHA = PSIONIC_ALPHA_MAX_STRAIN,
))

GLOBAL_LIST_INIT(psionic_rank_descriptions, list(
	PSIONIC_RANK_LAMBDA = "Sensitivity only. No operant faculties or latency.",
	PSIONIC_RANK_EPSILON = "Latent faculties, with possible minor operancy.",
	PSIONIC_RANK_GAMMA = "Operant-rank faculties, and no higher.",
	PSIONIC_RANK_DELTA = "Master-rank faculties, and no higher.",
	PSIONIC_RANK_BETA = "Grandmaster-rank faculties, and no higher.",
	PSIONIC_RANK_ALPHA = "Paramount-rank faculties with severe mental strain.",
))

/proc/get_psionic_rank_level(rank)
	var/rank_level = GLOB.psionic_rank_order[rank]
	if(isnull(rank_level))
		return GLOB.psionic_rank_order[PSIONIC_DEFAULT_RANK]

	return rank_level

/proc/get_psionic_rank_points(rank)
	var/rank_points = GLOB.psionic_rank_points[rank]
	if(isnull(rank_points))
		return GLOB.psionic_rank_points[PSIONIC_DEFAULT_RANK]

	return rank_points

/proc/is_psionic_rank_above(rank, threshold)
	return get_psionic_rank_level(rank) > get_psionic_rank_level(threshold)

/datum/component/psionic_profile
	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// Current awakened mob.
	var/mob/living/psion
	/// Unspent imprint points.
	var/available_points = 0
	/// Points spent on disciplines.
	var/spent_points = 0
	/// Current strain pressure.
	var/strain = 0
	/// Strain threshold before burnout.
	var/max_strain = PSIONIC_DEFAULT_MAX_STRAIN
	/// Current effective psionic rank.
	var/psionic_rank = PSIONIC_DEFAULT_RANK
	/// Highest latent psionic rank known to this profile.
	var/potential_rank = PSIONIC_DEFAULT_RANK
	/// If TRUE, an external limiter is suppressing the effective rank.
	var/rank_limited = FALSE
	/// Strain lost per second.
	var/strain_decay = PSIONIC_DEFAULT_STRAIN_DECAY
	/// Last world.time strain decay was calculated from.
	var/last_strain_decay = 0
	/// world.time until which psionics are burned out.
	var/burnout_until = 0
	/// Learned action type paths.
	var/list/known_powers = list()
	/// Granted actions keyed by action type path.
	var/list/granted_actions = list()
	/// Imprint points spent by anomaly school typepath.
	var/list/spent_points_by_school = list()
	/// Active systems that have granted this profile.
	var/list/profile_sources = list()

/datum/component/psionic_profile/Initialize(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	psion = parent
	available_points = max(points, 0)
	last_strain_decay = world.time
	add_source(source)
	awaken()
	learn_starting_powers(starting_powers)

/datum/component/psionic_profile/InheritComponent(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	add_source(source)
	add_points(points)
	learn_starting_powers(starting_powers)

/datum/component/psionic_profile/Destroy(force)
	if(psion)
		psion.remove_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)
	for(var/action_type in granted_actions)
		var/datum/action/action = granted_actions[action_type]
		qdel(action)
	granted_actions.Cut()
	known_powers.Cut()
	spent_points_by_school.Cut()
	profile_sources.Cut()
	psion = null
	return ..()

/datum/component/psionic_profile/proc/awaken()
	update_rank_traits()
	grant_action(/datum/action/cooldown/psionic/open_menu)
	to_chat(psion, span_purple("Something latent unfolds behind your eyes. Your psionic potential awakens."))

/datum/component/psionic_profile/proc/add_points(points)
	if(!isnum(points) || points <= 0)
		return
	available_points += points
	to_chat(psion, span_notice("Your psionic potential deepens. You have [available_points] unspent imprint point[available_points == 1 ? "" : "s"]."))

/datum/component/psionic_profile/proc/add_source(source)
	if(!source)
		return

	profile_sources[source] = TRUE

/datum/component/psionic_profile/proc/remove_source(source)
	if(!source || !profile_sources[source])
		return

	profile_sources -= source
	if(!length(profile_sources))
		qdel(src)

/datum/component/psionic_profile/proc/set_rank(rank = PSIONIC_DEFAULT_RANK, latent_rank = null, limited = FALSE, new_max_strain = null)
	if(rank)
		psionic_rank = rank
	if(latent_rank)
		potential_rank = latent_rank
	rank_limited = limited
	if(!isnull(new_max_strain))
		max_strain = new_max_strain
		strain = min(strain, max_strain)
	update_rank_traits()

/datum/component/psionic_profile/proc/update_rank_traits()
	if(!psion)
		return

	if(is_psionic_rank_above(potential_rank, PSIONIC_RANK_GAMMA))
		psion.add_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)
	else
		psion.remove_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)

/datum/component/psionic_profile/proc/get_rank_text()
	if(rank_limited && potential_rank != psionic_rank)
		return "[psionic_rank] (limited from [potential_rank])"

	return psionic_rank

/datum/component/psionic_profile/proc/get_spent_school_points(datum/psionic_school/school)
	return spent_points_by_school[school] || 0

/datum/component/psionic_profile/proc/get_interference_tier(datum/action/cooldown/psionic/source_action)
	var/rank_tier = max(get_psionic_rank_level(psionic_rank) - get_psionic_rank_level(PSIONIC_RANK_GAMMA), 0)
	if(rank_tier <= 0)
		return 0

	var/action_tier = 1
	if(source_action)
		action_tier = max(source_action.point_cost, 1)
	return rank_tier + (action_tier - 1)

/datum/component/psionic_profile/proc/emit_interference(datum/action/cooldown/psionic/source_action)
	if(!source_action?.causes_interference)
		return

	var/interference_tier = get_interference_tier(source_action)
	if(interference_tier <= 0)
		return

	var/turf/epicenter = get_turf(psion)
	if(!epicenter)
		return

	flicker_nearby_lights(epicenter, interference_tier)
	disrupt_nearby_machines(epicenter, interference_tier)
	damage_robotic_bodypart(interference_tier)

/datum/component/psionic_profile/proc/flicker_nearby_lights(turf/epicenter, interference_tier)
	var/flicker_range = PSIONIC_INTERFERENCE_RANGE + interference_tier
	for(var/obj/machinery/light/light in range(flicker_range, epicenter))
		if(prob(35 + (interference_tier * 15)))
			light.flicker(rand(1, min(interference_tier + 1, 5)))

/datum/component/psionic_profile/proc/disrupt_nearby_machines(turf/epicenter, interference_tier)
	var/disrupted = 0
	var/disrupt_range = PSIONIC_INTERFERENCE_RANGE + interference_tier
	for(var/obj/machinery/machine in range(disrupt_range, epicenter))
		if(istype(machine, /obj/machinery/light))
			continue
		if(prob(8 + (interference_tier * 7)))
			machine.emp_act(EMP_LIGHT)
			disrupted++
		if(disrupted >= min(interference_tier, PSIONIC_INTERFERENCE_MACHINE_CAP))
			break

/datum/component/psionic_profile/proc/damage_robotic_bodypart(interference_tier)
	if(!iscarbon(psion) || !prob(20 + (interference_tier * 10)))
		return

	var/mob/living/carbon/carbon_psion = psion
	var/list/robotic_parts = carbon_psion.get_damageable_bodyparts(BODYTYPE_ROBOTIC)
	if(!length(robotic_parts))
		return

	var/obj/item/bodypart/robotic_part = pick(robotic_parts)
	robotic_part.receive_damage(burn = 2 + (interference_tier * 2), forced = TRUE, required_bodytype = BODYTYPE_ROBOTIC, wound_bonus = CANT_WOUND)
	carbon_psion.update_damage_overlays()
	to_chat(carbon_psion, span_warning("Psionic static bites through [robotic_part]."))

/datum/component/psionic_profile/proc/learn_starting_powers(list/starting_powers)
	if(!length(starting_powers))
		return

	for(var/action_type in starting_powers)
		learn_power(action_type, 0, TRUE)

/datum/component/psionic_profile/proc/learn_power(action_type, cost = 1, silent = FALSE)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return FALSE
	if(action_type in known_powers)
		if(!silent)
			to_chat(psion, span_warning("You already know that discipline."))
		return FALSE
	if(cost > available_points)
		if(!silent)
			to_chat(psion, span_warning("You need [cost] imprint point[cost == 1 ? "" : "s"] for that discipline."))
		return FALSE

	available_points -= cost
	spent_points += cost
	known_powers += action_type
	var/datum/psionic_power/catalog_power = get_psionic_power_for_action(action_type)
	if(cost > 0 && catalog_power?.school)
		spent_points_by_school[catalog_power.school] = get_spent_school_points(catalog_power.school) + cost
	grant_action(action_type)

	if(!silent)
		var/datum/action/cooldown/psionic/power = granted_actions[action_type]
		to_chat(psion, span_purple("You imprint [power.name]."))
	return TRUE

/datum/component/psionic_profile/proc/grant_action(action_type)
	if(action_type in granted_actions)
		return granted_actions[action_type]

	var/datum/action/cooldown/psionic/new_action = new action_type(src)
	new_action.Grant(psion)
	granted_actions[action_type] = new_action
	return new_action

/datum/component/psionic_profile/proc/open_power_menu(mob/living/user)
	decay_strain()
	var/rank_text = get_rank_text()
	if(available_points <= 0)
		to_chat(user, span_notice("Rank: [rank_text]. Strain: [round(strain)]/[max_strain]. You have no unspent imprint points."))
		return

	var/list/options = list()
	var/list/option_to_power = list()
	for(var/datum/psionic_power/power as anything in get_psionic_power_catalog())
		if(power.action_type in known_powers)
			continue
		if(power.cost > available_points)
			continue
		var/option = "[power.get_school_name()]: [power.name] ([power.cost]) - [power.desc]"
		options += option
		option_to_power[option] = power

	if(!length(options))
		to_chat(user, span_notice("Rank: [rank_text]. Strain: [round(strain)]/[max_strain]. No available disciplines can be imprinted with your current points."))
		return

	var/choice = tgui_input_list(user, "Rank: [rank_text]. Strain: [round(strain)]/[max_strain]. Unspent points: [available_points].", "Psionic Imprinting", options)
	if(!choice || QDELETED(src) || QDELETED(user))
		return

	var/datum/psionic_power/chosen_power = option_to_power[choice]
	if(chosen_power)
		learn_power(chosen_power.action_type, chosen_power.cost)

/datum/component/psionic_profile/proc/decay_strain()
	if(!last_strain_decay)
		last_strain_decay = world.time
		return

	var/elapsed = world.time - last_strain_decay
	if(elapsed < 1 SECONDS)
		return

	var/decay_amount = round((elapsed / 10) * strain_decay)
	if(decay_amount > 0)
		strain = max(strain - decay_amount, 0)
		last_strain_decay = world.time

/datum/component/psionic_profile/proc/try_gain_strain(amount)
	decay_strain()
	if(is_burned_out())
		to_chat(psion, span_warning("Your mind is still ringing from psionic burnout."))
		return FALSE
	if(strain + amount > max_strain)
		trigger_burnout()
		return FALSE

	strain += amount
	if(strain >= max_strain * 0.75)
		to_chat(psion, span_warning("Pressure claws at the edge of your thoughts."))
	else if(strain >= max_strain * 0.5)
		to_chat(psion, span_notice("A dull pressure builds behind your eyes."))
	return TRUE

/datum/component/psionic_profile/proc/is_burned_out()
	return burnout_until > world.time

/datum/component/psionic_profile/proc/trigger_burnout()
	burnout_until = world.time + PSIONIC_BURNOUT_TIME
	strain = max_strain
	to_chat(psion, span_userdanger("Your psionic focus collapses into static."))
	psion.Knockdown(2 SECONDS)

	if(iscarbon(psion))
		var/mob/living/carbon/carbon_psion = psion
		carbon_psion.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 190)
