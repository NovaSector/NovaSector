/// The save trigger, and the control panel for everything a player can change about their home.
///
/// Homes are never written to disk on their own - somebody has to walk up to this and say so, which
/// is what stops a home that got griefed while its owner was out from overwriting a good save.
/obj/machinery/home_saver
	name = "domicile registry console"
	desc = "Commits the current state of these rooms to your account's permanent record, and \
		controls the fittings. Storage compartments are catalogued as furniture, not as containers - \
		anything shut inside one is not on the record and will not come back."
	icon = /obj/machinery/keycard_auth::icon
	icon_state = /obj/machinery/keycard_auth::icon_state
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	density = FALSE
	use_power = NO_POWER_USE
	/// Blocks a second save being kicked off while write_map() is still chewing through the room.
	var/saving = FALSE

/obj/machinery/home_saver/examine(mob/user)
	. = ..()
	. += span_notice("Wrench it loose to move it, or unbolt it from its own panel.")
	var/datum/home_instance/home = get_home_of(src)
	if(!isnull(home))
		. += span_notice(home.save_state_blurb())

/obj/machinery/home_saver/wrench_act(mob/living/user, obj/item/tool)
	var/datum/home_instance/home = get_home_of(src)
	if(isnull(home) || !home.is_owner(user))
		balloon_alert(user, "not your residence!")
		return ITEM_INTERACT_BLOCKING
	return default_unfasten_wrench(user, tool) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/machinery/home_saver/attack_hand(mob/living/user, list/modifiers)
	ui_interact(user)
	return TRUE

/obj/machinery/home_saver/attack_robot(mob/user)
	if(user.Adjacent(src))
		ui_interact(user)
	return TRUE

/obj/machinery/home_saver/ui_interact(mob/user, datum/tgui/ui)
	var/datum/home_instance/home = get_home_of(src)
	if(isnull(home))
		to_chat(user, span_warning("\The [src] isn't linked to any residence."))
		return
	if(!home.is_owner(user))
		to_chat(user, span_warning("\The [src] is keyed to somebody else's account and ignores you."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HomeConsole", name)
		ui.open()

/// The catalogue only changes when somebody edits the code, so it ships once per window rather than
/// on every update tick.
/obj/machinery/home_saver/ui_static_data(mob/user)
	var/list/catalogue = list()
	for(var/datum/home_supply/entry as anything in SShomes.supply_catalogue)
		catalogue += list(list(
			"name" = entry.name,
			"category" = entry.category,
			"desc" = entry.desc,
			"contents" = entry.manifest_summary(),
			"needs_approval" = entry.needs_approval,
		))
	return list("catalogue" = catalogue)

/obj/machinery/home_saver/ui_data(mob/user)
	var/datum/home_instance/home = get_home_of(src)
	if(isnull(home))
		return list()
	return list(
		"last_saved" = home.last_saved,
		"saving" = saving,
		"door_hung" = !isnull(home.find_door()),
		"bolted" = anchored,
		"brightness" = home.brightness,
		"lamp_color" = home.lamp_color,
		"gravity" = home.gravity,
		"has_backup" = fexists(SShomes.home_file(home.owner_ckey, "home_backup.dmm")),
		"max_brightness" = HOME_BRIGHTNESS_MAX,
		"supply_cooldown" = SShomes.supply_cooldown_remaining(home.owner_ckey) / 10,
	)

/obj/machinery/home_saver/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/mob/living/user = ui.user
	var/datum/home_instance/home = get_home_of(src)
	// Re-checked on every action, not just on open: a blocking prompt gives somebody plenty of time
	// to wander off, and the home itself can be torn down underneath an open window.
	if(isnull(home) || !home.is_owner(user) || !user.Adjacent(src))
		return TRUE

	switch(action)
		if("save")
			commit_save(home, user)
			return TRUE
		if("restore")
			restore_backup(home, user)
			return TRUE
		if("leave")
			home.evict(user)
			return TRUE
		if("take_down_door")
			home.uninstall_door(user)
			return TRUE
		if("toggle_bolts")
			set_anchored(!anchored)
			balloon_alert(user, anchored ? "bolted down" : "unbolted")
			return TRUE
		if("set_brightness")
			home.brightness = clamp(round(text2num(params["value"])), HOME_BRIGHTNESS_MIN, HOME_BRIGHTNESS_MAX)
			home.apply_lights()
			return TRUE
		if("set_color")
			home.lamp_color = sanitize_home_lamp_color(params["value"])
			home.apply_lights()
			return TRUE
		if("pick_color")
			var/picked = input(user, "Pick a bulb colour", "Lighting", home.lamp_color || "#ffffff") as color|null
			if(picked && home.is_owner(user))
				home.lamp_color = sanitize_home_lamp_color(picked)
				home.apply_lights()
			return TRUE
		if("toggle_gravity")
			home.gravity = !home.gravity
			home.apply_gravity()
			return TRUE
		if("requisition")
			request_catalogue_line(home, user, params["name"])
			return TRUE
		if("written_requisition")
			var/written = trim(sanitize(params["text"]), MAX_MESSAGE_LEN)
			if(written)
				SShomes.request_supplies(home, user, null, written)
			return TRUE

/obj/machinery/home_saver/proc/commit_save(datum/home_instance/home, mob/living/user)
	if(saving)
		balloon_alert(user, "already committing!")
		return
	// A residence with no front door loads as a sealed box and has to have one fitted for the
	// player on the way in. Refusing here is kinder than silently filing a home they cannot use.
	if(isnull(home.find_door()))
		to_chat(user, span_warning("\The [src] refuses the record: your front door is not hung. Put it back up first."))
		return

	saving = TRUE
	balloon_alert(user, "committing record...")
	var/saved = SShomes.save_home(home, user)
	saving = FALSE
	if(!saved)
		return
	balloon_alert(user, "record committed")
	to_chat(user, span_notice("\The [src] chimes. Your home is on the record exactly as it stands."))

/obj/machinery/home_saver/proc/restore_backup(datum/home_instance/home, mob/living/user)
	if(tgui_alert(user, "Restoring rolls your home back to the save before your last one. Everything currently in these rooms is lost. Continue?", "Restore Previous Save", list("Restore", "Cancel")) != "Restore")
		return
	if(!user.Adjacent(src) || !home.is_owner(user))
		return
	SShomes.restore_backup(home, user)

/// Looks a catalogue line up by name and files it. Going by name rather than by index means a
/// stale window cannot order the wrong thing after the catalogue has been edited.
/obj/machinery/home_saver/proc/request_catalogue_line(datum/home_instance/home, mob/user, entry_name)
	for(var/datum/home_supply/entry as anything in SShomes.supply_catalogue)
		if(entry.name != entry_name)
			continue
		SShomes.request_supplies(home, user, entry)
		return
