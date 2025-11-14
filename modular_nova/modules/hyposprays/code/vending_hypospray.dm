/obj/machinery/vending/drugs/Initialize(mapload)
	var/area/ruin/interdyne_planetary_base/this_area = get_area(src)
	if(istype(this_area))
		products[/obj/item/storage/hypospraykit/interdyne] = 5
	else
		products[/obj/item/storage/hypospraykit] = 5
	. = ..()
