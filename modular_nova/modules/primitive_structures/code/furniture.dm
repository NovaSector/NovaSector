/obj/item/target/archery
	name = "archery target"
	desc = "A shooting target, specifically for bows."
	icon = 'modular_nova/modules/tribal_extended/icons/items_and_weapons.dmi'
	icon_state = "archery_target"
	bullet_impact_sound = SFX_BULLET_IMPACT_WOOD

/datum/crafting_recipe/archery_target

	name = "archery target"
	category = CAT_FURNITURE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF

	reqs = list(
		/obj/item/stack/tile/grass/thatch = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/item/target/archery
