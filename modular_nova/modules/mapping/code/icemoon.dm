/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"
/*------*/

/datum/map_template/ruin/icemoon/underground/nova/mining_site_below
	name = "Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	suffix = "icemoon_underground_mining_site_nova.dmm"
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/interdyne_base
	name = "Interdyne Pharmaceutics Nova Sector Base 8817238"
	id = "ice-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	suffix = "icemoon_underground_interdyne_base1_nova.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/nova/interdyne_base)
	always_place = TRUE
