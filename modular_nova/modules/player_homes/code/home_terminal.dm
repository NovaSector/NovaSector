/// How long a visitor must wait before knocking at the same door again.
#define HOME_KNOCK_COOLDOWN (30 SECONDS)

/// The front door to the whole system: a pad in the cafe that cycles a player into their own home.
/// Sits alongside /obj/machinery/cafe_condo_teleporter, which does the same job for disposable rooms.
/obj/machinery/home_terminal
	name = "domicile registry terminal"
	desc = "A bluespace registry keyed to a private, permanent residence. It follows your account \
		rather than your employment file, so every identity you wear walks into the same rooms."
	icon = /obj/machinery/quantumpad::icon
	icon_state = /obj/machinery/quantumpad::icon_state
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	density = FALSE
	use_power = NO_POWER_USE

/obj/machinery/home_terminal/examine(mob/user)
	. = ..()
	. += span_notice("Your residences are tied to your account, and every character you play shares them. You may keep up to [CONFIG_GET(number/player_home_slots)].")
	. += span_warning("Anything that is part of your residence stays in it - you keep your own belongings.")

/obj/machinery/home_terminal/attack_hand(mob/living/user, list/modifiers)
	ui_interact(user)
	return TRUE

/obj/machinery/home_terminal/attack_robot(mob/user)
	if(user.Adjacent(src))
		ui_interact(user)
	return TRUE

/obj/machinery/home_terminal/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] rejects your mind as the bluespace energies around it disrupt your telekinesis."))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/home_terminal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PlayerHome", name)
		ui.open()

/// The preview pictures of the player's homes, for whichever ones have had a save produce one.
/// Per-player, so they cannot be declared statically the way a normal interface asset would be.
/obj/machinery/home_terminal/ui_assets(mob/user)
	. = ..()
	if(!user?.ckey)
		return .
	for(var/slot in SShomes.filed_slots(user.ckey))
		var/datum/asset/home_preview/preview = SShomes.get_preview_asset(user.ckey, slot)
		if(!isnull(preview))
			. += preview
	return .

/// Static because it reads every home's sidecar off disk. The actions that change it refresh it.
/obj/machinery/home_terminal/ui_static_data(mob/user)
	var/list/starters = list()
	for(var/starter_name in sort_list(SShomes.starter_templates))
		var/datum/map_template/home/starter = SShomes.starter_templates[starter_name]
		if(starter.admin_only)
			continue
		starters += list(list(
			"name" = starter.name,
			"blurb" = starter.blurb,
			"size" = "[starter.width]x[starter.height]",
		))

	var/list/homes = list()
	if(user?.ckey)
		for(var/slot in SShomes.filed_slots(user.ckey))
			var/list/metadata = SShomes.read_metadata(user.ckey, slot)
			var/datum/asset/home_preview/preview = SShomes.get_preview_asset(user.ckey, slot)
			homes += list(list(
				"slot" = slot,
				"name" = SShomes.home_display_name(user.ckey, slot, metadata),
				"named" = !!metadata["label"],
				"starter" = metadata["starter"],
				"last_saved" = metadata["saved_at"],
				"object_count" = metadata["object_count"],
				"preview_asset" = preview?.asset_name,
			))

	return list(
		"starters" = starters,
		"homes" = homes,
		"max_homes" = CONFIG_GET(number/player_home_slots),
	)

/obj/machinery/home_terminal/ui_data(mob/user)
	var/list/loaded_slots = list()
	for(var/slot in 1 to HOME_MAX_SLOTS)
		if(!isnull(SShomes.get_active_home(user.ckey, slot)))
			loaded_slots += slot
	return list(
		"enabled" = !!CONFIG_GET(flag/player_homes_enabled),
		"loaded_slots" = loaded_slots,
		"hosts" = SShomes.visitable_hosts(user),
	)

/obj/machinery/home_terminal/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	if(!ready_for(user))
		return TRUE

	switch(action)
		if("enter")
			enter_home(user, sanitize_home_slot(params["slot"]))
			return TRUE
		if("create")
			create_home(user, params["starter"])
			update_static_data(user, ui)
			return TRUE
		if("reset")
			reset_home(user, sanitize_home_slot(params["slot"]))
			update_static_data(user, ui)
			return TRUE
		if("rename")
			rename_home(user, sanitize_home_slot(params["slot"]))
			update_static_data(user, ui)
			return TRUE
		if("knock")
			// Only ever a knock. Admission is not an action a client can ask for.
			var/home_key = SShomes.host_home_from_ref(params["ref"])
			if(home_key)
				SShomes.knock(user, home_key, src)
			return TRUE

/// Shared gate for every action. Mirrors the condo teleporter's eligibility check, and is re-run
/// after any blocking prompt so a player can't walk away mid-dialogue and still cycle through.
/obj/machinery/home_terminal/proc/ready_for(mob/user)
	if(!CONFIG_GET(flag/player_homes_enabled))
		to_chat(user, span_warning("The registry is offline."))
		return FALSE
	if(!user?.ckey)
		to_chat(user, span_warning("\The [src] can't find an account to key a residence to."))
		return FALSE
	if(!Adjacent(user))
		to_chat(user, span_warning("You are too far away from \the [src] to use it!"))
		return FALSE
	if(user.incapacitated)
		to_chat(user, span_warning("You aren't able to operate \the [src] anymore!"))
		return FALSE
	return TRUE

/obj/machinery/home_terminal/proc/enter_home(mob/user, slot)
	if(isnull(slot) || !SShomes.has_home(user.ckey, slot))
		to_chat(user, span_warning("The registry has no such residence on file for your account."))
		return
	var/datum/home_instance/home = SShomes.get_active_home(user.ckey, slot) || SShomes.load_home(user.ckey, slot, src, user)
	if(isnull(home))
		return
	SShomes.warp_into_home(home, user)

/// Shows a visitor into somebody else's home. Only ever joins a home already standing - a guest
/// never causes one to load. No permission check on purpose: this is only reachable from ask_host(),
/// after the owner has personally agreed. Nothing else may call it, and no ui_act maps to it.
/obj/machinery/home_terminal/proc/admit_visitor(mob/visitor, home_key)
	// The host could have walked out during the minute their prompt was open.
	var/datum/home_instance/home = SShomes.active_homes[home_key]
	if(isnull(home))
		to_chat(visitor, span_warning("The door was answered, but the residence has since been shut up."))
		return
	SShomes.warp_into_home(home, visitor)

/// Files a new home in the account's lowest free slot and walks the player straight into it.
/obj/machinery/home_terminal/proc/create_home(mob/user, starter_name)
	var/datum/map_template/home/starter = SShomes.starter_templates[starter_name]
	if(isnull(starter))
		return
	if(starter.admin_only)
		log_admin("[key_name(user)] asked the home terminal for restricted plan '[starter.name]', which is not offered to players.")
		message_admins("[key_name_admin(user)] asked the home terminal for restricted plan '[starter.name]', which is not offered to players.")
		return
	// Loading the new home can sleep, and a second click landing meanwhile would file a second home.
	// Timed rather than held, so a runtime partway through can never lock somebody out for the round.
	if(world.time < SShomes.claims_in_progress[user.ckey])
		return
	var/slot = SShomes.next_free_slot(user.ckey)
	if(isnull(slot))
		to_chat(user, span_warning("Your account already holds as many residences as the registry will file. Demolish one to make room."))
		return
	SShomes.claims_in_progress[user.ckey] = world.time + 10 SECONDS
	if(!SShomes.write_starter(user.ckey, slot, starter, user))
		SShomes.claims_in_progress -= user.ckey
		to_chat(user, span_warning("The registry failed to file your residence. Contact an administrator."))
		return
	to_chat(user, span_notice("The registry files your residence and unlocks the pad."))
	enter_home(user, slot)
	SShomes.claims_in_progress -= user.ckey

/obj/machinery/home_terminal/proc/reset_home(mob/user, slot)
	if(isnull(slot) || !SShomes.has_home(user.ckey, slot))
		return
	var/home_name = SShomes.home_display_name(user.ckey, slot)
	if(tgui_alert(user, "This demolishes \"[home_name]\". Everything you have built or carried into it is gone, and the plot is freed for a new plan. Your other residences are untouched. Its last save is kept as a backup for administrators. Continue?", "Demolish Residence", list("Demolish", "Cancel")) != "Demolish")
		return
	if(!ready_for(user))
		return
	SShomes.reset_home(user.ckey, slot, user)
	to_chat(user, span_notice("The registry demolishes [html_encode(home_name)]. The plot is free for a new plan."))

/// Names one of the player's homes, so they can tell them apart. Clearing the name goes back to the plan's.
/obj/machinery/home_terminal/proc/rename_home(mob/user, slot)
	if(isnull(slot) || !SShomes.has_home(user.ckey, slot))
		return
	var/list/metadata = SShomes.read_metadata(user.ckey, slot)
	var/typed = tgui_input_text(user, "What should this residence be called? Leave it blank to go back to its plan's name.", "Name Residence", metadata["label"], max_length = HOME_LABEL_MAX_LEN, encode = FALSE)
	if(isnull(typed) || !ready_for(user) || !SShomes.has_home(user.ckey, slot))
		return
	typed = trim(typed)
	var/label = null
	if(length(typed))
		label = reject_bad_text(typed, HOME_LABEL_MAX_LEN)
		if(isnull(label))
			to_chat(user, span_warning("The registry won't file that name."))
			return
	SShomes.set_home_label(user.ckey, slot, label)

/*
 * Visiting somebody else's home, done by knocking via the terminal.
 */

/// The home this mob is standing in, if it is one of their own. With several homes to an account,
/// that is the only door it makes sense to knock at: the one the host is actually behind.
/datum/controller/subsystem/homes/proc/home_hosted_by(mob/host_mob)
	if(!isliving(host_mob) || !host_mob.ckey)
		return null
	var/datum/home_instance/home = get_home_of(host_mob)
	if(isnull(home) || !home.is_owner(host_mob))
		return null
	return home

/// Everyone whose door there is any point knocking at: online, standing in one of their own homes,
/// and answering callers. You cannot knock at an empty house, since admission is granted in the
/// moment and a host answering from across the station would be letting somebody into rooms they
/// are not in.
///
/// Hosts are identified to the client by a mob ref, never by ckey - a player should not learn who is
/// behind a character from a door list.
/datum/controller/subsystem/homes/proc/visitable_hosts(mob/visitor)
	var/list/hosts = list()
	for(var/client/online as anything in GLOB.clients)
		if(!online.ckey || (online.ckey == visitor?.ckey))
			continue
		var/mob/host_mob = online.mob
		var/datum/home_instance/host_home = home_hosted_by(host_mob)
		if(isnull(host_home) || !host_home.accepts_knocks)
			continue
		hosts += list(list(
			"ref" = REF(host_mob),
			"name" = host_mob.real_name || "Unknown",
		))
	return hosts

/// Resolves what the client sent back into the home we are willing to knock at, as a home_key().
/// Re-checks that they are in, because a window open on somebody's screen can easily outlast them
/// going home, or moving on to another of their homes.
/datum/controller/subsystem/homes/proc/host_home_from_ref(host_ref)
	var/mob/host_mob = locate(host_ref)
	if(!ismob(host_mob))
		return null
	var/datum/home_instance/host_home = home_hosted_by(host_mob)
	return host_home?.registry_key()

/// Knocks at somebody's door. The answer is asked for asynchronously, so the visitor is not left
/// staring at a frozen terminal while the host makes up their mind.
/datum/controller/subsystem/homes/proc/knock(mob/visitor, home_key, obj/machinery/home_terminal/terminal)
	var/datum/home_instance/home = active_homes[home_key]
	var/client/host = GLOB.directory[home?.owner_ckey]
	if(isnull(home) || isnull(host) || isnull(host.mob) || !home.accepts_knocks)
		to_chat(visitor, span_warning("Nobody is answering."))
		return FALSE

	// Per host rather than per home: hopping between homes should not reset how often they get knocked at.
	var/cooldown_key = "[visitor.ckey]-[home.owner_ckey]"
	if(world.time < knock_cooldowns[cooldown_key])
		to_chat(visitor, span_warning("You have only just knocked. Give them a moment."))
		return FALSE
	knock_cooldowns[cooldown_key] = world.time + HOME_KNOCK_COOLDOWN

	to_chat(visitor, span_notice("You knock, and wait to see if anybody answers."))
	INVOKE_ASYNC(src, PROC_REF(ask_host), visitor, host, home_key, terminal)
	return TRUE

/// Puts the question to the host and acts on the answer. Runs detached from the knocker.
/datum/controller/subsystem/homes/proc/ask_host(mob/visitor, client/host, home_key, obj/machinery/home_terminal/terminal)
	var/visitor_name = visitor.real_name || visitor.ckey
	var/answer = tgui_alert(
		host,
		"[visitor_name] is knocking at your door. Letting them in admits them this once - if they leave, they will have to knock again.",
		"Somebody at the Door",
		list("Let them in", "Refuse"),
		timeout = 1 MINUTES,
	)
	if(answer != "Let them in")
		to_chat(visitor, span_warning("Nobody answers the door."))
		return

	// The yes was for the person stood at the pad a moment ago. It lapses rather than following them.
	if(QDELETED(terminal) || !terminal.ready_for(visitor))
		to_chat(host, span_warning("You open the door, but [visitor_name] is no longer waiting."))
		return

	log_game("Player homes: [host.ckey] let [visitor.ckey] into their home ([home_key]).")
	to_chat(host, span_notice("You let [visitor_name] in."))
	to_chat(visitor, span_notice("The door opens."))
	terminal.admit_visitor(visitor, home_key)

#undef HOME_KNOCK_COOLDOWN
