/datum/export/food
	cost = 10
	unit_name = "serving"
	message = "of food"
	export_types = list(/obj/item/food)
	include_subtypes = TRUE
	exclude_types = list(/obj/item/food/grown,/obj/item/food/drug)

/datum/export/moon_rock
	cost = CARGO_CRATE_VALUE * 0.8
	unit_name = "moon rock"
	export_types = list(/obj/item/food/drug/moon_rock)
	include_subtypes = FALSE

/datum/export/blastoff_ampoule
	cost = CARGO_CRATE_VALUE * 1
	unit_name = "blastoff ampoule"
	export_types = list(/obj/item/reagent_containers/cup/blastoff_ampoule)
	include_subtypes = FALSE

/datum/export/blastoff_ampoule/get_base_cost(obj/item/reagent_containers/cup/blastoff_ampoule/ampoule)
	var/blastoff_amount = ampoule.reagents.get_reagent_amount(/datum/reagent/drug/blastoff)
	if(!blastoff_amount)
		return 0
	return (blastoff_amount * CARGO_CRATE_VALUE * 0.1)

/datum/export/saturnx
	cost = CARGO_CRATE_VALUE * 1
	unit_name = "saturnx glob"
	export_types = list(/obj/item/food/drug/saturnx)
	include_subtypes = FALSE
