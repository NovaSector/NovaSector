/obj/machinery/trash_compactor
	name = "trash compactor"
	desc = "A machine that crushes and processes recyclable materials. After processing trash, it punches GAP cards and dispenses ration tickets. Wisdom guaranteed with every transaction."
	icon = 'modular_nova/modules/trash_compactor/icons/trash_compactor.dmi'
	icon_state = "active"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 500
	circuit = /obj/item/circuitboard/machine/trash_compactor

	// Track trash count for each user
	var/list/trash_counts = list()
	// Add this with the other variable declarations at the top of the trash_compactor object
	var/list/ticket_counts = list()
	// Track inserted GAP cards
	var/obj/item/gbp_punchcard/inserted_card = null

/obj/machinery/trash_compactor/examine(mob/living/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		// Get user's bank account
		var/datum/bank_account/user_account = user.get_bank_account()

		// Get tracker key
		var/tracker_key
		if(user_account)
			tracker_key = user_account.account_id
		else if(user)
			tracker_key = user.real_name

		// Show trash count if user has used the machine before
		if(tracker_key && trash_counts[tracker_key])
			var/required = is_janitor(user) ? 5 : 15
			var/remaining = required - trash_counts[tracker_key]
			. += span_notice("The status display reads: You have deposited <b>[trash_counts[tracker_key]]</b> pieces of trash. <b>[remaining]</b> more needed for a ration ticket.")
		else
			. += span_notice("The status display reads: Deposit [is_janitor(user) ? "5" : "15"] pieces of trash to receive a ration ticket.")

		if(inserted_card)
			. += span_notice("There's a GAP card inserted in the machine.")

/obj/machinery/trash_compactor/attackby(obj/item/attacking_item, mob/living/carbon/user)
	. = ..()

	// Handle GAP card insertion
	if(istype(attacking_item, /obj/item/gbp_punchcard))
		if(inserted_card)
			balloon_alert(user, "GAP card already inserted!")
			return COMPONENT_NO_AFTERATTACK
		if(!user.transferItemToLoc(attacking_item, src))
			return
		inserted_card = attacking_item
		balloon_alert(user, "GAP card inserted!")
		return COMPONENT_NO_AFTERATTACK

	// Handle trash bags for bulk processing
	if(istype(attacking_item, /obj/item/storage/bag/trash))
		process_trash_bag(attacking_item, user)
		return COMPONENT_NO_AFTERATTACK

	if(process_trash(attacking_item, user))
		return COMPONENT_NO_AFTERATTACK

	return NONE

/obj/machinery/trash_compactor/attack_hand_secondary(mob/living/user)
	. = ..()
	if(inserted_card)
		if(!user.put_in_hands(inserted_card))
			inserted_card.forceMove(drop_location())
		inserted_card = null
		balloon_alert(user, "card removed")
		return TRUE
	return FALSE

/obj/machinery/trash_compactor/proc/is_janitor(mob/user)
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	return human_user.mind?.assigned_role == "Janitor"

/obj/machinery/trash_compactor/proc/process_trash(obj/item/trash_item, mob/living/carbon/user, bulk_processing = FALSE)
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert(user, "no power!")
		return FALSE

	if(!istype(trash_item, /obj/item/trash))
		return FALSE

	// Get user's bank account
	var/datum/bank_account/user_account = user.get_bank_account()

	// Track trash count by account or user if no account
	var/tracker_key
	if(user_account)
		tracker_key = user_account.account_id
	else if(user)
		tracker_key = user.real_name

	if(tracker_key)
		trash_counts[tracker_key] = trash_counts[tracker_key] ? trash_counts[tracker_key] + 1 : 1

	qdel(trash_item)

	if(!bulk_processing)
		// Say random wisdom (only for single items, not bulk)
		var/wisdom = pick(GLOB.wisdoms)
		say(wisdom)
		balloon_alert(user, "trash compacted!")
		playsound(src, 'sound/machines/ping.ogg', 40, TRUE)
		use_energy(active_power_usage)

		// Check if we've reached required pieces of trash
		if(tracker_key && trash_counts[tracker_key] >= (is_janitor(user) ? 5 : 15))
			// Reset trash counter
			trash_counts[tracker_key] = 0

			// Handle janitor rewards
			if(is_janitor(user))
				if(user_account)
					user_account.adjust_money(100)
					say("100 credits added to your bank account! Thank you for your service.")
				else
					new /obj/item/stack/spacecash/c100(drop_location())
					say("100 credit bill dispensed! Please consider opening a bank account.")
				playsound(src, 'sound/machines/chime.ogg', 50, TRUE)
			else
				// Non-janitor rewards
				ticket_counts[tracker_key] = ticket_counts[tracker_key] ? ticket_counts[tracker_key] + 1 : 1
				var/ticket_type = /obj/item/paper/paperslip/ration_ticket
				if(ticket_counts[tracker_key] % 3 == 0)  // Every third ticket
					ticket_type = /obj/item/paper/paperslip/ration_ticket/luxury
				new ticket_type(drop_location())
				say("Ration ticket dispensed! Thank you for your contribution to recycling.")
				playsound(src, 'sound/machines/chime.ogg', 50, TRUE)

			// Punch the GAP card if one is inserted
			if(inserted_card)
				if(inserted_card.punches < inserted_card.max_punches)
					inserted_card.punches++
					inserted_card.icon_state = "punchcard_[inserted_card.punches]"
				if(inserted_card.punches == inserted_card.max_punches)
					playsound(src, 'sound/items/party_horn.ogg', 100)
					say("Congratulations, you have finished your punchcard!")
				else
					playsound(src, 'sound/items/boxcutter_activate.ogg', 50, TRUE)
					say("GAP card punched!")

	return TRUE

/obj/machinery/trash_compactor/proc/process_trash_bag(obj/item/storage/bag/trash/trash_bag, mob/living/carbon/user)
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert(user, "no power!")
		return FALSE

	var/processed_count = 0
	for(var/obj/item/trash/trash_item in trash_bag.contents)
		if(process_trash(trash_item, user, bulk_processing = TRUE))
			processed_count++

	if(processed_count > 0)
		balloon_alert(user, "processed [processed_count] items!")
		playsound(src, 'sound/machines/ping.ogg', 60, TRUE)
		use_energy(active_power_usage * processed_count)
	else
		balloon_alert(user, "bag empty!")

	return processed_count > 0

/obj/item/circuitboard/machine/trash_compactor
	name = "Trash Compactor (Machine Board)"
	build_path = /obj/machinery/trash_compactor
	req_components = null
