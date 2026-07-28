/obj/structure/sink/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(busy)
		to_chat(user, span_warning("Someone's already washing here!"))
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/towel))
		if(reagents.total_volume <= 0)
			to_chat(user, span_notice("\The [src] is dry."))
			return ITEM_INTERACT_BLOCKING

		busy = TRUE
		user.visible_message(span_notice("[user] starts washing [tool] in [src]."), span_notice("You start washing [tool] in [src]."))

		if(!do_after(user, 2 SECONDS, src))
			busy = FALSE
			to_chat(user, span_warning("You take [tool] away from [src] before you're done washing it."))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/towel/washed_towel = tool

		washed_towel.reagents.remove_all(washed_towel.reagents.total_volume)
		washed_towel.transfer_reagents_to_towel(reagents, washed_towel.reagents.maximum_volume, user)

		washed_towel.set_wet(TRUE)
		washed_towel.make_used(user, silent = TRUE)

		START_PROCESSING(SSobj, src)
		user.visible_message(span_notice("[user] finishes washing [tool] in [src]."), span_notice("You finish washing [washed_towel] in [src], leaving it quite wet."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)

		busy = FALSE
		return ITEM_INTERACT_SUCCESS

	else
		return ..()

