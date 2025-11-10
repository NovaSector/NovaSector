/// Level xp we give or remove with this quirk
#define SKILLED_QUIRK_SKILL_LEVEL SKILL_LEVEL_EXPERT
/// Skills we dont want to be selectable for our quirk
#define SKILLED_QUIRK_SKILLS_BLACKLIST list( \
	/datum/skill/language, \
)
GLOBAL_LIST_INIT(skill_choices, init_skill_choices())

/proc/init_skill_choices()
	. = list()
	for (var/datum/skill/skill as anything in subtypesof(/datum/skill))
		if(skill in SKILLED_QUIRK_SKILLS_BLACKLIST)
			continue
		.[initial(skill.name)] = skill

/datum/quirk/skilled
	name = "Skilled"
	desc = "Before working on this station you honed your skill to a level far above that of an average spaceman. Now you can use your knowledge for the greater good. Or just boast about it."
	medical_record_text = "Patient keeps stating the fact they are a top professional even if it is not related to a checkup."
	icon = FA_ICON_USER_PLUS
	value = 4
	gain_text = span_notice("You feel professional.")
	lose_text = span_notice("You no longer feel professional.")
	quirk_flags = QUIRK_HIDE_FROM_SCAN

/datum/quirk_constant_data/skilled
	associated_typepath = /datum/quirk/skilled
	customization_options = list(/datum/preference/choiced/skilled)

/datum/quirk/skilled/add(client/client_source)
	var/datum/mind/holder_mind = quirk_holder.mind

	var/our_skill = client_source?.prefs?.read_preference(/datum/preference/choiced/skilled)
	holder_mind?.adjust_experience(GLOB.skill_choices[our_skill], SKILL_EXP_LIST[SKILLED_QUIRK_SKILL_LEVEL])

/datum/preference/choiced/skilled
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "skilled_quirk"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/skilled/init_possible_values()
	return assoc_to_keys(GLOB.skill_choices)

/datum/preference/choiced/skilled/create_default_value()
	return "Smithing"

/datum/preference/choiced/skilled/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Skilled" in preferences.all_quirks

/datum/preference/choiced/skilled/apply_to_human(mob/living/carbon/human/target, value)
	return

#undef SKILLED_QUIRK_SKILL_LEVEL
#undef SKILLED_QUIRK_SKILLS_BLACKLIST
