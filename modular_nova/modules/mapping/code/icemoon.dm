/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"
/*------*/

/datum/map_template/ruin/icemoon/underground/nova/mining_site_below
	name = "Ice-ruin Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_mining_site.dmm"
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/interdyne_base
	name = "Ice-ruin Interdyne Pharmaceuticals Nova Sector Base 8817238"
	id = "ice-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_interdyne_base1.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/nova/interdyne_base)
	always_place = TRUE
