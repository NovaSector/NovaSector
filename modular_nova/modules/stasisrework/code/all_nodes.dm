/datum/techweb_node/cryostasis/
	display_name = "Cryostasis Technology"
	description = "Smart freezing of objects to preserve them!"
	prereq_ids = list("exp_tools", "chem_synthesis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/cryostasis/New()
	design_ids += list(
		"stasisbag",
	)
	return ..()
