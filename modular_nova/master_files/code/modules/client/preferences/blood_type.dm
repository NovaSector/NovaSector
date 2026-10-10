/datum/preference/choiced/blood_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "blood_type"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODYPARTS // Apply after species, cause that's super important.

// Values are the blood types' names rather than their typepaths, as choiced preferences are
// serialized to the savefile (and sent to the UI) as text. get_blood_type() keys off the same names.
/datum/preference/choiced/blood_type/init_possible_values()
	return list(
		/datum/blood_type/human/o_minus::name,
		/datum/blood_type/human/o_plus::name,
		/datum/blood_type/human/a_minus::name,
		/datum/blood_type/human/a_plus::name,
		/datum/blood_type/human/b_minus::name,
		/datum/blood_type/human/b_plus::name,
		/datum/blood_type/human/ab_minus::name,
		/datum/blood_type/human/ab_plus::name,
	)

/datum/preference/choiced/blood_type/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	if(/datum/quirk/unusual_biochemistry::name in preferences.all_quirks)
		return FALSE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	return isnull(initial(species.exotic_bloodtype))

/datum/preference/choiced/blood_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/datum/preference/choiced/blood_type/blood_type_pref = GLOB.preference_entries[/datum/preference/choiced/blood_type]
	if(!blood_type_pref.is_accessible(preferences))
		return
	target.set_blood_type(value)
