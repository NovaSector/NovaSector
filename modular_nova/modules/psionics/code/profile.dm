/datum/quirk_constant_data/psionic_gift
	associated_typepath = /datum/quirk/psionic_gift
	customization_options = list(
		/datum/preference/choiced/psionic_rank,
		/datum/preference/color/psionic_color,
	)

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
	/// Color used by psionic manifestations.
	var/psionic_color = PSIONIC_DEFAULT_COLOR
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
	/// Selected lower-rank variants keyed by psionic action type.
	var/list/selected_power_rank_variants = list()
	/// Imprint points spent by anomaly school typepath.
	var/list/spent_points_by_school = list()
	/// Anomaly schools attuned through matching anomaly cores.
	var/list/attuned_schools = list()
	/// Active systems that have granted this profile, mapped to their current point grant.
	var/list/profile_sources = list()

/datum/component/psionic_profile/Initialize(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	psion = parent
	RegisterSignal(psion, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	RegisterSignal(psion, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignals(
		psion,
		list(SIGNAL_ADDTRAIT(TRAIT_PSIONIC_DAMPENER), SIGNAL_REMOVETRAIT(TRAIT_PSIONIC_DAMPENER)),
		PROC_REF(on_psionic_availability_changed),
	)
	last_strain_decay = world.time
	add_source(source, points, TRUE)
	awaken()
	learn_starting_powers(starting_powers)

/datum/component/psionic_profile/InheritComponent(points = PSIONIC_DEFAULT_POINTS, list/starting_powers, source = PSIONIC_TRAIT_SOURCE)
	if(add_source(source, points))
		learn_starting_powers(starting_powers)

/datum/component/psionic_profile/Destroy(force)
	if(psion)
		UnregisterSignal(psion, list(
			COMSIG_MOB_HUD_CREATED,
			COMSIG_LIVING_LIFE,
			SIGNAL_ADDTRAIT(TRAIT_PSIONIC_DAMPENER),
			SIGNAL_REMOVETRAIT(TRAIT_PSIONIC_DAMPENER),
		))
		remove_strain_hud()
		psion.remove_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)
	for(var/action_type in granted_actions)
		var/datum/action/action = granted_actions[action_type]
		qdel(action)
	granted_actions.Cut()
	known_powers.Cut()
	selected_power_rank_variants.Cut()
	spent_points_by_school.Cut()
	attuned_schools.Cut()
	profile_sources.Cut()
	psion = null
	return ..()

/datum/component/psionic_profile/proc/awaken()
	update_rank_traits()
	grant_action(/datum/action/cooldown/psionic/open_menu)
	install_strain_hud()
	to_chat(psion, span_purple("Something latent unfolds behind your eyes. Your psionic potential awakens."))

/datum/component/psionic_profile/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER

	install_strain_hud()

/datum/component/psionic_profile/proc/on_life(datum/source, seconds_per_tick)
	SIGNAL_HANDLER

	decay_strain()
	update_strain_hud()
	update_psionic_action_buttons()

/datum/component/psionic_profile/proc/on_psionic_availability_changed(datum/source)
	SIGNAL_HANDLER

	update_psionic_action_buttons()

/datum/component/psionic_profile/proc/install_strain_hud()
	var/datum/hud/psion_hud = psion?.hud_used
	if(!psion_hud)
		return

	var/atom/movable/screen/psionic/strain/strain_hud = psion_hud.screen_objects[HUD_PSIONIC_STRAIN]
	if(!strain_hud)
		strain_hud = psion_hud.add_screen_object(/atom/movable/screen/psionic/strain, HUD_PSIONIC_STRAIN, HUD_GROUP_INFO, update_screen = TRUE)
	update_strain_hud()

/datum/component/psionic_profile/proc/remove_strain_hud()
	psion?.hud_used?.remove_screen_object(HUD_PSIONIC_STRAIN)

/datum/component/psionic_profile/proc/update_strain_hud()
	var/atom/movable/screen/psionic/strain/strain_hud = psion?.hud_used?.screen_objects[HUD_PSIONIC_STRAIN]
	if(!strain_hud)
		return

	strain_hud.update_strain(strain, max_strain, is_burned_out())

/datum/component/psionic_profile/proc/update_psionic_action_buttons(update_flags = UPDATE_BUTTON_STATUS)
	for(var/action_type in granted_actions)
		var/datum/action/action = granted_actions[action_type]
		action?.build_all_button_icons(update_flags)

/datum/component/psionic_profile/proc/apply_manifestation_color(atom/manifestation)
	if(!manifestation)
		return

	var/color_to_apply = psionic_color || PSIONIC_DEFAULT_COLOR
	manifestation.add_atom_colour(color_to_apply, FIXED_COLOUR_PRIORITY)
	manifestation.set_light_color(color_to_apply)

/datum/component/psionic_profile/proc/get_power_rank_variant(action_type)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return null

	return selected_power_rank_variants[action_type]

/datum/component/psionic_profile/proc/set_power_rank_variant(action_type, variant_rank)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return FALSE
	if(!variant_rank)
		selected_power_rank_variants -= action_type
		return TRUE

	selected_power_rank_variants[action_type] = variant_rank
	return TRUE

/datum/component/psionic_profile/proc/add_points(points, silent = FALSE)
	if(!isnum(points))
		return FALSE
	points = max(round(points), 0)
	if(points <= 0)
		return FALSE

	available_points += points
	if(!silent)
		to_chat(psion, span_notice("Your psionic potential deepens. You have [available_points] unspent imprint point[available_points == 1 ? "" : "s"]."))
	return TRUE

/datum/component/psionic_profile/proc/remove_points(points, silent = FALSE)
	if(!isnum(points))
		return FALSE
	points = max(round(points), 0)
	if(points <= 0)
		return FALSE

	if(points > available_points)
		reset_imprints(get_total_source_points(), TRUE)
	else
		available_points -= points
	if(!silent)
		to_chat(psion, span_notice("Your psionic potential recedes. You have [available_points] unspent imprint point[available_points == 1 ? "" : "s"]."))
	return TRUE

/datum/component/psionic_profile/proc/reset_imprints(points = 0, silent = FALSE)
	points = max(points, 0)
	for(var/action_type in known_powers.Copy())
		var/datum/action/action = granted_actions[action_type]
		if(action)
			qdel(action)
		granted_actions -= action_type

	known_powers.Cut()
	spent_points_by_school.Cut()
	spent_points = 0
	available_points = points
	if(!silent)
		to_chat(psion, span_notice("Your imprinted disciplines fold away. You have [available_points] imprint point[available_points == 1 ? "" : "s"] to spend."))

/datum/component/psionic_profile/proc/add_source(source, points = 0, silent = FALSE)
	if(!source)
		return FALSE
	if(!isnum(points))
		points = 0
	points = max(round(points), 0)

	if(source in profile_sources)
		var/current_points = profile_sources[source] || 0
		if(points <= current_points)
			return FALSE

		profile_sources[source] = points
		add_points(points - current_points, silent)
		return TRUE

	profile_sources[source] = points
	add_points(points, silent)
	return TRUE

/datum/component/psionic_profile/proc/set_source_points(source, points = 0, silent = FALSE)
	if(!source)
		return FALSE
	if(!isnum(points))
		points = 0
	points = max(round(points), 0)
	if(!(source in profile_sources))
		return add_source(source, points, silent)

	var/current_points = profile_sources[source] || 0
	if(points == current_points)
		return FALSE

	profile_sources[source] = points
	if(points > current_points)
		add_points(points - current_points, silent)
	else
		remove_points(current_points - points, silent)
	return TRUE

/datum/component/psionic_profile/proc/has_source(source)
	return source && (source in profile_sources)

/datum/component/psionic_profile/proc/get_total_source_points()
	var/total_points = 0
	for(var/source in profile_sources)
		total_points += profile_sources[source] || 0
	return total_points

/datum/component/psionic_profile/proc/remove_source(source)
	if(!has_source(source))
		return

	var/source_points = profile_sources[source] || 0
	profile_sources -= source
	if(!length(profile_sources))
		qdel(src)
		return

	remove_points(source_points, TRUE)

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
	update_strain_hud()
	update_psionic_action_buttons(UPDATE_BUTTON_NAME|UPDATE_BUTTON_STATUS)

/datum/component/psionic_profile/proc/update_rank_traits()
	if(!psion)
		return

	if(is_psionic_rank_above(psionic_rank, PSIONIC_RANK_GAMMA))
		psion.add_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)
	else
		psion.remove_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), PSIONIC_TRAIT_SOURCE)

/datum/component/psionic_profile/proc/get_rank_text()
	if(rank_limited && potential_rank != psionic_rank)
		return "[psionic_rank] (limited from [potential_rank])"

	return psionic_rank

/datum/component/psionic_profile/proc/get_spent_school_points(school)
	return spent_points_by_school[school] || 0

/datum/component/psionic_profile/proc/is_school_attuned(school)
	return !!attuned_schools[school]

/datum/component/psionic_profile/proc/attune_school(school)
	if(!ispath(school, /datum/psionic_school))
		return FALSE
	if(is_school_attuned(school))
		var/datum/psionic_school/attuned_school = get_psionic_school(school)
		to_chat(psion, span_notice("Your thoughts are already attuned to [attuned_school?.name || "that resonance"]."))
		return FALSE

	var/datum/psionic_school/attuning_school = get_psionic_school(school)
	attuned_schools[school] = TRUE
	to_chat(psion, span_purple("The core collapses into a stable [attuning_school?.name || "psionic"] resonance. That branch will build less strain."))
	return TRUE

/datum/component/psionic_profile/proc/get_school_strain_discount(school)
	if(!ispath(school, /datum/psionic_school))
		return 0

	var/discount = 0
	if(get_spent_school_points(school) >= PSIONIC_BRANCH_COMMITMENT_POINTS)
		discount += PSIONIC_BRANCH_COMMITMENT_STRAIN_DISCOUNT
	if(is_school_attuned(school))
		discount += PSIONIC_CORE_ATTUNEMENT_STRAIN_DISCOUNT

	return min(discount, PSIONIC_MAX_STRAIN_DISCOUNT)

/datum/component/psionic_profile/proc/get_action_strain_gain(amount, datum/action/cooldown/psionic/source_action)
	amount = max(round(amount), 0)
	if(amount <= 0)
		return 0

	var/discount = get_school_strain_discount(source_action?.school)
	if(discount <= 0)
		return amount

	return max(round(amount * (100 - discount) / 100), 1)

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

/datum/component/psionic_profile/proc/learn_power(action_type, cost = null, silent = FALSE)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return FALSE
	var/datum/psionic_power/catalog_power = get_psionic_power_for_action(action_type)
	if(isnull(cost))
		cost = catalog_power ? catalog_power.get_cost() : 1
	if(action_type in known_powers)
		if(!silent)
			to_chat(psion, span_warning("You already know that discipline."))
		return FALSE
	if(cost > 0 && catalog_power)
		var/lock_reason = get_power_lock_reason(catalog_power)
		if(lock_reason)
			if(!silent)
				to_chat(psion, span_warning(lock_reason))
			return FALSE
	if(cost > available_points)
		if(!silent)
			to_chat(psion, span_warning("You need [cost] imprint point[cost == 1 ? "" : "s"] for that discipline."))
		return FALSE

	available_points -= cost
	spent_points += cost
	known_powers += action_type
	var/catalog_school = catalog_power ? catalog_power.get_school_type() : null
	if(cost > 0 && catalog_school)
		spent_points_by_school[catalog_school] = get_spent_school_points(catalog_school) + cost
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
	ui_interact(user)

/datum/component/psionic_profile/proc/get_power_lock_reason(datum/psionic_power/power)
	if(!power)
		return "That discipline cannot be imprinted."
	if(power.action_type in known_powers)
		return "You already know that discipline."
	if(length(power.required_powers))
		for(var/required_power_type in power.required_powers)
			if(required_power_type in known_powers)
				continue

			var/datum/psionic_power/required_power = get_psionic_power_for_action(required_power_type)
			var/required_power_name = required_power ? required_power.get_name() : "the prerequisite discipline"
			return "Imprint [required_power_name] first."
	var/power_cost = power.get_cost()
	if(power_cost > available_points)
		return "You need [power_cost] imprint point[power_cost == 1 ? "" : "s"] for that discipline."
	var/power_school = power.get_school_type()
	if(power.required_school_points > get_spent_school_points(power_school))
		var/datum/psionic_school/school = get_psionic_school(power_school)
		return "Spend [power.required_school_points] point[power.required_school_points == 1 ? "" : "s"] in [school?.name || "this school"] first."

	return null

/datum/component/psionic_profile/proc/get_power_tier(datum/psionic_power/power)
	var/power_tier = max(round(power.required_school_points / 2) + 1, 1)
	if(length(power.required_powers))
		for(var/required_power_type in power.required_powers)
			var/datum/psionic_power/required_power = get_psionic_power_for_action(required_power_type)
			if(!required_power || required_power == power)
				continue

			power_tier = max(power_tier, get_power_tier(required_power) + 1)

	return power_tier

/datum/component/psionic_profile/proc/get_power_ui_data(datum/psionic_power/power)
	var/lock_reason = get_power_lock_reason(power)
	var/datum/action/cooldown/psionic/action_type = power.action_type
	return list(
		"action_type" = "[action_type]",
		"name" = power.get_name(),
		"desc" = power.get_desc(),
		"cost" = power.get_cost(),
		"required_school_points" = power.required_school_points,
		"tier" = get_power_tier(power),
		"learned" = (action_type in known_powers),
		"can_buy" = isnull(lock_reason),
		"lock_reason" = lock_reason,
		"icon" = initial(action_type.button_icon),
		"icon_state" = initial(action_type.button_icon_state),
	)

/datum/component/psionic_profile/ui_state(mob/user)
	return GLOB.always_state

/datum/component/psionic_profile/ui_status(mob/user, datum/ui_state/state)
	if(user != psion)
		return UI_CLOSE

	return ..()

/datum/component/psionic_profile/ui_interact(mob/user, datum/tgui/ui)
	if(user != psion)
		return

	decay_strain()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PsionicImprinting", "Psionic Imprinting")
		ui.open()

/datum/component/psionic_profile/ui_data(mob/user)
	decay_strain()
	var/list/data = list()
	data["rank"] = psionic_rank
	data["rank_text"] = get_rank_text()
	data["potential_rank"] = potential_rank
	data["rank_limited"] = rank_limited
	data["available_points"] = available_points
	data["spent_points"] = spent_points
	data["strain"] = round(strain)
	data["max_strain"] = max_strain
	data["schools"] = list()

	var/list/powers_by_school = list()
	for(var/datum/psionic_power/power as anything in get_psionic_power_catalog())
		var/power_school = power.get_school_type()
		if(!power_school)
			continue
		LAZYADD(powers_by_school[power_school], power)

	for(var/school_type in get_psionic_school_catalog())
		var/list/school_powers = powers_by_school[school_type]
		if(!length(school_powers))
			continue

		var/datum/psionic_school/school = get_psionic_school(school_type)
		var/list/power_data = list()
		for(var/datum/psionic_power/power as anything in school_powers)
			power_data += list(get_power_ui_data(power))

		data["schools"] += list(list(
			"id" = "[school_type]",
			"key" = school.ui_key,
			"name" = school.name,
			"desc" = school.desc,
			"spent_points" = get_spent_school_points(school_type),
			"attuned" = is_school_attuned(school_type),
			"strain_discount" = get_school_strain_discount(school_type),
			"icon" = school.ui_icon,
			"icon_state" = school.ui_icon_state,
			"color" = school.ui_color,
			"powers" = power_data,
		))

	return data

/datum/component/psionic_profile/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(ui.user != psion)
		return FALSE

	switch(action)
		if("imprint")
			var/action_type = text2path(params["action_type"])
			var/datum/psionic_power/power = get_psionic_power_for_action(action_type)
			if(!power)
				return FALSE

			return learn_power(action_type)

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
		update_strain_hud()

/datum/component/psionic_profile/proc/try_gain_strain(amount, datum/action/cooldown/psionic/source_action)
	decay_strain()
	amount = get_action_strain_gain(amount, source_action)
	if(amount <= 0)
		return TRUE
	if(is_burned_out())
		to_chat(psion, span_warning("Your mind is still ringing from psionic burnout."))
		return FALSE
	if(strain + amount > max_strain)
		trigger_burnout()
		return FALSE

	strain += amount
	update_strain_hud()
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
	update_strain_hud()
	update_psionic_action_buttons()
	to_chat(psion, span_userdanger("Your psionic focus collapses into static."))
	psion.Knockdown(2 SECONDS)

	if(iscarbon(psion))
		var/mob/living/carbon/carbon_psion = psion
		carbon_psion.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 190)
