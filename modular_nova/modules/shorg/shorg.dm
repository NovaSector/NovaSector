/mob/living/basic/pet/dog/shorg // I had thought of a different names such as shitten(shark+kitten), but shorg sounds fine
	name = "\improper shorg"
	real_name = "shorg"
	desc = "It's an adorable mix of dog and shark with not so adorable species name - shorg."
	icon = 'modular_nova/modules/shorg/pets.dmi'
	held_lh = 'modular_nova/modules/shorg/pets_held_lh.dmi'
	held_rh = 'modular_nova/modules/shorg/pets_held_rh.dmi'
	icon_state = "shorg"
	icon_living = "shorg"
	icon_dead = "shorg_dead"
	collar_icon_state = "shorg"
	held_state = "shorg"
	butcher_results = list(/obj/item/food/fishmeat/quality = 3, /obj/item/food/meat/slab/corgi = 1)
	gold_core_spawnable = FRIENDLY_SPAWN
	collar_icon_state = "shorg"
	held_state = "shorg"
	faction = list(FACTION_NEUTRAL, FACTION_CARP) // Carps wont attack it
	obj_damage = 5
	melee_damage_lower = 8
	melee_damage_upper = 16
	wound_bonus = 15 // Shark(shorg?) bites

/datum/supply_pack/critter/corgis/shorg
	name = "Shorg Crate"
	desc = "Contains a single shorg - a shark-corgi hybrid. Adorable."
	cost = CARGO_CRATE_VALUE * 10
	contains = list(/mob/living/basic/pet/dog/shorg)
	crate_name = "shorg crate"
