// Removes all reagents which were added by neuroware chips.
/obj/item/disk/neuroware/neuroware_deactivator
	name = "neuroware deactivator"
	desc = "A neuroware chip containing a program which deactivates running neuroware over time.<br>\
	Can be used 3 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/reset"
	post_init_icon_state = "chip_deforest"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/reset_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	success_message = "neuroware reset"
	uses = 3

/obj/item/disk/neuroware/trauma_fixer
	name = "trauma fixer neuroware"
	desc = "A neuroware chip containing a program which fixes basic brain traumas. No impact on severe, deep-rooted, or permanent traumas.<br>\
	Can be used 3 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/brain"
	post_init_icon_state = "chip_super"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/brain_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	uses = 3

/obj/item/disk/neuroware/synaptizine
	name = "\improper SynapTuner Pro neuroware"
	desc = "A neuroware chip containing SynapTuner Pro, a digitized form of synaptizine.<br> \
	Treats the following conditions:<br>\
	 - Drowsiness<br>\
	 - Impaired movement<br>\
	 - Hallucinations<br>\
	Side effects may include toxicity.<br>\
	Can be used 2 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/synaptizine"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/synaptizine/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU
	uses = 2

/obj/item/disk/neuroware/psicodine
	name = "\improper Thera-Pro therapeutic neuroware"
	desc = "A neuroware chip containing Thera-Pro, a digitized form of psicodine.<br> \
	Treats the following conditions:<br>\
	 - Dizziness<br>\
	 - Jitters<br>\
	 - Confusion<br>\
	 - Feelings of disgust<br>\
	 - Feelings of insanity<br>\
	Can be used 2 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/psicodine"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	list_reagents = list(/datum/reagent/medicine/psicodine/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU
	uses = 2

/obj/item/disk/neuroware/morphine
	name = "\improper AnaSynthic neuroware"
	desc = "A neuroware chip containing AnaSynthic, a general anasthetic program which blocks pain and causes unconsciousness.<br>\
	Can be used 3 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/morphine"
	post_init_icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	list_reagents = list(/datum/reagent/medicine/morphine/synth = 10)
	manufacturer_tag = NEUROWARE_BISHOP
	uses = 3

/obj/item/disk/neuroware/lidocaine
	name = "\improper NGesic neuroware"
	desc = "A neuroware chip containing NGesic, a \"painkiller\" analgesic program which blocks pain signals.<br>\
	Can be used 3 times before deactivating."
	icon_state = "/obj/item/disk/neuroware/lidocaine"
	post_init_icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	list_reagents = list(/datum/reagent/medicine/lidocaine/synth = 10)
	manufacturer_tag = NEUROWARE_BISHOP
	uses = 3
