/datum/psionic_school
	/// Display name for this school.
	var/name = "Unaligned"
	/// Short description of the school's psionic expression.
	var/desc = "Unaligned."
	/// Primary anomaly type this school resonates with.
	var/obj/effect/anomaly/anomaly_path
	/// Primary anomaly core type this school resonates with.
	var/obj/item/assembly/signaler/anomaly/anomaly_core_path
	/// Additional anomaly variants that should be treated as the same school.
	var/list/related_anomaly_paths
	/// Additional anomaly core variants that should be treated as the same school.
	var/list/related_anomaly_core_paths
	/// Stable TGUI key used for school-specific presentation.
	var/ui_key = "unaligned"
	/// Icon used for the imprinting branch display.
	var/ui_icon = "icons/effects/anomalies.dmi"
	/// Icon state used for the imprinting branch display.
	var/ui_icon_state = "vortex"
	/// Accent color used for the imprinting branch display.
	var/ui_color = "#8dd8ff"

/datum/psionic_school/New()
	. = ..()
	if(!length(related_anomaly_paths) && anomaly_path)
		related_anomaly_paths = list(anomaly_path)
	if(!length(related_anomaly_core_paths) && anomaly_core_path)
		related_anomaly_core_paths = list(anomaly_core_path)

/datum/psionic_school/bioscrambler
	name = "Biomancy"
	desc = "Body, mind, and living patterns."
	anomaly_path = /obj/effect/anomaly/bioscrambler
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/bioscrambler
	ui_key = "bioscrambler"
	ui_icon_state = "bioscrambler"
	ui_color = "#d86fff"

/datum/psionic_school/gravity
	name = "Graviturgy"
	desc = "Mass, inertia, and kinetic pressure."
	anomaly_path = /obj/effect/anomaly/grav
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/grav
	related_anomaly_paths = list(/obj/effect/anomaly/grav, /obj/effect/anomaly/grav/high)
	ui_key = "gravity"
	ui_icon = "icons/effects/effects.dmi"
	ui_icon_state = "shield2"
	ui_color = "#61d878"

/datum/psionic_school/bluespace
	name = "Metakinetics"
	desc = "The space in-between, teleportation, distance."
	anomaly_path = /obj/effect/anomaly/bluespace
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/bluespace
	ui_key = "bluespace"
	ui_icon = "icons/obj/weapons/guns/projectiles.dmi"
	ui_icon_state = "bluespace"
	ui_color = "#3fd6ff"

/datum/psionic_school/flux
	name = "Elementomancy"
	desc = "Flux, matter transitions, energy."
	anomaly_path = /obj/effect/anomaly/flux
	anomaly_core_path = /obj/item/assembly/signaler/anomaly/flux
	ui_key = "flux"
	ui_icon_state = "flux"
	ui_color = "#ffe36b"

/proc/get_psionic_school_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	for(var/school_type in subtypesof(/datum/psionic_school))
		catalog[school_type] = new school_type

	return catalog

/proc/get_psionic_school(school_type)
	if(!ispath(school_type, /datum/psionic_school))
		return null

	return get_psionic_school_catalog()[school_type]

/proc/get_psionic_school_for_anomaly(anomaly_type)
	if(!ispath(anomaly_type, /obj/effect/anomaly))
		return null

	var/list/catalog = get_psionic_school_catalog()
	for(var/school_type in catalog)
		var/datum/psionic_school/school = catalog[school_type]
		for(var/related_anomaly_path in school.related_anomaly_paths)
			if(ispath(anomaly_type, related_anomaly_path))
				return school

	return null

/proc/get_psionic_school_for_anomaly_core(anomaly_core_type)
	if(!ispath(anomaly_core_type, /obj/item/assembly/signaler/anomaly))
		return null

	var/list/catalog = get_psionic_school_catalog()
	for(var/school_type in catalog)
		var/datum/psionic_school/school = catalog[school_type]
		for(var/related_anomaly_core_path in school.related_anomaly_core_paths)
			if(ispath(anomaly_core_type, related_anomaly_core_path))
				return school

	return null

/// Rank variants are immutable configuration, so one shared instance per type serves every action.
/proc/get_psionic_rank_variant_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	for(var/variant_type in subtypesof(/datum/psionic_rank_variant))
		catalog[variant_type] = new variant_type

	return catalog

/proc/get_psionic_rank_variants(list/variant_types)
	var/list/catalog = get_psionic_rank_variant_catalog()
	var/list/variants = list()
	for(var/variant_type in variant_types)
		var/datum/psionic_rank_variant/variant = catalog[variant_type]
		if(variant)
			variants += variant

	return variants

/datum/psionic_power
	/// Points that must already be spent in this power's school before it can be imprinted.
	var/required_school_points = 0
	/// Action type paths that must already be known before this power can be imprinted.
	var/list/required_powers
	/// Action type granted when learned.
	var/datum/action/cooldown/psionic/action_type
	/// Lowest rank among this power's forms, cached at catalog build.
	var/cached_minimum_rank
	/// UI-ready form data (rank, name, description), cached at catalog build.
	var/list/cached_variant_data
	/// Prerequisite depth used to lay the power out in the imprinting tree, cached at catalog build.
	var/cached_tier

/datum/psionic_power/proc/get_name()
	if(!action_type)
		return "Psionic Power"

	return initial(action_type.name)

/datum/psionic_power/proc/get_desc()
	if(!action_type)
		return "A psionic discipline."

	return initial(action_type.desc)

/datum/psionic_power/proc/get_cost()
	if(!action_type)
		return 0

	return max(initial(action_type.point_cost), 0)

/datum/psionic_power/proc/is_lewd()
	if(!action_type)
		return FALSE

	return initial(action_type.lewd)

/datum/psionic_power/proc/get_school_type()
	if(!action_type)
		return null

	return initial(action_type.school)

/datum/psionic_power/proc/get_school()
	var/school_type = get_school_type()
	if(!school_type)
		return null

	return get_psionic_school(school_type)

/datum/psionic_power/proc/get_minimum_rank()
	return cached_minimum_rank

/datum/psionic_power/proc/get_variant_data()
	return cached_variant_data || list()

/datum/psionic_power/proc/get_tier()
	return cached_tier

/// Depth of this power's prerequisite chain. Cycle-safe via [visited_powers].
/datum/psionic_power/proc/calculate_tier(list/visited_powers)
	var/power_tier = max(round(required_school_points / 2) + 1, 1)
	if(!length(required_powers))
		return power_tier

	visited_powers = (visited_powers?.Copy() || list()) + src
	for(var/required_power_type in required_powers)
		var/datum/psionic_power/required_power = get_psionic_power_for_action(required_power_type)
		if(!required_power || (required_power in visited_powers))
			continue

		power_tier = max(power_tier, required_power.calculate_tier(visited_powers) + 1)

	return power_tier

/// Snapshots form metadata from an already-built [action], avoiding per-query action churn.
/// Must run after get_catalog_error() has validated this power.
/datum/psionic_power/proc/build_cache(datum/action/cooldown/psionic/action)
	cached_minimum_rank = null
	cached_variant_data = list()

	var/minimum_rank_level
	for(var/datum/psionic_rank_variant/variant as anything in action.get_rank_variants())
		cached_variant_data += list(list(
			"rank" = variant.rank,
			"name" = variant.get_name(action),
			"description" = variant.get_description(action),
		))
		var/variant_rank_level = get_psionic_rank_level(variant.rank)
		if(isnull(minimum_rank_level) || variant_rank_level < minimum_rank_level)
			cached_minimum_rank = variant.rank
			minimum_rank_level = variant_rank_level

/datum/psionic_power/proc/get_catalog_error(datum/action/cooldown/psionic/action)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return "has no valid psionic action_type"
	if(initial(action_type.point_cost) < 0)
		return "has a negative action point_cost"
	if(!get_school_type())
		return "has no action school"
	if(!get_school())
		return "uses an unknown action school [get_school_type()]"
	if(!length(action.rank_variant_types))
		return "has no action rank variants"
	var/previous_rank_level = 0
	for(var/variant_type in action.rank_variant_types)
		if(!ispath(variant_type, /datum/psionic_rank_variant))
			return "has a non-psionic rank variant [variant_type]"

		// get_selected_rank_variant() treats the last unlocked form as the best one.
		var/datum/psionic_rank_variant/variant = get_psionic_rank_variant_catalog()[variant_type]
		var/variant_rank_level = get_psionic_rank_level(variant.rank)
		if(variant_rank_level < previous_rank_level)
			return "lists rank variant [variant_type] out of ascending rank order"
		previous_rank_level = variant_rank_level
	if(length(required_powers))
		for(var/required_power_type in required_powers)
			if(!ispath(required_power_type, /datum/action/cooldown/psionic))
				return "has a non-psionic required power [required_power_type]"

			// A lewd prerequisite of a non-lewd power would leave a visible node with an invisible parent
			// in the imprinting tree of a psion whose ERP preference hides lewd powers.
			var/datum/action/cooldown/psionic/required_action_type = required_power_type
			if(!is_lewd() && initial(required_action_type.lewd))
				return "is a non-lewd power with lewd prerequisite [required_power_type]"

	return null

/proc/get_psionic_power_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	var/list/cataloged_actions = list()
	for(var/power_type in subtypesof(/datum/psionic_power))
		var/datum/psionic_power/power = new power_type
		var/datum/action/cooldown/psionic/action = ispath(power.action_type, /datum/action/cooldown/psionic) ? new power.action_type : null
		var/catalog_error = power.get_catalog_error(action)
		if(!catalog_error && cataloged_actions[power.action_type])
			catalog_error = "duplicates psionic action [power.action_type]"
		if(catalog_error)
			stack_trace("[power.type] [catalog_error].")
			qdel(action)
			qdel(power)
			continue

		cataloged_actions[power.action_type] = TRUE
		power.build_cache(action)
		qdel(action)
		catalog += power

	for(var/datum/psionic_power/power as anything in catalog)
		power.cached_tier = power.calculate_tier()

	return catalog

/proc/get_psionic_power_for_action(action_type)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return null

	var/static/list/powers_by_action_type
	if(isnull(powers_by_action_type))
		powers_by_action_type = list()
		for(var/datum/psionic_power/power as anything in get_psionic_power_catalog())
			powers_by_action_type[power.action_type] = power

	return powers_by_action_type[action_type]
