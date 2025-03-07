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

/*
*
* Accessory Medals
*
*/
/datum/loadout_item/accessory/medal1
	name = "Special heart medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/arrow

/datum/loadout_item/accessory/medal2
	name = "Special heart medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/hollow

/datum/loadout_item/accessory/medal3
	name = "Special heart medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/bars

/datum/loadout_item/accessory/medal4
	name = "Heart medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/regheart/hollow

/datum/loadout_item/accessory/medal5
	name = "Heart medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/regheart/bars

/datum/loadout_item/accessory/medal6
	name = "Hollow shield medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/arrow

/datum/loadout_item/accessory/medal7
	name = "Hollow shield medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/hollow

/datum/loadout_item/accessory/medal8
	name = "Hollow shield medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/bars

/datum/loadout_item/accessory/medal9
	name = "Blank bar medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/arrow

/datum/loadout_item/accessory/medal10
	name = "Blank bar medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/hollow

/datum/loadout_item/accessory/medal11
	name = "Blank bar medal (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/bars

/datum/loadout_item/accessory/medal12
	name = "Crown medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/arrow

/datum/loadout_item/accessory/medal13
	name = "Crown medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow

/datum/loadout_item/accessory/medal14
	name = "Crown medal (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/bars

/datum/loadout_item/accessory/medal15
	name = "Hollow crown medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcrown/arrow

/datum/loadout_item/accessory/medal16
	name = "Hollow crown medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcrown/hollow

/datum/loadout_item/accessory/medal17
	name = "Hollow crown medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcrown/bars

/datum/loadout_item/accessory/medal18
	name = "Hollow circle medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcircle/arrow

/datum/loadout_item/accessory/medal19
	name = "Hollow circle medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcircle/hollow

/datum/loadout_item/accessory/medal20
	name = "Hollow circle medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowcircle/bars

/datum/loadout_item/accessory/medal21
	name = "Circle medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/arrow

/datum/loadout_item/accessory/medal22
	name = "Circle medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow

/datum/loadout_item/accessory/medal23
	name = "Circle medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/bars

/datum/loadout_item/accessory/medal24
	name = "Glowbar necklace"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/glowbar

/datum/loadout_item/accessory/medal25
	name = "Glowcrystal necklace"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/glowcrystal

/datum/loadout_item/accessory/rankpin1
	name = "Rankpin (Star)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin

/datum/loadout_item/accessory/rankpin2
	name = "Rankpin (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin/rankpinalt1

/datum/loadout_item/accessory/rankpin3
	name = "Rankpin (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin/rankpinalt2

/*
*
* Special Pins
*
*/

/datum/loadout_item/accessory/ccpin
	name = "Centcomm neckpin"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specialpins/centcomm
	restricted_roles = list(JOB_NT_REP, JOB_CAPTAIN, JOB_BLUESHIELD)

/datum/loadout_item/accessory/ntpin
	name = "Nanotrasen neckpin"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specialpins

/datum/loadout_item/accessory/porttarkon
	name = "Port Tarkon neckpin"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specialpins/porttarkon

/*
*
* Ribbons
*
*/
/datum/loadout_item/accessory/ribbon1
	name = "Ribbon (Down Arrow)"
	item_path = /obj/item/clothing/accessory/nova/ribbon

/datum/loadout_item/accessory/ribbon2
	name = "Ribbon (Slash)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_slash

/datum/loadout_item/accessory/ribbon3
	name = "Ribbon (Up Arrow)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_arrup

/datum/loadout_item/accessory/ribbon4
	name = "Ribbon (Line)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_line

/datum/loadout_item/accessory/ribbon5
	name = "Ribbon (Dual)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_dual

/datum/loadout_item/accessory/ribbon6
	name = "Ribbon (Flat)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_flat

/datum/loadout_item/accessory/ribbon7
	name = "Ribbon (Two-Tone)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_twotone

