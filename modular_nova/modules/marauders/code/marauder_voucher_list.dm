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

/// TRADE VOUCHER SET
/datum/voucher_set/traitor/voucher_trade

/datum/voucher_set/traitor/voucher_trade/secondary_weapon
	name = /obj/item/paper/paperslip/corporate/syndicate/secondary::name
	description = /obj/item/paper/paperslip/corporate/syndicate/secondary::desc
	icon = /obj/item/paper/paperslip/corporate/syndicate/secondary::icon
	icon_state = /obj/item/paper/paperslip/corporate/syndicate/secondary::icon_state
	set_items = list(
		/obj/item/paper/paperslip/corporate/syndicate/secondary
	)

/datum/voucher_set/traitor/voucher_trade/implant
	name = /obj/item/paper/paperslip/corporate/syndicate/implant::name
	description = /obj/item/paper/paperslip/corporate/syndicate/implant::desc
	icon = /obj/item/paper/paperslip/corporate/syndicate/implant::icon
	icon_state = /obj/item/paper/paperslip/corporate/syndicate/implant::icon_state
	set_items = list(
		/obj/item/paper/paperslip/corporate/syndicate/implant
	)

/datum/voucher_set/traitor/voucher_trade/supplies
	name = /obj/item/paper/paperslip/corporate/syndicate/supplies::name
	description = /obj/item/paper/paperslip/corporate/syndicate/supplies::desc
	icon = /obj/item/paper/paperslip/corporate/syndicate/supplies::icon
	icon_state = /obj/item/paper/paperslip/corporate/syndicate/supplies::icon_state
	set_items = list(
		/obj/item/paper/paperslip/corporate/syndicate/supplies
	)

/// PRIMARY WEAPON VOUCHER SET
/datum/voucher_set/traitor/primary_weapon

/// SECONDARY WEAPON VOUCHER SET
/datum/voucher_set/traitor/secondary_weapon

/// EXOSUIT VOUCHER SET
/datum/voucher_set/traitor/mod

/datum/voucher_set/traitor/mod/nukie
	name = "Syndicate MODsuit"
//	description = ""
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "syndicate-helmet-sealed"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate
	)

/datum/voucher_set/traitor/mod/elite
	name = "Elite MODsuit"
//	description = ""
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "elite-helmet-sealed"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate_elite
	)

/datum/voucher_set/traitor/mod/infiltrator
	name = "Infiltrator MODsuit"
//	description = ""
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "infiltrator-helmet-sealed"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate_infiltrator
	)


/datum/voucher_set/traitor/mech

/datum/voucher_set/traitor/mech/gygax
	name = /obj/vehicle/sealed/mecha/gygax::name
	description = /obj/vehicle/sealed/mecha/gygax::desc
	icon = /obj/vehicle/sealed/mecha/gygax::icon
	icon_state = /obj/vehicle/sealed/mecha/gygax::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/gygax,
		/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster,
		/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		/obj/item/mecha_ammo/lmg,
		/obj/item/mecha_parts/mecha_equipment/repair_droid
	)

/datum/voucher_set/traitor/mech/ripleymk2
	name = /obj/vehicle/sealed/mecha/ripley/mk2::name
	description = /obj/vehicle/sealed/mecha/ripley/mk2::desc
	icon = /obj/vehicle/sealed/mecha/ripley/mk2::icon
	icon_state = /obj/vehicle/sealed/mecha/ripley/mk2::icon_state
	set_items = list(
		/obj/vehicle/sealed/mecha/ripley/mk2,
		/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill,
		/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide,
		/obj/item/stack/sheet/animalhide/goliath_hide
	)

/// IMPLANT VOUCHER SET
/datum/voucher_set/traitor/implant

/datum/voucher_set/traitor/organ

/// SUPPLIES VOUCHER SET
/datum/voucher_set/traitor/supplies/ammo

/datum/voucher_set/traitor/supplies/science

/datum/voucher_set/traitor/supplies/stealth

/datum/voucher_set/traitor/supplies/tools

/datum/voucher_set/traitor/supplies/medical

/datum/voucher_set/traitor/supplies/surgery
