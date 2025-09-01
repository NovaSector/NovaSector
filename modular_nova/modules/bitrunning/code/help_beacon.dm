//Request reinforcements from ghost pop; sacrifice one of your respawns. Good for solo runs to make them not solo.
/obj/item/antag_spawner/bitrunning_help
	name = "subcontracted assistance request beacon"
	desc = "A single-use beacon designed to send an assistance request to any willing freelance bitrunners."
	icon = 'modular_nova/modules/bitrunning/icons/remote.dmi'
	icon_state = "delivery_running"
	/// The applied outfit
	var/datum/outfit/subcontractor_outfit = /datum/outfit/subcontracted_bitrunner
	/// Does it use up retries?
	var/spends_retries = TRUE
	/// Style used by the droppod
	var/pod_style = /datum/pod_style/box
	/// Where do we land our pod?
	var/turf/spawn_location
	/// Check to prevent request spamming
	var/polling = FALSE

/// Checks whether the request beacon can be used
/// Checks if the user is a domain ghost actor or bitrunning glitch and electrocutes them if they are.
/// Arguments:
/// * user - The mob attempting to use the beacon
/// Returns TRUE if the beacon can be used, FALSE otherwise
/obj/item/antag_spawner/bitrunning_help/proc/check_usability(mob/user)
	if(user.mind.has_antag_datum(/datum/antagonist/domain_ghost_actor, TRUE) || user.mind.has_antag_datum(/datum/antagonist/bitrunning_glitch, TRUE))
		to_chat(user, span_danger("Listen here hacker. Your interest will be terminated. Bitrunner will be retained."))
		if(isliving(user))
			var/mob/living/intruder = user
			intruder.electrocute_act(15, user, 1, SHOCK_NOGLOVES|SHOCK_NOSTUN)
		return FALSE
	return TRUE

/// Creates the drop pod the subcontractor will be dropped by
/// Creates a supplypod, duh.
/// Returns the created supplypod object
/obj/item/antag_spawner/bitrunning_help/proc/setup_pod()
	var/obj/structure/closet/supplypod/pod = new(null, pod_style)
	pod.explosionSize = list(0,0,0,0)
	pod.bluespace = TRUE
	return pod

/obj/item/antag_spawner/bitrunning_help/attack_self(mob/user)
	// Check usability and if already in use
	if(!check_usability(user))
		return

	if(polling)
		balloon_alert(user, "already in use!")
		return

	balloon_alert(user, "[src] activated!")
	polling = TRUE

	// Find an available quantum server
	var/obj/machinery/quantum_server/server = get_available_server()
	if(!server)
		balloon_alert(user, "bandwidth limit reached!")
		polling = FALSE
		return

	// Poll for a ghost candidate
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(
		"Do you want to play as a reinforcement subcontracted Bitrunner?",
		check_jobban = ROLE_GLITCH,
		role = ROLE_GLITCH,
		poll_time = 15 SECONDS,
		ignore_category = POLL_IGNORE_GLITCH,
		alert_pic = src,
		role_name_text = "Subcontracted Assisting Bitrunner",
		amount_to_pick = 1
	)

	// Process the chosen candidate
	if(chosen_one)
		if(QDELETED(src))
			return

		if(spends_retries)
			server.retries_spent += 1
			server.threat += 1

		// Announce the successful query
		var/obj/machinery/announcement_system/aas = get_announcement_system(source = server)
		if(aas)
			aas.broadcast("Subcontractor query successful, bitrunner connecting.", list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_FACTION))

		// Spawn the antag and clean up
		spawn_antag(chosen_one.client, get_turf(src), "subrunner", user.mind, server)
		do_sparks(4, TRUE, get_turf(src))
		qdel(src)
	else
		polling = FALSE
		to_chat(user, span_warning("Unable to detect spooling quantum servers. Please wait and try again later."))

/// Finds an available quantum server
/// Iterates through all quantum servers to find one that has available retries or doesn't require retries to be spent.
/// Returns the first available quantum server or null if none are found
/obj/item/antag_spawner/bitrunning_help/proc/get_available_server()
	// Find an available quantum server
	for(var/obj/machinery/quantum_server/server as anything in SSmachines.get_machines_by_type(/obj/machinery/quantum_server))
		if(server.retries_spent < length(server.exit_turfs) || !spends_retries)
			return server
	return null

/obj/item/antag_spawner/bitrunning_help/spawn_antag(client/our_client, turf/T, kind, datum/mind/user, obj/machinery/quantum_server/connected_server)
	// Create and equip the subcontractor
	var/mob/living/carbon/human/subcontractor = create_subcontractor(our_client)

	// Set up mind and antagonist status
	var/datum/mind/ghost_mind = subcontractor.mind
	if(ghost_mind)
		subcontractor.AddComponent(/datum/component/temporary_body, ghost_mind, ghost_mind.current, TRUE)
	subcontractor.mind.add_antag_datum(/datum/antagonist/bitrunning_reinforcement)

	// Move to a safe location
	move_to_safe_location(subcontractor)

	// Equip the subcontractor
	equip_subcontractor(subcontractor, connected_server)

	// Set up ID card
	setup_id_card(subcontractor)

	// Add bodycam component
	add_bodycam(subcontractor)

	// Create and prepare the drop pod
	var/obj/structure/closet/supplypod/pod = setup_pod()
	subcontractor.forceMove(pod)
	new /obj/effect/pod_landingzone(spawn_location ? spawn_location : get_turf(src), pod)

/// Creates a new human subcontractor from a client
/// Creates a new human mob, transfers the client's preferences, sets the ckey, and assigns a name from either preferences or a list of hacker aliases.
/// Arguments:
/// * our_client - The client to create the subcontractor from
/// Returns the newly created human subcontractor
/obj/item/antag_spawner/bitrunning_help/proc/create_subcontractor(client/our_client)
	var/mob/living/carbon/human/subcontractor = new()
	our_client.prefs.safe_transfer_prefs_to(subcontractor, is_antag = TRUE)
	subcontractor.ckey = our_client.key
	subcontractor.real_name = subcontractor.client?.prefs?.read_preference(/datum/preference/name/hacker_alias) || pick(GLOB.hacker_aliases)
	return subcontractor

/// Moves the subcontractor to a safe starting location
/// Moves the subcontractor to a new player start location if available, otherwise moves them to coordinates 1,1,1 as a fallback.
/// Arguments:
/// * subcontractor - The human subcontractor to be moved
/obj/item/antag_spawner/bitrunning_help/proc/move_to_safe_location(mob/living/carbon/human/subcontractor)
	if(length(GLOB.newplayer_start))
		subcontractor.forceMove(pick(GLOB.newplayer_start))
	else
		subcontractor.forceMove(locate(1,1,1))

/// Equips the subcontractor with appropriate gear
/// Creates and customizes the outfit for the subcontractor, sets armor values for clothing, and adds custom items to the backpack if not using a forced outfit.
/// Arguments:
/// * subcontractor - The human subcontractor to be equipped
/// * server - The quantum server connected to the domain (for domain-specific outfit)
/obj/item/antag_spawner/bitrunning_help/proc/equip_subcontractor(mob/living/carbon/human/subcontractor, obj/machinery/quantum_server/server)
	// Create and customize outfit before applying
	var/outfit_path = server.generated_domain.forced_outfit || subcontractor_outfit
	var/datum/outfit/to_wear = new outfit_path()

	// Set armor values for clothing in the outfit
	if(istype(to_wear.uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/uniform = to_wear.uniform
		uniform.set_armor(/datum/armor/clothing_under)

	if(istype(to_wear.head, /obj/item/clothing/head))
		var/obj/item/clothing/head/headwear = to_wear.head
		headwear.set_armor(/datum/armor/none)

	// If not using forced outfit, customize the backpack contents
	if(!server.generated_domain.forced_outfit)
		// Clear existing backpack contents and add our custom items
		if(istype(to_wear.back, /obj/item/storage/backpack))
			LAZYNULL(to_wear.backpack_contents)
			to_wear.backpack_contents = list(
				/obj/item/storage/box/survival = 1,
				/obj/item/storage/medkit/regular = 1,
				/obj/item/flashlight = 1,
				/obj/item/storage/box/nif_ghost_box = 1,
				/obj/item/storage/box/syndie_kit/chameleon/ghostcafe = 1,
			)

	// Apply the customized outfit
	subcontractor.equipOutfit(to_wear, visuals_only = TRUE)

/// Sets up the subcontractor's ID card
/// Creates a new account for the ID card, sets it as non-replaceable, registers the subcontractor's name, updates the label, and applies the bit avatar trim to the card.
/// Arguments:
/// * subcontractor - The human subcontractor whose ID card to set up
/obj/item/antag_spawner/bitrunning_help/proc/setup_id_card(mob/living/carbon/human/subcontractor)
	var/obj/item/card/id/id_card = subcontractor.wear_id
	if(id_card)
		id_card.registered_account = new()
		id_card.registered_account.replaceable = FALSE
		id_card.registered_name = subcontractor.real_name
		id_card.update_label()
		SSid_access.apply_trim_to_card(id_card, /datum/id_trim/bit_avatar)

/// Adds a bodycam component to the subcontractor
/// Adds a simple bodycam component to the subcontractor.
/// Arguments:
/// * subcontractor - The human subcontractor to add the bodycam to
/obj/item/antag_spawner/bitrunning_help/proc/add_bodycam(mob/living/carbon/human/subcontractor)
	subcontractor.AddComponent( \
		/datum/component/simple_bodycam, \
		camera_name = "bitrunner bodycam", \
		c_tag = "Avatar [subcontractor.real_name]", \
		network = BITRUNNER_CAMERA_NET, \
		emp_proof = TRUE, \
	)
