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
