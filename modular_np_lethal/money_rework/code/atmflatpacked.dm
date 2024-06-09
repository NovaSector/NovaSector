// atm flatpack stuff

#define FABRICATOR_CATEGORY_FLATPACK_MACHINES "/Flatpacked Machines"
#define FABRICATOR_SUBCATEGORY_MANUFACTURING "/Manufacturing"
#define FABRICATOR_SUBCATEGORY_POWER "/Power"
#define FABRICATOR_SUBCATEGORY_MATERIALS "/Materials"
#define FABRICATOR_SUBCATEGORY_ATMOS "/Atmospherics"


/datum/techweb_node/colony_fabricator_flatpacks_money
	id = "colony_fabricator_flatpacks"
	display_name = "Colony Fabricator Flatpack Designs"
	description = "Contains all of the colony fabricator's flatpack machine designs."
	design_ids = list(
		"flatpack_atm",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 69420) // haha sex
	hidden = TRUE
	show_on_wiki = FALSE
	starting_node = TRUE

/datum/design/flatpack_atm
	name = "Flat-Packed Banking Terminal"
	desc = "A convenient way to store necessary currency through a peer-to-peer trans-spatial \
		banking network. Low-risk, but no-reward."
	id = "flatpack_atm"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
	build_path = /obj/item/flatpacked_machine/atm
	category = list(
		RND_CATEGORY_INITIAL,
		FABRICATOR_CATEGORY_FLATPACK_MACHINES + FABRICATOR_SUBCATEGORY_MATERIALS,
	)
	construction_time = 30 SECONDS

#undef FABRICATOR_CATEGORY_FLATPACK_MACHINES
#undef FABRICATOR_SUBCATEGORY_MANUFACTURING
#undef FABRICATOR_SUBCATEGORY_POWER
#undef FABRICATOR_SUBCATEGORY_MATERIALS
#undef FABRICATOR_SUBCATEGORY_ATMOS
