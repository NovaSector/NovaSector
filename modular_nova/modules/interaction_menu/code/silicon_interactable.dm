/// Cyborgs do not have genital organs, but can opt into lewd interaction slots.
/mob/living/silicon/robot
	var/list/simulated_genitals = list(
		ORGAN_SLOT_PENIS = FALSE,
		ORGAN_SLOT_VAGINA = FALSE,
		ORGAN_SLOT_BREASTS = FALSE,
		ORGAN_SLOT_ANUS = FALSE,
	)

/mob/living/silicon/robot/has_interaction_part(organ_slot)
	return has_erp_interactions_enabled() && !!simulated_genitals[organ_slot]

/mob/living/silicon/robot/proc/has_erp_interactions_enabled()
	return !!client?.prefs?.read_preference(/datum/preference/toggle/erp)

/mob/living/silicon/robot/proc/get_simulated_interaction_parts()
	if(!has_erp_interactions_enabled())
		return list()

	var/list/parts = list()
	for(var/organ_slot in simulated_genitals)
		parts += list(list(
			"name" = organ_slot,
			"active" = simulated_genitals[organ_slot],
		))
	return parts

/mob/living/silicon/robot/proc/toggle_simulated_interaction_part(organ_slot)
	if(!has_erp_interactions_enabled() || !organ_slot || !(organ_slot in simulated_genitals))
		return FALSE

	simulated_genitals[organ_slot] = !simulated_genitals[organ_slot]
	return TRUE
