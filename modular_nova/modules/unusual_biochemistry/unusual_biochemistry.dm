GLOBAL_LIST_INIT(possible_blood_types, list(
	/datum/blood_type/haemocyanin,
	/datum/blood_type/chlorocruorin,
	/datum/blood_type/hemerythrin,
	/datum/blood_type/pinnaglobin,
	/datum/blood_type/exotic,
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
	var/static/list/exotic_blood_reagents = list()

	/// The unusual blood type chosen by quirk prefs
	var/blood_type
	/// The blood color that corresponds to the chosen blood type
	var/blood_color

/datum/quirk_constant_data/unusual_biochemistry
	associated_typepath = /datum/quirk/unusual_biochemistry
	customization_options = list(/datum/preference/choiced/unusual_biochemistry)

/datum/quirk/unusual_biochemistry/add(client/client_source)
	blood_type = client_source?.prefs.read_preference(/datum/preference/choiced/unusual_biochemistry)
	var/datum/blood_type/blood_type_datum = get_blood_type(blood_type)
	if(blood_type_datum)
		blood_color = blood_type_datum.color
	else
		blood_type_datum = get_blood_type(pick(GLOB.possible_blood_types)) // no client/prefs for some reason? pick a random one
		blood_color = blood_type_datum.color

	var/mob/living/carbon/human/human_holder = quirk_holder

	// if this is an exotic blood type, sets that up for them
	var/exotic_blood_reagent = exotic_blood_reagents[blood_type]
	if(exotic_blood_reagent)
		human_holder.dna.species.exotic_blood = exotic_blood_reagent
		human_holder.dna.species.exotic_bloodtype = blood_type
	else
		human_holder.dna.species.exotic_blood = null
		human_holder.dna.species.exotic_bloodtype = null

	human_holder.dna.blood_type = blood_type_datum

	// Redo the mail goodies if we somehow got blood deficiency added first
//	var/datum/quirk/blooddeficiency/blood_deficiency_quirk = quirk_holder.get_quirk(/datum/quirk/blooddeficiency)
//	if(istype(blood_deficiency_quirk))
//		blood_deficiency_quirk.update_mail(new_species = human_holder.dna.species)

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
	var/list/possible_blood_types = list()
	for(var/datum/blood_type/blood_type as anything in GLOB.possible_blood_types)
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
	for(var/datum/blood_type/blood_type as anything in GLOB.possible_blood_types)
		blood_type_data[blood_type::name] = list(
			"color" = blood_type::color,
			"chemical" = blood_type::restoration_chem::name,
			"blurb" = blood_type::desc,
		)

	data["extra_quirk_data"] = blood_type_data

	return data

/datum/preference/choiced/unusual_biochemistry/apply_to_human(mob/living/carbon/human/target, value)
	return
