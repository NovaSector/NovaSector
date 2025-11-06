/// Integrated persocom - protean's built-in virtual PDA. Requires no power, works anywhere, syncs with ID cards, accessible even in suit mode.
/obj/item/modular_computer/pda/protean
	name = "integrated persocom"
	desc = "A virtual PDA interface integrated into the protean's neural core."

	base_active_power_usage = 0 WATTS
	base_idle_power_usage = 0 WATTS

	long_ranged = TRUE // Proteans have good internal antennae

	max_idle_programs = 3

	max_capacity = 64
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1

/obj/item/modular_computer/pda/protean/Initialize(mapload)
	. = ..()

	// prevent these from being created outside of protean brains
	if(!istype(loc, /obj/item/organ/brain/protean))
		return INITIALIZE_HINT_QDEL

/obj/item/modular_computer/pda/protean/check_power_override()
	return TRUE

/datum/action/item_action/protean/open_internal_computer
	name = "Open Persocom"
	desc = "Accesses your built-in virtual machine."
	check_flags = NONE
	button_icon = 'modular_nova/modules/proteans/icons/protean.dmi'
	button_icon_state = "posi1"

/datum/action/item_action/protean/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/brain/protean/targetmachine = target
	if(!targetmachine.internal_computer)
		return
	targetmachine.internal_computer.interact(owner)

/obj/item/modular_computer/pda/protean/ui_state(mob/user)
	return GLOB.default_state

/obj/item/modular_computer/pda/protean/ui_status(mob/user)
	var/obj/item/organ/brain/protean/brain_loc = loc
	if(!istype(brain_loc))
		return UI_CLOSE

	if(!QDELETED(brain_loc.owner))
		// Allow protean to use perscom while in suit mode (user is the protean owner)
		if(user == brain_loc.owner)
			// Proteans in suit mode are technically incapacitated (TRAIT_CRITICAL_CONDITION)
			// but should still be able to use their persocom. Check only if alive.
			if(user.stat == DEAD)
				return UI_CLOSE
			return UI_INTERACTIVE
		// Others need to be adjacent
		return min(
			ui_status_user_is_abled(user, src),
			ui_status_only_living(user),
			ui_status_user_is_adjacent(user, brain_loc.owner),
		)
	return ..()

/// Updates the perscom's linked ID card reference. Called when protean equips/unequips ID cards, PDAs, or wallets.
/obj/item/modular_computer/pda/protean/proc/update_id_slot(obj/item/card/id/id_card)
	var/obj/item/organ/brain/protean/brain_loc = loc
	if(!istype(brain_loc))
		return
	if(isnull(brain_loc.internal_computer))
		return
	brain_loc.internal_computer.handle_id_slot(brain_loc.owner, id_card)

/// Called when id slot item is unequipped from the id slot
/obj/item/modular_computer/pda/protean/proc/on_id_item_unequipped(datum/source)
	SIGNAL_HANDLER
	clear_id_slot_signals(source)
	update_id_slot()

/// Called when id slot item's contained id is moved out of the id slot item
/obj/item/modular_computer/pda/protean/proc/on_id_item_moved(datum/source)
	SIGNAL_HANDLER
	clear_id_slot_signals(source)
	update_id_slot()

/// Called when something is inserted into an id slot wallet or pda
/obj/item/modular_computer/pda/protean/proc/on_id_item_stored(datum/source, obj/item/card/id/to_insert)
	SIGNAL_HANDLER
	if(!istype(to_insert))
		return

	UnregisterSignal(source, COMSIG_STORAGE_STORED_ITEM)
	update_id_slot(to_insert)

/obj/item/modular_computer/pda/protean/proc/clear_id_slot_signals(obj/item/id_slot_item)
	if(!istype(id_slot_item))
		return

	UnregisterSignal(id_slot_item, list(
		COMSIG_ITEM_POST_UNEQUIP,
		COMSIG_MOVABLE_MOVED,
		COMSIG_ITEM_UNSTORED,
		COMSIG_STORAGE_STORED_ITEM,
		COMSIG_MODULAR_COMPUTER_INSERTED_ID,
	))

	// make sure we clear all the signals on the contained id too
	var/obj/item/card/id/contained_id_item
	if(istype(id_slot_item, /obj/item/modular_computer/pda))
		var/obj/item/modular_computer/pda/id_slot_pda = id_slot_item
		contained_id_item = id_slot_pda.stored_id
	else if(istype(id_slot_item, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/id_slot_wallet = id_slot_item
		contained_id_item = id_slot_wallet.GetID()

	if(contained_id_item)
		UnregisterSignal(contained_id_item, list(COMSIG_MOVABLE_MOVED, COMSIG_ITEM_UNSTORED))

/// Handles ID slot item changes and sets up signal tracking. Supports ID cards, PDAs with cards, and wallets with cards.
/obj/item/modular_computer/pda/protean/proc/handle_id_slot(mob/living/carbon/human/protean, obj/item/id_item)
	if(!istype(protean))
		return
	if(isnull(id_item))
		if(stored_id)
			to_chat(protean, span_notice("Persocom RFID link disconnected."))
		stored_id = null
		return
	if(istype(id_item, /obj/item/card/id))
		stored_id = id_item
		to_chat(protean, span_notice("Persocom establishing new RFID link with [id_item]."))
		RegisterSignal(id_item, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
	else if(istype(id_item, /obj/item/modular_computer))
		var/obj/item/modular_computer/pda = id_item
		stored_id = pda.stored_id
		to_chat(protean, span_notice("Persocom establishing new RFID link with [pda]."))
		RegisterSignal(pda, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
		RegisterSignal(pda, COMSIG_MODULAR_COMPUTER_INSERTED_ID, PROC_REF(on_id_item_stored))
		if(pda.stored_id)
			RegisterSignal(pda.stored_id, COMSIG_MOVABLE_MOVED, PROC_REF(on_id_item_moved))
	else if(istype(id_item, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/your_wallet = id_item
		stored_id = your_wallet.GetID()
		to_chat(protean, span_notice("Persocom establishing new RFID link with [your_wallet]."))
		RegisterSignal(your_wallet, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_id_item_unequipped))
		RegisterSignal(your_wallet, COMSIG_STORAGE_STORED_ITEM, PROC_REF(on_id_item_stored))
		var/obj/item/card/id/wallet_id = your_wallet.GetID()
		if(wallet_id)
			RegisterSignal(wallet_id, COMSIG_ITEM_UNSTORED, PROC_REF(on_id_item_moved))
	else
		stored_id = null

/obj/item/modular_computer/pda/protean/remove_id(mob/user, silent = FALSE)
	return

/obj/item/modular_computer/pda/protean/get_ntnet_status()
	. = ..()
	if(is_centcom_level(loc.z)) // Centcom is excluded because cafe
		return NTNET_NO_SIGNAL

/obj/item/modular_computer/pda/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/targetmachine = target_mob
	if(!istype(targetmachine))
		return ..()

	var/obj/item/organ/brain/protean/protean_brain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(protean_brain) && protean_brain.internal_computer)
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES || user.zone_selected == BODY_ZONE_HEAD)
			balloon_alert(user, "establishing SSH login with persocom...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "connection established")
				to_chat(targetmachine, span_notice("[user] establishes an SSH connection between [src] and your persocom emulation."))
				protean_brain.internal_computer.interact(user)
			return
	return ..()

/obj/item/modular_computer/pda/protean/get_header_data()
	var/list/data = ..()
	var/obj/item/organ/brain/protean/brain_loc = loc
	// Battery level is now according to the protean metal reserves
	if(istype(brain_loc) && brain_loc.owner)
		var/obj/item/organ/stomach/protean/stomach = brain_loc.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
		var/charge_level = stomach ? (stomach.metal / PROTEAN_STOMACH_FULL) * 100 : 0
		switch(charge_level)
			if(80 to 110)
				data["PC_batteryicon"] = "batt_100.gif"
			if(60 to 80)
				data["PC_batteryicon"] = "batt_80.gif"
			if(40 to 60)
				data["PC_batteryicon"] = "batt_60.gif"
			if(20 to 40)
				data["PC_batteryicon"] = "batt_40.gif"
			if(5 to 20)
				data["PC_batteryicon"] = "batt_20.gif"
			else
				data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "[round(charge_level)]%"
	return data

// Add persocom to protean brain
/obj/item/organ/brain/protean
	var/obj/item/modular_computer/pda/protean/internal_computer
	actions_types = list(/datum/action/item_action/protean/open_internal_computer)

/obj/item/organ/brain/protean/Initialize(mapload)
	. = ..()
	internal_computer = new(src)

/obj/item/organ/brain/protean/Destroy()
	QDEL_NULL(internal_computer)
	return ..()

/obj/item/organ/brain/protean/on_mob_insert(mob/living/carbon/human/brain_owner, special, movement_flags)
	. = ..()
	if(!istype(brain_owner))
		return
	RegisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_signal))
	if(internal_computer && brain_owner.wear_id)
		internal_computer.handle_id_slot(brain_owner, brain_owner.wear_id)

/obj/item/organ/brain/protean/on_mob_remove(mob/living/carbon/human/brain_owner, special, movement_flags)
	. = ..()
	if(!istype(brain_owner))
		return
	UnregisterSignal(brain_owner, COMSIG_MOB_EQUIPPED_ITEM)
	if(internal_computer)
		internal_computer.handle_id_slot(brain_owner)
		internal_computer.clear_id_slot_signals(brain_owner.wear_id)

/obj/item/organ/brain/protean/proc/on_equip_signal(datum/source, obj/item/item, slot)
	SIGNAL_HANDLER
	if(isnull(internal_computer))
		return
	if(slot == ITEM_SLOT_ID)
		internal_computer.handle_id_slot(owner, item)

