// Peacekeeper armor
// 250 doesn't seem like a massive amount until you realize
// They only take at most 12 damage a hit

/obj/item/clothing/suit/armor/sf_peacekeeper
	max_integrity = 250
	limb_integrity = 250
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam

/obj/item/clothing/suit/armor/sf_peacekeeper/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>robotic repair spray</b>.")

/obj/item/clothing/head/helmet/sf_peacekeeper
	max_integrity = 250
	limb_integrity = 250
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam

/obj/item/clothing/suit/armor/sf_peacekeeper/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>robotic repair spray</b>.")

// Hardened armor
// These have less integrity because they nullify armor penetration before being hit

/obj/item/clothing/suit/armor/sf_hardened
	max_integrity = 200
	limb_integrity = 200
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/suit/armor/sf_hardened/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/head/helmet/toggleable/sf_hardened
	max_integrity = 200
	limb_integrity = 200
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/head/helmet/toggleable/sf_hardened/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

// Sacrificial armor, which needs a lot of health because of its high damage reduction

/obj/item/clothing/suit/armor/sf_sacrificial
	max_integrity = 400
	limb_integrity = 400
	slowdown = 0.25
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/suit/armor/sf_sacrificial/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

/obj/item/clothing/head/helmet/sf_sacrificial
	max_integrity = 400
	limb_integrity = 400
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam_super

/obj/item/clothing/head/helmet/sf_sacrificial/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>premium robotic repair spray</b>.")

// Frontier soft armor
// These have like security level armor, but the like 5 damage reduction might save you idk

/obj/item/clothing/suit/frontier_colonist_flak
	max_integrity = 500
	limb_integrity = 500

/obj/item/clothing/head/frontier_colonist_helmet
	max_integrity = 500
	limb_integrity = 500

// CIN larp armor

/obj/item/clothing/head/helmet/cin_surplus_helmet
	max_integrity = 200
	limb_integrity = 200
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam

/obj/item/clothing/head/helmet/cin_surplus_helmet/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>robotic repair spray</b>.")

/obj/item/clothing/suit/armor/vest/cin_surplus_vest
	max_integrity = 200
	limb_integrity = 200
	repairable_by = /obj/item/stack/medical/wound_recovery/robofoam

/obj/item/clothing/suit/armor/vest/cin_surplus_vest/examine(mob/user)
	. = ..()
	. += span_notice("In a pinch, it can be <b>repaired</b> with <b>robotic repair spray</b>.")
