/datum/preference/choiced/blood_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "blood_type"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODYPARTS // Apply after species, cause that's super important.

/datum/preference/choiced/blood_type/init_possible_values()
	return list(
		BLOOD_TYPE_O_MINUS,
		BLOOD_TYPE_O_PLUS,
		BLOOD_TYPE_A_MINUS,
		BLOOD_TYPE_A_PLUS,
		BLOOD_TYPE_B_MINUS,
		BLOOD_TYPE_B_PLUS,
		BLOOD_TYPE_AB_MINUS,
		BLOOD_TYPE_AB_PLUS,
	)
/datum/preference/choiced/blood_type/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	if("Unusual Biochemistry" in preferences.all_quirks)
		return FALSE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(species::exotic_bloodtype)
		return FALSE

	return TRUE

/datum/preference/choiced/blood_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/datum/preference/choiced/species/species_pref = GLOB.preference_entries[/datum/preference/choiced/blood_type]
	if(!species_pref.is_accessible(preferences))
		return
	target.set_blood_type(value)
