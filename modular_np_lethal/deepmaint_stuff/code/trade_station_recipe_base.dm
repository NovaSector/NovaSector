/datum/crafting_bench_recipe_real
	/// The name of the recipe to show
	var/recipe_name = "generic debug recipe"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/obj/resulting_item = /obj/item/forging
	/// How many things are we making (good for ammo and whatnot)
	var/amount_to_make = 1
