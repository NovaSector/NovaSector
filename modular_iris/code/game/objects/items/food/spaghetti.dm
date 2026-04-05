/obj/item/food/spaghetti/copypasta
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)

// This entire is ironically full of copypasta because the crafting system would otherwise break out pastas
/obj/item/food/spaghetti/pastatomato/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/food/pasta_triple,
		/datum/crafting_recipe/food/pasta_tower,
		/datum/crafting_recipe/food/pasta_spire,
		/datum/crafting_recipe/food/pasta_babel,
	)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/food/spaghetti/copypasta/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/food/pasta_triple)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/food/spaghetti/triple
	name = "triple pasta"
	desc = "Three times the charm, afterall 3 pastas are better than one."
	icon = 'modular_iris/icons/obj/food/spaghetti.dmi'
	icon_state = "triple"
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/triple/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/food/pasta_tower)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/food/spaghetti/tower
	name = "pasta tower"
	desc = "Before you stands a pasta tower, others may try to make towers out of pizza but this one is the proper one."
	icon = 'modular_iris/icons/obj/food/spaghetti.dmi'
	icon_state = "tower"
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/tower/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/food/pasta_spire)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/food/spaghetti/spire
	name = "inSPIREd pasta"
	desc = "Very carefully built pasta tower, mainly composed of tomato cards for perfect synergy with the pasta."
	icon = 'modular_iris/icons/obj/food/spaghetti.dmi'
	icon_state = "spire"
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/spire/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/food/pasta_babel)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/food/spaghetti/babel
	name = "babel pasta"
	desc = "A large tower of pasta whose comprehension is byond the imaginable extent, perhaps humanity was not meant to go this far."
	icon = 'modular_iris/icons/obj/food/spaghetti.dmi'
	icon_state = "babel"
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/singularity
	name = "singu-pasta"
	desc = "A large amount of pasta squeezed into a very tight space creating an illusion of a tiny pasta singularity."
	icon = 'modular_iris/icons/obj/food/spaghetti.dmi'
	icon_state = "singularity"
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("infinity" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/singularity/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/food/expand_pasta_singularity)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
