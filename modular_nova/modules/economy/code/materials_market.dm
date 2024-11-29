// Behavior overrides for the Galactic Materials Market

/obj/machinery/materials_market
	desc = "This machine allows the user to buy sheets of minerals \
	across the system. It once allowed the sale of excess minerals as well, but after the Great Crash of 2564, nobody buys materials from the frontier anymore. \
		Prices are known to fluctuate quite often, sometimes even within the same minute. All transactions are final."

/obj/machinery/materials_market/attackby(obj/item/attacking_item, mob/user, params)
	if(is_type_in_list(attacking_item, exportable_material_items))
		say("Selling materials to the GMM is no longer available due to volatile logistics conditions in frontier space. Please export your materials via standard Union-NT cargo arrangements.")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, FALSE)
		return TRUE
	return ..()
