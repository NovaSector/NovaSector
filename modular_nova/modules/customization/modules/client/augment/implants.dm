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

/datum/augment_item/implant/chest/nutriment_pump
	name = "Nutriment Pump"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/chest/nutriment

//LEFT ARM IMPLANTS
/datum/augment_item/implant/l_arm
	slot = AUGMENT_SLOT_LEFT_ARM_IMPLANT

/datum/augment_item/implant/l_arm/civilian_lighter
	name = "Left Thumbtip Lighter"
	cost = 2
	path = /obj/item/organ/internal/cyberimp/arm/civilian_lighter/left_arm

/datum/augment_item/implant/l_arm/razor_claws
    name = "Left Razor Claws (Knife + Wirecutters)"
    cost = 4
    path = /obj/item/organ/internal/cyberimp/arm/razor_claws/left_arm

/datum/augment_item/implant/l_arm/adjuster
	name = "Left Adjuster Implant (Screwdriver + Wrench)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/adjuster/left_arm

/datum/augment_item/implant/l_arm/bureaucracy
	name = "Left Bureaucrat's 'Jacent' Toolset Implant (4-colour Pen + Small Paper Bin + Approve/Deny Stamps)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/bureaucracy/left_arm

/datum/augment_item/implant/l_arm/cargo
	name = "Left FTU 'Deckhand' toolset implant (Universal Scanner + Boxcutter)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/cargo/left_arm

/datum/augment_item/implant/l_arm/civilian_barstaff
	name = "Left Waitstaff's Toolset Implant (Serving Tray + Rag)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/civilian_barstaff/left_arm

/datum/augment_item/implant/l_arm/emt_triage
	name = "Left Triage Actuator Implant (Drapes + Retractor + Hemostat)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/emt_triage/left_arm

/datum/augment_item/implant/l_arm/blacksteel_forging
	name = "Left Blacksteel 'Starforge' Toolset Implant (Forging Hammer + Tongs + Bellows)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/blacksteel_forging/left_arm

/datum/augment_item/implant/l_arm/arc_welder
	name = "Left Shipbreaker's Toolset Implant (Arc Welder + Crowbar + Wrench)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/arc_welder/left_arm

/datum/augment_item/implant/l_arm/electrical_toolset
	name = "Left Electrical Toolset Implant (Screwdriver + Multitool)"
	cost = 8
	path = /obj/item/organ/internal/cyberimp/arm/electrical_toolset/left_arm

//RIGHT ARM IMPLANTS
/datum/augment_item/implant/r_arm
	slot = AUGMENT_SLOT_RIGHT_ARM_IMPLANT

/datum/augment_item/implant/r_arm/civilian_lighter
	name = "Right Thumbtip Lighter"
	cost = 2
	path = /obj/item/organ/internal/cyberimp/arm/civilian_lighter/right_arm

/datum/augment_item/implant/r_arm/razor_claws
    name = "Right Razor Claws (Knife + Wirecutters)"
    cost = 4
    path = /obj/item/organ/internal/cyberimp/arm/razor_claws/right_arm

/datum/augment_item/implant/r_arm/adjuster
	name = "Right Adjuster Implant (Screwdriver + Wrench)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/adjuster/right_arm

/datum/augment_item/implant/r_arm/bureaucracy
	name = "Right Bureaucrat's 'Jacent' Toolset Implant (4-colour Pen + Small Paper Bin + Approve/Deny Stamps)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/bureaucracy/right_arm

/datum/augment_item/implant/r_arm/cargo
	name = "Right FTU 'Deckhand' toolset implant (Universal Scanner + Boxcutter)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/cargo/right_arm

/datum/augment_item/implant/r_arm/civilian_barstaff
	name = "Right Waitstaff's Toolset Implant (Serving Tray + Rag)"
	cost = 4
	path = /obj/item/organ/internal/cyberimp/arm/civilian_barstaff/right_arm

/datum/augment_item/implant/r_arm/emt_triage
	name = "Right Triage Actuator Implant (Drapes + Retractor + Hemostat)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/emt_triage/right_arm

/datum/augment_item/implant/r_arm/blacksteel_forging
	name = "Right Blacksteel 'Starforge' Toolset Implant (Forging Hammer + Tongs + Bellows)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/blacksteel_forging/right_arm

/datum/augment_item/implant/r_arm/arc_welder
	name = "Right Shipbreaker's Toolset Implant (Arc Welder + Crowbar + Wrench)"
	cost = 6
	path = /obj/item/organ/internal/cyberimp/arm/arc_welder/right_arm

/datum/augment_item/implant/r_arm/electrical_toolset
	name = "Right Electrical Toolset Implant (Screwdriver + Multitool)"
	cost = 8
	path = /obj/item/organ/internal/cyberimp/arm/electrical_toolset/right_arm

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
