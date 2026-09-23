// Recipes for the flooring tgstation #97723 removed.


GLOBAL_LIST_INIT(floors_and_walls_bone_recipes, list(
	new /datum/stack_recipe("bone tile", /obj/item/stack/tile/bone, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES),
))

/obj/item/stack/sheet/bone/get_main_recipes()
	. = ..()
	. += GLOB.floors_and_walls_bone_recipes

GLOBAL_LIST_INIT(floors_and_walls_meat_recipes, list(
	new /datum/stack_recipe("meat tile", /obj/item/stack/tile/meat, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES),
))

/obj/item/stack/sheet/meat/get_main_recipes()
	. = ..()
	. += GLOB.floors_and_walls_meat_recipes

/datum/crafting_recipe/ashforge
	name = "Ash Forge Tile"
	result = /obj/item/stack/tile/circuit/ash
	reqs = list(
		/obj/item/stack/sheet/mineral/plastitanium = 1,
		/datum/reagent/ash = 80,
		/datum/reagent/phosphorus = 80,
	)
	result_amount = 6
	category = CAT_TILES

/datum/crafting_recipe/silvergold
	name = "Silver And Gold Tile"
	result = /obj/item/stack/tile/silvergold
	reqs = list(
		/obj/item/stack/sheet/mineral/silver = 1,
		/obj/item/stack/sheet/mineral/gold = 1,
	)
	result_amount = 8
	category = CAT_TILES

/datum/crafting_recipe/neo_tile
	name = "Neo Tile"
	result = /obj/item/stack/tile/neo/red
	reqs = list(
		/obj/item/stack/tile/iron = 4,
		/datum/reagent/phosphorus = 20,
		/datum/reagent/uranium/radium = 20,
		/datum/reagent/fuel/oil = 10,
	)
	result_amount = 4
	category = CAT_TILES
