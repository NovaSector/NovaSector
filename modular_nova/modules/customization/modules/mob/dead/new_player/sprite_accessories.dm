// GLOBAL_LIST_EMPTY(cached_mutant_icon_files)

/// The flag to show that snouts should use the muzzled sprite.
#define SPRITE_ACCESSORY_USE_MUZZLED_SPRITE (1<<0)
/// The flag to show that this tail sprite can wag.
#define SPRITE_ACCESSORY_WAG_ABLE (1<<1)
/// The flag that controls whether or not this sprite accessory should force the wearer to hide its shoes.
#define SPRITE_ACCESSORY_HIDE_SHOES (1<<2)
/// The flag to that controls whether or not this sprite accessory should force worn facewear to use layers 5 (for glasses) and 4 (for masks and hats).
#define SPRITE_ACCESSORY_USE_ALT_FACEWEAR_LAYER (1<<3)

/datum/sprite_accessory
	///Unique key of an accessory. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	///You can also put down a a HEX color, to be used instead as the default
	var/default_color
	///Set this to a name, then the accessory will be shown in preferences, if a species can have it. Most accessories have this
	///Notable things that have it set to FALSE are things that need special setup, such as genitals
	var/generic

	/// Whether or not this sprite accessory has an additional overlay added to
	/// it as an "inner" part, which is pre-colored.
	var/has_inner = FALSE

	/// For all the flags that you need to pass from a sprite_accessory to an organ, when it's linked to one.
	/// (i.e. passing through the fact that a snout should or shouldn't use a muzzled sprite for head worn items)
	var/flags_for_organ = NONE

	color_src = USE_ONE_COLOR

	///Which layers does this accessory affect
	var/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER, BODY_FRONT_UNDER_CLOTHES, ABOVE_BODY_FRONT_HEAD_LAYER)

	///This is used to determine whether an accessory gets added to someone. This is important for accessories that are "None", which should have this set to false
	var/factual = TRUE

	///Use this as a type path to an organ that this sprite_accessory will be associated. Make sure the organ has 'mutantpart_info' set properly.
	var/obj/item/organ/organ_type

	///Set this to true to make an accessory appear as color customizable in preferences despite advanced color settings being off, will also prevent the accessory from being reset
	var/always_color_customizable
	///Special case of whether the accessory should be shifted in the X dimension, check taur genitals for example
	var/special_x_dimension
	///Special case for MODsuit overlays
	var/use_custom_mod_icon
	///If defined, the accessory will be only available to ckeys inside the list. ITS ASSOCIATIVE, ie. ("ckey" = TRUE). For speed
	var/list/ckey_whitelist
	///Whether this feature is genetic, and thus modifiable by DNA consoles
	var/genetic = FALSE
	var/uses_emissives = FALSE
	var/color_layer_names
	/// If this sprite accessory will be inaccessable if ERP config is disabled
	var/erp_accessory = FALSE
	// If this sprite accessory should use something other than the feature_key to decide its sprite key
	// For example, if TG has it different in their icon files (e.g. "_fish_tail_" instead of "_tail_")
	// This should hopefully prevent the need to copy paste TG icons into tails.dmi
	var/feature_key_override

/datum/sprite_accessory/New()
	if(!default_color)
		switch(color_src)
			if(USE_ONE_COLOR)
				default_color = DEFAULT_PRIMARY
			if(USE_MATRIXED_COLORS)
				default_color = DEFAULT_MATRIXED
			else
				default_color = "#FFFFFF"
	if(name == SPRITE_ACCESSORY_NONE)
		factual = FALSE
	if(color_src == USE_MATRIXED_COLORS && default_color != DEFAULT_MATRIXED)
		default_color = DEFAULT_MATRIXED
	if (color_src == USE_MATRIXED_COLORS)
		color_layer_names = list()
		if (!SSaccessories.cached_mutant_icon_files[icon])
			SSaccessories.cached_mutant_icon_files[icon] = icon_states(new /icon(icon))
		for (var/layer in relevent_layers)
			var/layertext = layer == BODY_BEHIND_LAYER ? "BEHIND" : (layer == BODY_ADJ_LAYER ? "ADJ" : "FRONT")
			if ("m_[key]_[icon_state]_[layertext]_primary" in SSaccessories.cached_mutant_icon_files[icon])
				color_layer_names["1"] = "primary"
			if ("m_[key]_[icon_state]_[layertext]_secondary" in SSaccessories.cached_mutant_icon_files[icon])
				color_layer_names["2"] = "secondary"
			if ("m_[key]_[icon_state]_[layertext]_tertiary" in SSaccessories.cached_mutant_icon_files[icon])
				color_layer_names["3"] = "tertiary"

/datum/sprite_accessory/proc/is_hidden(mob/living/carbon/human/owner)
	return FALSE

/datum/sprite_accessory/proc/get_special_icon(mob/living/carbon/human/H, passed_state)
	return icon

/datum/sprite_accessory/proc/get_special_x_dimension(mob/living/carbon/human/H, passed_state)
	return 0

// A proc for accessories which have 'use_custom_mod_icon' set to TRUE
/datum/sprite_accessory/proc/get_custom_mod_icon(mob/living/carbon/human/owner, mutable_appearance/appearance_to_use = null)
	return null

/datum/sprite_accessory/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = list(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = list(features["mcolor3"])
		if(DEFAULT_MATRIXED)
			colors = list(features["mcolor"], features["mcolor2"], features["mcolor3"])
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && !(TRAIT_USES_SKINTONES in pref_species.inherent_traits))
				colors = list(features["skin_color"])
			else
				colors = list(features["mcolor"])
		else
			colors = list(default_color)

	return colors

/datum/sprite_accessory/moth_markings
	key = "moth_markings"
	generic = "Moth markings"
	// organ_type = /obj/item/organ/moth_markings // UNCOMMENT THIS IF THEY EVER FIX IT UPSTREAM, CAN'T BE BOTHERED TO FIX IT MYSELF

/datum/sprite_accessory/moth_markings/is_hidden(mob/living/carbon/human/owner)
	return FALSE

/datum/sprite_accessory/moth_markings/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/pod_hair
	icon = 'modular_nova/master_files/icons/mob/species/podperson_hair.dmi'
	key = "pod_hair"
	recommended_species = list(SPECIES_PODPERSON, SPECIES_PODPERSON_WEAK)
	organ_type = /obj/item/organ/pod_hair

/datum/sprite_accessory/pod_hair/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE

/datum/sprite_accessory/caps
	key = "caps"
	generic = "Caps"
	icon = 'icons/mob/human/species/mush_cap.dmi'
	relevent_layers = list(BODY_ADJ_LAYER)
	color_src = USE_ONE_COLOR
	organ_type = /obj/item/organ/mushroom_cap
	genetic = TRUE

/datum/sprite_accessory/caps/is_hidden(mob/living/carbon/human/human)
	if(((human.head?.flags_inv & HIDEHAIR) || (human.wear_mask?.flags_inv & HIDEHAIR)) || (key in human.try_hide_mutant_parts))
		return TRUE

	return FALSE

/datum/sprite_accessory/caps/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/caps/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/lizard_markings
	key = "body_markings"
	generic = "Body Markings"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/lizard_markings/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/// Legs are a special case, they aren't actually sprite_accessories but are updated with them.
/// These datums exist for selecting legs on preference, and little else
/datum/sprite_accessory/legs
	icon = null
	em_block = TRUE
	key = "legs"
	color_src = null
	genetic = TRUE

/datum/sprite_accessory/legs/none
	name = NORMAL_LEGS

/datum/sprite_accessory/legs/digitigrade_lizard
	name = DIGITIGRADE_LEGS
