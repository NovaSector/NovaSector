// mrsanderp's donator item
/datum/crafting_recipe/food/miso_pasta
	name = "Miso Pasta"
	reqs = list(
		/obj/item/food/spaghetti/boiledspaghetti = 1,
		/obj/item/food/grown/mushroom/chanterelle = 1,
		/datum/reagent/consumable/nutriment/soup/dashi = 15,
		/obj/item/reagent_containers/cup/bowl = 1
	)
	result = /obj/item/food/donator/miso_pasta
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	dish_category = DISH_NOODLES
	meal_category = MEAL_MAIN_COURSE
	cuisine_category = CUISINE_MARTIAN

// mrsanderp's donator item
/datum/crafting_recipe/food/red_bay_chicken_meatballs
	name = "Red Bay Chicken Meatballs"
	reqs = list(
		/datum/reagent/consumable/red_bay = 1,
		/obj/item/food/meatball/chicken = 3,
		/obj/item/food/grown/herbs = 2,
		/obj/item/popsicle_stick = 2
	)
	result = /obj/item/food/donator/red_bay_chicken_meatballs
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	dish_category = DISH_MEAT
	meal_category = MEAL_SNACK
	cuisine_category = CUISINE_MARTIAN

// mrsanderp's donator item
/datum/crafting_recipe/food/tiramisu
	name = "Tiramisu"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/datum/reagent/consumable/coffee = 10,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/cream = 10,
		/obj/item/food/chocolatebar = 1
	)
	result = /obj/item/food/donator/tiramisu
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	dish_category = DISH_PASTRY
	meal_category = MEAL_DESSERT
	cuisine_category = CUISINE_MARTIAN

// mrsanderp's donator item
/datum/crafting_recipe/food/red_planet_parm
	name = "Red Planet Parm"
	reqs = list(
		/obj/item/food/breadslice/reispan = 2,
		/obj/item/food/meat/steak/chicken = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/cheese/firm_cheese_slice = 1
	)
	result = /obj/item/food/donator/red_planet_parm
	dish_category = DISH_SANDWICH
	meal_category = MEAL_MAIN_COURSE
	cuisine_category = CUISINE_MARTIAN
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	removed_foodtypes = RAW

// mrsanderp's donator item
/datum/crafting_recipe/food/aubergine_rolls
	name = "Aubergine Rolls"
	reqs = list(
		/datum/reagent/consumable/nutriment/fat/oil/olive = 2,
		/obj/item/food/grown/eggplant = 1,
		/obj/item/food/cheese/mozzarella = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/donator/aubergine_rolls
	dish_category = DISH_SALAD
	meal_category = MEAL_APPETIZER
	cuisine_category = CUISINE_MARTIAN
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

// mrsanderp's donator item
/datum/crafting_recipe/food/pineapple_trifle
	name = "Pineapple Trifle"
	reqs = list(
		/obj/item/food/pineappleslice = 2,
		/obj/item/food/pastrybase = 1,
		/datum/reagent/consumable/cream = 15,
		/datum/reagent/consumable/pineapplejuice = 10,
		/datum/reagent/consumable/sugar = 5,
	)
	result = /obj/item/food/donator/pineapple_trifle
	dish_category = DISH_PASTRY
	meal_category = MEAL_DESSERT
	cuisine_category = CUISINE_MARTIAN
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	added_foodtypes = SUGAR
