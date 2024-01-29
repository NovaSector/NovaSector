/datum/quirk/equipping/entombed
	name = "Entombed"
	desc = "You are permanently fused to (or otherwise reliant on) a single MOD unit that can never be removed from your person. If it runs out of charge, you'll start to die!"
	gain_text = span_warning("Your exosuit is both prison and home.")
	lose_text = span_notice("At last, you're finally free from that horrible exosuit.")
	medical_record_text = "Patient is physiologically reliant on a MOD unit for homeostasis. Do not attempt removal."
	value = 0
	icon = FA_ICON_SUITCASE
	forced_items = list(/obj/item/mod/control/pre_equipped/entombed = list(ITEM_SLOT_BACK))
	/// The modsuit we're stuck in
	var/obj/item/mod/control/pre_equipped/entombed/modsuit

/datum/quirk/equipping/entombed/add_unique(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (istype(human_holder.back, /obj/item/mod/control/pre_equipped/entombed))
		modsuit = human_holder.back // link this up to the quirk for easy access

	if (isnull(modsuit))
		return

	// set all of our customization stuff from prefs, if we have it
	var/modsuit_skin = client_source?.prefs.read_preference(/datum/preference/choiced/entombed_skin)

	if (modsuit_skin == NONE)
		modsuit_skin = "civilian"

	modsuit.skin = lowertext(modsuit_skin)

	var/modsuit_name = client_source?.prefs.read_preference(/datum/preference/text/entombed_mod_name)
	if (modsuit_name)
		modsuit.name = modsuit_name

	var/modsuit_desc = client_source?.prefs.read_preference(/datum/preference/text/entombed_mod_desc)
	if (modsuit_desc)
		modsuit.desc = modsuit_desc

	var/modsuit_skin_prefix = client_source?.prefs.read_preference(/datum/preference/text/entombed_mod_prefix)
	if (modsuit_skin_prefix)
		modsuit.theme.name = lowertext(modsuit_skin_prefix)

	// quickly deploy it on roundstart
	modsuit.quick_activation()
	// lower the helmet for style points and also to make chargen less annoying
	var/obj/item/clothing/head/mod/helmet = locate() in modsuit.mod_parts
	modsuit.retract(human_holder, helmet)

	// deploy specific racial features - ethereals get ethereal cores, plasmamen get free plasma stabilizer module
	if (isethereal(human_holder))
		var/obj/item/mod/core/ethereal/eth_core = new
		eth_core.install(modsuit)
	else if (isplasmaman(human_holder))
		var/obj/item/mod/module/plasma_stabilizer/entombed/plasma_stab = new
		modsuit.install(plasma_stab, human_holder)

/datum/quirk/equipping/entombed/remove()
	QDEL_NULL(modsuit)

/datum/quirk_constant_data/entombed
	associated_typepath = /datum/quirk/equipping/entombed
	customization_options = list(/datum/preference/choiced/entombed_skin, /datum/preference/text/entombed_mod_name, /datum/preference/text/entombed_mod_desc, /datum/preference/text/entombed_mod_prefix)

/datum/preference/choiced/entombed_skin
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "entombed_skin"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/choiced/entombed_skin/init_possible_values()
	return list(
		"Standard",
		"Civilian",
		"Colonist",
		"Engineering",
		"Atmospheric",
		"Advanced",
		"Mining",
		"Loader",
		"Medical",
		"Rescue",
		"Security",
		"Cosmohonk",
		"Interdyne",
		"Prototype",
	)

/datum/preference/choiced/entombed_skin/create_default_value()
	return "Civilian"

/datum/preference/choiced/entombed_skin/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Entombed" in preferences.all_quirks

/datum/preference/choiced/entombed_skin/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/entombed_mod_name
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "entombed_mod_name"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 32

/datum/preference/text/entombed_mod_name/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Entombed" in preferences.all_quirks

/datum/preference/text/entombed_mod_name/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/entombed_mod_name/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/entombed_mod_desc
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "entombed_mod_desc"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/text/entombed_mod_desc/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Entombed" in preferences.all_quirks

/datum/preference/text/entombed_mod_desc/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/entombed_mod_desc/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/entombed_mod_prefix
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "entombed_mod_prefix"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 16

/datum/preference/text/entombed_mod_prefix/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Entombed" in preferences.all_quirks

/datum/preference/text/entombed_mod_prefix/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/entombed_mod_prefix/create_default_value()
	return "Fused"

/datum/preference/text/entombed_mod_prefix/apply_to_human(mob/living/carbon/human/target, value)
	return
