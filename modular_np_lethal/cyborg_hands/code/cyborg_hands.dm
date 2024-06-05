// Lets cyborgs pick stuff up, and outlines stuff that isn't in their model's kit for easier identification.
// Anything they pick up can be used like normal. Retains all of its functionality. ALL of it. Balance nightmare? Yes

/obj/item/attack_ai(mob/user)
	if(Adjacent(user, src) && !istype(src.loc, /obj/item/robot_model) && iscyborg(user)) // it's not one of our modules, and we're 100% sure we're a cyborg
		var/mob/living/silicon/robot/robor = user

		// determine the appropriate hand index we can use for this, by checking held_items to see what modules are empty
		var/can_pickup = FALSE
		for (var/module_slot in 1 to length(robor.held_items))
			if(!robor.held_items[module_slot])
				robor.active_hand_index = module_slot
				can_pickup = TRUE
				break

		if (!can_pickup)
			balloon_alert(robor, "no modules free to pick up with!")
			return

		if(robor.low_power_mode)
			balloon_alert(robor, "no power: hand actuators disabled!")
			return

		if (robor.is_invalid_module_number(robor.active_hand_index))
			balloon_alert(robor, "module too damaged: seek repairs!")
			return

		if (!attempt_pickup(user))
			robor.select_module(robor.active_hand_index) // set it to active because you know, we probably want to use it
			SET_PLANE_EXPLICIT(src, ABOVE_HUD_PLANE, src) // so we can see the stupid thing on the HUD
			AddComponent(/datum/component/cyborg_hand_item, host = robor) // link up our component for outline + other handling
			robor.hud_used.persistent_inventory_update() // so it shows up on the HUD at all
			robor.observer_screen_update(src, TRUE) // so ghosts see it via observer overlay
		return

	return ..()

/mob/living/silicon/put_in_hand_check()
	return TRUE // unbelievable, stupendous, excellent, a paragon of coding prowess

/mob/living/silicon/robot/select_module()
	..()

	var/mod_index = get_selected_module()
	active_hand_index = !mod_index ? 1 : mod_index

/mob/living/silicon/robot/unequip_module_from_slot(obj/item/item_module, module_num)
	// we're dropping an item that we picked up. normally this runtimes, but clearly we don't want that, we just want to drop the stupid item.
	// look this sucks and there's code duplication involved here but it'd be semi-modular otherwise
	if(!(item_module in model.modules))
		dropItemToGround(item_module)

		if(client)
			client.screen -= item_module

		if(module_active == item_module)
			module_active = null

		switch(module_num)
			if(BORG_CHOOSE_MODULE_ONE)
				if(!(disabled_modules & BORG_MODULE_ALL_DISABLED))
					inv1.icon_state = initial(inv1.icon_state)
			if(BORG_CHOOSE_MODULE_TWO)
				if(!(disabled_modules & BORG_MODULE_TWO_DISABLED))
					inv2.icon_state = initial(inv2.icon_state)
			if(BORG_CHOOSE_MODULE_THREE)
				if(!(disabled_modules & BORG_MODULE_THREE_DISABLED))
					inv3.icon_state = initial(inv3.icon_state)

		hud_used.persistent_inventory_update()
		observer_screen_update(item_module, FALSE)
		return

	return ..()

/mob/living/silicon/robot/can_hold_items(obj/item/I)
	return ..()
