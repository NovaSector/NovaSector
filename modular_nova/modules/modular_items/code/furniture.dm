/obj/structure/bed/double/pelt/synthetic
	name = "white pelts bed"
	desc = "A luxurious double bed, made with synthetic white wolf pelts."
	icon_state = "pelt_bed_white"
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_beds.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	max_buckled_mobs = 2
	build_stack_type = /obj/item/stack/sheet/leather
	build_stack_amount = 4

/obj/structure/bed/double/pelt/atom_deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/mineral/wood(loc, build_stack_amount)

/datum/crafting_recipe/synth_white_pelt_bed
	name = "Synthetic White Pelts Bed"
	category = CAT_FURNITURE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/leather = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/double/pelt/synthetic

/obj/structure/bed/double/pelt/synthetic/black
	name = "black pelts bed"
	desc = "A luxurious double bed, made with synthetic black wolf pelts."
	icon_state = "pelt_bed_black"
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_beds.dmi'

/datum/crafting_recipe/synth_black_pelt_bed
	name = "Synthetic Black Pelts Bed"
	category = CAT_FURNITURE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/leather = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/double/pelt/synthetic/black

// Medieval oversized beds
/obj/structure/bed/oversized
	name = "single oversized bed"
	desc = "A luxurious bed, inviting you to rest on it, oh traveler."
	icon = 'modular_nova/master_files/icons/obj/medieval/structures_64x64.dmi'
	icon_state = "bed_1x2"
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 150
	integrity_failure = 0.35
	max_buckled_mobs = 2
	build_stack_type = /obj/item/stack/sheet/cloth
	build_stack_amount = 4

/obj/structure/bed/oversized/atom_deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/mineral/wood(loc, build_stack_amount)

/datum/crafting_recipe/oversized_bed
	name = "Single Oversized Bed"
	category = CAT_FURNITURE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/cloth = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/oversized

/obj/structure/bed/oversized/double
	name = "double oversized bed"
	icon = 'modular_nova/master_files/icons/obj/medieval/structures_64x64.dmi'
	icon_state = "bed_2x2"
	max_buckled_mobs = 2
	build_stack_amount = 8

/datum/crafting_recipe/oversized_bed_double
	name = "Double Oversized Bed"
	category = CAT_FURNITURE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/cloth = 8,
		/obj/item/stack/sheet/mineral/wood = 8,
	)

	result = /obj/structure/bed/oversized/double
