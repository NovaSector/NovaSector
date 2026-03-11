// Folder which supplies the vouchers to the player
/obj/item/folder/syndicate/vouchers
	name = "equipment voucher folder"
	icon_state = "folder_sblue"

/obj/item/folder/syndicate/vouchers/Initialize(mapload)
	. = ..()
	new /obj/item/paper/fluff/midround_traitor/voucher_instruction(src)
	new /obj/item/paper/paperslip/corporate/syndicate/traitor/primary(src)
	new /obj/item/paper/paperslip/corporate/syndicate/traitor/secondary(src)
	new /obj/item/paper/paperslip/corporate/syndicate/traitor/exosuit(src)
	new /obj/item/paper/paperslip/corporate/syndicate/traitor/implant(src)
	new /obj/item/paper/paperslip/corporate/syndicate/traitor/supplies(src)
	update_appearance()
	enable_shine()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(disable_shine))

/obj/item/folder/syndicate/vouchers/proc/enable_shine()
	add_filter("shine", 1, list("type" = "rays", "size" = 28, "color" = COLOR_VIVID_YELLOW))
	animate(get_filter("shine"), offset = 100, time = 2 MINUTES, loop = -1, flags = ANIMATION_PARALLEL)

/obj/item/folder/syndicate/vouchers/proc/disable_shine()
	SIGNAL_HANDLER
	remove_filter("shine")
	UnregisterSignal(src, COMSIG_ITEM_EQUIPPED)

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
