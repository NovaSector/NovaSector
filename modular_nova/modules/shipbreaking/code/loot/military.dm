/obj/effect/spawner/random/salvage/salvaged_gun
	name = "random salvage shuttle gun"
	icon_state = "armory"
	spawn_random_offset = FALSE
	loot = list(
		/obj/item/gun/ballistic/rifle/boltaction/surplus = 2,
		/obj/item/gun/ballistic/rifle/boltaction = 2,
		/obj/item/gun/ballistic/rifle/boltaction/prime = 1,
		/obj/item/gun/ballistic/rifle/rebarxbow = 1,
		/obj/item/gun/ballistic/rifle/sks = 1,
		/obj/item/gun/ballistic/rifle/sporterized/empty = 1,
		/obj/item/gun/ballistic/automatic/lanca = 2,
		/obj/item/gun/ballistic/automatic/mini_uzi = 2,
	)

/obj/effect/spawner/random/salvage/salvaged_gun/random_offset
	name = "randomly offset salvage shuttle gun"
	spawn_random_offset = TRUE
