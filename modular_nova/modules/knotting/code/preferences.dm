/// Abstract base for knotting prefs.
/datum/preference/toggle/knotting
	abstract_type = /datum/preference/toggle/knotting

/datum/preference/toggle/knotting/is_accessible(datum/preferences/preferences)
	if(!..(preferences))
		return FALSE
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/toggle/knotting/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	return ..()

/datum/preference/toggle/knotting/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/// Whether this character can knot a partner after climax.
/datum/preference/toggle/knotting/has_knot
	category = PREFERENCE_CATEGORY_ERP
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "has_knot"
	default_value = FALSE

/datum/preference/toggle/knotting/has_knot/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE
	var/penis_choice = preferences.read_preference(/datum/preference/choiced/genital/penis)
	var/datum/preference/choiced/genital/penis/penis_choice_pref = GLOB.preference_entries[/datum/preference/choiced/genital/penis]
	return penis_choice_pref.is_accessible(preferences) && is_factual_sprite_accessory(ORGAN_SLOT_PENIS, penis_choice)

/datum/preference/toggle/knotting/has_knot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(value)
		var/penis_choice = preferences.read_preference(/datum/preference/choiced/genital/penis)
		var/datum/preference/choiced/genital/penis/penis_choice_pref = GLOB.preference_entries[/datum/preference/choiced/genital/penis]
		if(!penis_choice_pref.is_accessible(preferences) || !is_factual_sprite_accessory(ORGAN_SLOT_PENIS, penis_choice))
			return
		ADD_TRAIT(target, TRAIT_CAN_KNOT, ROUNDSTART_TRAIT)
	else
		REMOVE_TRAIT(target, TRAIT_CAN_KNOT, ROUNDSTART_TRAIT)

/// Whether characters with knots can knot this character.
/datum/preference/toggle/knotting/receive
	category = PREFERENCE_CATEGORY_ERP
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "knotting_receive"
	default_value = FALSE
