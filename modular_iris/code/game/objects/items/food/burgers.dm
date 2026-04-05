/obj/item/food/burger/saturnburger
	name = "Saturn burger"
	icon = 'modular_iris/icons/obj/food/burger.dmi'
	icon_state = "saturnburger"
	desc = "A burger with an usually large onion slice."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "onion" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/mcpicklepounder
	name = "McPickle Pounder"
	icon = 'modular_iris/icons/obj/food/burger.dmi'
	desc = "A cheeseburger filled with a large amount of pickles."
	icon_state = "mcpicklepounder"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "pickle" = 4, "cheese" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/tomatonator
	name = "Tomatonator"
	icon = 'modular_iris/icons/obj/food/burger.dmi'
	desc = "A burger with a single massive tomato in the middle."
	icon_state = "tomatonator"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "beef patty" = 2, "tomato" = 4)
	foodtypes = GRAIN | MEAT | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/lilypadburger
	name = "lilypad burger"
	icon = 'modular_iris/icons/obj/food/burger.dmi'
	desc = "Is that a goddamn lilypad?"
	icon_state = "lilypadburger"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "lettuce" = 4, "cabbage" = 4)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2
