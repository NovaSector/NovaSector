/obj/item/pizzabox/random
	boxtag = "Randy's Surprise"
	boxtag_set = TRUE

/obj/item/pizzabox/random/Initialize(mapload)
	. = ..()
	if(!pizza)
		var/random_pizza = pick(EDIBLE_PIZZA_LIST)
		pizza = new random_pizza(src)
