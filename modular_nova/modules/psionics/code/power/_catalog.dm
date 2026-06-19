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
	name = "Bluespace Conjuration"
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

/proc/get_psionic_school_for_anomaly_source(anomaly_source_type)
	var/datum/psionic_school/school = get_psionic_school_for_anomaly(anomaly_source_type)
	if(school)
		return school

	return get_psionic_school_for_anomaly_core(anomaly_source_type)

/datum/psionic_power
	/// Points that must already be spent in this power's school before it can be imprinted.
	var/required_school_points = 0
	/// Action type paths that must already be known before this power can be imprinted.
	var/list/required_powers
	/// Action type granted when learned.
	var/datum/action/cooldown/psionic/action_type

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

/datum/psionic_power/proc/get_school_type()
	if(!action_type)
		return null

	return initial(action_type.school)

/datum/psionic_power/proc/get_school()
	var/school_type = get_school_type()
	if(!school_type)
		return null

	return get_psionic_school(school_type)

/datum/psionic_power/proc/get_school_name()
	var/datum/psionic_school/resonance_school = get_school()
	if(!resonance_school)
		return "Unaligned"

	return resonance_school.name

/datum/psionic_power/proc/get_minimum_rank()
	if(!action_type)
		return null

	var/list/action_rank_variant_types = initial(action_type.rank_variant_types)
	if(!length(action_rank_variant_types))
		return null

	var/minimum_rank
	var/minimum_rank_level
	for(var/variant_type in action_rank_variant_types)
		if(!ispath(variant_type, /datum/psionic_rank_variant))
			continue

		var/datum/psionic_rank_variant/variant = new variant_type
		var/variant_rank = variant.rank
		qdel(variant)
		var/variant_rank_level = get_psionic_rank_level(variant_rank)
		if(!variant_rank_level)
			continue
		if(isnull(minimum_rank_level) || variant_rank_level < minimum_rank_level)
			minimum_rank = variant_rank
			minimum_rank_level = variant_rank_level

	return minimum_rank

/datum/psionic_power/proc/get_catalog_error()
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return "has no valid psionic action_type"
	if(initial(action_type.point_cost) < 0)
		return "has a negative action point_cost"
	if(!get_school_type())
		return "has no action school"
	if(!get_school())
		return "uses an unknown action school [get_school_type()]"
	if(length(required_powers))
		for(var/required_power_type in required_powers)
			if(!ispath(required_power_type, /datum/action/cooldown/psionic))
				return "has a non-psionic required power [required_power_type]"

	return null

/proc/get_psionic_power_catalog()
	var/static/list/catalog
	if(catalog)
		return catalog

	catalog = list()
	var/list/cataloged_actions = list()
	for(var/power_type in subtypesof(/datum/psionic_power))
		var/datum/psionic_power/power = new power_type
		var/catalog_error = power.get_catalog_error()
		if(catalog_error)
			stack_trace("[power.type] [catalog_error].")
			qdel(power)
			continue
		if(cataloged_actions[power.action_type])
			stack_trace("[power.type] duplicates psionic action [power.action_type].")
			qdel(power)
			continue
		cataloged_actions[power.action_type] = TRUE
		catalog += power

	return catalog

/proc/get_psionic_power_for_action(action_type)
	if(!ispath(action_type, /datum/action/cooldown/psionic))
		return null

	for(var/datum/psionic_power/power as anything in get_psionic_power_catalog())
		if(power.action_type == action_type)
			return power

	return null
