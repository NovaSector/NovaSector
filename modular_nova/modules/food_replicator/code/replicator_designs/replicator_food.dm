/datum/design/biogen/hc_food
	name = "HC Food Basetype"
	id = DESIGN_ID_IGNORE
	build_path = /obj/item/storage/box/colonial_rations
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HC_FOOD,
	)

/datum/design/biogen/hc_food/ration
	name = "Foreign Colonization Ration"
	id = "slavic_mre"
	materials = list(/datum/material/biomass = 550)
	build_path = /obj/item/storage/box/colonial_rations

/datum/design/biogen/hc_food/pljeskavica
	name = "Foreign Colonization Ration, Main Course"
	id = "slavic_burger"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_main

/datum/design/biogen/hc_food/nachos
	name = "Foreign Colonization Ration, Side Dish"
	id = "mexican_chips"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_side

/datum/design/biogen/hc_food/blins
	name = "Foreign Colonization Ration, Dessert"
	id = "slavic_crepes"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_dessert

///Despite being in the medical.dm file, it's still used to fill your hunger up, as such, technically, is food.
/datum/design/biogen/hc_food/glucose
	name = "EVA Glucose Injector"
	id = "slavic_glupen"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/hypospray/medipen/glucose

/datum/design/biogen/hc_food/spork
	name = "Foreign Colonization Ration, Utensils"
	id = "slavic_utens"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/storage/box/utensils

/datum/design/biogen/hc_food/bubblegum
	name = "Foreign Colonization Ration, Bubblegum Pack"
	id = "slavic_gum"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/colonial

/datum/design/biogen/hc_food/cup
	name = "Empty Paper Cup"
	id = "slavic_cup"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty

/datum/design/biogen/hc_food/tea
	name = "Powdered Black Tea"
	id = "slavic_tea"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_tea

/datum/design/biogen/hc_food/coffee
	name = "Powdered Coffee"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coffee

/datum/design/biogen/hc_food/cocoa
	name = "Powdered Hot Chocolate"
	id = "slavic_coco"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coco

/datum/design/biogen/hc_food/lemonade
	name = "Powdered Lemonade"
	id = "slavic_lemon"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_lemonade

/datum/design/biogen/hc_food/replicator_sugar
	name = "Sugar"
	id = "slavic_sugar"
	materials = list(/datum/material/biomass = 5)
	make_reagent = /datum/reagent/consumable/sugar

/datum/design/biogen/hc_food/powdered_milk
	name = "Powdered Milk"
	id = "slavic_milk"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_milk

/datum/design/biogen/hc_food/water
	name = "Water"
	id = "slavic_water"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/water
