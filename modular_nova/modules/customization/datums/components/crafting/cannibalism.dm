/datum/crafting_recipe/food/fried_teshari
	name = "Blue Bird Chicken"
	reqs = list(
		/obj/item/food/meat/steak/chicken/tesh = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/corn_starch = 5,
		/obj/item/stack/sheet/cardboard = 1,
	)
	result = /obj/item/food/fried_teshari
	removed_foodtypes = RAW
	added_foodtypes = FRIED
	dish_category = DISH_MEAT

/datum/crafting_recipe/food/fried_vox
	name = "Green Bird Chicken"
	reqs = list(
		/obj/item/food/meat/slab/chicken/vox = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/corn_starch = 5,
		/obj/item/stack/sheet/cardboard = 1,
	)
	result = /obj/item/food/fried_vox
	removed_foodtypes = RAW
	added_foodtypes = FRIED
	dish_category = DISH_MEAT


/datum/crafting_recipe/food/chickenburger/human
	added_foodtypes = FRIED | GORE
	name = "Birdman Sandwich (Teshari)"
	reqs = list(
			/obj/item/food/patty/tesh/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/chicken/human
	dish_category = DISH_BURGER


