// Tail hardlight
/datum/sprite_accessory/tails
	use_custom_mod_icon = TRUE

// Ears hardlight
/datum/sprite_accessory/ears
	use_custom_mod_icon = TRUE

// Wings hardlight
/datum/sprite_accessory/wings
	use_custom_mod_icon = TRUE

// Antennae hardlight
/datum/sprite_accessory/moth_antennae
	use_custom_mod_icon = TRUE

// IPC Antennae hardlight
/datum/sprite_accessory/antenna
	use_custom_mod_icon = TRUE

// Horns hardlight
/datum/sprite_accessory/horns
	use_custom_mod_icon = TRUE

// Taur hardlight
/datum/sprite_accessory/taur
	use_custom_mod_icon = TRUE

// Lizard spines hardlight
/datum/sprite_accessory/spines
	use_custom_mod_icon = TRUE

// Xenodorsal hardlight
/datum/sprite_accessory/xenodorsal
	use_custom_mod_icon = TRUE

// Skrell hair hardlight
/datum/sprite_accessory/skrell_hair
	use_custom_mod_icon = TRUE

/// Is this accessory currently under an active hardlight MOD overlay? Used for determining if we should apply a mod overlay to a bodypart
/datum/sprite_accessory/proc/mod_overlay_active(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return FALSE
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return FALSE
	return (modsuit_control.active || modsuit_control.activating) && modsuit_control.theme?.hardlight

/// The hardlight theme string, for use in the render cache key - so we don't get any color collisions
/datum/sprite_accessory/proc/get_hardlight_theme_key(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return ""
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return ""
	return "[modsuit_control.theme?.hardlight_theme]"
