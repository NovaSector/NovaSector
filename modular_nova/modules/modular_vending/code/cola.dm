/obj/machinery/vending/cola
	products_nova = list(
		/obj/item/reagent_containers/cup/soda_cans/nova/lubricola = 10,
		/obj/item/reagent_containers/cup/soda_cans/nova/welding_fizz = 10,
		/obj/item/reagent_containers/cup/soda_cans/thc = 10,
	)

/obj/machinery/vending/cola/Initialize(mapload)
	if(check_holidays("Four-Twenty"))
		products_nova += list(
				/obj/item/reagent_containers/cup/soda_cans/thc = 10,
			)
	return ..()
