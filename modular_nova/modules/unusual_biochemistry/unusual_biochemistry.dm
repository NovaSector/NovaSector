GLOBAL_LIST_INIT(possible_blood_types, list(
	"Haemocyanin" = list("color" = "#3399FF", "chemical" = /datum/reagent/copper::name),
	"Chlorocruorin" = list("color" = "#9FF73B", "chemical" = /datum/reagent/iron::name),
	"Hemerythrin" = list("color" = "#C978DD", "chemical" = /datum/reagent/iron::name),
	"Pinnaglobin" = list("color" = "#CDC020", "chemical" = /datum/reagent/manganese::name),
	"Exotic" = list("color" = "#333333", "chemical" = /datum/reagent/sulfur::name, "blurb" = "This blood color does not appear to exist naturally in nature, but with exposure to sulfur or some other genetic engineering or corruption it might be possible."),
))

/datum/quirk/unusual_biochemistry
	name = "Unusual Biochemistry"
	desc = "Your blood's chemical makeup differs from that of a typical crew member."
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
		blood_color = GLOB.possible_blood_types[blood_type]["color"]
	else
		blood_color = pick(flatten_list(GLOB.possible_blood_types["color"])) // no client/prefs for some reason? pick a random one

	var/mob/living/carbon/human/human_holder = quirk_holder

	// if this is an exotic blood type, sets that up for them
	var/exotic_blood_reagent = exotic_blood_reagents[blood_type]
	if(exotic_blood_reagent)
		human_holder.dna.species.exotic_blood = exotic_blood_reagent
		human_holder.dna.species.exotic_bloodtype = blood_type
	else
		human_holder.dna.species.exotic_blood = null
		human_holder.dna.species.exotic_bloodtype = null

	human_holder.dna.blood_type = get_blood_type_by_name(blood_type)

	// updates the cached organ blood types
	var/list/blood_dna_info = human_holder.get_blood_dna_list()
	for(var/obj/item/organ/organ in human_holder.organs)
		organ.blood_dna_info = blood_dna_info

/datum/preference/choiced/unusual_biochemistry
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "unusual_biochemistry"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/unusual_biochemistry/init_possible_values()
	return assoc_to_keys(GLOB.possible_blood_types)

/datum/preference/choiced/unusual_biochemistry/create_default_value()
	return "Haemocyanin"

/datum/preference/choiced/unusual_biochemistry/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Unusual Biochemistry" in preferences.all_quirks

/datum/preference/choiced/unusual_biochemistry/compile_constant_data()
	var/list/data = ..()

	// An assoc list of values to display names so we don't show players numbers in their settings!
	data["extra_quirk_data"] = GLOB.possible_blood_types

	return data

/datum/preference/choiced/unusual_biochemistry/apply_to_human(mob/living/carbon/human/target, value)
	return
