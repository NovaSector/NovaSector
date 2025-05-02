//Request reinforcements from ghost pop; sacrifice one of your respawns. Good for solo runs to make them not solo.
/obj/item/antag_spawner/bitrunning_help
	name = "subcontracted assistance request beacon"
	desc = "A single-use beacon designed to send an assistance request to any willing freelance bitrunners."
	icon = 'modular_nova/modules/bitrunning/icons/remote.dmi'
	icon_state = "delivery_running"
	/// The applied outfit
	var/datum/outfit/outfit = /datum/outfit/subcontracted_bitrunner
	/// Does it use up retries?
	var/spends_retries = TRUE
	/// Style used by the droppod
	var/pod_style = /datum/pod_style/box
	/// Where do we land our pod?
	var/turf/spawn_location

/obj/item/antag_spawner/bitrunning_help/proc/check_usability(mob/user)
	if(user.mind.has_antag_datum(/datum/antagonist/domain_ghost_actor,TRUE) || user.mind.has_antag_datum(/datum/antagonist/bitrunning_glitch,TRUE))
		to_chat(user, span_danger("Listen here hacker. Your interest will be terminated. Bitrunner will be retained."))
		var/mob/living/fakerunner = user
		fakerunner.electrocute_act(15, user, 1, SHOCK_NOGLOVES|SHOCK_NOSTUN)
		return FALSE
	for(var/obj/machinery/quantum_server/server in SSmachines.get_machines_by_type(/obj/machinery/quantum_server))
		if(server.retries_spent >= length(server.exit_turfs) && spends_retries == TRUE)
			user.balloon_alert(user, "bandwidth limit reached!")
			return FALSE
		if(spends_retries)
			server.retries_spent += 1
		server.threat += 1
		var/obj/machinery/announcement_system/aas = get_announcement_system(source = server)
		if(aas)
			aas.broadcast("Subcontractor query successful, new bitrunner inbound.", list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_FACTION))
	return TRUE

/// Creates the drop pod the subcontractor will be dropped by
/obj/item/antag_spawner/bitrunning_help/proc/setup_pod()
	var/obj/structure/closet/supplypod/pod = new(null, pod_style)
	pod.explosionSize = list(0,0,0,0)
	pod.bluespace = TRUE
	return pod

/obj/item/antag_spawner/bitrunning_help/attack_self(mob/user)
	if(!(check_usability(user)))
		return

	to_chat(user, span_notice("You activate [src] and wait for confirmation."))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates("Do you want to play as a reinforcement subcontracted Bitrunner?", check_jobban = ROLE_GLITCH, role = ROLE_GLITCH, poll_time = 15 SECONDS, ignore_category = POLL_IGNORE_GLITCH, alert_pic = src, role_name_text = "Subcontracted Assisting Bitrunner", amount_to_pick = 1)
	if(chosen_one)
		if(QDELETED(src) || !check_usability(user))
			return
		used = TRUE
		spawn_antag(chosen_one.client, get_turf(src), "subrunner", user.mind)
		do_sparks(4, TRUE, src)
		qdel(src)
	else
		for(var/obj/machinery/quantum_server/server in SSmachines.get_machines_by_type(/obj/machinery/quantum_server))
			if(spends_retries)
				server.retries_spent -= 1
			server.threat -= 1
		to_chat(user, span_warning("Unable to detect spooling quantum servers. Please wait and try again later."))

/obj/item/antag_spawner/bitrunning_help/spawn_antag(client/our_client, turf/T, kind, datum/mind/user)
	var/mob/living/carbon/human/subrunner = new()
	our_client.prefs.safe_transfer_prefs_to(subrunner, is_antag = TRUE)
	subrunner.ckey = our_client.key
	subrunner.real_name = subrunner.client?.prefs?.read_preference(/datum/preference/name/hacker_alias)
	var/datum/mind/ghost_mind = subrunner.mind
	if(ghost_mind) // Preserves any previous bodies before making the switch
		subrunner.AddComponent(/datum/component/temporary_body, ghost_mind, ghost_mind.current, TRUE)
	subrunner.mind.add_antag_datum(/datum/antagonist/bitrunning_reinforcement)
	if(length(GLOB.newplayer_start)) // needed as hud code doesn't render huds if the atom (in this case the subrunner) is in nullspace, so just move the subrunner somewhere safe
		subrunner.forceMove(pick(GLOB.newplayer_start))
	else
		subrunner.forceMove(locate(1,1,1))
	if(outfit)
		subrunner.equip_species_outfit(outfit)

	var/obj/structure/closet/supplypod/pod = setup_pod()
	subrunner.forceMove(pod)
	new /obj/effect/pod_landingzone(spawn_location ? spawn_location : get_turf(src), pod)
