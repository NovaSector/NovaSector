// mrsanderp's donator items

/obj/item/food/donator/miso_pasta
	name = "miso pasta"
	desc = "A popular Martian-Italian fusion food. Dashi noodle broth served under spaghetti noodles and topped with herbs and mushrooms."
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "misonoodle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment = 4
	)
	tastes = list("miso broth" = 1, "dough" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donator/red_bay_chicken_meatballs
	name = "red bay chicken meatballs"
	desc = "Chicken meatballs seasoned with Red Bay seasoning, before being skewered by wooden rods. A popular dish in the Marisian settlement of Red Italy."
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "redbayballs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("spicy meatballs" = 1, "chicken" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donator/tiramisu
	name = "tiramisu"
	desc = "A dessert dish consisting of layered thin pastries, dipped in coffee and iced with cream and cocoa. Rumored in the past to help with marital problems in the bedroom."
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "tiramisu"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/coffee = 3,
		/datum/reagent/consumable/coco = 2
	)
	tastes = list("coffee" = 1, "pastry" = 1 , "sugar" = 1)
	foodtypes = SUGAR | GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donator/red_planet_parm
	name = "red planet parm"
	desc = "A fried chicken parmigiana hoagie made with rice bread and topped with tomato sauce and parmesan cheese. A proud symbol of the mixture of Terran-Italian and Martian cultures that inhabit the settlement of Red Italy."
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "chickenparm"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2
	)
	tastes = list("rice dough" = 1, "chicken" = 1, "tomatoes" = 1, "cheese" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/donator/aubergine_rolls
	name = "aubergine rolls"
	desc = "Eggplant slices rolled and wrapped around melted cheese, before seasoned with tomato sauce and olive oil. Simple, yet filling!"
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "auberginerolls"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("eggplant" = 1, "cheese" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donator/pineapple_trifle
	name = "pineapple trifle"
	desc = "Beloved by both Martians and Terran-Italians, the pineapple trifle is a custard lined with pastries, and topped with both dried pineapples and pineapple syrup. A perfect New Years dessert!"
	icon = 'modular_nova/modules/mrsanderp_foods/icons/martian_italian.dmi'
	icon_state = "pineappletrifle"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("pineapple" = 1, "pastry" = 1 , "sugar" = 1)
	foodtypes = SUGAR | GRAIN | FRUIT | DAIRY | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
