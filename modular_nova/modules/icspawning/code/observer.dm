// NOVA MODULE ICSPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
// todo: update spawn-in type to a list, add new spawn-in animations and types (particularly a totally silent one, similar to how ctrlshiftclick works).

/mob/dead/observer/CtrlClickOn(mob/user)
	quickicspawn(user)

/mob/dead/observer/proc/quickicspawn(mob/user)
	if(isobserver(user) && check_rights(R_SPAWN))
		var/datum/preferences/prefs = user.client?.prefs
		if(!prefs)
			return

		var/list/spawn_options = list("Bluespace", "Pod", "Silent")
		var/list/custom_slots = list()
		for(var/slot_name in prefs.preferred_spawn_methods)
			custom_slots += "Slot: [slot_name]"

		var/teleport_option = tgui_alert(usr, "How would you like to be spawned in?", "IC Quick Spawn", custom_slots + spawn_options + list("Make a Custom Slot", "Clear Slots", "Cancel"))

		if (teleport_option == "Cancel" || !teleport_option)
			return

		var/dresscode
		var/character_option

		if (teleport_option == "Make a Custom Slot")
			var/slot_name = tgui_input_text(usr, "Enter a name for this custom spawn slot", "Save Custom Slot")
			if(!slot_name)
				return
			var/method = tgui_alert(usr, "Select spawn method for this slot", "Save Custom Slot", spawn_options)
			if(!method)
				return
			var/outfit = client.robust_dress_shop_nova()
			if(!outfit)
				return

			prefs.preferred_spawn_methods[slot_name] = method
			prefs.preferred_spawn_outfits[slot_name] = outfit
			prefs.save_preferences()
			to_chat(usr, span_notice("Saved custom spawn slot '[slot_name]'."))
			return

		if (teleport_option == "Clear Slots")
			if(tgui_alert(usr, "Are you sure you want to clear ALL custom spawn slots?", "Clear Slots", list("Yes", "No")) == "Yes")
				prefs.preferred_spawn_methods = list()
				prefs.preferred_spawn_outfits = list()
				prefs.save_preferences()
				to_chat(usr, span_notice("Cleared all custom spawn slots."))
			return

		if (findtext(teleport_option, "Slot - "))
			var/slot_name = copytext(teleport_option, 7) // Length of "Slot: " + 1
			teleport_option = prefs.preferred_spawn_methods[slot_name]
			dresscode = prefs.preferred_spawn_outfits[slot_name]
			character_option = "Selected Character" // Default for slots
		else
			character_option = tgui_alert(usr, "Which character?", "IC Quick Spawn", list("Selected Character", "Randomly Created", "Cancel"))
			if (character_option == "Cancel" || !character_option)
				return

			var/initial_outfits = tgui_input_list(usr, "Select outfit", "Quick Dress", list("Show All Outfits", "Bluespace Tech", "Subspace Tech", "Cancel"))
			if (initial_outfits == "Cancel" || !initial_outfits)
				return

			switch(initial_outfits)
				if("Bluespace Tech")
					dresscode = /datum/outfit/admin/bluespace
				if("Subspace Tech")
					dresscode = /datum/outfit/admin/subspace
				if("Show All Outfits")
					dresscode = client.robust_dress_shop_nova()
					if (!dresscode)
						return

		// We're spawning someone else
		var/give_return
		if (user != usr)
			give_return = tgui_alert(usr, "Do you want to give them the Return spell? This lets them instantly erase their character, so be careful.", "Give power?", list("Yes", "No"))
			if(!give_return)
				return

		var/addquirks
		if(character_option == "Selected Character")
			addquirks = tgui_input_list(src, "Include quirks?", "Quirky", list("Quirks Only", "Quirks & Loadout", "Loadout Only", "Neither"))
			if(!addquirks)
				return


		var/turf/current_turf = get_turf(user)
		var/mob/living/carbon/human/spawned_player = new(user)

		if (character_option == "Selected Character")
			spawned_player.name = user.name
			spawned_player.real_name = user.real_name

			var/mob/living/carbon/human/player_as_human = spawned_player
			user.client?.prefs.safe_transfer_prefs_to(player_as_human)
			if(addquirks == "Quirks & Loadout" || addquirks == "Loadout Only")
				if(dresscode == "Naked")
					player_as_human.equip_outfit_and_loadout(new /datum/outfit(), user.client?.prefs)
				else
					player_as_human.equip_outfit_and_loadout(dresscode, user.client?.prefs)
			else if(dresscode != "Naked")
				spawned_player.equipOutfit(dresscode)
			if(addquirks == "Quirks & Loadout" || addquirks == "Quirks Only")
				SSquirks.AssignQuirks(player_as_human, user.client)
			player_as_human.dna.update_dna_identity()
		else if(dresscode != "Naked")
			spawned_player.equipOutfit(dresscode)
		QDEL_IN(user, 1)

		if (teleport_option == "Bluespace")
			playsound(spawned_player, 'sound/effects/magic/Disable_Tech.ogg', 100, 1)

		if(user.mind && isliving(spawned_player))
			user.mind.transfer_to(spawned_player, 1) // second argument to force key move to new mob
		else
			spawned_player.ckey = user.key

		if(give_return != "No")
			var/datum/action/cooldown/spell/return_back/return_spell = new(spawned_player)
			return_spell.Grant(spawned_player)

		switch(teleport_option)
			if("Bluespace")
				spawned_player.forceMove(current_turf)
				do_sparks(10, TRUE, spawned_player, spark_type = /datum/effect_system/basic/spark_spread/quantum)

			if("Pod")
				var/obj/structure/closet/supplypod/empty_pod = new()

				empty_pod.style = /datum/pod_style/advanced
				empty_pod.bluespace = TRUE
				empty_pod.explosionSize = list(0,0,0,0)
				empty_pod.desc = "A sleek, and slightly worn bluespace pod - its probably seen many deliveries..."

				spawned_player.forceMove(empty_pod)

				new /obj/effect/pod_landingzone(current_turf, empty_pod)

			if("Silent")
				spawned_player.forceMove(current_turf)

/client/proc/robust_dress_shop_nova()
	var/list/baseoutfits = list("Naked", "Custom", "As Job...", "As Plasmaman...")
	var/list/outfits = list()
	var/list/paths = subtypesof(/datum/outfit) - typesof(/datum/outfit/job) - typesof(/datum/outfit/plasmaman)

	for(var/path in paths)
		// Get the datum from the path so we can grab its name.
		var/datum/outfit/path_as_outfit = path
		outfits[initial(path_as_outfit.name)] = path

	var/dresscode = tgui_input_list(src, "Select outfit", "Robust quick dress shop", baseoutfits + sort_list(outfits))

	if (isnull(dresscode))
		return

	if (outfits[dresscode])
		dresscode = outfits[dresscode]

	if (dresscode == "As Job...")
		var/list/job_paths = subtypesof(/datum/outfit/job)
		var/list/job_outfits = list()
		for(var/path in job_paths)
			var/datum/outfit/O = path
			job_outfits[initial(O.name)] = path
		dresscode = tgui_input_list(src, "Select job equipment", "Robust quick dress shop", sort_list(job_outfits))

//		dresscode = input("Select job equipment", "Robust quick dress shop") as null|anything in sort_list(job_outfits)
//		dresscode = job_outfits[dresscode]
		if(isnull(dresscode))
			return
		return job_outfits[dresscode]

	if (dresscode == "As Plasmaman...")
		var/list/plasmaman_paths = typesof(/datum/outfit/plasmaman)
		var/list/plasmaman_outfits = list()
		for(var/path in plasmaman_paths)
			var/datum/outfit/O = path
			plasmaman_outfits[initial(O.name)] = path

//		dresscode = input("Select plasmeme equipment", "Robust quick dress shop") as null|anything in sort_list(plasmaman_outfits)
		dresscode = tgui_input_list(src, "Select plasmeme equipment", "Robust quick dress shop", sort_list(plasmaman_outfits))
//		dresscode = plasmaman_outfits[dresscode]
		if(isnull(dresscode))
			return
		return plasmaman_outfits[dresscode]

	if (dresscode == "Custom")
		var/list/custom_outfits = list()
		for(var/datum/outfit/req_outfit in GLOB.custom_outfits)
			custom_outfits[req_outfit.name] = req_outfit
		var/selected_name = tgui_input_list(src, "Select outfit", "Robust quick dress shop", sort_list(custom_outfits))
		dresscode = custom_outfits[selected_name]
		if(isnull(dresscode))
			return
		return custom_outfits[dresscode]

	return dresscode
