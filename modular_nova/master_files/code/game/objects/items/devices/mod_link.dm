/obj/item/clothing/neck/link_scryer/can_call()
	. = ..()
	var/mob/living/user = loc
	if(!istype(user))
		return FALSE

	var/area/user_area = get_area(user)

	// if we're in a ghost-cafe, we can't call or be called.
	// this will still work on the interlink (/area/centcom/interlink)
	if(user_area.type in GLOB.ghost_cafe_areas)
		return FALSE

