/*
*	LOADOUT ITEM DATUMS FOR THE ACCESSORY SLOT
*/

/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/accessories
	category_ui_icon = FA_ICON_ID_BADGE
	tab_order = /datum/loadout_category/undersuit::tab_order + 1


/datum/loadout_item/accessory/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, visuals_only = FALSE)
	if(initial(outfit_important_for_life.accessory))
		.. ()
		return TRUE

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.accessory)
			LAZYADD(outfit.backpack_contents, outfit.accessory)
		outfit.accessory = item_path
	else
		outfit.accessory = item_path


/datum/loadout_item/accessory/ribbon
	name = "Ribbon"
	item_path = /obj/item/clothing/accessory/medal/ribbon

/datum/loadout_item/accessory/wetmaker
	name = "Stardress hydro-vaporizer"
	item_path = /obj/item/clothing/accessory/vaporizer

/*
*	ARMBANDS
*/

/datum/loadout_item/accessory/armband_medblue
	name = "Blue-White Armband"
	item_path = /obj/item/clothing/accessory/armband/medblue/nonsec

/datum/loadout_item/accessory/armband_med
	name = "White Armband"
	item_path = /obj/item/clothing/accessory/armband/med/nonsec

/datum/loadout_item/accessory/armband_cargo
	name = "Brown Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo/nonsec

/datum/loadout_item/accessory/armband_engineering
	name = "Orange Armband"
	item_path = /obj/item/clothing/accessory/armband/engine/nonsec

/datum/loadout_item/accessory/armband_security_nonsec
	name = "Blue Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland/nonsec

/datum/loadout_item/accessory/armband_security
	name = "Security Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/holobadge
	name = "Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/holobadge/lanyard
	name = "Holobadge with Lanyard"
	item_path = /obj/item/clothing/accessory/badge/holo/cord
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/armband_security_deputy
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband_science
	name = "Purple Armband"
	item_path = /obj/item/clothing/accessory/armband/science/nonsec

/datum/loadout_item/accessory/green_pin
	name = "Green Pin"
	item_path = /obj/item/clothing/accessory/green_pin

/*
*	ARMOURLESS
*/

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talisman"
	item_path = /obj/item/clothing/accessory/talisman/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/skullcodpiece/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/sinew_kilt
	name = "Heirloom Sinew Skirt"
	item_path = /obj/item/clothing/accessory/skilt/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)
