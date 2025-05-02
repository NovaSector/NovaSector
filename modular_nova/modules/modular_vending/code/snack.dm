/obj/machinery/vending/snack/Initialize(mapload)
	if(check_holidays("Four-Twenty"))
		products_nova += list(
				/obj/item/food/brownie/thc = 6,
				/obj/item/food/thcgummies = 6,
				/obj/item/food/cookie/thc = 6,
			)
	return ..()
