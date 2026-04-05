/datum/design/diethylamine
	name = "Diethylamine"
	id = "diethylamine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/diethylamine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/saltpetre
	name = "Saltpetre"
	id = "saltpetre"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 0.5)
	make_reagent = /datum/reagent/saltpetre
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_CHEMICALS)

/datum/design/diskplantgene
	name = "Plant Data Disk"
	id = "diskplantgene"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/disk/plantgene
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)
