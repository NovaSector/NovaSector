/datum/design/biogen/hc_food
	abstract_type = /datum/design/biogen/hc_food
	name = "HC Food Basetype"
	build_path = /obj/item/storage/box/colonial_rations
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_HC_FOOD,
	)

/datum/design/biogen/hc_food/ration
	name = "Foreign Colonization Ration"
	materials = list(/datum/material/biomass = 550)
	build_path = /obj/item/storage/box/colonial_rations

/datum/design/biogen/hc_food/pljeskavica
	name = "Foreign Colonization Ration, Main Course"
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_main

/datum/design/biogen/hc_food/nachos
	name = "Foreign Colonization Ration, Side Dish"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_side

/datum/design/biogen/hc_food/blins
	name = "Foreign Colonization Ration, Dessert"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/effect/spawner/random/food_or_drink/colonial_dessert

///Despite being in the medical.dm file, it's still used to fill your hunger up, as such, technically, is food.
/datum/design/biogen/hc_food/glucose
	name = "EVA Glucose Injector"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/hypospray/medipen/glucose

/datum/design/biogen/hc_food/spork
	name = "Foreign Colonization Ration, Utensils"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/storage/box/utensils

/datum/design/biogen/hc_food/bubblegum
	name = "Foreign Colonization Ration, Bubblegum Pack"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/storage/box/gum/colonial

/datum/design/biogen/hc_food/cup
	name = "Empty Paper Cup"
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/reagent_containers/cup/glass/coffee/colonial/empty

/datum/design/biogen/hc_food/tea
	name = "Powdered Black Tea"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_tea

/datum/design/biogen/hc_food/coffee
	name = "Powdered Coffee"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coffee

/datum/design/biogen/hc_food/cocoa
	name = "Powdered Hot Chocolate"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_coco

/datum/design/biogen/hc_food/lemonade
	name = "Powdered Lemonade"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_lemonade

/datum/design/biogen/hc_food/replicator_sugar
	name = "Sugar"
	materials = list(/datum/material/biomass = 5)
	make_reagent = /datum/reagent/consumable/sugar

/datum/design/biogen/hc_food/powdered_milk
	name = "Powdered Milk"
	materials = list(/datum/material/biomass = 4)
	make_reagent = /datum/reagent/consumable/powdered_milk

/datum/design/biogen/hc_food/water
	name = "Water"
	materials = list(/datum/material/biomass = 1)
	make_reagent = /datum/reagent/water
