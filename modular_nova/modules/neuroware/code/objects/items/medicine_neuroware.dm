// Removes all reagents which were added by neuroware chips.
/obj/item/disk/neuroware/reset
	name = "system reset neuroware"
	desc = "A neuroware chip containing a system reset program which stops and deletes all installed neuroware. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/reset"
	post_init_icon_state = "chip_deforest"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/reset_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	success_message = "neuroware reset"
	uses = 3

/obj/item/disk/neuroware/brain
	name = "corruption repair neuroware"
	desc = "A neuroware chip containing a corruption-repairing program which attempts to fix minor brain traumas in artificial brains. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/brain"
	post_init_icon_state = "chip_super"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/brain_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	uses = 3

/obj/item/disk/neuroware/synaptizine
	name = "\improper SynapTuner Pro neuroware"
	desc = "A neuroware chip containing SynapTuner Pro, which reduces drowsiness and hallucinations while increasing resistance to stuns. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/synaptizine"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/synaptizine/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU
	uses = 2

/obj/item/disk/neuroware/psicodine
	name = "\improper Zen-First-Aid neuroware"
	desc = "A neuroware chip containing Zen-First-Aid, an \"emotional first-aid kit\" which suppresses anxiety and mental distress. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/psicodine"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	list_reagents = list(/datum/reagent/medicine/psicodine/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU
	uses = 2

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
