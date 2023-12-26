/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/lavaland/nova
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
/*------*/

/datum/map_template/ruin/lavaland/ash_walker
	name = "Ash Walker Nest"
	id = "ash-walker"
	description = "A race of unbreathing lizards live here, that run faster than a human can, worship a broken dead city, and are capable of reproducing by something involving tentacles? \
	Probably best to stay clear."
	prefix = "_maps/RandomRuins/LavaRuins/nova/"
	suffix = "lavaland_surface_ash_walker1_nova.dmm"
	cost = 1000
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/nova/interdyne_base
	name = "Interdyne Pharmaceutics Nova Sector Base 3c76928"
	id = "lava-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	suffix = "lavaland_surface_interdyne_base_nova.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/icemoon/underground/nova/interdyne_base)
	always_place = TRUE

