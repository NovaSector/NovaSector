// modularizes lethalmoney into the money spawners

/obj/effect/spawner/random/entertainment/money_small_lethal
	name = "lethalstation small money spawner"
	icon_state = "cash"
	spawn_loot_count = 1
	spawn_loot_split = TRUE
	loot = list(
		/obj/item/lethalcash/c1 = 5,
		/obj/item/lethalcash/c10 = 3,
		/obj/item/lethalcash/c20 = 2,
	)

/obj/effect/spawner/random/entertainment/money_lethal
	name = "lethalstation money spawner"
	icon_state = "cash"
	spawn_loot_count = 1
	spawn_loot_split = TRUE
	loot = list(
		/obj/item/lethalcash/c1 = 10,
		/obj/item/lethalcash/c10 = 5,
		/obj/item/lethalcash/c20 = 3,
		/obj/item/lethalcash/c50 = 2,
		/obj/item/lethalcash/c100 = 1,
	)

/obj/effect/spawner/random/entertainment/money_medium_lethal
	name = "lethalstation medium money spawner"
	icon_state = "cash"
	spawn_loot_count = 1
	loot = list(
		/obj/item/lethalcash/c100 = 25,
		/obj/item/lethalcash/c200 = 15,
		/obj/item/lethalcash/c50 = 10,
		/obj/item/lethalcash/c500 = 5,
		/obj/item/lethalcash/c1000 = 1,
	)

/obj/effect/spawner/random/entertainment/money_large_lethal
	name = "lethalstation large money spawner"
	icon_state = "cash"
	spawn_loot_count = 1
	spawn_loot_split = TRUE
	loot = list(
		/obj/item/lethalcash/c1 = 100,
		/obj/item/lethalcash/c10 = 80,
		/obj/item/lethalcash/c20 = 60,
		/obj/item/lethalcash/c50 = 40,
		/obj/item/lethalcash/c100 = 30,
		/obj/item/lethalcash/c200 = 20,
		/obj/item/lethalcash/c500 = 10,
		/obj/item/lethalcash/c1000 = 5,
	)

/obj/item/storage/briefcase/secure/syndie/lethal //one of those things people may like to have
	force = 15

/obj/item/storage/briefcase/secure/syndie/lethal/PopulateContents()
	. = ..()
	for(var/iterator in 1 to 5)
		new /obj/item/lethalcash/c1000(src)
