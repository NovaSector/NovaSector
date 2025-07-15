// Folder which supplies the vouchers to the player
/obj/item/folder/syndicate/vouchers
	name = "equipment voucher folder"
	icon_state = "folder_sblue"
	var/list/voucher_list = list(
		/obj/item/paper/fluff/midround_traitor/voucher_instruction,
		/obj/item/paper/paperslip/corporate/syndicate/traitor/primary,
		/obj/item/paper/paperslip/corporate/syndicate/traitor/secondary,
		/obj/item/paper/paperslip/corporate/syndicate/traitor/exosuit,
		/obj/item/paper/paperslip/corporate/syndicate/traitor/implant,
		/obj/item/paper/paperslip/corporate/syndicate/traitor/supplies,
	)

/obj/item/folder/syndicate/vouchers/Initialize(mapload)
	. = ..()
	for(var/obj/item/slip as anything in voucher_list)
		if(ispath(slip, /obj/item/paper/paperslip/corporate/syndicate/traitor))
			new slip(src)
	update_appearance()

// Plastic slips
/obj/item/paper/paperslip/corporate/syndicate
	icon = 'modular_nova/master_files/icons/obj/bureaucracy.dmi' //https://github.com/tgstation/tgstation/pull/92091
	icon_state = "slip_red"

/obj/item/paper/paperslip/corporate/syndicate/traitor
	desc = "A plastic card with a data string printed on it. These cards act as equipment vouchers, and its data string can be downloaded by various machinery to unlock gear."

/obj/item/paper/paperslip/corporate/syndicate/traitor/Initialize(mapload)
	. = ..()
	var/list/characters = list()
	characters += GLOB.alphabet
	characters += GLOB.alphabet_upper
	characters += GLOB.numerals
	var/data_string = random_string(rand(180,220), characters)
	add_raw_text(data_string)
	update_appearance()

/obj/item/paper/paperslip/corporate/syndicate/traitor/primary
	name = "primary weapon voucher"
	icon_state = "slip_red_stripe"

/obj/item/paper/paperslip/corporate/syndicate/traitor/secondary
	name = "secondary weapon voucher"
	icon_state = "slip_red"

/obj/item/paper/paperslip/corporate/syndicate/traitor/exosuit
	name = "robotics exosuit voucher"
	icon_state = "slip_purple"

/obj/item/paper/paperslip/corporate/syndicate/traitor/implant
	name = "medical implant voucher"
	icon_state = "slip_lightblue"

/obj/item/paper/paperslip/corporate/syndicate/traitor/supplies
	name = "general supplies voucher"
	icon_state = "slip_brown"
