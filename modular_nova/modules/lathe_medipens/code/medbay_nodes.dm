/datum/techweb_node/medbay_equip_adv
	id = TECHWEB_NODE_MEDBAY_MEDIPENS
	display_name = "Auto-Injecting 'Medipen' Syringes"
	description = "Advanced auto-injecting syringes, called 'medipens'. Used for automatically injecting medications into patients."
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP_ADV)
	design_ids = list(
		"medipen_universal",
		"medipen_epinephrine",
		"medipen_atropine",
		"medipen_salbutamol",
		"medipen_oxandrolone",
		"medipen_salacid",
		"medipen_penacid",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
