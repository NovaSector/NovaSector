/datum/preference/choiced/unusual_biochemistry
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "unusual_biochemistry"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/unusual_biochemistry/init_possible_values()
	var/list/possible_blood_types = list()
	for(var/datum/blood_type/blood_type as anything in GLOB.possible_unusual_biochem_blood_types)
		possible_blood_types += blood_type::name
	return possible_blood_types

/datum/preference/choiced/unusual_biochemistry/create_default_value()
	return "Haemocyanin"

/datum/preference/choiced/unusual_biochemistry/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Unusual Biochemistry" in preferences.all_quirks

/datum/preference/choiced/unusual_biochemistry/compile_constant_data()
	var/list/data = ..()

	var/list/blood_type_data = list()
	for(var/datum/blood_type/blood_type as anything in GLOB.possible_unusual_biochem_blood_types)
		blood_type_data[blood_type::name] = list(
			"color" = blood_type::color,
			"chemical" = blood_type::restoration_chem::name,
			"blurb" = blood_type::desc,
		)

	data["extra_quirk_data"] = blood_type_data

	return data

/datum/preference/choiced/unusual_biochemistry/apply_to_human(mob/living/carbon/human/target, value)
	return
