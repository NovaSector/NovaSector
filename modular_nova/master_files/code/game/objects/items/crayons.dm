//Removing the questionable stuff modularly.

/obj/item/toy/crayon/Initialize(mapload)
	. = ..()

	graffiti -= "prolizard"
	graffiti -= "antilizard"

	graffiti_large_h -= "furrypride"
	graffiti_large_h -= "yiffhell"
