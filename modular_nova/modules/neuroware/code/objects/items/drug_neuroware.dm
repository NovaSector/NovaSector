/obj/item/disk/neuroware/blastoff
	name = "\improper ElektroHaus 3B neuroware"
	desc = "A neuroware chip containing ElektroHaus 3B, which is a hardcore database of thrilling and dangerous dance-moves."
	icon_state = "/obj/item/disk/neuroware/blastoff"
	post_init_icon_state = "chip_donk"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	list_reagents = list(/datum/reagent/drug/blastoff/synth = 15)
	manufacturer_tag = NEUROWARE_DONK

/obj/item/disk/neuroware/cocaine
	name = "\improper #Zeng-Hu Accelerator neuroware"
	desc = "A neuroware chip containing Zeng-Hu Accelerator, a powerful cyberware accelerator and overclock program. Reduces stun times, but causes drowsiness and severe system corruption if overloaded."
	icon_state = "/obj/item/disk/neuroware/cocaine"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	list_reagents = list(/datum/reagent/drug/cocaine/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU

/obj/item/disk/neuroware/happiness
	name = "\improper SmileML 2565 neuroware"
	desc = "A neuroware chip containing the 2565 edition of SmileML, which induces happiness and blocks psychological pain. Multi-user license included."
	icon_state = "/obj/item/disk/neuroware/happiness"
	post_init_icon_state = "chip_zenghu"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	list_reagents = list(/datum/reagent/drug/happiness/synth = 15)
	manufacturer_tag = NEUROWARE_ZENGHU
	uses = 2

/obj/item/disk/neuroware/mushroomhallucinogen
	name = "\improper PsychoRot neuroware"
	desc = "A neuroware chip containing PsychoRot, which emulates the vivid psychoactive effects found in mushroom hallucinaogens."
	icon_state = "/obj/item/disk/neuroware/mushroomhallucinogen"
	post_init_icon_state = "chip_donk"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	list_reagents = list(/datum/reagent/drug/mushroomhallucinogen/synth = 15)
	manufacturer_tag = NEUROWARE_DONK

/obj/item/disk/neuroware/pumpup
	name = "homebrew overclock neuroware"
	desc = "A neuroware chip containing someone's DIY homebrew neurocomputing program. It seems to mimic the effects of adrenaline."
	icon_state = "/obj/item/disk/neuroware/pumpup"
	post_init_icon_state = "chip_maint"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	list_reagents = list(/datum/reagent/drug/pumpup/synth = 15)
	manufacturer_tag = NEUROWARE_MAINT

/obj/item/disk/neuroware/space_drugs
	name = "\improper Kaleido Demo neuroware"
	desc = "A neuroware chip containing a demo version of Kaleido, a fun and colorful demonstration of a \"neuromorphic kaleidoscope\"."
	icon_state = "/obj/item/disk/neuroware/space_drugs"
	post_init_icon_state = "chip_donk"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	list_reagents = list(/datum/reagent/drug/space_drugs/synth = 15)
	manufacturer_tag = NEUROWARE_DONK

/obj/item/disk/neuroware/thc
	name = "\improper Mr.Stoned v1 neuroware"
	desc = "A neuroware chip containing version 1.0 of Mr.Stoned, which emulates the effects of cannabis and THC."
	icon_state = "/obj/item/disk/neuroware/thc"
	post_init_icon_state = "chip_donk"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	list_reagents = list(/datum/reagent/drug/thc/synth = 15)
	manufacturer_tag = NEUROWARE_DONK
