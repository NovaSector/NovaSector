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

/datum/loadout_item/accessory/maidcorset_tactical
	name = "tactical maid apron"
	item_path = /obj/item/clothing/accessory/maidcorset/syndicate/loadout_corset

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
	name = "Red Armband"
	item_path = /obj/item/clothing/accessory/armband/nonsec

/datum/loadout_item/accessory/armband_security
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/holobadge
	name = "Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/holobadge/blue
	name = "Blue Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/holobadge/lanyard
	name = "Holobadge with Lanyard"
	item_path = /obj/item/clothing/accessory/badge/holo/cord
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

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
/datum/loadout_item/accessory/sheart1
	name = "Special Heart Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/arrow_ribbon

/datum/loadout_item/accessory/sheart2
	name = "Special Heart Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/hollow_ribbon

/datum/loadout_item/accessory/sheart3
	name = "Special Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specheart/bars_ribbon

/datum/loadout_item/accessory/heart1
	name = "Heart Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/regheart/arrow_ribbon

/datum/loadout_item/accessory/heart2
	name = "Heart Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/regheart/hollow_ribbon

/datum/loadout_item/accessory/heart3
	name = "Heart Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/regheart/bars_ribbon

/datum/loadout_item/accessory/hshield1
	name = "Hollow Shield Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/arrow_ribbon

/datum/loadout_item/accessory/hshield2
	name = "Hollow Shield Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/hollow_ribbon

/datum/loadout_item/accessory/hshield3
	name = "Hollow Shield Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/hollowshield/bars_ribbon

/datum/loadout_item/accessory/bbar1
	name = "Blank Bar Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/arrow_ribbon

/datum/loadout_item/accessory/bbar2
	name = "Blank Bar Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/hollow_ribbon

/datum/loadout_item/accessory/bbar3
	name = "Blank Bar Medal (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bbar/bars_ribbon

/datum/loadout_item/accessory/crown1
	name = "Crown Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/arrow_ribbon

/datum/loadout_item/accessory/crown2
	name = "Crown Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow_ribbon

/datum/loadout_item/accessory/crown3
	name = "Crown Medal (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/bars_ribbon

/datum/loadout_item/accessory/hcrown1
	name = "Hollow Crown Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow/arrow_ribbon

/datum/loadout_item/accessory/hcrown2
	name = "Hollow Crown Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow/hollow_ribbon

/datum/loadout_item/accessory/hcrown3
	name = "Hollow Crown Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow/bars_ribbon

/datum/loadout_item/accessory/hcircle1
	name = "Hollow Circle Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow/arrow_ribbon

/datum/loadout_item/accessory/hcircle2
	name = "Hollow Circle Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow/hollow_ribbon

/datum/loadout_item/accessory/hcircle3
	name = "Hollow Circle Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow/bars_ribbon

/datum/loadout_item/accessory/circle1
	name = "Circle Medal (Arrow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/arrow_ribbon

/datum/loadout_item/accessory/circle2
	name = "Circle Medal (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow_ribbon

/datum/loadout_item/accessory/circle3
	name = "Circle Medal (Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/bars_ribbon

/datum/loadout_item/accessory/glowneck1
	name = "Glowbar necklace"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/glowbar

/datum/loadout_item/accessory/glowneck2
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
	name = "Centcomm Neckpin"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specialpins/centcomm
	restricted_roles = list(JOB_NT_REP, JOB_CAPTAIN, JOB_BLUESHIELD)

/datum/loadout_item/accessory/ntpin
	name = "Nanotrasen Neckpin"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/specialpins

/datum/loadout_item/accessory/porttarkon
	name = "Port Tarkon Neckpin"
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

/datum/loadout_item/accessory/ribbonmilitary1
	name = "Military Ribbon (1 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon

/datum/loadout_item/accessory/ribbonmilitary1
	name = "Military Ribbon (2 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon/alt1

/datum/loadout_item/accessory/ribbonmilitary1
	name = "Military Ribbon (3 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon/alt2
