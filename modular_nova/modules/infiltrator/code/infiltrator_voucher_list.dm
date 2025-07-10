//regular item vouchers
/obj/item/folder/syndicate/vouchers
	name = "equipment voucher folder"
	icon_state = "folder_sblue"
	var/list/voucher_list = list(
		/obj/item/paper/paperslip/corporate/syndicate,
		/obj/item/paper/paperslip/corporate/syndicate,
		/obj/item/paper/paperslip/corporate/syndicate,
	)

/obj/item/folder/syndicate/vouchers/Initialize(mapload)
	. = ..()
	for(var/obj/item/paperslip as anything in voucher_list)
		if(ispath(paperslip, /obj/item/paper/paperslip/corporate/syndicate))
			new paperslip(src)
	update_appearance()

/obj/item/paper/paperslip/corporate/syndicate
	name = "item voucher"
	desc = "A plastic card used to redeem equipment, this one is blank."
	icon_state = "voucher_blank"
	icon = 'modular_nova/modules/infiltrator/icons/voucher.dmi'
	show_written_words = FALSE




//voucher datums
//and their items if necessary
/datum/voucher_set/traitor

/datum/voucher_set/traitor/mod

/datum/voucher_set/traitor/mod/nukie
	name = "Syndicate MODsuit"
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	icon_state = "syndicate-plating"
	set_items = list(
		/obj/item/mod/construction/plating/syndicate,
		/obj/item/disk/mecha_part_fabricator/modmodule_data
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
		/obj/item/disk/mecha_part_fabricator/modmodule_data
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
		/obj/item/disk/mecha_part_fabricator/modmodule_data
	)

/obj/item/mod/construction/plating/syndicate_infiltrator
	icon = 'modular_nova/modules/moretraitoritems/icons/mod_construction.dmi'
	theme = /datum/mod_theme/infiltrator


/datum/voucher_set/traitor/mod/mech_voucher
	name = "Orbital Mechpad Link"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "datadisk10"
	set_items = list(
		/obj/item/disk/orbitalpad_data
	)

/obj/item/disk/orbitalpad_data
	name = "bluespace co-ordinate data disk"
	desc = "A disk which contains an encryption string of bluespace co-ordinates. It should be inserted into a orbital mech pad console."
	icon_state = "datadisk10"

/datum/voucher_set/traitor/mech

/datum/voucher_set/traitor/mech/gygax
	name = "Gygax"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "gygax"
	set_items = list(
		/obj/vehicle/sealed/mecha/gygax,
		/obj/item/disk/mecha_part_fabricator/mechaparts_data
	)

/datum/voucher_set/traitor/mech/ripleymk2
	name = "Ripley Mk.II"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "ripleymkii"
	set_items = list(
		/obj/vehicle/sealed/mecha/ripley/mk2,
		/obj/item/disk/mecha_part_fabricator/mechaparts_data
	)
