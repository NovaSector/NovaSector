/datum/techweb_node/misc_cargo
	display_name = "Misc. Cargo Technology"
	description = "Cease crying! Contains copious Cargonian conundrum correction concepts. Can convey cargo correctly, circulate contemporaneously, cache compactly."
	prerequisite_nodes = list(/datum/techweb_node/bluespace_theory)
	unlocked_designs = list(
		/datum/design/conveyor_sorter,
		/datum/design/cargo_teleporter,
		/datum/design/goodycase_holder,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SUPPLY)
