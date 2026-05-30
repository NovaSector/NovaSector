/// Used inside the foods prefs menu. Indicates that a food is toxic.
#define FOOD_PREFERENCE_TOXIC 1
/// Used inside the foods prefs menu. Indicates that a food is disliked.
#define FOOD_PREFERENCE_DISLIKED 2
/// Used inside the foods prefs menu. Indicates that a food is neither liked or disliked.
#define FOOD_PREFERENCE_NEUTRAL 3
/// Used inside the foods prefs menu. Indicates that a food is liked.
#define FOOD_PREFERENCE_LIKED 4
/// Used inside the food prefs menu. Indicates the value of this entry is the default food like/dislike value for the food.
#define FOOD_PREFERENCE_DEFAULT 5
/// Used inside the food prefs menu as an entry. If set to TRUE, the food is completely ignored by the verification system. Optional.
#define FOOD_PREFERENCE_OBSCURE 6

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
