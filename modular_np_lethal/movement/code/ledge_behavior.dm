#define LEDGE_TRAIT "ledge trait"
#define LEDGE_KEY "ledge_recover"

/// Emulates 'hanging from a ledge', mostly used for chasms and z-level movement behavior.
/// Returns FALSE if the mob falls, returns TRUE if the MOB climbs back up.
/// Call this >AFTER< the mob has been moved onto the problematic turf.
/mob/living/proc/recover_from_ledge(list/unsafe_turfs, channel = 20 SECONDS, channel_cancel = 18 SECONDS, checks)
	if (stat == CONSCIOUS && !IsSleeping() && !IsUnconscious())
		var/turf/the_chasm = get_turf(src)
		var/list/nearby_turfs = the_chasm.reachableAdjacentTurfs(src, null, FALSE)
		var/list/safe_turfs = list()

		if (!unsafe_turfs)
			unsafe_turfs = GLOB.turfs_openspace // initialize with typical openspace turfs if none supplied

		for (var/turf/turf_to_check as anything in nearby_turfs) // attempt to find as many "safe" turfs as possible for us to try and clamber back up from
			if (!locate(turf_to_check) in unsafe_turfs)
				safe_turfs += turf_to_check

		if (LAZYLEN(safe_turfs) >= 1) //we have at least 1 safe turf we can try to grasp onto

			var/turf/salvation = pick(safe_turfs)
			Immobilize(channel_cancel, TRUE) // you get 2 seconds of leeway at the end of the channel to decide if you want to live or die
			visible_message(span_boldwarning("Scrabbling wildly, [src] only barely manages to avoid falling down into [the_chasm], clinging to the edge of [salvation] for dear life!"), span_userdanger("Scrabbling wildly, you grip onto the edge of [salvation] for dear life!"))

			ADD_TRAIT(src, TRAIT_MOVE_FLYING, LEDGE_TRAIT) // temporary so they don't fall down again
			ADD_TRAIT(src, TRAIT_NO_FLOATING_ANIM, LEDGE_TRAIT)

			// handle pixel shifting
			set_ledge_pixel_offsets(salvation)
			playsound(src, 'modular_np_lethal/movement/sound/gripping.mp3', 35)

			if (do_after(src, channel, salvation, extra_checks = checks, interaction_key = LEDGE_KEY, max_interact_count = 1))
				forceMove(salvation) // ONLY A HERO CAN SAVE US, I'M NOT GONNA STAND HERE AND WAAAAIITTT
				playsound(src, 'modular_np_lethal/movement/sound/stumble.mp3', 50)
				visible_message(span_warning("[src] clambers up and onto [salvation], exhausted."), span_userdanger("With a final burst of strength, you haul yourself up and over onto [salvation], and promptly collapse into an exhausted heap."))

				StaminaKnockdown(200)

				REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, LEDGE_TRAIT)
				REMOVE_TRAIT(src, TRAIT_NO_FLOATING_ANIM, LEDGE_TRAIT)
				reset_ledge_pixel_offsets()

				return TRUE
			else
				REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, LEDGE_TRAIT)
				REMOVE_TRAIT(src, TRAIT_NO_FLOATING_ANIM, LEDGE_TRAIT)
				reset_ledge_pixel_offsets()
				SetImmobilized(0, TRUE)

				if (!pulledby && !locate(src) in salvation)
					forceMove(the_chasm)
					playsound(src, 'modular_np_lethal/movement/sound/body-falling.mp3', 50)
					visible_message(span_warning("A look of horror briefly crosses [src]'s features as their grip loosens, then they are gone, falling into [the_chasm]!"), span_userdanger("Your gut lurches in horror as your grip works its way loose, and then you are falling... <i>falling...</i>"))
					return FALSE
				else // save them if they're being pulled by something or someone
					visible_message(span_notice("[pulledby] pulls [src] up from the ledge!"), span_boldnotice("[pulledby] pulls you up from the ledge, and you collapse into a heap, exhausted!"))
					StaminaKnockdown(100)
					playsound(src, 'modular_np_lethal/movement/sound/stumble.mp3', 50)
					return TRUE
		else
			to_chat(src, span_userdanger("You find nothing to cling to, and fall..."))
			playsound(src, 'modular_np_lethal/movement/sound/body-falling.mp3', 50)

	return FALSE
/// Set the pixel offsets to make it look like we're hanging onto a ledge.
/// Mimics `set_pull_offsets` except that it always defaults to aggressive grab pixel shifting.
/mob/living/proc/set_ledge_pixel_offsets(turf/place)
	var/dir = get_dir(src, place)
	setDir(dir)
	var/offset =  GRAB_PIXEL_SHIFT_AGGRESSIVE
	var/target_pixel_x = base_pixel_x + body_position_pixel_x_offset
	var/target_pixel_y = base_pixel_y + body_position_pixel_y_offset
	switch (dir)
		if (NORTH)
			animate(src, pixel_x = target_pixel_x, pixel_y = target_pixel_y + offset, 3)
		if (SOUTH)
			animate(src, pixel_x = target_pixel_x, pixel_y = target_pixel_y - offset, 3)
		if (EAST)
			animate(src, pixel_x = target_pixel_x + offset, pixel_y = target_pixel_y, 3)
		if (WEST)
			animate(src, pixel_x = target_pixel_x - offset, pixel_y = target_pixel_y, 3)

/mob/living/proc/reset_ledge_pixel_offsets()
	animate(src, pixel_x = src.base_pixel_x + src.body_position_pixel_x_offset , pixel_y = src.base_pixel_y + src.body_position_pixel_y_offset, 1)

#undef LEDGE_TRAIT
#undef LEDGE_KEY
