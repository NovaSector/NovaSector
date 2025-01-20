// recipes for dashi, coconut milk, curry powder, red bay seasoning, worcestershire sauce, CHAP, and moonfish eggs, all without the produce console
// coding by linkbro, scotsman go ree and type, most recipe ideas provided by tetrako, red bird go peep and cook!


/datum/chemical_reaction/food/soup/homemade_dashi
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

/datum/crafting_recipe/food/reaction/soup/homemade_dashi
	result = /datum/reagent/consumable/nutriment/soup/dashi
	reaction = /datum/chemical_reaction/food/soup/homemade_dashi
	category = CAT_MARTIAN

/datum/chemical_reaction/food/soup/substitute_coconut_milk
	required_reagents = list(
		/datum/reagent/consumable/korta_milk = 1,
		/datum/reagent/water = 1,
		/datum/reagent/consumable/enzyme = 1,
	)
	results = list(
		/datum/reagent/consumable/coconut_milk = 2,
	)

/datum/crafting_recipe/food/reaction/food/substitute_coconut_milk
	result = /datum/reagent/consumable/coconut_milk
	reaction = /datum/chemical_reaction/food/soup/substitute_coconut_milk
	category = CAT_MARTIAN

/datum/chemical_reaction/food/soup/curry_powder
	required_reagents = list(
		/datum/reagent/consumable/chili_powder = 10,
		/datum/reagent/consumable/blackpepper = 10,
	)
	results = list(
		/datum/reagent/consumable/curry_powder = 20,
	)

/datum/crafting_recipe/food/reaction/soup/curry_powder
	result = /datum/reagent/consumable/curry_powder
	reaction = /datum/chemical_reaction/food/soup/curry_powder
	category = CAT_MARTIAN

/datum/chemical_reaction/food/soup/red_bay
	required_reagents = list(
		/datum/reagent/consumable/chili_powder = 10,
	)
	required_ingredients = list(
		/obj/item/food/dried_herbs = 1,
	)
	results = list(
		/datum/reagent/consumable/red_bay = 20,
	)

/datum/crafting_recipe/food/reaction/soup/red_bay
	result = /datum/reagent/consumable/red_bay
	reaction = /datum/chemical_reaction/food/soup/red_bay
	category = CAT_MARTIAN

/datum/chemical_reaction/food/worcestershire_sauce
	results = list(
		/datum/reagent/consumable/worcestershire = 4
	)
	required_reagents = list(
		/datum/reagent/consumable/onion_juice = 1,
		/datum/reagent/consumable/garlic = 1,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/bonito = 1,
		/datum/reagent/consumable/sugar = 1,
	)

/datum/crafting_recipe/food/reaction/worcestershire_sauce
	reaction = /datum/chemical_reaction/food/worcestershire_sauce
	category = CAT_MARTIAN

/datum/crafting_recipe/food/reaction/vinegar
	reaction = /datum/chemical_reaction/food/wine_vinegar

/datum/crafting_recipe/food/reaction/sake
	reaction = /datum/chemical_reaction/drink/sake

/datum/crafting_recipe/food/can_of_chap
	name = "Can of CHAP"
	time = 40
	reqs = list(
		/obj/item/stack/sheet/iron = 1,
		/obj/item/food/meat/slab = 2,
	)
	result = /obj/item/food/canned/chap
	category = CAT_MEAT

/datum/crafting_recipe/food/grinder/chili_powder
	reqs = list(/obj/item/food/dried_chili = 1)
	result = /datum/reagent/consumable/chili_powder

/datum/crafting_recipe/food/grinder/bonito
	reqs = list(/obj/item/food/dried_fish = 1)
	result = /datum/reagent/consumable/bonito

/datum/food_processor_process/moonfish_eggs
	input = /obj/item/fish/moonfish/dwarf
	output = /obj/item/food/moonfish_eggs

/datum/crafting_recipe/food/processor/moonfish_eggs
	reqs = list(/obj/item/fish/moonfish/dwarf = 1)
	result = /obj/item/food/moonfish_eggs
	category = CAT_SEAFOOD

/datum/crafting_recipe/food/drying/dried_fish
	reqs = list(/obj/item/food/fishmeat = 1)
	result = /obj/item/food/dried_fish
	category = CAT_MARTIAN

/datum/crafting_recipe/food/drying/dried_chili
	reqs = list(/obj/item/food/grown/chili = 1)
	result = /obj/item/food/dried_chili
	category = CAT_MARTIAN

/datum/crafting_recipe/food/drying/dried_herbs
	reqs = list(/obj/item/food/grown/herbs = 1)
	result = /obj/item/food/dried_herbs
	category = CAT_MARTIAN
