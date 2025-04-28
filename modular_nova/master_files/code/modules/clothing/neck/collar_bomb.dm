/obj/item/clothing/neck/collar_bomb/explosive_countdown(ticks_left)
	active = TRUE
	if(ticks_left > 0)
		playsound(src, 'sound/items/timer.ogg', 30, FALSE)
		balloon_alert_to_viewers("[ticks_left]")
		ticks_left--
		addtimer(CALLBACK(src, PROC_REF(explosive_countdown), ticks_left), 1 SECONDS)
		return

	playsound(src, 'sound/effects/snap.ogg', 75, TRUE)
	if(!ishuman(loc))
		balloon_alert_to_viewers("dud...")
		active = FALSE
		return
	var/mob/living/carbon/human/brian = loc
	if(brian.get_item_by_slot(ITEM_SLOT_NECK) != src)
		balloon_alert_to_viewers("dud...")
		active = FALSE
		return
	// everything above this line is just copy-pasted as of 4/27/2025 m/d/y
	visible_message(span_warning("[src] goes off, horrifically maiming [brian]!"), span_hear("You hear a boom!"))
	playsound(src, SFX_EXPLOSION, 30, TRUE)
	var/obj/item/bodypart/head/dome = brian.get_bodypart(BODY_ZONE_HEAD)
	// max damage to the head is 250 and we want to hit crit slash/crit bone/crit burn
	dome.receive_damage(brute = 75, sharpness = SHARP_EDGED)
	dome.receive_damage(brute = 75, sharpness = SHARP_EDGED)
	dome.receive_damage(burn = 100)
	var/datum/wound/cranial_fissure/crit_wound = new()
	crit_wound.apply_wound(dome)
	brian.investigate_log("has been blasted by [src].", INVESTIGATE_DEATHS)
	// everything below this line is just copy-pasted as of 4/27/2025 m/d/y
	flash_color(brian, flash_color = COLOR_RED, flash_time = 1 SECONDS)
	qdel(src)
