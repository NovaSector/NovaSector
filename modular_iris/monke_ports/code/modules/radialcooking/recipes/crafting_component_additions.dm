/datum/component/personal_crafting/proc/craft_until_cant(datum/crafting_recipe/recipe_to_use, mob/chef, turf/craft_location)
	while(TRUE)
		// attempt_craft_loop sleeps, so this won't freeze the server while we craft
		if(!attempt_craft_loop(recipe_to_use, chef, craft_location))
			break

/// Attempts a crafting loop. Returns true if it succeeds, false otherwise
/datum/component/personal_crafting/proc/attempt_craft_loop(datum/crafting_recipe/recipe_to_use, mob/chef, turf/craft_location)
	var/list/surroundings = get_surroundings(chef)
	if(!check_contents(chef, recipe_to_use, surroundings))
		chef.balloon_alert_to_viewers("failed to craft, missing ingredients!")
		return FALSE

	var/atom/movable/result = construct_item(chef, recipe_to_use)
	if(istext(result))
		chef.balloon_alert_to_viewers("failed to craft[result]")
		return FALSE
    //We made an item and didn't get a fail message
	result.forceMove(craft_location)
	result.pixel_x = rand(-10, 10)
	result.pixel_y = rand(-10, 10)
	if(isitem(result))
		var/obj/item/item_result = result
		item_result.do_drop_animation(chef)
	chef.investigate_log("[key_name(chef)] crafted [recipe_to_use]", INVESTIGATE_CRAFTING)
	return TRUE
