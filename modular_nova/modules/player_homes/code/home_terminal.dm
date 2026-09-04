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
	. += span_notice("Your residence is tied to your account, and every character you play shares it.")
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

/// The player's own preview picture, if their last save produced one. Per-player, so it cannot be
/// declared statically the way a normal interface asset would be.
/obj/machinery/home_terminal/ui_assets(mob/user)
	. = ..()
	var/datum/asset/home_preview/preview = SShomes.get_preview_asset(user?.ckey)
	if(!isnull(preview))
		. += preview
	return .

/obj/machinery/home_terminal/ui_static_data(mob/user)
	var/list/starters = list()
	for(var/starter_name in sort_list(SShomes.starter_templates))
		var/datum/map_template/home/starter = SShomes.starter_templates[starter_name]
		starters += list(list(
			"name" = starter.name,
			"blurb" = starter.blurb,
			"size" = "[starter.width]x[starter.height]",
		))
	return list("starters" = starters)

/obj/machinery/home_terminal/ui_data(mob/user)
	var/list/metadata = SShomes.read_metadata(user.ckey)
	var/datum/asset/home_preview/preview = SShomes.get_preview_asset(user.ckey)
	return list(
		"preview_asset" = preview?.asset_name,
		"enabled" = !!CONFIG_GET(flag/player_homes_enabled),
		"has_home" = SShomes.has_home(user.ckey),
		"loaded" = !isnull(SShomes.active_homes[user.ckey]),
		"last_saved" = metadata["saved_at"],
		"object_count" = metadata["object_count"],
		"starter" = metadata["starter"],
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
			enter_home(user)
			return TRUE
		if("create")
			create_home(user, params["starter"])
			return TRUE
		if("reset")
			reset_home(user)
			return TRUE
		if("knock")
			// Only ever a knock. Admission is not an action a client can ask for.
			var/host_ckey = SShomes.host_ckey_from_ref(params["ref"])
			if(host_ckey)
				SShomes.knock(user, host_ckey, src)
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

/obj/machinery/home_terminal/proc/enter_home(mob/user)
	if(!SShomes.has_home(user.ckey))
		to_chat(user, span_warning("The registry has no residence on file for your account."))
		return
	var/datum/home_instance/home = SShomes.active_homes[user.ckey] || SShomes.load_home(user.ckey, src, user)
	if(isnull(home))
		return
	SShomes.warp_into_home(home, user)

/// Shows a visitor into somebody else's home. Only ever joins a home already standing - a guest
/// never causes one to load. No permission check on purpose: this is only reachable from ask_host(),
/// after the owner has personally agreed. Nothing else may call it, and no ui_act maps to it.
/obj/machinery/home_terminal/proc/admit_visitor(mob/visitor, owner_ckey)
	// The host could have walked out during the minute their prompt was open.
	var/datum/home_instance/home = SShomes.active_homes[owner_ckey]
	if(isnull(home))
		to_chat(visitor, span_warning("The door was answered, but the residence has since been shut up."))
		return
	SShomes.warp_into_home(home, visitor)

/obj/machinery/home_terminal/proc/create_home(mob/user, starter_name)
	if(SShomes.has_home(user.ckey))
		to_chat(user, span_warning("Your account already has a residence on file."))
		return
	var/datum/map_template/home/starter = SShomes.starter_templates[starter_name]
	if(isnull(starter))
		return
	if(!SShomes.write_starter(user.ckey, starter, user))
		to_chat(user, span_warning("The registry failed to file your residence. Contact an administrator."))
		return
	to_chat(user, span_notice("The registry files your residence and unlocks the pad."))
	enter_home(user)

/obj/machinery/home_terminal/proc/reset_home(mob/user)
	if(!SShomes.has_home(user.ckey))
		return
	if(tgui_alert(user, "This demolishes your residence and files a fresh one from its original plan. Everything you have built or carried in is gone. Your previous save is kept as a backup for administrators. Continue?", "Demolish Residence", list("Demolish", "Cancel")) != "Demolish")
		return
	if(!ready_for(user))
		return
	SShomes.reset_home(user.ckey, user)
	to_chat(user, span_notice("The registry demolishes your residence. Pick a new plan from the terminal."))

/*
 * Visiting somebody else's home, done by knocking via the terminal.
 */

/// Everyone whose door there is any point knocking at: online, currently in their own home, and
/// answering callers. You cannot knock at an empty house, since admission is granted in the moment
/// and a host answering from across the station would be letting somebody into rooms they are not in.
///
/// Hosts are identified to the client by a mob ref, never by ckey - a player should not learn who is
/// behind a character from a door list.
/datum/controller/subsystem/homes/proc/visitable_hosts(mob/visitor)
	var/list/hosts = list()
	for(var/client/online as anything in GLOB.clients)
		if(!online.ckey || (online.ckey == visitor?.ckey))
			continue
		var/mob/host_mob = online.mob
		var/datum/home_instance/host_home = active_homes[online.ckey]
		if(isnull(host_mob) || isnull(host_home) || !host_home.accepts_knocks)
			continue
		hosts += list(list(
			"ref" = REF(host_mob),
			"name" = host_mob.real_name || "Unknown",
		))
	return hosts

/// Resolves what the client sent back into an account we are willing to knock at. Re-checks that
/// they are in, because a window open on somebody's screen can easily outlast them going home.
/datum/controller/subsystem/homes/proc/host_ckey_from_ref(host_ref)
	var/mob/host_mob = locate(host_ref)
	if(!ismob(host_mob) || !host_mob.ckey)
		return null
	return isnull(active_homes[host_mob.ckey]) ? null : host_mob.ckey

/// Knocks at somebody's door. The answer is asked for asynchronously, so the visitor is not left
/// staring at a frozen terminal while the host makes up their mind.
/datum/controller/subsystem/homes/proc/knock(mob/visitor, owner_ckey, obj/machinery/home_terminal/terminal)
	var/client/host = GLOB.directory[owner_ckey]
	var/datum/home_instance/home = active_homes[owner_ckey]
	if(isnull(host) || isnull(host.mob) || isnull(home) || !home.accepts_knocks)
		to_chat(visitor, span_warning("Nobody is answering."))
		return FALSE

	var/cooldown_key = "[visitor.ckey]-[owner_ckey]"
	if(world.time < knock_cooldowns[cooldown_key])
		to_chat(visitor, span_warning("You have only just knocked. Give them a moment."))
		return FALSE
	knock_cooldowns[cooldown_key] = world.time + HOME_KNOCK_COOLDOWN

	to_chat(visitor, span_notice("You knock, and wait to see if anybody answers."))
	INVOKE_ASYNC(src, PROC_REF(ask_host), visitor, host, owner_ckey, terminal)
	return TRUE

/// Puts the question to the host and acts on the answer. Runs detached from the knocker.
/datum/controller/subsystem/homes/proc/ask_host(mob/visitor, client/host, owner_ckey, obj/machinery/home_terminal/terminal)
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

	log_game("Player homes: [owner_ckey] let [visitor.ckey] into their home.")
	to_chat(host, span_notice("You let [visitor_name] in."))
	to_chat(visitor, span_notice("The door opens."))
	terminal.admit_visitor(visitor, owner_ckey)

#undef HOME_KNOCK_COOLDOWN
