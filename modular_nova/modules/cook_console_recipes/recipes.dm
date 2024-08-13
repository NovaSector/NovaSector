// recipes for dashi, coconut milk, curry powder, red bay seasoning, worcestershire sauce, CHAP, and moonfish eggs, all without the produce console
// coding by linkbro, scotsman go ree and type, most recipe ideas provided by tetrako, red bird go peep and cook!


/datum/chemical_reaction/food/soup/homemadedashi
	required_reagents = list(
		/datum/reagent/water = 40,
		/datum/reagent/consumable/bonito = 20,
	)
	required_ingredients = list(
		/obj/item/food/seaweedsheet = 1,
	)
	results = list(
		/datum/reagent/consumable/nutriment/soup/dashi = 40,
	)

/datum/crafting_recipe/food/reaction/soup/homemadedashi
	reaction = /datum/chemical_reaction/food/soup/homemadedashi
	category = CAT_MARTIAN


/datum/chemical_reaction/food/soup/substitutecoconutmilk
	required_reagents = list(
		/datum/reagent/consumable/korta_milk = 1,
		/datum/reagent/water = 1,
		/datum/reagent/consumable/enzyme = 1,
	)
	results = list(
		/datum/reagent/consumable/coconut_milk = 2,
	)

/datum/crafting_recipe/food/reaction/soup/substitutecoconutmilk
	reaction = /datum/chemical_reaction/food/soup/substitutecoconutmilk
	category = CAT_MARTIAN


/datum/chemical_reaction/food/soup/currypowder
	required_reagents = list(
		/datum/reagent/consumable/chilipowder = 10,
		/datum/reagent/consumable/blackpepper = 10,
	)
	results = list(
		/datum/reagent/consumable/curry_powder = 20,
	)

/datum/crafting_recipe/food/reaction/soup/currypowder
	reaction = /datum/chemical_reaction/food/soup/currypowder
	category = CAT_MARTIAN


/datum/chemical_reaction/food/soup/redbay
	required_reagents = list(
		/datum/reagent/consumable/chilipowder = 10,
	)
	required_ingredients = list(
		/obj/item/food/driedherbs = 1,
	)
	results = list(
		/datum/reagent/consumable/red_bay = 20,
	)

/datum/crafting_recipe/food/reaction/soup/redbay
	reaction = /datum/chemical_reaction/food/soup/redbay
	category = CAT_MARTIAN


/datum/chemical_reaction/food/worcestershiresauce
	results = list(
		/datum/reagent/consumable/worcestershire = 4
	)
	required_reagents = list(
		/datum/reagent/consumable/onionjuice = 1,
		/datum/reagent/consumable/garlic = 1,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/bonito = 1,
		/datum/reagent/consumable/sugar = 1,
	)

/datum/crafting_recipe/food/reaction/worcestershiresauce
	reaction = /datum/chemical_reaction/food/worcestershiresauce
	category = CAT_MARTIAN

/datum/crafting_recipe/food/reaction/vinegar
	reaction = /datum/chemical_reaction/food/wine_vinegar

/datum/crafting_recipe/food/reaction/sake
	reaction = /datum/chemical_reaction/drink/sake

/datum/crafting_recipe/food/canofchap
	name = "Can of CHAP"
	time = 40
	reqs = list(/obj/item/stack/sheet/iron = 1,
		/obj/item/food/meat/slab = 2
	)
	result = /obj/item/food/canned/chap
	category = CAT_MEAT


/datum/crafting_recipe/food/grinder/chilipowder
	reqs = list(/obj/item/food/driedchili = 1)
	result = /datum/reagent/consumable/chilipowder

/datum/crafting_recipe/food/grinder/bonito
	reqs = list(/obj/item/food/driedfish = 1)
	result = /datum/reagent/consumable/bonito


/datum/food_processor_process/moonfisheggs
	input = /obj/item/fish/dwarf_moonfish
	output = /obj/item/food/moonfish_eggs

/datum/crafting_recipe/food/processor/moonfisheggs
	reqs = list(/obj/item/fish/dwarf_moonfish = 1)
	result = /obj/item/food/moonfish_eggs
	category = CAT_SEAFOOD


/datum/crafting_recipe/food/drying/driedfish
	reqs = list(/obj/item/food/fishmeat = 1)
	result = /obj/item/food/driedfish
	category = CAT_MARTIAN


/datum/crafting_recipe/food/drying/driedchili
	reqs = list(/obj/item/food/grown/chili = 1)
	result = /obj/item/food/driedchili
	category = CAT_MARTIAN


/datum/crafting_recipe/food/drying/driedherbs
	reqs = list(/obj/item/food/grown/herbs = 1)
	result = /obj/item/food/driedherbs
	category = CAT_MARTIAN
