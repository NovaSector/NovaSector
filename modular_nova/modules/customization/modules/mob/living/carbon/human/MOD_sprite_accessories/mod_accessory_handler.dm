/// Creates a masked icon for sprite accessories which have 'use_custom_mod_icon' set to TRUE
/datum/sprite_accessory/proc/get_custom_mod_icon(mob/living/carbon/human/owner, mutable_appearance/appearance_to_use = null)
	if(!use_custom_mod_icon)
		return null

	if(!mod_overlay_active(owner))
		return null
	if(isnull(appearance_to_use))
		return null // No source image -> nothing to blend. Callers composite per-pass.
	var/obj/item/mod/control/modsuit_control = owner.back
	var/datum/mod_theme/mod_theme = modsuit_control.theme

	var/index = "[appearance_to_use.icon]-[appearance_to_use.icon_state]-[mod_theme.hardlight_theme]"
	var/static/list/mod_icon_cache = list()
	var/icon/special_icon = mod_icon_cache[index]
	if(!special_icon)
		special_icon = icon(appearance_to_use.icon, appearance_to_use.icon_state)
		var/icon/MOD_texture = icon('modular_nova/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi', "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		special_icon = fcopy_rsc(special_icon)
		mod_icon_cache[index] = special_icon

	return icon(special_icon)

/// Checks that this accessory should be affected by a hardlight MOD overlay.
/// The default behavior is to check for an active MOD and the chestplate being deployed.
/datum/sprite_accessory/proc/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_chestplate(wearer)

/datum/sprite_accessory/ears/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/horns/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/skrell_hair/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/antenna/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/moth_antennae/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/caps/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/frills/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/head_accessory/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/neck_accessory/mod_overlay_active(mob/living/carbon/human/wearer)
	return has_active_mod_and_helmet(wearer)

/datum/sprite_accessory/proc/has_active_mod_and_helmet(mob/living/carbon/human/wearer)
	return (wearing_active_mod(wearer) && wearing_mod_helmet(wearer))

/datum/sprite_accessory/proc/has_active_mod_and_chestplate(mob/living/carbon/human/wearer)
	return (wearing_active_mod(wearer) && wearing_mod_chestplate(wearer))

/// Checks that a MOD control unit on the wearer is active or activating and has a hardlight theme
/datum/sprite_accessory/proc/wearing_active_mod(mob/living/carbon/human/wearer)
	var/obj/item/mod/control/modsuit_control = wearer?.back
	if(!istype(modsuit_control))
		return FALSE
	return (modsuit_control.active || modsuit_control.activating) && modsuit_control.theme?.hardlight

/datum/sprite_accessory/proc/wearing_mod_chestplate(mob/living/carbon/human/wearer)
	return (istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))

/datum/sprite_accessory/proc/wearing_mod_helmet(mob/living/carbon/human/wearer)
	return (istype(wearer?.head, /obj/item/clothing/head/mod))

/// The hardlight theme string, for use in the render cache key - so we don't get any color collisions
/datum/sprite_accessory/proc/get_hardlight_theme_key(mob/living/carbon/human/wearer)
	if(!istype(wearer?.wear_suit, /obj/item/clothing/suit/mod))
		return ""
	var/obj/item/mod/control/modsuit_control = wearer.back
	if(!istype(modsuit_control))
		return ""
	return "[modsuit_control.theme?.hardlight_theme]"
