// Ashwalker Bed
/obj/structure/bed/double/thatch
	name = "thatch bed"
	desc = "A rustic bed, made from thatch."
	icon_state = "thatch_bed"
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_beds.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	max_buckled_mobs = 2
	build_stack_type = /obj/item/stack/tile/grass/thatch
	build_stack_amount = 4

/obj/structure/bed/double/thatch/atom_deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/mineral/wood(loc, build_stack_amount)

/datum/crafting_recipe/thatch_bed
	name = "Thatch Bed"
	category = CAT_FURNITURE
	//recipe given to ashwalkers as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/tile/grass/thatch = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/double/thatch
