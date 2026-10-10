/datum/design/biogen/hc_medical
	abstract_type = /datum/design/biogen/hc_medical
	name = "HC Medical Basetype"
	build_path = /obj/item/storage/pouch
	materials = list(/datum/material/biomass = 250)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HC_MEDICAL,
	)

/datum/design/biogen/hc_medical/pocket_medkit
	name = "Empty Pocket First Aid Kit"
	build_path = /obj/item/storage/pouch/cin_medkit

/datum/design/biogen/hc_medical/medipouch
	name = "Empty Medipen Pouch"
	build_path = /obj/item/storage/pouch/cin_medipens

/datum/design/biogen/hc_medical/genpouch
	name = "Empty General Purpose Pouch"
	build_path = /obj/item/storage/pouch/cin_general

/datum/design/biogen/hc_medical/sutures
	name = "Hemostatic Sutures"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture/bloody

/datum/design/biogen/hc_medical/mesh
	name = "Hemostatic Mesh"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh/bloody

/datum/design/biogen/hc_medical/bruise_patch
	name = "Bruise Patch"
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/applicator/patch/libital

/datum/design/biogen/hc_medical/burn_patch
	name = "Burn Patch"
	build_path = /obj/item/reagent_containers/applicator/patch/aiuri

/datum/design/biogen/hc_medical/gauze
	name = "Medical Gauze"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/hc_medical/epi_pill
	name = "Epinephrine Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/epinephrine

/datum/design/biogen/hc_medical/conv_pill
	name = "Convermol Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/convermol

/datum/design/biogen/hc_medical/multiver_pill
	name = "Multiver Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/multiver
