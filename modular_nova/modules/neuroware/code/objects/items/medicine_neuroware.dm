// Removes all reagents which were added by neuroware chips.
/obj/item/disk/neuroware/reset
	name = "system reset neuroware"
	desc = "A neuroware chip containing a system reset program which stops and deletes all installed neuroware."
	icon_state = "chip_deforest"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/reset_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	success_message = "neuroware reset"
	uses = 5

/obj/item/disk/neuroware/brain
	name = "corruption repair neuroware"
	desc = "A neuroware chip containing a corruption-repairing program which attempts to fix minor brain traumas in artificial brains."
	icon_state = "chip_super"
	greyscale_colors = "#474747"
	list_reagents = list(/datum/reagent/medicine/brain_neuroware = 15)
	manufacturer_tag = NEUROWARE_DEFOREST
	uses = 5

/obj/item/disk/neuroware/synaptizine
	name = "SynapTuner Pro neuroware"
	desc = "A neuroware chip containing SynapTuner Pro, which reduces drowsiness and hallucinations while increasing resistance to stuns."
	icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	list_reagents = list(/datum/reagent/medicine/synaptizine/synth = 15)
	manufacturer_tag = NEUROWARE_BISHOP

/obj/item/disk/neuroware/psicodine
	name = "Zen-First-Aid neuroware"
	desc = "A neuroware chip containing Zen-First-Aid, an \"emotional first-aid kit\" which suppresses anxiety and mental distress."
	icon_state = "chip_bishop"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	list_reagents = list(/datum/reagent/medicine/psicodine/synth = 15)
	manufacturer_tag = NEUROWARE_BISHOP
