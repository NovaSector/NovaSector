// Personalized story value calculation per-atom for storyteller

/atom/proc/story_value()
	return story_value_materials(src)

/obj/item/story_value()
	var/val = story_value_item_credit(src)
	if(val)
		return val
	return story_value_materials(src)

/obj/machinery/story_value()
	// Default: materials define most of the value; items inside are not counted here
	return story_value_materials(src)

/obj/structure/story_value()
	return story_value_materials(src)


/proc/story_value_item_credit(obj/item/I)
	if(isnull(I) || QDELETED(I))
		return 0
	var/val = I.get_item_credit_value()
	return max(0, val)

/proc/story_value_materials(atom/A)
	if(isnull(A) || QDELETED(A))
		return 0
	if(!length(A.custom_materials))
		return 0
	var/total = 0
	var/list/mat_effects = A.get_material_effects_list(A.custom_materials)
	if(!islist(mat_effects) || !length(mat_effects))
		return 0
	for(var/datum/material/mat as anything in mat_effects)
		var/list/deets = mat_effects[mat]
		var/amt = deets[MATERIAL_LIST_OPTIMAL_AMOUNT]
		total += (initial(mat.value_per_unit) || 0) * (amt || 0)
	return max(0, total)

