/datum/design/biogen/frontier_ration/snacks
	abstract_type = /datum/design/biogen/frontier_ration/snacks
	name = "Frontier Snacks Basetype"
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/storage/box
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_AKHTER_FOODRICATOR_SNACKS,
	)

/datum/design/biogen/frontier_ration/snacks/gum
	name = "Gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum

/datum/design/biogen/frontier_ration/snacks/gum_wakeup
	name = "Activin 12 Hour Medicated Gum"
	build_path = /obj/item/storage/box/gum/wake_up

/datum/design/biogen/frontier_ration/snacks/energy_bar
	name = "High Power Energy Bar"
	build_path = /obj/item/food/energybar

/datum/design/biogen/frontier_ration/snacks/ciggies
	name = "Cigarettes"
	build_path = /obj/item/storage/fancy/cigarettes/cigpack_uplift

/datum/design/biogen/frontier_ration/snacks/engine_fodder
	name = "Engine Fodder"
	build_path = /obj/item/food/vendor_snacks/moth_bag

/datum/design/biogen/frontier_ration/snacks/fueljak_snack
	name = "Fueljack's Snack"
	build_path = /obj/item/food/vendor_snacks/moth_bag/fuel_jack

/datum/design/biogen/frontier_ration/snacks/ricecracker
	name = "Rice Crackers"
	build_path = /obj/item/food/vendor_snacks/rice_crackers
