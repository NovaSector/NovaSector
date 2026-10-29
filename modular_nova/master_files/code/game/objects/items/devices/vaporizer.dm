/obj/item/vaporizer
	desc = "An ingenious little device manufactured for supporting an alternative method for respiration. \
			Relying on a removable cell, the coil mechanism synthesizes a hydrogen oxygen mixture, \
			which can then be used to moisturize the wearer's gills. \n\
			The rate at which liquid is applied seems to be intended for skin which excels at retaining moisture. \n\
			A label on its back warns about the potential dangers of electro-magnetic pulses."
	// reduced power cost to last a little bit longer,
	// but still generally need charging once a round.
	power_cost = 25 JOULES

/datum/design/vaporizer
	name = "Hydro-Vaporizer"
	desc = "A hydro-vaporizer without a cell. It makes Akulans and other water breathers wet so they can survive."
	build_type = PROTOLATHE | AWAY_LATHE
	materials = /obj/item/vaporizer::custom_materials
	build_path = /obj/item/vaporizer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING
