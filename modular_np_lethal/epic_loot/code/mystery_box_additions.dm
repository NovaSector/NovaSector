GLOBAL_LIST_INIT(lethal_deathmatch_guns, list(
	/obj/effect/spawner/random/epic_loot/deathmatch_silly_arms,
	/obj/effect/spawner/random/epic_loot/deathmatch_silly_arms_blue,
	/obj/effect/spawner/random/epic_loot/deathmatch_serious_arms,
	/obj/effect/spawner/random/epic_loot/deathmatch_serious_arms_blue,
	/obj/effect/spawner/random/epic_loot/deathmatch_grenade_or_explosive,
))

GLOBAL_LIST_INIT(lethal_funny_mystery_box_items, list(
	/obj/effect/spawner/random/epic_loot/deathmatch_armor,
	/obj/effect/spawner/random/epic_loot/deathmatch_medkit,
	/obj/effect/spawner/random/epic_loot/deathmatch_funny,
))

/obj/structure/mystery_box/guns/generate_valid_types()
	valid_types = GLOB.lethal_deathmatch_guns

/obj/structure/mystery_box/tdome/generate_valid_types()
	valid_types = GLOB.lethal_deathmatch_guns + GLOB.lethal_funny_mystery_box_items
