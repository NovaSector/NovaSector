///The amount of time it takes for the pad to warm up
#define SYN_BOUNTY_PAD_WARM_TIME 6 SECONDS

/**
 * # Syndicate Pad & Pad Terminal
 *
 * A citizen pad modified to accept goods and return money to a specified account
 *
 * This file is based off of civilian_bounties.dm
 * Any changes made to that file should be copied over with discretion
 *
 * Do not make this a subtype a subtype for the civilian bountypad it will break it
 */

/obj/machinery/computer/piratepad_control
	var/export_market = EXPORT_MARKET_PIRACY

///Pad for the Syndicate Bounty Control.
/obj/item/circuitboard/machine/ghostpad
	name = "Soar Industries Sales Pad"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/piratepad/ghostpad
	req_components = list(
		/datum/stock_part/scanning_module = 1,
		/datum/stock_part/micro_laser = 1,
	)

/obj/machinery/piratepad/ghostpad
	name = "\improper Soar Industries sales pad"
	desc = "A Specialized Deepspace Teleportation Pad that has been made for selling goods long distance to other companies. Will accept various (non-living) objects."
	circuit = /obj/item/circuitboard/machine/ghostpad
	icon = 'modular_nova/master_files/icons/obj/machines/ghost_pad.dmi'
	icon_state = "ghost_pad"
	idle_state = "ghost_pad"
	warmup_state = "ghost_pad-idle"
	sending_state = "ghost_pad-beam"

	// The modifier to reduce warmuptime
	var/warmup_reduction = 0

/obj/machinery/piratepad/ghostpad/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, "[icon_state]-idle-open", "[idle_state]", tool)

/obj/machinery/piratepad/ghostpad/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_crowbar(tool)

/obj/machinery/piratepad/ghostpad/RefreshParts()
	. = ..()
	var/tier = -2
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		tier += micro_laser.tier

	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		tier += scanning_module.tier

	warmup_reduction = tier * (0.5 SECONDS)

///Computer for activating the bounty pad
/obj/item/circuitboard/computer/ghostpad
	name = "SOAR Industries Sales Terminal"
	build_path = /obj/machinery/computer/piratepad_control/ghostpad

/obj/machinery/computer/piratepad_control/ghostpad
	name = "\improper SOAR Industries sales terminal"
	desc = "A specially made SOAR Industries Sales Console for selling objects and things to deepspace buyers."
	status_report = "Ready for delivery."
	icon_screen = "civ_bounty"
	icon_keyboard = "syndie_key"
	warmup_time = SYN_BOUNTY_PAD_WARM_TIME
	circuit = /obj/item/circuitboard/computer/ghostpad
	export_market = EXPORT_MARKET_STATION

	/// The account to add balance (Defauult ghost console one is Civ to avoid runtime errors)
	var/credits_account = ACCOUNT_CIV
	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null

/obj/machinery/computer/piratepad_control/ghostpad/post_machine_initialize()
	. = ..()
	synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)

/obj/machinery/computer/piratepad_control/ghostpad/ui_data(mob/user)
	points = !synced_bank_account ? 0 : synced_bank_account.account_balance
	return ..()

/obj/machinery/computer/piratepad_control/ghostpad/recalc()
	if(!safe_to_sell())
		return
	return ..()

/obj/machinery/computer/piratepad_control/ghostpad/send()
	var/obj/machinery/piratepad/ghostpad/pad = pad_ref?.resolve()
	if(isnull(pad))
		pad_ref = null
		sending = FALSE
		status_report = "Error: Pad not found. Please re-link the pad to the console to continue."
		return
	if(!safe_to_sell())
		sending = FALSE
		reset_icon(pad)
		return
	if(!synced_bank_account) /// Resolve the account
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
		if(!synced_bank_account)
			status_report = "Error: No department account found. Please report to Gorlex Industries."
			sending = FALSE
			reset_icon(pad)
			return
	points = 0
	. = ..()
	if(points)
		/// Waiter! Waiter! More boomer-shooter sound effect references please!!
		if(prob(1))
			playsound(pad, 'sound/machines/wewewew.ogg', 70, FALSE) /// HL1
		else if(prob(1))
			playsound(pad, 'sound/machines/wewewew.ogg', 70, FALSE) /// TF2
		else
			playsound(pad, 'sound/machines/wewewew.ogg', 70, FALSE) /// Quake
		synced_bank_account.adjust_money(points)
	points = synced_bank_account.account_balance

/obj/machinery/computer/piratepad_control/ghostpad/start_sending()
	var/obj/machinery/piratepad/ghostpad/pad = pad_ref?.resolve()
	if(isnull(pad))
		pad_ref = null
		status_report = "Error: Pad not found. Please re-link the pad to the console to continue."
		return
	if(pad && istype(pad, /obj/machinery/piratepad/ghostpad))
		warmup_time = clamp(SYN_BOUNTY_PAD_WARM_TIME - pad.warmup_reduction, 1 SECONDS, SYN_BOUNTY_PAD_WARM_TIME)
	return ..()

/// Utilizes cargoshuttle blacklist to determine what is "Safe" or not blacklisted to be sold. Any item that is NOT able to be sold for profit gets ignored and not flagged as "blacklisted"
/obj/machinery/computer/piratepad_control/ghostpad/proc/safe_to_sell()
	var/obj/machinery/piratepad/ghostpad/pad = pad_ref?.resolve()
	if(isnull(pad))
		pad_ref = null
		status_report = "Error: Pad not found. Please re-link the pad to the console to continue."
		return FALSE
	for(var/atom/movable/atom_movable in get_turf(pad))
		if(atom_movable == pad)
			continue
		for(var/atom/exporting_atom in atom_movable.get_all_contents()) /// Reuse the cargo blacklist logic here to ensure we're not deleting something important forever
			if((is_type_in_typecache(exporting_atom, GLOB.blacklisted_cargo_types) || HAS_TRAIT(exporting_atom, TRAIT_BANNED_FROM_CARGO_SHUTTLE)) && !istype(exporting_atom, /obj/docking_port))
				status_report = "Error: Black listed item ([format_text(exporting_atom.name)]) detected on pad. Please remove from pad and rescan."
				return FALSE
	return TRUE

/// Resets the pad's iconstate to its idle state after usage
/obj/machinery/computer/piratepad_control/ghostpad/proc/reset_icon(obj/machinery/piratepad/ghostpad/pad)
	if(!pad)
		return
	flick(pad.sending_state,pad)
	pad.icon_state = pad.idle_state

#undef SYN_BOUNTY_PAD_WARM_TIME


/*
* Ghost faction pads
*/

// Interdyne Pad
/obj/item/circuitboard/machine/ghostpad/interdyne
	name = "\improper Interdyne deepspace sales pad"
	greyscale_colors = COLOR_PRIDE_GREEN
	build_path = /obj/machinery/piratepad/ghostpad/interdyne

/obj/machinery/piratepad/ghostpad/interdyne
	name = "Interdyne Deepspace Sales Pad"
	desc = "A standard Interdyne Sales Pad to \
	send any (non-living) object to an distant off-sector \
	for processing. No returns!"

	icon_state = "interdyne_pad"
	idle_state = "interdyne_pad"
	warmup_state = "interdyne_pad-idle"
	sending_state = "interdyne_pad-beam"

	circuit = /obj/item/circuitboard/machine/ghostpad/interdyne

/obj/item/circuitboard/computer/ghostpad/interdyne
	name = "\improper Interdyne deepspace sales terminal"
	greyscale_colors = COLOR_PRIDE_GREEN
	build_path = /obj/machinery/computer/piratepad_control/ghostpad/interdyne

/obj/machinery/computer/piratepad_control/ghostpad/interdyne
	name = "Interdyne Deepspace Sales Terminal"
	desc = "A modified civilian console with an elaborate relay to other authorized facilities for selling goods."
	status_report = "Ready for delivery."
	icon_screen = "civ_bounty"
	icon_keyboard = "syndie_key"
	circuit = /obj/item/circuitboard/computer/ghostpad/interdyne
	credits_account = ACCOUNT_INT

// Syndicate Pad
/obj/item/circuitboard/machine/ghostpad/syndicate
	name = "\improper Syndicate deepspace sales pad"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/piratepad/ghostpad/syndicate

/obj/machinery/piratepad/ghostpad/syndicate
	name = "Syndicate Deepspace Sales Pad"
	desc = "A Syndicate Sales Pad, Specially made to \
	send any (non-living) object to an distant off-sector \
	for processing. No returns!"

	icon_state = "syndicate_pad"
	idle_state = "syndicate_pad"
	warmup_state = "syndicate_pad-idle"
	sending_state = "syndicate_pad-beam"

	circuit = /obj/item/circuitboard/machine/ghostpad/syndicate

/obj/item/circuitboard/computer/ghostpad/syndicate
	name = "\improper Syndicate deepspace sales terminal"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/piratepad_control/ghostpad/syndicate

/obj/machinery/computer/piratepad_control/ghostpad/syndicate
	name = "Syndicate Deepspace Sales Terminal"
	desc = "A modified civilian console with an elaborate relay to other authorized facilities for selling goods."
	status_report = "Ready for delivery."
	icon_screen = "civ_bounty"
	icon_keyboard = "syndie_key"
	circuit = /obj/item/circuitboard/computer/ghostpad/syndicate
	credits_account = ACCOUNT_DS2

// Tarkon Pad
/obj/item/circuitboard/machine/ghostpad/tarkon
	name = "Tarkon Deepspace Sales Pad"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/piratepad/ghostpad/tarkon

/obj/machinery/piratepad/ghostpad/tarkon
	name = "\improper Tarkon deepspace sales pad"
	desc = "A standard Tarkon Sales Pad designed to \
		send any (non-living) object to an distant off-sector \
		for processing. No returns!"

	icon_state = "tarkon_pad"
	idle_state = "tarkon_pad"
	warmup_state = "tarkon_pad-idle"
	sending_state = "tarkon_pad-beam"

	circuit = /obj/item/circuitboard/machine/ghostpad/tarkon

/obj/item/circuitboard/computer/ghostpad/tarkon
	name = "Tarkon Deepspace Sales Terminal"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/piratepad_control/ghostpad/tarkon

/obj/machinery/computer/piratepad_control/ghostpad/tarkon
	name = "\improper Tarkon deepspace sales terminal"
	desc = "A modified civilian console with an elaborate relay to other authorized facilities for selling goods."
	status_report = "Ready for delivery."
	icon_screen = "civ_bounty"
	icon_keyboard = "syndie_key"
	circuit = /obj/item/circuitboard/computer/ghostpad/tarkon
	credits_account = ACCOUNT_TI
