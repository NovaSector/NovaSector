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
//All the drinks are very good because this shit cost 1k minimum to get the starfruit

/datum/chemical_reaction/drink/starfruit_soda
	results = list(/datum/reagent/consumable/ethanol/starfruit_soda = 5)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 2,
		/datum/reagent/consumable/ethanol/rum = 2,
		/datum/reagent/consumable/ethanol/cognac = 1,
		/datum/reagent/consumable/sodawater = 1,
	)
	mix_message = "The ingredients combine into fizzy soda."

/datum/reagent/consumable/ethanol/starfruit_soda //starfruit juice 2, rum 2, cognac 1, soda water 1
	name = "Stellar Twist"
	description = "A drink over tired moms could hide in their thermos."
	boozepwr = 35
	color = "#434294"
	quality = DRINK_VERYGOOD
	taste_description = "sweet stellar adventures"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_soda
	required_drink_type = /datum/reagent/consumable/ethanol/starfruit_soda
	name = "Stellar Twist"
	desc = "An alcoholic starfruit soda, you can see the carbination in the glass"
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starsoda"

/datum/chemical_reaction/drink/starfruit_lubricant
	results = list(/datum/reagent/consumable/ethanol/starfruit_lubricant = 2)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/ethanol/synthanol = 1,
	)
	mix_message = "The ingredients combine into a fizzy soda."

/datum/reagent/consumable/ethanol/starfruit_lubricant //starfruit juice 1, Synthanol 1
	name = "Stellar Lubricant"
	description = "A drink over tired moms could hide in their thermos. Now for Synths!"
	boozepwr = 35
	color = "#45b33b"
	quality = DRINK_VERYGOOD
	taste_description = "sweet stellar adventures"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_lubricant
	required_drink_type = /datum/reagent/consumable/ethanol/starfruit_lubricant
	name = "Stellar Lubricant"
	desc = "An alcoholic synth friendly starfruit soda, you can see the carination in the glass."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starsodasynth"

/datum/chemical_reaction/drink/starfruit_latte
	results = list(/datum/reagent/consumable/starfruit_latte = 2)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/coffee = 1,
	)

/datum/reagent/consumable/starfruit_latte //starfruit juice 1, coffee 1
	name = "Starlit Latte"
	description = "A subtly sweet coffee seemingly out of this world."
	nutriment_factor = 8
	color = "#361329"
	quality = DRINK_VERYGOOD
	taste_description = "hauntingly familiar allure"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starfruit_latte
	required_drink_type = /datum/reagent/consumable/starfruit_latte
	name = "mug of starlit latte"
	desc = "A simple coffe flavored with sweet starfruit juice. It takes you on a journey to a place you’ve never been, yet somehow know by heart."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starfruit_latte"

/datum/chemical_reaction/drink/starbeam_shake //starfruit juice 1 , vanilla dream 1 , ice 1
	results = list(/datum/reagent/consumable/starbeam_shake = 3)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/vanilla_dream = 1,
		/datum/reagent/consumable/ice = 1,
	)

/datum/reagent/consumable/starbeam_shake
	name = "starbeam shake"
	description = "A delightful shake made with a rare starfruit."
	color = "#a551be"
	nutriment_factor = 0
	quality = DRINK_VERYGOOD
	taste_description = "smooth starlight"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/starbeam_shake
	required_drink_type = /datum/reagent/consumable/starbeam_shake
	name = "starbeam shake"
	desc = "A thick and creamy drink that takes you for a journey in the stars."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "voidshake"

/datum/chemical_reaction/drink/forgotten_star
	results = list(/datum/reagent/consumable/ethanol/forgotten_star = 5)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/pineapplejuice = 1,
		/datum/reagent/consumable/ethanol/white_russian = 1,
		/datum/reagent/consumable/ethanol/creme_de_coconut = 1,
		/datum/reagent/consumable/ethanol/bitters = 1,
	)
	mix_message = "The ingredients combine into a shooting star."

/datum/reagent/consumable/ethanol/forgotten_star //starfruit juice 1, creme de coconut 1, white russian 1, pineapple juice 1, bitters 1
	name = "Forgotten Star"
	description = "A cosmic cry of a bygone era."
	boozepwr = 55
	color = "#434294"
	quality = DRINK_VERYGOOD
	taste_description = "dreamy, tropical starlit sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/forgotten_star
	required_drink_type = /datum/reagent/consumable/ethanol/forgotten_star
	name = "Forgotten Star"
	desc = "An alcoholic starfruit coctail, you can almost make out a distant star system in the glass."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "forgottenstar"

/datum/chemical_reaction/drink/astral_flame
	results = list(/datum/reagent/consumable/ethanol/astral_flame = 6)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/ethanol/navy_rum = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/consumable/limejuice = 1,
		/datum/reagent/consumable/sodawater = 1,
	)
	mix_message = "The ingredients morph into a an enticing smell"

/datum/reagent/consumable/ethanol/astral_flame //starfruit juice 1, navy rum 1, lime juice 1, soda water 1, menthol 1
	name = "Astral Flame"
	description = "Enticing flames."
	boozepwr = 55
	color = "#6b3481"
	quality = DRINK_VERYGOOD
	taste_description = "enticing warmth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/astral_flame
	required_drink_type = /datum/reagent/consumable/ethanol/astral_flame
	name = "Astral Flame"
	desc = "An alcoholic starfruit mojito, the flame in the glass tempts you closer."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "astralflame"

/datum/chemical_reaction/drink/space_muse
	results = list(/datum/reagent/consumable/ethanol/space_muse = 3)
	required_reagents = list(
		/datum/reagent/consumable/starfruit_juice = 1,
		/datum/reagent/consumable/ethanol/creme_de_menthe = 1,
		/datum/reagent/consumable/ethanol/vodka = 1,
	)
	mix_message = "The mixture gives a soft crackling snap."

/datum/reagent/consumable/ethanol/space_muse //starfruit juice 1, creme de menthe, 1 vodka
	name = "Space Muse"
	description = "A snapshot straight from your local telescope."
	boozepwr = 35
	color = "#7cb1e2"
	quality = DRINK_VERYGOOD
	taste_description = "haughty cosmic thought"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/space_muse
	required_drink_type = /datum/reagent/consumable/ethanol/space_muse
	name = "Space Muse"
	desc = "An alcoholic coctail that draws you in with sybtle bites of mint and starfruit."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "spacemuse"

//Starfruit dishes

/datum/crafting_recipe/food/glazed_ribs
	name = "Starfruit Glazed Ribs"
	reqs = list(
		/obj/item/food/bbqribs = 1,
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
	foodtypes = MEAT | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/datum/crafting_recipe/food/meatplatter
	name = "BBQ Meat Platter"
	reqs = list(
		/obj/item/food/bbqribs = 1,
		/obj/item/food/glazed_ribs = 1,
		/obj/item/food/roasted_bell_pepper = 2,
	)
	result = /obj/item/food/meatplatter
	category = CAT_MEAT

/obj/item/food/meatplatter
	name = "BBQ meat platter"
	desc = "An elaborate BBQ platter adorned with several BBQ favorites on this side of the galaxy. Garnished with some rosted pepper."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "meatdisc"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/bbqsauce = 10,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("tender meat" = 2, "sweet sauce" = 1, "smokey BBQ" = 1, "sugary glaze" = 1)
	foodtypes = MEAT | VEGETABLES | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_5

/datum/crafting_recipe/food/chicken_alfredo
	name = "Starfruit Chicken Alfredo"
	reqs = list(
		/obj/item/food/meat/slab/chicken = 1,
		/obj/item/food/grown/starfruit = 2,
		/datum/reagent/consumable/cream = 10,
		/obj/item/food/spaghetti/boiledspaghetti = 1
	)
	result = /obj/item/food/chicken_alfredo
	category = CAT_MISCFOOD
	removed_foodtypes = RAW

/obj/item/food/chicken_alfredo
	name = "starfruit chicken alfredo"
	desc = "A chicken alfredo dish with a starfruit cream sauce. Not for the faint of heart."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "alfredo"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("sweet chicken" = 2, "creamy sauce" = 1, "cursed knowledge" = 1, "tasty noodles" = 1)
	foodtypes = MEAT | GRAIN | FRUIT| SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitsushiroll
	name = "Starfruit Sushi Roll"
	reqs = list(
		/obj/item/food/seaweedsheet = 1,
		/obj/item/food/boiledrice = 1,
		/obj/item/food/starfruit_sashimi = 1,
	)
	result = /obj/item/food/starfruitsushiroll
	category = CAT_SEAFOOD
	removed_foodtypes = BREAKFAST

/obj/item/food/starfruitsushiroll
	name = "starfruit sushi roll"
	desc = "A roll of simple sushi with delicious starfruit sashimi. Sliceable into pieces!"
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "sashimiroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 2, "starfruit" = 2, "fish" = 2)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN |FRUIT | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/starfruitsushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/starfruitsushislice, 4, screentip_verb = "Chop")

/obj/item/food/starfruitsushislice
	name = "starfruit sushi slice"
	desc = "A slice of starfruit sushi with rice, fish, and cradled in a seaweed sheat."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "sashimirollslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 2, "starfruit" = 2, "fish" = 2)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruit_sashimi
	name = "Starfruit Sashimi"
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
	foodtypes = SEAFOOD | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/datum/crafting_recipe/food/eggplantfry
	name = "Starfruit Eggplant Stir Fry"
	reqs = list(
		/obj/item/food/grown/bell_pepper = 1,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/eggplant = 2,
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
	foodtypes = VEGETABLES | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/tofubeef
	name = "Starfruit Tofu Beef Ramen"
	reqs = list(
		/obj/item/food/tofu = 1,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/spaghetti/boiledspaghetti = 1,
	)
	result = /obj/item/food/tofubeef
	category = CAT_MISCFOOD

/obj/item/food/tofubeef
	name = "starfruit tofu beef ramen"
	desc = "A delightful ramen dish steeped in beef, tofu and starfruit. The uncanny combination of ingredients results in a suprisingly tangy dish with a subtly sweet aftertaste."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "tofubeef"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("noodles" = 2, "boiled starfruit" = 1, "sweet ramen" = 1)
	foodtypes = VEGETABLES | MEAT | GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitplate
	name = "Starfruit Noodle Pasta"
	reqs = list(
		/obj/item/food/meatball = 2,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/starfruit = 1,
		/obj/item/food/spaghetti/pastatomato = 1,
	)
	result = /obj/item/food/starfruitplate
	category = CAT_MISCFOOD

/obj/item/food/starfruitplate
	name = "starfruit noodle pasta"
	desc = "Savory boiled pasta with a rich and creamy reduced starfruit meat sauce."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starfruitplate"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/starfruit_juice = 10,
	)
	tastes = list("sweet spagetti" = 2, "simmered starfruit" = 1, "savory meat" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitcake
	name = "Starfruit Cake"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/grown/starfruit = 5
	)
	result = /obj/item/food/cake/starfruit
	category = CAT_CAKE

/obj/item/food/cake/starfruit
	name = "starfruit cake"
	desc = "An elaborately decorated cake with a starfruit filling. Pairs well with a starlit latte."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cake" = 3, "sweetness" = 2, "unbearable longing" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/starfruit
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/starfruit
	name = "starfruit cake slice"
	desc = "A slice of starfruit cake, you got a slice with extra frosting! Lucky you!"
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starcake_slice"
	tastes = list("cake" = 3, "astral sweetness" = 2, "unbearable longing" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

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
	icon_state = "macaron_4"
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

/datum/crafting_recipe/food/starfruitcobbler
	name = "Starfruit Cobbler"
	reqs = list(
		/obj/item/food/pastrybase = 2,
		/obj/item/food/grown/starfruit = 2,
		/datum/reagent/consumable/starfruitjelly = 10,
	)
	result = /obj/item/food/pie/starfruitcobbler
	category = CAT_PASTRY

/obj/item/food/pie/starfruitcobbler
	name = "starfruit cobbler"
	desc = "A tasty cobbler packed with sweet starfruit in a buttery pastry crust. Topped with a small amount of sweet cream."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "cobbler"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pie" = 1, "sugar" = 2, "starfruit" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT | FRUIT | DAIRY | SUGAR

/datum/crafting_recipe/food/starfruit_toast
	name = "Starfruit Jellied Toast"
	reqs = list(
		/obj/item/food/breadslice/plain = 1,
		/datum/reagent/consumable/starfruitjelly = 5,
	)
	result = /obj/item/food/starfruit_toast
	category = CAT_BREAD
	added_foodtypes = BREAKFAST

/obj/item/food/starfruit_toast
	name = "starfruit jellied toast"
	desc = "A slice of toast covered with delicious starfruit jam."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "spacejamtoast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	bite_consumption = 3
	tastes = list("toast" = 1, "jelly" = 1, "starfruit jelly" = 1)
	foodtypes = GRAIN | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitpie
	name = "Starfruit Pie"
	reqs = list(
		/obj/item/food/pie/plain = 1,
		/obj/item/food/grown/starfruit = 2,
	)
	result = /obj/item/food/pie/starfruitpie
	category = CAT_PASTRY

/obj/item/food/pie/starfruitpie
	name = "starfruit pie"
	desc = "Deceptively simple, yet flavor intensive."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starfruitpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("starfruit" = 1, "pie" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR | DAIRY
	slice_type = /obj/item/food/pieslice/starfruitpie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/starfruitpie
	name = "starfruit pie slice"
	desc = "Takes you on a journey though space!"
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "starfruitpie_slice"
	tastes = list("pie" = 1, "starfruit" = 1, "cosmic longing" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitcompote
	name = "Starfruit Compote"
	reqs = list(
		/obj/item/food/grown/starfruit = 5,
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/ethanol/cognac = 10,
	)
	result = /obj/item/food/starfruitcompote
	category = CAT_MISCFOOD

/obj/item/food/starfruitcompote
	name = "starfruit compote"
	desc = "An irresistibly sweet dish of starfruit boiled down in cognac and sugar."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "compote"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("starfruit" = 1, "sweet sugar" = 1, "cognac spice" = 1)
	bite_consumption = 3
	foodtypes = FRUIT | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starfruitbrulee
	name = "Starfruit Creme Brulee"
	reqs = list(
		/datum/reagent/consumable/starfruit_juice = 10,
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/salt = 5,
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/eggwhite = 4,
	)
	result = /obj/item/food/starfruitbrulee
	category = CAT_MISCFOOD

/obj/item/food/starfruitbrulee
	name = "starfruit creme brulee"
	desc = "A delightful pudding dish made from primarily caramel, starfruit, and egg whites."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "cremebrulee"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("starfruit" = 1, "caramel" = 1, "subtle cream" = 1)
	foodtypes = FRUIT | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/datum/crafting_recipe/food/starcupcake
	name = "Starfruit Cupcake"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/grown/starfruit = 2
	)
	result = /obj/item/food/starcupcake
	category = CAT_PASTRY

/obj/item/food/starcupcake
	name = "starfruit cupcake"
	desc = "A sweet cupcake with a starfruit frosting."
	icon = 'modular_nova/master_files/icons/obj/food/starfruit.dmi'
	icon_state = "cupcakestar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cake" = 3, "starfruit" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/book/manual/starfruit
	name = "Starfruit preperation and you!"
	icon = 'modular_nova/master_files/icons/obj/starfruitbook.dmi'
	icon_state = "cookbook"
	lefthand_file = 'modular_nova/master_files/icons/mob/inhands/starfruitbook_lhand.dmi'
	righthand_file = 'modular_nova/master_files/icons/mob/inhands/starfruitbook_rhand.dmi'
	starting_author = "Artic Deep Beverage Research Division"
	starting_title = "Starfruit preperation and you!"
	starting_content = {"<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<style>
h1 {font-size: 18px; margin: 15px 0px 5px;}
h2 {font-size: 15px; margin: 15px 0px 5px;}
li {margin: 2px 0px 2px 15px;}
ul {list-style: none; margin: 5px; padding: 0px;}
ol {margin: 5px; padding: 0px 15px;}
</style>
</head>
<body>

<h2>Artic Starfruit Beverage Recipies:</h2>

<b>Starfruit Soda:</b> Two parts starfruit juice, two parts rum, one part cognac, one part soda water<br>

<b>Starfruit Lubricant:</b> One part starfruit juice, one part synthanol<br>

<b>Starlit Latte:</b> One part starfruit juice, one part coffee<br>

<b>Starbeam Shake:</b> One part starfruit juice, one part vanilla dream, one part ice<br>

<b>Forgotten Star:</b> One part starfruit juice, one part creme de coconut, one part white russian, one part pineapple juice, one part bitters

<b>Astral Flame:</b> One Part Starfruit juice, one part navy rum,one part lime juice,one part soda water, one part menthol

<b>Space Muse:</b> One part starfruit juice, one part creme de menthe, one part vodka
</body>
</html>
"}
