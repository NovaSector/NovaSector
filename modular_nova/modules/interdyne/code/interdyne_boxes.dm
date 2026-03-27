/// Interdyne Pharmaceuticals — Branded storage boxes
/// Dark boxes with green borders, only visible in cardboard recipes for Interdyne personnel.

/obj/item/storage/box/interdyne
	name = "\improper Interdyne supply box"
	desc = "A dark storage box bearing Interdyne Pharmaceuticals branding. The green trim marks it as corporate property."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_boxes.dmi'
	icon_state = "interdyne_box"
	illustration = null

/obj/item/storage/box/interdyne/medical
	name = "\improper Interdyne medical supply box"
	desc = "A dark storage box marked with a medical cross and Interdyne Pharmaceuticals branding. For pharmaceutical shipments."
	icon_state = "interdyne_box_med"

/// Stack recipes — added to cardboard only for users with ACCESS_SYNDICATE

GLOBAL_LIST_INIT(interdyne_cardboard_recipes, list(
	new/datum/stack_recipe_list("Interdyne boxes", list(
		new/datum/stack_recipe("Interdyne supply box", /obj/item/storage/box/interdyne, crafting_flags = NONE, category = CAT_CONTAINERS),
		new/datum/stack_recipe("Interdyne medical supply box", /obj/item/storage/box/interdyne/medical, crafting_flags = NONE, category = CAT_CONTAINERS),
	)),
))

/// Add Interdyne recipes to the cardboard stack's recipe list so is_valid_recipe passes
/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.interdyne_cardboard_recipes

/// Only show Interdyne recipes in the UI for users with ACCESS_SYNDICATE
/obj/item/stack/sheet/cardboard/ui_static_data(mob/user)
	// Build base recipes WITHOUT Interdyne ones
	var/list/base_recipes = recipes.Copy()
	for(var/datum/stack_recipe_list/recipe_list in base_recipes)
		if(recipe_list.title == "Interdyne boxes")
			base_recipes -= recipe_list

	var/list/data = list()
	data["recipes"] = recursively_build_recipes(base_recipes)

	// Add Interdyne recipes only for syndicate access holders
	if(isliving(user))
		var/mob/living/living_user = user
		var/obj/item/card/id/id_card = living_user.get_idcard(hand_first = TRUE)
		if(id_card && (ACCESS_SYNDICATE in id_card.GetAccess()))
			data["recipes"] += recursively_build_recipes(GLOB.interdyne_cardboard_recipes)

	return data
