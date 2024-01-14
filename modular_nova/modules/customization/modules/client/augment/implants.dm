/datum/augment_item/implant
	category = AUGMENT_CATEGORY_IMPLANTS

/datum/augment_item/implant/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)
		return
	var/obj/item/organ/new_organ = new path()
	new_organ.Insert(H,FALSE,FALSE)

//BRAIN IMPLANTS
/datum/augment_item/implant/brain
	slot = AUGMENT_SLOT_BRAIN_IMPLANT

//CHEST IMPLANTS
/datum/augment_item/implant/chest
	slot = AUGMENT_SLOT_CHEST_IMPLANT

//LEFT ARM IMPLANTS
/datum/augment_item/implant/l_arm
	slot = AUGMENT_SLOT_LEFT_ARM_IMPLANT

/datum/augment

/datum/augment_item/implant/l_arm/civilian_lighter
	name = "Thumbtip Lighter"
	cost = 2
	path = /obj/item/organ/internal/cyberimp/arm/civilian_lighter/left_arm

/datum/augment_item/implant/l_arm/razor_claws
    name = "Left Razor Claws (Knife + Wirecutters)"
    cost = 4
    path = /obj/item/organ/internal/cyberimp/arm/razor_claws/left_arm

/datum/augment_item/implant/l_arm/adjuster
	name = "Adjuster Implant (Screwdriver + Wrench)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/adjuster/left_arm

/datum/augment_item/implant/l_arm/civilian_barstaff
	name = "Waitstaff's Toolset Implant (Serving Tray + Rag)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/civilian_barstaff/left_arm

/datum/augment_item/implant/l_arm/emt_triage
	name = "Triage Actuator Implant (Drapes + Retractor + Hemostat)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/emt_triage/left_arm

/datum/augment_item/implant/l_arm/arc_welder
	name = "Shipbreaker's Toolset Implant (Arc Welder + Crowbar + Wrench)"
	cost = 8
	path = /obj/item/organ/internal/cyberimp/arm/arc_welder/left_arm

/datum/augment_item/implant/l_arm/electrical_toolset
	name = "Electrical Toolset Implant (Screwdriver + Multitool)"
	cost = 8
	path = /obj/item/organ/internal/cyberimp/arm/electrical_toolset/left_arm

//RIGHT ARM IMPLANTS
/datum/augment_item/implant/r_arm
	slot = AUGMENT_SLOT_RIGHT_ARM_IMPLANT

/datum/augment_item/implant/r_arm/razor_claws
    name = "Right Razor Claws (Knife + Wirecutters)"
    cost = 4
    path = /obj/item/organ/internal/cyberimp/arm/razor_claws/right_arm

//EYES IMPLANTS
/datum/augment_item/implant/eyes
	slot = AUGMENT_SLOT_EYES_IMPLANT

//MOUTH IMPLANTS
/datum/augment_item/implant/mouth
	slot = AUGMENT_SLOT_MOUTH_IMPLANT

/datum/augment_item/implant/mouth/breathing_tube
	name = "Breathing Tube"
	cost = 2
	path = /obj/item/organ/internal/cyberimp/mouth/breathing_tube
