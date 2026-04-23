#define TECHWEB_NODE_BEER_SYNTIZER "integrated beer syntizer"

/datum/techweb_node/beer_cyberimp
	id = TECHWEB_NODE_BEER_SYNTIZER
	display_name = "a REALLY USEFUL implant"
	description = "opens up the most needed thing in the world for everyone"
	prereq_ids = list(TECHWEB_NODE_INTERGRATED_TOOLSETS)
	design_ids = list("integrated beer syntizer")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE,RADIO_CHANNEL_SERVICE)

/datum/design/beer_cyberimp
	name = "integrated beer syntizer implantr"
	desc = "A stripped-down version of engineering cyborg toolset, designed to be installed on subject's arm."
	id = "integrated beer syntizer"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.25,
	)
	construction_time = 2 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/beer
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
