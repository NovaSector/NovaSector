//Removing the questionable stuff modularly.

/obj/item/toy/crayon/Initialize(mapload)
	. = ..()

	graffiti -= list(
		"prolizard", 
		"antilizard",
	)
	
	graffiti_large_h -= list(
		"furrypride", 
		"yiffhell",
	)
