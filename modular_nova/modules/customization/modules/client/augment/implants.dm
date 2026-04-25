/datum/augment_item/implant
	abstract_type = /datum/augment_item/implant
	category = AUGMENT_CATEGORY_IMPLANTS
	/// Whether this organ augment is visible from outside or not
	var/has_visual

/datum/augment_item/implant/New()
	// Figure out if we should visually apply or not

	// Cyberimp overlays - yes!
	if(ispath(path, /obj/item/organ/cyberimp))
		var/obj/item/organ/cyberimp/cybernetic_path = path
		has_visual = !isnull(cybernetic_path::aug_overlay)
		return ..()

	// otherwise go by the organ's visual var
	var/obj/item/organ/organ_path = path
	has_visual = organ_path::visual
	return ..()

/datum/augment_item/implant/apply(mob/living/carbon/human/organ_receiver, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup && !has_visual)
		return
	var/obj/item/organ/new_organ = new path
	new_organ.Insert(organ_receiver, special = FALSE, movement_flags = DELETE_IF_REPLACED)

//CHEST IMPLANTS
/datum/augment_item/implant/chest
	slot = AUGMENT_SLOT_CHEST
	slot_flag = CHEST
	body_zone = BODY_ZONE_CHEST

/datum/augment_item/implant/chest/nutriment_pump
	name = "Nutriment Pump"
	cost = 4
	path = /obj/item/organ/cyberimp/chest/nutriment

/datum/augment_item/implant/chest/optical_camo
	name = "Optical Camouflage Implant"
	cost = 9
	path = /obj/item/organ/cyberimp/chest/opticalcamo

/datum/augment_item/implant/chest/internal_health_analyzer/lite
	name = "Internal Health Analyzer"
	cost = 6
	path = /obj/item/organ/cyberimp/chest/scanner/lite

//LEFT ARM IMPLANTS
/datum/augment_item/implant/l_arm
	slot = AUGMENT_SLOT_L_ARM
	slot_flag = ARM_LEFT
	body_zone = BODY_ZONE_L_ARM

/datum/augment_item/implant/l_arm/mantis_blade_left
	name = "Obsolete Mantis Blade"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/armblade/early/l

/datum/augment_item/implant/l_arm/charging_implant
	name = "Charging Cord Implant"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/left_arm

/datum/augment_item/implant/l_arm/civilian_lighter
	name = "Thumbtip Lighter"
	cost = 2
	path = /obj/item/organ/cyberimp/arm/toolkit/civilian_lighter/left_arm

/datum/augment_item/implant/l_arm/razor_claws
	name = "Razor Claws"
	extra_info = "Knife + Wirecutters"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/left_arm

/datum/augment_item/implant/l_arm/adjuster
	name = "Adjuster Implant"
	extra_info = "Screwdriver + Wrench"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/adjuster/left_arm

/datum/augment_item/implant/l_arm/bureaucracy
	name = "Bureaucrat's 'Jacent' Toolset Implant"
	extra_info = "4-colour Pen + Small Paper Bin + Approve/Deny Stamps"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/bureaucracy/left_arm

/datum/augment_item/implant/l_arm/cargo
	name = "FTU 'Deckhand' Toolset Implant"
	extra_info = "Universal Scanner + Boxcutter"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/cargo/left_arm

/datum/augment_item/implant/l_arm/civilian_barstaff
	name = "Waitstaff's Toolset Implant"
	extra_info = "Serving Tray + Rag"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff/left_arm

/datum/augment_item/implant/l_arm/emt_triage
	name = "Triage Actuator Implant"
	extra_info = "Drapes + Retractor + Hemostat"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/emt_triage/left_arm

/datum/augment_item/implant/l_arm/blacksteel_forging
	name = "Blacksteel 'Starforge' Toolset Implant"
	extra_info = "Forging Hammer + Tongs + Bellows"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/left_arm

/datum/augment_item/implant/l_arm/arc_welder
	name = "Shipbreaker's Toolset Implant"
	extra_info = "Arc Welder + Crowbar + Wrench"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/arc_welder/left_arm

/datum/augment_item/implant/l_arm/electrical_toolset
	name = "Electrical Toolset Implant"
	extra_info = "Screwdriver + Multitool + Wirecutters"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/left_arm

/datum/augment_item/implant/l_arm/mining_drill
	name = "Daiba Masterworks 'Burrower' Drill"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/mining_drill/left_arm

//RIGHT ARM IMPLANTS
/datum/augment_item/implant/r_arm
	slot = AUGMENT_SLOT_R_ARM
	slot_flag = ARM_RIGHT
	body_zone = BODY_ZONE_R_ARM

/datum/augment_item/implant/r_arm/mantis_blade_right
	name = "Obsolete Mantis Blade"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/armblade/early

/datum/augment_item/implant/r_arm/charging_implant
	name = "Charging Cord Implant"
	path = /obj/item/organ/cyberimp/arm/toolkit/power_cord/right_arm

/datum/augment_item/implant/r_arm/civilian_lighter
	name = "Thumbtip Lighter"
	cost = 2
	path = /obj/item/organ/cyberimp/arm/toolkit/civilian_lighter/right_arm

/datum/augment_item/implant/r_arm/razor_claws
	name = "Razor Claws"
	extra_info = "Knife + Wirecutters"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/razor_claws/right_arm

/datum/augment_item/implant/r_arm/adjuster
	name = "Adjuster Implant"
	extra_info = "Screwdriver + Wrench"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/adjuster/right_arm

/datum/augment_item/implant/r_arm/bureaucracy
	name = "Bureaucrat's 'Jacent' Toolset Implant"
	extra_info = "4-colour Pen + Small Paper Bin + Approve/Deny Stamps"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/bureaucracy/right_arm

/datum/augment_item/implant/r_arm/cargo
	name = "FTU 'Deckhand' Toolset Implant"
	extra_info = "Universal Scanner + Boxcutter"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/cargo/right_arm

/datum/augment_item/implant/r_arm/civilian_barstaff
	name = "Waitstaff's Toolset Implant"
	extra_info = "Serving Tray + Rag"
	cost = 4
	path = /obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff/right_arm

/datum/augment_item/implant/r_arm/emt_triage
	name = "Triage Actuator Implant"
	extra_info = "Drapes + Retractor + Hemostat"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/emt_triage/right_arm

/datum/augment_item/implant/r_arm/blacksteel_forging
	name = "Blacksteel 'Starforge' Toolset Implant"
	extra_info = "Forging Hammer + Tongs + Bellows"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/right_arm

/datum/augment_item/implant/r_arm/arc_welder
	name = "Shipbreaker's Toolset Implant"
	extra_info = "Arc Welder + Crowbar + Wrench"
	cost = 6
	path = /obj/item/organ/cyberimp/arm/toolkit/arc_welder/right_arm

/datum/augment_item/implant/r_arm/electrical_toolset
	name = "Electrical Toolset Implant"
	extra_info = "Screwdriver + Multitool + Wirecutters"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/right_arm

/datum/augment_item/implant/r_arm/mining_drill
	name = "Daiba Masterworks 'Burrower' Drill"
	cost = 8
	path = /obj/item/organ/cyberimp/arm/toolkit/mining_drill/right_arm
