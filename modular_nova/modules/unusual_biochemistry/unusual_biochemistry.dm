GLOBAL_LIST_INIT(blood_type_to_color, list(
	"Haemocyanin" = "#3399FF",
	"Chlorocruorin" = "#9FF73B",
	"Hemerythrin" = "#C978DD",
	"Pinnaglobin" = "#CDC020",
	"Exotic" = "#333333",
))

/datum/quirk/unusual_biochemistry
	name = "Unusual Biochemistry"
	desc = "You bring your pet to work with you so that it, too, can experience the dangers of station life."
	icon = FA_ICON_DROPLET
	value = 0
	mob_trait = TRAIT_UNUSUAL_BIOCHEMISTRY
	gain_text = span_notice("You have an unusual biochemistry.")
	lose_text = span_danger("Your biochemistry has become... normal.")
	medical_record_text = "Patient possessess an unusual biochemistry. Blood transfusions may require the assistance of a chemist."
	quirk_flags = QUIRK_HUMAN_ONLY
	var/static/list/exotic_blood_reagents = list(
		"Haemocyanin" = /datum/reagent/copper,
		"Pinnaglobin" = /datum/reagent/manganese,
		"Exotic" = /datum/reagent/sulfur,
	)

	/// The unusual blood type chosen by quirk prefs
	var/blood_type
	/// The blood color that corresponds to the chosen blood type
	var/blood_color

/datum/quirk_constant_data/unusual_biochemistry
	associated_typepath = /datum/quirk/unusual_biochemistry
	customization_options = list(/datum/preference/choiced/unusual_biochemistry)

/datum/quirk/unusual_biochemistry/add(client/client_source)
	blood_type = client_source?.prefs.read_preference(/datum/preference/choiced/unusual_biochemistry)
	if(blood_type)
		blood_color = GLOB.blood_type_to_color[blood_type]
	else
		blood_color = pick(flatten_list(GLOB.blood_type_to_color)) // no client/prefs for some reason? pick a random one

	var/mob/living/carbon/human/human_holder = quirk_holder

	// if this is an exotic blood type, sets that up for them
	var/exotic_blood_reagent = exotic_blood_reagents[blood_type]
	if(exotic_blood_reagent)
		human_holder.dna.species.exotic_blood = exotic_blood_reagent
		human_holder.dna.species.exotic_bloodtype = blood_type
	else
		human_holder.dna.blood_type = blood_type
		human_holder.dna.species.exotic_blood = null
		human_holder.dna.species.exotic_bloodtype = null

/// Returns the blood reagent subtype for get_blood_id()
/datum/quirk/unusual_biochemistry/proc/get_blood_type()
	if(blood_type == "Chlorocruorin")
		/datum/reagent/blood/chlorocruorin
	else
		return /datum/reagent/blood/hemerythrin

/datum/preference/choiced/unusual_biochemistry
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "unusual_biochemistry"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/unusual_biochemistry/init_possible_values()
	return assoc_to_keys(GLOB.blood_type_to_color)

/datum/preference/choiced/unusual_biochemistry/create_default_value()
	return "Haemocyanin"

/datum/preference/choiced/unusual_biochemistry/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Unusual Biochemistry" in preferences.all_quirks

/datum/preference/choiced/unusual_biochemistry/apply_to_human(mob/living/carbon/human/target, value)
	return
