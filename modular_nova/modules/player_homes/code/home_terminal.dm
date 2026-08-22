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
