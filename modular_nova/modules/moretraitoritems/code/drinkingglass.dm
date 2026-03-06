/obj/item/reagent_containers/cup/glass/drinkingglass/shotglass/syndicate
	gulp_size = 50
	amount_per_transfer_from_this = 50
	possible_transfer_amounts = list(50)
	volume = 50
	initial_reagent_flags = REFILLABLE | DRAINABLE | DUNKABLE // no transparent (go ahead. get oneshot by the 50u ultrashot idiot)

/obj/item/storage/box/syndieshotglasses
	name = "box of shot glasses"
	desc = "It has a picture of shot glasses on it."
	illustration = "drinkglass"

/obj/item/storage/box/syndieshotglasses/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/glass/drinkingglass/shotglass/syndicate(src)
