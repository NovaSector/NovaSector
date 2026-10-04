/obj/effect/spawner/random/maintsrooms
	name = "random maintsrooms spawn"
	desc = "Spawns a random object, mob, or structure for the maintsrooms awaymission."
	loot = list(
		/turf/closed/wall/r_wall = 310,
		/turf/open/floor/white = 370,
		/obj/structure/table/reinforced = 230,
		/obj/effect/spawner/random/environmentally_safe_anomaly/immobile = 30,
		/obj/effect/decal/remains/human = 4,
		/obj/effect/decal/remains/robot = 4,
		/obj/effect/decal/remains/xeno = 4,
		/obj/structure/fluff/clockwork/clockgolem_remains = 4,
		/obj/item/raw_anomaly_core/random = 20,
		/obj/item/stack/sheet/mineral/zaukerite = 3,
		/obj/item/stack/sheet/mineral/runite = 4,
		/obj/item/stack/sheet/mineral/gold = 4,
		/obj/item/stack/sheet/mineral/diamond = 4,
		/obj/item/stack/sheet/mineral/adamantine = 3,
		/obj/item/stack/sheet/hauntium = 3,
		/obj/item/stack/telecrystal = 3,
		/obj/item/stack/ore/bluespace_crystal = 4,
	)

/// number count for myself, this is the remaining amount until the sum is 100
/// 0
/obj/effect/spawner/random/maintsrooms/make_item(spawn_loc, type_path_to_make)
	if(ispath(type_path_to_make, /turf) && isturf(spawn_loc))
		var/turf/spawn_turf = spawn_loc
		return spawn_turf.place_on_top(type_path_to_make)
	else
		return ..()

/obj/effect/spawner/random/maintsrooms/no_walls
	name = "random maintsrooms spawn (no walls)"

/obj/effect/spawner/random/maintsrooms/no_walls/New()
	loot[/turf/open/floor/white] = (loot[/turf/open/floor/white] + loot[/turf/closed/wall/r_wall])
	loot -= /turf/closed/wall/r_wall
	return ..()
