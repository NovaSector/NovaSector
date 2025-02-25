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
	MEDALS
*/

/datum/loadout_item/accessory/specheart_arrow
	name = "Special Heart Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/specheart/arrow

/datum/loadout_item/accessory/specheart_hollow
	name = "Special Heart Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/specheart/hollow

/datum/loadout_item/accessory/specheart_bars
	name = "Special Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/specheart/bars

/datum/loadout_item/accessory/heart_arrow
	name = "Regular Heart Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/regheart/arrow

/datum/loadout_item/accessory/heart_hollow
	name = "Regular Heart Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/regheart/hollow

/datum/loadout_item/accessory/heart_bars
	name = "Regular Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/regheart/bars
/datum/loadout_item/accessory/ribbon_arrdown
	name = "Ribbon (Arrow Down)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_arrdown

/datum/loadout_item/accessory/ribbon_slash
	name = "Ribbon (Slash)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_slash

/datum/loadout_item/accessory/ribbon_arrup
	name = "Ribbon (Arrow Up)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_arrup

/datum/loadout_item/accessory/ribbon_line
	name = "Ribbon (Line)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_line

/datum/loadout_item/accessory/ribbon_dual
	name = "Ribbon (Dual)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_dual


/datum/loadout_item/accessory/ribbon_flat
	name = "Ribbon (Flat)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_flat

/datum/loadout_item/accessory/ribbon_twotone
	name = "Ribbon (Two tone)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_twotone

/datum/loadout_item/accessory/blankshield_arrow
	name = "Blank Shield Medal (arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankshield/arrow

/datum/loadout_item/accessory/blankshield_hollow
	name = "Blank Shield Medal (hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankshield/hollow

/datum/loadout_item/accessory/blankshield_bars
	name = "Blank Shield Medal (bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankshield/bars

/datum/loadout_item/accessory/hollowshield_arrow
	name = "Hollow Shield Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowshield/arrow

/datum/loadout_item/accessory/hollowshield_hollow
	name = "Hollow Shield Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowshield/hollow

/datum/loadout_item/accessory/hollowshield_bars
	name = "Hollow Shield Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowshield/bars

/datum/loadout_item/accessory/hollowcircle_arrow
	name = "Hollow Circle Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowcircle/arrow

/datum/loadout_item/accessory/hollowcircle_hollow
	name = "Hollow Circle Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowcircle/hollow

/datum/loadout_item/accessory/hollowcircle_bars
	name = "Hollow Circle Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/hollowcircle/bars

/datum/loadout_item/accessory/blankcircle_arrow
	name = "Blank Circle Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcircle/arrow

/datum/loadout_item/accessory/blankcircle_hollow
	name = "Blank Circle Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcircle/hollow

/datum/loadout_item/accessory/blankcircle_bars
	name = "Blank Circle Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcircle/bars

/datum/loadout_item/accessory/crown_arrow
	name = "Crown Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/crown/arrow

/datum/loadout_item/accessory/crown_hollow
	name = "Crown Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/crown/hollow

/datum/loadout_item/accessory/crown_bars
	name = "Crown Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/crown/bars

/datum/loadout_item/accessory/blankcrown_arrow
	name = "Blank Crown Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcrown/arrow

/datum/loadout_item/accessory/blankcrown_hollow
	name = "Blank Crown Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcrown/hollow

/datum/loadout_item/accessory/blankcrown_bar
	name = "Blank Crown Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/medal/blankcrown/bars
/datum/loadout_item/accessory/MilitaryRibbon_1
	name = "Military Ribbon (1 Color)"
	item_path = /obj/item/clothing/accessory/nova/militaryribbon/ribbonbar1tone
/datum/loadout_item/accessory/MilitaryRibbon_2
	name = "Military Ribbon (2 Color)"
	item_path = /obj/item/clothing/accessory/nova/militaryribbon/ribbonbar2tone
/datum/loadout_item/accessory/MilitaryRibbon_3
	name = "Military Ribbon (3 Color)"
	item_path = /obj/item/clothing/accessory/nova/militaryribbon/ribbonbar3tone

/datum/loadout_item/accessory/glowcrystal
	name = "Glow Crystal Necklace"
	item_path = /obj/item/clothing/accessory/nova/crystal/glowcrystal
/datum/loadout_item/accessory/NanotrasenPin
	name = "Nanotasen Company Pin"
	item_path = /obj/item/clothing/accessory/nova/medal/specialpins/ntpin

/datum/loadout_item/accessory/CentralCommandPin
	name = "Central Command Pin"
	item_path = /obj/item/clothing/accessory/nova/medal/specialpins/ccpin
	restricted_roles = list(JOB_BLUESHIELD, JOB_CAPTAIN, JOB_NT_REP)

/datum/loadout_item/accessory/Rankpin1
	name = "Star rank pin"
	item_path = /obj/item/clothing/accessory/nova/rankpin/rankpin1

/datum/loadout_item/accessory/Rankpin2
	name = "1st Officer Rank bar"
	item_path = /obj/item/clothing/accessory/nova/rankpin/rankpin2

/datum/loadout_item/accessory/Rankpin3
	name = "2nd Officer rank bar"
	item_path = /obj/item/clothing/accessory/nova/rankpin/rankpin3
