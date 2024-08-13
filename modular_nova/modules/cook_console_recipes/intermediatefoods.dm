// a few simple food items/reagents used as ingredients. mostly dried forms of normal foods to give the new dehydrator a use.
// they should be fine to use as normal foods and as ingredients for recipes, don't be shy!

/obj/item/food/driedfish
	name = "dried fish fillet"
	desc = "Technically fish jerky?"
	icon = 'modular_nova/modules/cook_console_recipes/icons.dmi'
	icon_state = "driedfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1, "dried meat" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	grind_results = list(/datum/reagent/consumable/bonito = 20)

/obj/item/food/fishmeat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/driedfish)

/obj/item/food/driedchili
	name = "dried chili"
	desc = "It's spicy! Wait... it's dry too."
	icon = 'modular_nova/modules/cook_console_recipes/icons.dmi'
	icon_state = "driedchili"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("dry heat" = 1)
	foodtypes = FRUIT
	grind_results = list(/datum/reagent/consumable/chilipowder = 20)

/obj/item/food/grown/chili/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/driedchili)

/obj/item/food/driedherbs
	name = "bundle of dried herbs"
	desc = "A bundle of various dried herbs. shouldn't be too hard to crumble up the one you want."
	icon = 'modular_nova/modules/cook_console_recipes/icons.dmi'
	icon_state = "driedherbs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("store bought herbs." = 1)
	foodtypes = VEGETABLES

/obj/item/food/grown/herbs/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/driedherbs)


/datum/reagent/consumable/bonito
	name = "bonito flakes"
	description = "Also known as \"Katsuobushi\", apparently!"
	color = "#fce2c7"
	taste_description = "Umami"
	taste_mult = 1.5


/datum/reagent/consumable/chilipowder
	name = "Chili Powder"
	description = "\"No, no, chili p's my signature!\""
	color = "#88100a"
	taste_description = "dry hot peppers"
	taste_mult = 1.5


/datum/reagent/consumable/onionjuice
	name = "Onion Juice"
	description = "Like tear juice but more palatable."
	color = "#1bf5ea"
	taste_description = "onion"

/obj/item/food/onion_slice
	grind_results = list(/datum/reagent/consumable/onionjuice = 20)



