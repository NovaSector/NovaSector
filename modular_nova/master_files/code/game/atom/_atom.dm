// Construction skill
/atom/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	if(ismob(crafter))
		var/mob/crafting_mob = crafter
		crafting_mob.mind?.adjust_experience(/datum/skill/construction, 3)
