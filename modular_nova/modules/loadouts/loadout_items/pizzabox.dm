/// Handpicked list of various pizzas and "pizzas" to make sure it's both 'safe' (human-edible) and doesn't spawn the base type like the bomb pizza can.
#define EDIBLE_PIZZA_LIST list( \
	/obj/item/food/pizza/margherita, \
	/obj/item/food/pizza/meat, \
	/obj/item/food/pizza/mushroom, \
	/obj/item/food/pizza/vegetable, \
	/obj/item/food/pizza/donkpocket, \
	/obj/item/food/pizza/dank, \
	/obj/item/food/pizza/sassysage, \
	/obj/item/food/pizza/pineapple, \
	/obj/item/food/pizza/mothic_margherita, \
	/obj/item/food/pizza/mothic_firecracker, \
	/obj/item/food/pizza/mothic_five_cheese, \
	/obj/item/food/pizza/mothic_white_pie, \
	/obj/item/food/pizza/mothic_pesto, \
	/obj/item/food/pizza/mothic_garlic, \
	/obj/item/food/pizza/flatbread/rustic, \
	/obj/item/food/pizza/flatbread/italic, \
	/obj/item/food/pizza/flatbread/zmorgast, \
	/obj/item/food/pizza/flatbread/fish, \
	/obj/item/food/pizza/flatbread/mushroom, \
	/obj/item/food/pizza/flatbread/nutty, \
)
/// Pizzas that we aren't allowed to pick, for one reason or another.
#define EXCLUDED_PIZZA_LIST list( \
	/obj/item/food/pizza/custom, \
	/obj/item/food/pizza/flatbread, \
	/obj/item/food/pizza/arnold, \
	/obj/item/food/pizza/margherita/raw, \
	/obj/item/food/pizza/meat/raw, \
	/obj/item/food/pizza/mushroom/raw, \
	/obj/item/food/pizza/vegetable/raw, \
	/obj/item/food/pizza/donkpocket/raw, \
	/obj/item/food/pizza/dank/raw, \
	/obj/item/food/pizza/sassysage/raw, \
	/obj/item/food/pizza/pineapple/raw, \
	/obj/item/food/pizza/arnold/raw, \
	/obj/item/food/pizza/energy/raw, \
)

/obj/item/pizzabox/random
	boxtag = "Randy's Surprise"
	boxtag_set = TRUE

/obj/item/pizzabox/random/Initialize(mapload)
	. = ..()
	if(!pizza)
		var/random_pizza = pick(EDIBLE_PIZZA_LIST)
		pizza = new random_pizza(src)

#undef EDIBLE_PIZZA_LIST
#undef EXCLUDED_PIZZA_LIST
