// Folder which supplies the vouchers to the player
/obj/item/folder/syndicate/vouchers
	name = "equipment voucher folder"
	icon_state = "folder_sblue"
	var/list/voucher_list = list(
		/obj/item/paper/paperslip/corporate/syndicate/primary,
		/obj/item/paper/paperslip/corporate/syndicate/secondary,
		/obj/item/paper/paperslip/corporate/syndicate/exosuit,
		/obj/item/paper/paperslip/corporate/syndicate/implant,
		/obj/item/paper/paperslip/corporate/syndicate/implant,
		/obj/item/paper/paperslip/corporate/syndicate/supplies,
		/obj/item/paper/paperslip/corporate/syndicate/supplies
	)

/obj/item/folder/syndicate/vouchers/Initialize(mapload)
	. = ..()
	for(var/obj/item/paperslip as anything in voucher_list)
		if(ispath(paperslip, /obj/item/paper/paperslip/corporate/syndicate))
			new paperslip(src)
	update_appearance()

/// VOUCHER ITEMS
// Paper slips
/obj/item/paper/paperslip/corporate/syndicate/primary
	name = "primary weapon voucher"
	desc = ""
	default_raw_text = ""
//	icon_state = "/obj/item/paper/paperslip/corporate/syndicate/primary"
//	greyscale_colors = COLOR_SYNDIE_RED_HEAD

/obj/item/paper/paperslip/corporate/syndicate/secondary
	name = "secondary weapon voucher"
	desc = ""
	default_raw_text = ""
//	icon_state = "/obj/item/paper/paperslip/corporate/syndicate/secondary"
//	greyscale_colors = COLOR_PINK_RED

/obj/item/paper/paperslip/corporate/syndicate/exosuit
	name = "robotics exosuit voucher"
	desc = ""
	default_raw_text = ""
//	icon_state = "/obj/item/paper/paperslip/corporate/syndicate/exosuit"
//	greyscale_colors = COLOR_SCIENCE_PINK

/obj/item/paper/paperslip/corporate/syndicate/implant
	name = "medical implant voucher"
	desc = ""
	default_raw_text = ""
//	icon_state = "/obj/item/paper/paperslip/corporate/syndicate/implant"
//	greyscale_colors = COLOR_MEDICAL_BLUE

/obj/item/paper/paperslip/corporate/syndicate/supplies
	name = "general supplies voucher"
	desc = ""
	default_raw_text = ""
//	icon_state = "/obj/item/paper/paperslip/corporate/syndicate/supplies"
//	greyscale_colors = COLOR_CARGO_BROWN


///
/// VOUCHER ITEM SETS

/// EXOSUIT VOUCHER SET
/datum/voucher_set/traitor/mod

/datum/voucher_set/traitor/mod/nukie
	name = "Syndicate MODsuit"
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	icon_state = "syndicate-plating"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate,
	)

/obj/item/mod/construction/plating/syndicate
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	theme = /datum/mod_theme/syndicate

/datum/voucher_set/traitor/mod/elite
	name = "Elite MODsuit"
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	icon_state = "elite-plating"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate_elite,
	)

/obj/item/mod/construction/plating/syndicate_elite
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	theme = /datum/mod_theme/elite

/datum/voucher_set/traitor/mod/infiltrator
	name = "Infiltrator MODsuit"
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	icon_state = "infiltrator-plating"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate_infiltrator,
	)

/obj/item/mod/construction/plating/syndicate_infiltrator
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	theme = /datum/mod_theme/infiltrator


/datum/voucher_set/traitor/mech

/datum/voucher_set/traitor/mech/gygax
	name = "Gygax"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "gygax"
	set_items = list(
		/obj/vehicle/sealed/mecha/gygax,
		/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		/obj/item/mecha_ammo/lmg,
		/obj/item/mecha_parts/mecha_equipment/repair_droid
	)

/datum/voucher_set/traitor/mech/ripleymk2
	name = "Ripley Mk.II"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "ripleymkii"
	set_items = list(
		/obj/vehicle/sealed/mecha/ripley/mk2,
		/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill,
		/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide
	)
