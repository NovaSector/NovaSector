// LOADOUT ITEM DATUMS FOR THE ACCESSORY SLOT

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

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/accessory/chaps
	name = "Chaps"
	item_path = /obj/item/clothing/accessory/chaps

/datum/loadout_item/accessory/maidcorset_tactical
	name = "Maid Apron - Tactical"
	item_path = /obj/item/clothing/accessory/maidcorset/syndicate/loadout_corset

/datum/loadout_item/accessory/wetmaker
	name = "Stardress Hydro-Vaporizer"
	item_path = /obj/item/clothing/accessory/vaporizer

/*
*	ARMBANDS
*/

/datum/loadout_item/accessory/armband_medblue
	name = "Armband (Blue-White)"
	item_path = /obj/item/clothing/accessory/armband/medblue/nonsec

/datum/loadout_item/accessory/armband_cargo
	name = "Armband (Brown)"
	item_path = /obj/item/clothing/accessory/armband/cargo/nonsec

/datum/loadout_item/accessory/armband_engineering
	name = "Armband (Orange)"
	item_path = /obj/item/clothing/accessory/armband/engine/nonsec

/datum/loadout_item/accessory/armband_science
	name = "Armband (Purple)"
	item_path = /obj/item/clothing/accessory/armband/science/nonsec

/datum/loadout_item/accessory/armband_security_nonsec
	name = "Armband (Red)"
	item_path = /obj/item/clothing/accessory/armband/nonsec

/datum/loadout_item/accessory/armband_med
	name = "Armband (White)"
	item_path = /obj/item/clothing/accessory/armband/med/nonsec

/datum/loadout_item/accessory/armband_security
	name = "Armband - Security Deputy"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/green_pin
	name = "Green \"Newbie\" Pin"
	item_path = /obj/item/clothing/accessory/green_pin

/datum/loadout_item/accessory/holobadge
	name = "Holobadge"
	item_path = /obj/item/clothing/accessory/badge/holo
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/holobadge/blue
	name = "Holobadge (Blue)"
	item_path = /obj/item/clothing/accessory/badge/holo/blue
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/accessory/holobadge/lanyard
	name = "Holobadge (Lanyard)"
	item_path = /obj/item/clothing/accessory/badge/holo/cord
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/*
*	ARMOURLESS
*/

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talisman"
	item_path = /obj/item/clothing/accessory/talisman/armourless

/datum/loadout_item/accessory/bone_charm/get_item_information()
	. = ..()
	.[FA_ICON_SHIELD_ALT] = TOOLTIP_NO_ARMOR

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/skullcodpiece/armourless

/datum/loadout_item/accessory/bone_codpiece/get_item_information()
	. = ..()
	.[FA_ICON_SHIELD_ALT] = TOOLTIP_NO_ARMOR

/datum/loadout_item/accessory/sinew_kilt
	name = "Heirloom Sinew Skirt"
	item_path = /obj/item/clothing/accessory/skilt/armourless

/datum/loadout_item/accessory/sinew_kilt/get_item_information()
	. = ..()
	.[FA_ICON_SHIELD_ALT] = TOOLTIP_NO_ARMOR

/*
*
* Accessory Medals
*
*/
/datum/loadout_item/accessory/medal
	abstract_type = /datum/loadout_item/accessory/medal
	group = "Medals"

/datum/loadout_item/accessory/medal/dogtags
	name = "Dogtags"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/dogtags

/datum/loadout_item/accessory/medal/shield
	name = "Medal - Shield"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/shield

/datum/loadout_item/accessory/medal/shield_br
	name = "Medal - Shield (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/shield/bar_ribbon

/datum/loadout_item/accessory/medal/shield_h
	name = "Medal - Shield (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/shield/hollow

/datum/loadout_item/accessory/medal/bar
	name = "Medal - Bar"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bar

/datum/loadout_item/accessory/medal/bar_br
	name = "Medal - Bar (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bar/bar_ribbon

/datum/loadout_item/accessory/medal/bar_h
	name = "Medal - Bar (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/bar/hollow

/datum/loadout_item/accessory/medal/circle
	name = "Medal - Circle"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle

/datum/loadout_item/accessory/medal/circle_br
	name = "Medal - Circle (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/bar_ribbon

/datum/loadout_item/accessory/medal/circle_alt
	name = "Medal - Circle (Alt)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal
	//This is actually the default setup for our medals!

/datum/loadout_item/accessory/medal/circle_h
	name = "Medal - Circle (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow

/datum/loadout_item/accessory/medal/circle_h_br
	name = "Medal - Circle (Hollow, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/circle/hollow/bar_ribbon

/datum/loadout_item/accessory/medal/heart
	name = "Medal - Heart"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/heart

/datum/loadout_item/accessory/medal/heart_br
	name = "Medal - Heart (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/heart/bar_ribbon

/datum/loadout_item/accessory/medal/heart_s
	name = "Medal - Heart (Special)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/heart/special

/datum/loadout_item/accessory/medal/heart_s_br
	name = "Medal - Heart (Special, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/heart/special/bar_ribbon

/datum/loadout_item/accessory/medal/crown
	name = "Medal - Crown"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown

/datum/loadout_item/accessory/medal/crown_br
	name = "Medal - Crown (Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/bar_ribbon

/datum/loadout_item/accessory/medal/crown_h
	name = "Medal - Crown (Hollow)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow

/datum/loadout_item/accessory/medal/crown_h_br
	name = "Medal - Crown (Hollow, Bar-Ribbon)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/crown/hollow/bar_ribbon

/datum/loadout_item/accessory/medal/glow_crystal
	name = "Glowcrystal necklace"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/glowcrystal
	can_be_reskinned = TRUE

/datum/loadout_item/accessory/medal/rankpin_star
	name = "Rankpin (Star)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin

/datum/loadout_item/accessory/medal/rankpin_bar
	name = "Rankpin (Bar)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin/bar

/datum/loadout_item/accessory/medal/rankpin_twobar
	name = "Rankpin (Double Bars)"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/rankpin/two_bar

/*
* Special Pins
*/

/datum/loadout_item/accessory/medal/cc_pin
	name = "Neckpin - CentCom"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/neckpin/centcom
	restricted_roles = list(JOB_NT_REP, JOB_CAPTAIN, JOB_BLUESHIELD)

/datum/loadout_item/accessory/medal/nt_pin
	name = "Neckpin - Nanotrasen"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/neckpin

/datum/loadout_item/accessory/medal/pt_pin
	name = "Neckpin - Port Tarkon"
	item_path = /obj/item/clothing/accessory/nova/acc_medal/neckpin/porttarkon

/*
* Ribbons
*/

/datum/loadout_item/accessory/medal/ribbon_mil
	name = "Ribbon - Military (1 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon

/datum/loadout_item/accessory/medal/ribbon_mil_2
	name = "Ribbon - Military (2 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon/two

/datum/loadout_item/accessory/medal/ribbon_mil_3
	name = "Ribbon - Military (3 Color)"
	item_path = /obj/item/clothing/accessory/nova/military_ribbon/three

/datum/loadout_item/accessory/medal/ribbon
	name = "Ribbon (Down Arrow)"
	item_path = /obj/item/clothing/accessory/nova/ribbon

/datum/loadout_item/accessory/medal/ribbon2
	name = "Ribbon (Slash)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_slash

/datum/loadout_item/accessory/medal/ribbon3
	name = "Ribbon (Up Arrow)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_arrup

/datum/loadout_item/accessory/medal/ribbon4
	name = "Ribbon (Line)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_line

/datum/loadout_item/accessory/medal/ribbon5
	name = "Ribbon (Dual)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_dual

/datum/loadout_item/accessory/medal/ribbon6
	name = "Ribbon (Flat)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_flat

/datum/loadout_item/accessory/medal/ribbon7
	name = "Ribbon (Two-Tone)"
	item_path = /obj/item/clothing/accessory/nova/ribbon/ribbon_twotone
