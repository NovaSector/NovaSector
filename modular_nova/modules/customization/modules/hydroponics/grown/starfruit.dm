// Starfruit
/obj/item/seeds/starfruit
	name = "starfruit seed pack"
	desc = "These seeds grow into starfruit plants, which bear a sugary and delicious fruit."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-starfruit"
	species = "starfruit"
	plantname = "Starfruit Plants"
	product = /obj/item/food/grown/starfruit
	lifespan = 50
	endurance = 15
	growthstages = 4
	growing_icon = 'modular_nova/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "starfruit-grow"
	icon_dead = "starfruit-dead"
	icon_harvest = "starfruit-harvest"
	genes = list(/datum/plant_gene/trait/glow/yellow, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(
		/datum/reagent/consumable/starfruit_juice = 0.3,
		/datum/reagent/consumable/nutriment = 0.1,
	)

/obj/item/food/grown/starfruit
	seed = /obj/item/seeds/starfruit
	name = "starfruit"
	desc = "The rare Primidine Starfruit was formerly one of the most commonly harvested fruits on Primidine, grown during the autumn and primary harvest season."
	icon = 'modular_nova/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "starfruit"
	bite_consumption_mod = 2
	foodtypes = FRUIT | SUGAR
	juice_typepath = /datum/reagent/consumable/starfruit_juice

//Starfruit drinks

/datum/chemical_reaction/drink/starfruit_soda
	results = list(/datum/reagent/consumable/ethanol/starfruit_soda = 7) //Woe, 70 units upon ye
	required_reagents = list(/datum/reagent/consumable/starfruit_juice = 2, /datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/cream = 1,  /datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ethanol/cognac = 1)

/datum/reagent/consumable/ethanol/starfruit_soda //starfruit juice 2, rum 2, cognac 1, cream 1, soda water 1
	name = "Stellar Twist"
	description = "A cosmic cry of a bygone era."
	boozepwr = 20
	color = "#434294"
	quality = DRINK_VERYGOOD
	taste_description = "sweet stellar adventures"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_soda
	required_drink_type = /datum/reagent/consumable/ethanol/starfruit_soda
	name = "Stellar Twist"
	desc = "An alcoholic starfruit cream soda, you can almost see a sparkling galaxy in the glass."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starsoda"

/datum/chemical_reaction/drink/starlit_latte
	results = list(/datum/reagent/consumable/starlit_latte = 2)
	required_reagents = list(/datum/reagent/consumable/starfruit_juice = 1, /datum/reagent/consumable/coffee = 1)

/datum/reagent/consumable/starlit_latte //starfruit juice 1, coffee 1
	name = "Starlit Latte"
	description = "A subtly sweet coffee seemingly out of this world."
	nutriment_factor = 8
	color = "#361329"
	quality = DRINK_VERYGOOD
	taste_description = "hauntingly familiar allure"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_latte
	required_drink_type = /datum/reagent/consumable/starlit_latte
	name = "mug of starlit latte"
	desc = "A simple coffe flavored with sweet starfruit juice. It takes you on a journey to a place you’ve never been, yet somehow know by heart."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "starfruit_latte"

/datum/chemical_reaction/drink/starbeam_shake // starfruit juice 1 , vanilla dream 1 , ice 1
	results = list(/datum/reagent/consumable/starbeam_shake = 3)
	required_reagents = list(/datum/reagent/consumable/starfruit_juice = 1, /datum/reagent/consumable/vanilla_dream = 1, /datum/reagent/consumable/ice = 1)

/datum/reagent/consumable/starbeam_shake
	name = "starbeam shake"
	description = "A delightful shake made from a rare starfruit."
	color = "#a551be"
	nutriment_factor = 0
	taste_description = "smooth starlight"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_shake
	required_drink_type = /datum/reagent/consumable/starbeam_shake
	name = "starbeam shake"
	desc = "A thick and creamy drink that takes you for a journey in the stars."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "voidshake"

//Starfruit dishes

/datum/crafting_recipe/food/glazed_ribs
	name = "Starfruit glazed ribs"
	reqs = list(
		/obj/item/food/bbqribs,
		/obj/item/food/grown/starfruit = 2,
		/datum/reagent/consumable/starfruit_juice = 5,
	)
	result = /obj/item/food/glazed_ribs
	category = CAT_MEAT

/obj/item/food/glazed_ribs
	name = "starfruit glazed ribs"
	desc = "Tender BBQ ribs, glazed with a sweet Starfruit sauce. Garinished with a carmalized starfruit on the side. The sweetest least vegan thing this side of the frontier."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "glazedchops"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/starfruit_juice = 5,
	)
	tastes = list("tender meat" = 2, "sweet sauce" = 1, "sugary glaze" = 1)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/datum/crafting_recipe/food/meatplatter
	name = "BBQ Meat Platter"
	reqs = list(
		/obj/item/food/bbqribs,
		/obj/item/food/glazed_ribs,
		/obj/item/food/roasted_bell_pepper = 2,
	)
	result = /obj/item/food/meatplatter
	category = CAT_MEAT

/obj/item/food/meatplatter
	name = "BBQ Meat Platter"
	desc = "An elaborate BBQ platter adorned with several BBQ favorites on this side of the galaxy. Garnished with some rosted pepper."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "meatdisk"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/bbqsauce = 10,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("tender meat" = 2, "sweet sauce" = 1, "smokey BBQ" = 1, "sugary glaze" = 1)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/meat/slab/chicken

/datum/crafting_recipe/food/starfruitsushiroll
	name = "Starfruit Sushi Roll"
	reqs = list(
		/obj/item/food/seaweedsheet = 1,
		/obj/item/food/boiledrice = 1,
		/obj/item/food/starfruit_sashimi = 1,
	)
	result = /obj/item/food/starfruitsushiroll
	category = CAT_SEAFOOD

/obj/item/food/starfruitsushiroll
	name = "starfruit sushi roll"
	desc = "A roll of simple vegetarian sushi with rice, carrots, and potatoes. Sliceable into pieces!"
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "sashimiroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 2, "starfruit" = 2, "fish" = 2)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/starfruitsushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/starfruitsushislice, 4, screentip_verb = "Chop")

/obj/item/food/starfruitsushislice
	name = "starfruit sushi slice"
	desc = "A slice of starfruit sushi with rice, fish, and cradled in a seaweed sheat."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "sashimiroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 2, "starfruit" = 2, "fish" = 2)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/datum/crafting_recipe/food/starfruit_sashimi
	name = "Starfruit sashimi"
	reqs = list(
		/obj/item/food/fishmeat = 2,
		/datum/reagent/consumable/soysauce = 10,
		/obj/item/food/grown/starfruit = 1,
	)
	result = /obj/item/food/starfruit_sashimi
	category = CAT_SEAFOOD

/obj/item/food/starfruit_sashimi
	name = "starfruit sashimi"
	desc = "Delicately slished sashimi made with a starfruit reduced soy sauce."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "sashimi"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("raw fish" = 2, "sweet fish" = 1, "soy sauce" = 1)
	foodtypes = SEAFOOD
	crafting_complexity = FOOD_COMPLEXITY_2

/datum/crafting_recipe/food/eggplantfry
	name = "starfruit eggplant stir fry"
	reqs = list(
		/obj/item/food/grown/bell_pepper = 1,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/grown/carrot = 1,
	)
	result = /obj/item/food/eggplantfry
	category = CAT_MISCFOOD

/obj/item/food/eggplantfry
	name = "starfruit eggplant stir fry"
	desc = "Eggplant stir fry with a reduced starfruit sauce, carrot, peppers, and cabbage. The starfruit has absolutely covered the dish."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "eggplantfry"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("eggplant" = 2, "simmered starfruit" = 1, "sautaed vegetables" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/tofubeef
	name = "starfruit tofu beef ramen"
	reqs = list(
		/obj/item/food/tofu = 1,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/spaghetti/boiledspaghetti = 1,
	)
	result = /obj/item/food/tofubeef
	category = CAT_MISCFOOD

/obj/item/food/tofubeef
	name = "starfruit eggplant stir fry"
	desc = "Eggplant stir fry with a reduced starfruit sauce, carrot, peppers, and cabbage. The starfruit has absolutely covered the dish."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "tofubeef"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("eggplant" = 2, "simmered starfruit" = 1, "sautaed vegetables" = 1)
	foodtypes = VEGETABLES | MEAT | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitplate
	name = "starfruit noodles"
	reqs = list(
		/obj/item/food/meatball = 2,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/spaghetti/pastatomato = 1,
	)
	result = /obj/item/food/tofubeef
	category = CAT_MISCFOOD

/obj/item/food/starfruitplate
	name = "starfruit noddles"
	desc = "Savory boiled pasta with a rich and creamy reduced starfruit meat sauce."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starfruitplate"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("eggplant" = 2, "simmered starfruit" = 1, "sautaed vegetables" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/starfruit
	name = "starfruit cake"
	desc = "An elaborately decorated cake with a starfruit filling. Pairs well with a starlit latte."
	icon_state = "starcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/starfruit
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/starfruit
	name = "starfruit cake slice"
	desc = "A slice of starfruit cake, you got a slice with extra frosting! Lucky you!"
	icon_state = "starcake_slice"
	tastes = list("cake" = 3, "astral sweetness" = 2, "unbearable longing" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/datum/reagent/consumable/starfruitjelly
	name = "Starfruit Jelly"
	description = "A rare sweet fruit jelly "
	nutriment_factor = 10
	color = "#6d3890"
	taste_description = "starfruit"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/condiment/starfruitjelly

/obj/item/reagent_containers/condiment/starfruitjelly
	name = "starfruit jelly"
	desc = "A jar of super-sweet starfruit jelly."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "spacejam"
	list_reagents = list(/datum/reagent/consumable/starfruitjelly = 50)
	fill_icon_thresholds = null

/datum/crafting_recipe/bottled/starfruitjelly
	name = "Starfruit Jelly"
	reqs = list(
		/obj/item/food/grown/starfruit = 10,
		/datum/reagent/water = 25,
	)
	result = /obj/item/reagent_containers/condiment/starfruitjelly
	category = CAT_MISCFOOD

/obj/item/food/cookie/macaron/starfruit
	name = "starfruit macaron"
	desc = "A sandwich-like confectionary with a soft cookie shell and a creamy starfruit jelly meringue center."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starmacaron"
	tastes = list("wafer" = 2, "sweet starfruit" = 2, "creamy meringue" = 3)

/datum/crafting_recipe/food/macaron/starfruit
	name = "Starfruit Macaron"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 2,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/starfruitjelly = 5,
	)
	result = /obj/item/food/cookie/macaron/starfruit
	category = CAT_PASTRY

/obj/item/food/pie/starfruitcobbler
	name = "starfruit cobbler"
	desc = "A tasty dessert of many different small barries on a thin pie crust."
	icon_state = "cobbler"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "sugar" = 2, "starfruit" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT

/obj/item/food/pie/starfruitpie
	name = "starfruit pie"
	desc = "Deceptively simple, yet flavor intensive."
	icon_state = "starfruitpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("starfruit" = 1, "pie" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	slice_type = /obj/item/food/pieslice/starfruitpie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/starfruitpie
	name = "starfruit pie slice"
	desc = "Takes you on a journy though space!"
	icon_state = "starfruitpie_slice"
	tastes = list("pie" = 1, "starfruit" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
