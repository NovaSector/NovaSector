/datum/techweb_node/misc_cargo
	id = TECHWEB_NODE_MISC_CARGO
	display_name = "Misc. Cargo Technology"
	description = "Cease crying! Contains copious Cargonian conundrum correction concepts. Can convey cargo correctly, circulate contemporaneously, cache compactly."
	prereq_ids = list(TECHWEB_NODE_BLUESPACE_THEORY)
	design_ids = list(
		"conveysorter",
		"cargotele",
		"goodycase_holder",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
