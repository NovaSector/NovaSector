///Defines for trash amounts to deposit, per person
#define REQUIRED_TRASH_CREW 15
#define REQUIRED_TRASH_JANITOR 5

///How much credits to give for doing your job right
#define JANITOR_WAGE_BONUS 100

///Every third ticket, for non-janitors, is a special one
#define LUXURY_TICKET_THRESHOLD 3

/obj/machinery/trash_compactor
	name = "\improper DeForest trash reclamation terminal"
	desc = "A vending machine-like terminal for the processing and reclamation of post-consumer station materials. \
		Approved waste inputs are converted into ration slips via the integrated incentive program. There's a slot for GAP cards, to stamp them for janitorial service. \
		A clean station is a symptom of a healthy crew. Consult your hygiene officer for a list of approved inputs."
	icon = 'modular_nova/modules/trash_compactor/icons/trash_compactor.dmi'
	icon_state = "trash_compactor"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/trash_compactor

	///Track trash count for each user
	var/list/trash_counts = list()
	///Track rewarded tickets for each user
	var/list/ticket_counts = list()
	///Store processed trash items separately from contents
	var/list/trash_storage = list()
	///Track inserted GAP cards
	var/obj/item/gbp_punchcard/inserted_card = null
	///Which items are considered trash?
	var/list/trash_items = list(
		/obj/item/trash,
		/obj/item/cigbutt,
		/obj/item/shard,
		/obj/item/broken_bottle,
		/obj/item/light/tube/broken,
		/obj/item/light/bulb/broken,
		/obj/item/food/deadmouse,
		/obj/item/popsicle_stick,
		/obj/item/reagent_containers/cup/glass/sillycup,
		/obj/item/grown/bananapeel,
		/obj/item/grown/corncob,
		/obj/item/food/candy_trash,
	)

/obj/machinery/trash_compactor/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "trash_compactor_broken"
		return
	if(machine_stat & NOPOWER)
		icon_state = "trash_compactor_nopower"
	else
		icon_state = "trash_compactor"
	return ..()

/obj/machinery/trash_compactor/update_overlays()
	. = ..()
	if(machine_stat & MAINT)
		. += "trash_compactor_maintenance"
	if((machine_stat & BROKEN || machine_stat & NOPOWER))
		return
	. += emissive_appearance(icon, "trash_compactor_glow", src, alpha = src.alpha)
	if(!isnull(inserted_card))
		. += "trash_compactor_gap"
		. += emissive_appearance(icon, "trash_compactor_gap_glow", src, alpha = src.alpha)

/obj/machinery/trash_compactor/examine(mob/living/user)
	. = ..()
	if(!in_range(user, src))
		return
	if(inserted_card)
		. += span_notice("There's a <b>GAP card</b> inserted in the machine. It'll <b>get stamped once</b> upon <b>hitting the quota</b>.")
	if(!istype(user)) // Only living mobs have bank accounts
		return
	// Get user's bank account
	var/datum/bank_account/user_account = user.get_bank_account()

	// Track trash count by account or user if no account
	var/tracker_key
	if(user_account)
		tracker_key = "[user_account.account_id]"
	else if(user)
		tracker_key = "[user.real_name]"

	// Show trash count if user has used the machine before
	if(tracker_key && (tracker_key in trash_counts))
		var/required = is_janitor(user) ? REQUIRED_TRASH_JANITOR : REQUIRED_TRASH_CREW
		var/remaining = required - trash_counts[tracker_key]
		. += span_notice("The status display reads: You have deposited <b>[trash_counts[tracker_key]]</b> pieces of trash. <b>[remaining]</b> more needed for [is_janitor(user) ? "a wage bonus" : "a ration ticket"].")
	else
		. += span_notice("The status display reads: Deposit [is_janitor(user) ? "[REQUIRED_TRASH_JANITOR]" : "[REQUIRED_TRASH_CREW]"] pieces of trash to receive [is_janitor(user) ? "a wage bonus" : "a ration ticket"].")

/obj/machinery/trash_compactor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE

	// Handle GAP card insertion
	if(istype(tool, /obj/item/gbp_punchcard))
		if(!isnull(inserted_card))
			balloon_alert(user, "gap card already inserted!")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		inserted_card = tool
		balloon_alert(user, "inserted card")
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	// Handle trash bags for bulk processing
	if(istype(tool, /obj/item/storage/bag/trash))
		process_trash_bag(tool, user)
		return ITEM_INTERACT_SUCCESS

	if(process_trash(tool, user))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/trash_compactor/attack_hand_secondary(mob/living/user, list/modifiers)
	. = NONE
	if(isnull(inserted_card))
		return
	if(!user.put_in_hands(inserted_card))
		inserted_card.forceMove(drop_location())
	inserted_card = null
	balloon_alert(user, "removed card")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/// Checks if the given user is a janitor by verifying their ID card's trim.
/obj/machinery/trash_compactor/proc/is_janitor(mob/user)
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	var/obj/item/card/id/id_card = human_user.get_idcard()
	if(!id_card)
		return FALSE
	if(istype(id_card.trim, /datum/id_trim/job/janitor)) //It's by trim so specifically-janitors get the advantage.
		return TRUE
	return FALSE

/// Processes a trash item through the compactor, tracking user progress and dispensing rewards.
/obj/machinery/trash_compactor/proc/process_trash(obj/item/trash_item, mob/living/carbon/user, bulk_processing = FALSE)
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert(user, "no power!")
		return FALSE

	if(!is_type_in_list(trash_item, trash_items))
		return FALSE

	// Get user's bank account
	var/datum/bank_account/user_account = user.get_bank_account()

	// Track trash count by account or user if no account
	var/tracker_key
	if(user_account)
		tracker_key = "[user_account.account_id]"
	else if(user)
		tracker_key = "[user.real_name]"

	// Initialize count if key doesn't exist
	if(tracker_key)
		trash_counts[tracker_key] ||= 0
		ticket_counts[tracker_key] ||= 0
		trash_counts[tracker_key]++

	// Store the trash item in the compactor
	trash_item.forceMove(src)
	trash_storage += trash_item

	if(!bulk_processing)
		// Say random wisdom (only for single items, not bulk)
		var/wisdom = pick(GLOB.wisdoms)
		say(wisdom)
		balloon_alert(user, "trash compacted")
		playsound(src, 'sound/machines/ping.ogg', 40, TRUE)

	// Check if we've reached required pieces of trash
	if(tracker_key && trash_counts[tracker_key] >= (is_janitor(user) ? REQUIRED_TRASH_JANITOR : REQUIRED_TRASH_CREW))
		// Reset trash counter
		trash_counts[tracker_key] = 0
		// Dispense reward using new proc
		dispense_reward(user, tracker_key)

	return TRUE

/// Handles dispensing rewards based on user type and ticket count
/obj/machinery/trash_compactor/proc/dispense_reward(mob/living/carbon/user, tracker_key)
	if(!user || !tracker_key)
		return

	var/datum/bank_account/user_account = user.get_bank_account()

	// Handle janitor rewards
	if(is_janitor(user))
		if(user_account)
			user_account.adjust_money(JANITOR_WAGE_BONUS, "Trash Compactor: Wage Bonus")
			say("[JANITOR_WAGE_BONUS] credits added to your bank account! Thank you for your service.")
		else
			new /obj/item/stack/spacecash/c100(drop_location())
			say("[/obj/item/stack/spacecash/c100::value] credit bill dispensed! Please consider opening a bank account.")
		playsound(src, 'sound/machines/chime.ogg', 50, TRUE)
		return

	// Handle non-janitor rewards
	ticket_counts[tracker_key]++

	var/ticket_type = /obj/item/paper/paperslip/ration_ticket
	if(ticket_counts[tracker_key] % LUXURY_TICKET_THRESHOLD == 0)
		ticket_type = /obj/item/paper/paperslip/ration_ticket/luxury

	new ticket_type(drop_location())
	say("Ration ticket dispensed! Thank you for your contribution to recycling.")
	playsound(src, 'sound/machines/chime.ogg', 50, TRUE)

	// Handle GAP card punching if inserted
	if(inserted_card)
		if(inserted_card.punches < inserted_card.max_punches)
			inserted_card.punches++
			inserted_card.icon_state = "punchcard_[inserted_card.punches]"
		if(inserted_card.punches == inserted_card.max_punches)
			playsound(src, 'sound/items/party_horn.ogg', 100)
			say("Congratulations, you have finished your punchcard!")
		else
			playsound(src, 'sound/items/boxcutter_activate.ogg', 50)
			say("GAP card punched!")

/// Processes-runs all valid trash items in a trash bag through the compactor.
/obj/machinery/trash_compactor/proc/process_trash_bag(obj/item/storage/bag/trash/trash_bag, mob/living/carbon/user)
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert(user, "no power!")
		return FALSE

	var/processed_count = 0
	for(var/obj/item/trash/trash_item in trash_bag.contents)
		if(process_trash(trash_item, user, bulk_processing = TRUE))
			processed_count++

	if(processed_count > 0)
		balloon_alert(user, "processed [processed_count] items")
		playsound(src, 'sound/machines/ping.ogg', 60, TRUE)
	else
		balloon_alert(user, "bag empty!")

	return processed_count > 0

/obj/item/circuitboard/machine/trash_compactor
	name = "\improper DeForest trash reclamation terminal (Machine Board)"
	build_path = /obj/machinery/trash_compactor
	req_components = list()

/obj/item/flatpack/trash_compactor
	name = "\improper DeForest trash reclamation terminal"
	board = /obj/item/circuitboard/machine/trash_compactor
	custom_premium_price = PAYCHECK_CREW * 1.5
