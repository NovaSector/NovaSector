/obj/item/disk/neuroware/morphine
	name = "\improper AnaSynthic neuroware"
	desc = "A neuroware chip containing AnaSynthic, a general anasthetic program which blocks pain and causes unconsciousness. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/morphine"
	post_init_icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	list_reagents = list(/datum/reagent/medicine/morphine/synth = 10)
	manufacturer_tag = NEUROWARE_BISHOP
	uses = 3

/obj/item/disk/neuroware/lidocaine
	name = "\improper NGesic neuroware"
	desc = "A neuroware chip containing NGesic, a \"painkiller\" analgesic program which blocks pain signals. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/lidocaine"
	post_init_icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	list_reagents = list(/datum/reagent/medicine/lidocaine/synth = 10)
	manufacturer_tag = NEUROWARE_BISHOP
	uses = 3
