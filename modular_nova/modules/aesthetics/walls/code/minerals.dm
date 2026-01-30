/turf/closed/mineral/random/volcanic/underground
	turf_type = /turf/open/misc/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/misc/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE
	mineralChance = 13

/turf/closed/mineral/random/volcanic/underground/mineral_chances()
	return list(
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stack/ore/diamond = 2,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/bananium = 1,
		/turf/closed/mineral/gibtonite = 2,
		/turf/closed/mineral/strange_rock/volcanic = 15,
	)
