/datum/unit_test/limbsanity

/datum/unit_test/limbsanity/Run()
	for(var/path in valid_subtypesof(/obj/item/bodypart)) /// removes the abstract items.
		var/obj/item/bodypart/part = path
		if(part::bodypart_flags & BODYPART_STUMP)
			continue // stumps don't need to have icons

		if(part::is_dimorphic)
			if(!icon_exists(UNLINT(part::should_draw_greyscale ? part::icon_greyscale : part::icon_static), "[part::limb_id]_[part::body_zone]_m"))
				TEST_FAIL("[path] does not have a valid icon for male variants")
			if(!icon_exists(UNLINT(part::should_draw_greyscale ? part::icon_greyscale : part::icon_static), "[part::limb_id]_[part::body_zone]_f"))
				TEST_FAIL("[path] does not have a valid icon for female variants")
		// NOVA EDIT ADDITION START
		else if(part::bodyshape & BODYSHAPE_DIGITIGRADE)
			var/digi_icon_state = "[part::limb_id]_[part::body_zone]_[ICON_KEY_DIGI]"
			if(!icon_exists(UNLINT(part::should_draw_greyscale ? part::icon_greyscale : part::icon_static), "[part::limb_id]_[part::body_zone]_[ICON_KEY_DIGI]"))
				TEST_FAIL("[path] does not have a valid icon for digi variants despite having the BODYSHAPE_DIGITIGRADE flag set. (MISSING ICON_STATE: ([digi_icon_state]))")
		// NOVA EDIT ADDITION END
		else if(!icon_exists(UNLINT(part::should_draw_greyscale ? part::icon_greyscale : part::icon_static), "[part::limb_id]_[part::body_zone]"))
			TEST_FAIL("[path] does not have a valid icon")
