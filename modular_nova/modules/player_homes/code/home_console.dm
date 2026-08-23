/// The save trigger, and the control panel for everything a player can change about their home.
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
	// A residence with no front door loads as a sealed box and has to have one fitted on the way in.
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

/**
 * A bin that destroys what is put in it. A home is sealed, so the junk that accumulates in one -
 * packaging a delivery came in, sheets left over from a build, whatever a guest dropped - has
 * nowhere else to go. Alt-click compacts the contents.
 *
 * It refuses anything alive, and anything release_home() would push back out to the terminal, at
 * ANY depth. A home is deliberately not allowed to become a black hole for the round's objectives,
 * and a bin that ate a nuke disk stuffed inside a backpack would be exactly that with extra steps.
 */
/obj/structure/closet/crate/bin/home_compactor
	name = "domicile waste compactor"
	desc = "A registry-issue bin with a matter shredder in the bottom. Whatever goes through it is \
		gone for good, so look twice before you run it."

/obj/structure/closet/crate/bin/home_compactor/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to compact everything inside. Right-click it with a wrench to unbolt it.")
	. += span_warning("It will not take anything alive, or anything the round might still need.")

/// Closets already anchor and unanchor on a right-click wrench, and the bin inherits that ungated -
/// which would let a guest shove the owner's compactor around. Gate it the way the console is gated
/// and otherwise leave the stock behaviour alone; anchored rides along in the save either way.
/obj/structure/closet/crate/bin/home_compactor/wrench_act_secondary(mob/living/user, obj/item/tool)
	var/datum/home_instance/home = get_home_of(src)
	if(!isnull(home) && !home.is_owner(user))
		balloon_alert(user, "not your residence!")
		return TRUE
	return ..()

/// Everything inside that the compactor is willing to destroy. Recomputed rather than remembered,
/// since the wait gives people time to reach back in.
/obj/structure/closet/crate/bin/home_compactor/proc/compactable()
	var/list/doomed = list()
	for(var/atom/movable/binned as anything in contents)
		var/refused = FALSE
		// get_all_contents() counts binned itself, so this checks the thing and everything in it.
		for(var/atom/movable/piece as anything in binned.get_all_contents())
			if(isliving(piece) || SShomes.is_round_critical(piece))
				refused = TRUE
				break
		if(!refused)
			doomed += binned
	return doomed

/obj/structure/closet/crate/bin/home_compactor/click_alt(mob/user)
	if(!isliving(user))
		return CLICK_ACTION_BLOCKING
	var/datum/home_instance/home = get_home_of(src)
	if(isnull(home))
		balloon_alert(user, "no registry link!")
		return CLICK_ACTION_BLOCKING
	if(!home.is_owner(user))
		balloon_alert(user, "not your residence!")
		return CLICK_ACTION_BLOCKING
	if(!length(compactable()))
		balloon_alert(user, length(contents) ? "it won't take those!" : "already empty!")
		return CLICK_ACTION_BLOCKING

	balloon_alert(user, "compacting...")
	if(!do_after(user, 2 SECONDS, target = src))
		return CLICK_ACTION_BLOCKING

	// Filtered again on the far side of the wait: whatever was dropped in meanwhile gets the same
	// examination, and anything protected that arrived is still refused.
	var/list/doomed = compactable()
	if(!length(doomed))
		balloon_alert(user, "it won't take those!")
		return CLICK_ACTION_BLOCKING
	var/destroyed = length(doomed)
	for(var/atom/movable/rubbish as anything in doomed)
		qdel(rubbish)

	do_animate()
	balloon_alert(user, "[destroyed] item\s compacted")
	var/spared = length(contents)
	if(spared)
		to_chat(user, span_warning("\The [src] leaves [spared] item\s where [spared == 1 ? "it is" : "they are"] - it will not destroy anything alive, or anything the round might still need."))
	return CLICK_ACTION_SUCCESS
