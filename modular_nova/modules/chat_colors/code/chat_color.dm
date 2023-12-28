/datum/preference/color/chat_color
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ic_chat_color"

/datum/preference/color/chat_color/apply_to_human(mob/living/carbon/human/target, value)
	var/target_color = process_chat_color(value)
	target.chat_color = target_color
	target.chat_color_darkened = target_color
	target.chat_color_name = target.name
	return

/datum/preference/color/chat_color/deserialize(input, datum/preferences/preferences)
	return process_chat_color(input)

/datum/preference/color/chat_color/create_default_value()
	return process_chat_color(random_color())

/datum/preference/color/chat_color/serialize(input)
	return process_chat_color(input)
