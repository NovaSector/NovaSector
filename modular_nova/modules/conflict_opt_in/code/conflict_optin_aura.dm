#define CONFLICT_OPT_IN_AURA_DURATION (5 SECONDS)
#define CONFLICT_OPT_IN_AURA_COOLDOWN (10 SECONDS)

/mob/living
	/// Assoc list of scanned mobs to the alternate appearance key applied to them.
	var/list/conflict_opt_in_aura_targets
	/// Timer clearing the current conflict opt-in aura scan.
	var/conflict_opt_in_aura_timer
	/// Prevents repeatedly flashing conflict opt-in status auras.
	COOLDOWN_DECLARE(conflict_opt_in_aura_cooldown)

/mob/living/proc/clear_conflict_opt_in_auras(clear_timer = TRUE)
	if(clear_timer && conflict_opt_in_aura_timer)
		deltimer(conflict_opt_in_aura_timer)
		conflict_opt_in_aura_timer = null
	for(var/mob/living/scanned_mob as anything in conflict_opt_in_aura_targets)
		if(QDELETED(scanned_mob))
			continue
		scanned_mob.remove_alt_appearance(conflict_opt_in_aura_targets[scanned_mob])
	LAZYCLEARLIST(conflict_opt_in_aura_targets)
	if(!clear_timer)
		conflict_opt_in_aura_timer = null

/mob/living/proc/show_conflict_opt_in()
	if(CONFIG_GET(flag/disable_conflict_opt_in_preferences))
		balloon_alert(src, "conflict opt-in disabled in config")
		return FALSE
	if(!client)
		return FALSE
	if(stat != CONSCIOUS)
		balloon_alert(src, "can't show statuses")
		return FALSE
	if(!COOLDOWN_FINISHED(src, conflict_opt_in_aura_cooldown))
		balloon_alert(src, "cooldown! [DisplayTimeText(COOLDOWN_TIMELEFT(src, conflict_opt_in_aura_cooldown))]")
		return FALSE

	clear_conflict_opt_in_auras()

	for(var/mob/living/scanned_mob in view(client.view || world.view, src))
		if(scanned_mob == src || isnull(scanned_mob.mind))
			continue

		var/opt_in_level = scanned_mob.mind.get_effective_conflict_opt_in_level()
		var/opt_in_status = GLOB.conflict_opt_in_strings["[opt_in_level]"] || CONFLICT_OPT_OUT_STRING
		var/aura_color = GLOB.conflict_opt_in_colors[opt_in_status] || COLOR_GRAY
		var/image/aura_image = image('icons/mob/effects/heretic_aura.dmi', scanned_mob, "heretic_aura")
		// The source aura is green, so flatten it to luminance before applying the status color.
		aura_image.color = color_matrix_multiply(color_matrix_saturation(0), color_hex2color_matrix(aura_color))

		var/aura_key = "conflict_opt_in_aura_[REF(src)]_[REF(scanned_mob)]"
		if(scanned_mob.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/one_person, aura_key, aura_image, NONE, src))
			LAZYSET(conflict_opt_in_aura_targets, scanned_mob, aura_key)

	if(!LAZYLEN(conflict_opt_in_aura_targets))
		balloon_alert(src, "no people in sight.")
		return FALSE

	COOLDOWN_START(src, conflict_opt_in_aura_cooldown, CONFLICT_OPT_IN_AURA_COOLDOWN)
	conflict_opt_in_aura_timer = addtimer(CALLBACK(src, PROC_REF(clear_conflict_opt_in_auras), FALSE), CONFLICT_OPT_IN_AURA_DURATION, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	balloon_alert(src, "conflict statuses shown")
	to_chat(src, span_notice("The conflict opt-in is visible now."))
	return TRUE

/mob/living/verb/show_conflict_opt_in_verb()
	set name = "Show Conflict Opt-In"
	set category = "IC"
	set desc = "Display nearby conflict opt-in statuses."

	show_conflict_opt_in()

/datum/keybinding/living/conflict_opt_in
	name = "conflict_opt_in"
	full_name = "Show Conflict Opt-In"
	description = "Displays nearby conflict opt-in statuses."
	keybind_signal = COMSIG_KB_LIVING_CONFLICT_OPT_IN

/datum/keybinding/living/conflict_opt_in/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(!istype(living_user))
		return FALSE
	return living_user.show_conflict_opt_in()

#undef CONFLICT_OPT_IN_AURA_COOLDOWN
#undef CONFLICT_OPT_IN_AURA_DURATION
