/datum/computer_file/program/contract_uplink
	filename = "contractor uplink"
	filedesc = "Syndicate Contractor Uplink"
	extended_desc = "A standard, Syndicate issued system for handling important contracts while on the field."
	category = PROGRAM_CATEGORY_MISC
	program_icon_state = "contractor-assign"
	program_icon = "tasks"
	size = 10

	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	available_on_syndinet = FALSE
	usage_flags = PROGRAM_PDA //this is all we've got sprites for :sob:
	unique_copy = TRUE
	undeletable = TRUE
	tgui_id = "SyndicateContractor"

	///The traitor datum stored on the program. Starts off as null and is set by the player.
	var/datum/antagonist/traitor/traitor_data
	///The error screen sent to the UI so they can show the player.
	var/error = ""
	///Boolean on whether the UI is on the Information screen.
	var/info_screen = TRUE
	///Boolean on whether the program is being loaded for the first time, for a unique screen animation.
	var/first_load = TRUE

/datum/computer_file/program/contract_uplink/clone()
	var/datum/computer_file/program/contract_uplink/temp = ..()
	temp.traitor_data = traitor_data
	return temp

/datum/computer_file/program/contract_uplink/Destroy(force)
	traitor_data = null
	return ..()

/datum/computer_file/program/contract_uplink/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/living/user = usr

	// NOVA EDIT ADDITION START
	var/obj/item/modular_computer/pda/contractor/uplink_computer = computer
	if(!istype(uplink_computer))
		return
	// NOVA EDIT ADDITION END

	switch(action)
		if("PRG_contract-accept")
			var/contract_id = text2num(params["contract_id"])
			uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ACTIVE // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ACTIVE
			uplink_computer.opfor_data.contractor_hub.current_contract = uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id] // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.current_contract
			program_icon_state = "contractor-contract"
			return TRUE

		if("PRG_login")
			/*
			var/datum/antagonist/traitor/traitor_user = user.mind.has_antag_datum(/datum/antagonist/traitor)
			if(!traitor_user)
				error = "UNAUTHORIZED USER"
				return TRUE

			traitor_data = traitor_user
			if(!traitor_data.uplink_handler.contractor_hub)
				traitor_data.uplink_handler.contractor_hub = new
				traitor_data.uplink_handler.contractor_hub.create_contracts(traitor_user.owner)
				user.playsound_local(user, 'sound/effects/contractstartup.ogg', 100, FALSE)
				program_icon_state = "contractor-contractlist"
			*/
			// NOVA EDIT ADDITION START
			if(!user.mind.opposing_force)
				var/datum/opposing_force/opposing_force = new(user.mind)
				user.mind.opposing_force = opposing_force
				SSopposing_force.new_opfor(opposing_force)
			var/datum/opposing_force/opfor_data = user.mind.opposing_force

			if (!opfor_data) // Just in case
				return FALSE
			// Only play greet sound, and handle contractor hub when assigning for the first time.
			if (!opfor_data.contractor_hub)
				user.playsound_local(user, 'sound/effects/contractstartup.ogg', 100, FALSE)
				opfor_data.contractor_hub = new
				opfor_data.contractor_hub.create_hub_items()

			// Stops any topic exploits such as logging in multiple times on a single system.
			if (!assigned)
				opfor_data.contractor_hub.create_contracts(opfor_data.mind_reference)

				uplink_computer.opfor_data = opfor_data

				program_icon_state = "contractor-contractlist"
				assigned = TRUE
			// NOVA EDIT ADDITION END
			return TRUE

		if("PRG_call_extraction")
			if (uplink_computer.opfor_data.contractor_hub.current_contract.status != CONTRACT_STATUS_EXTRACTING) // NOVA EDIT CHANGE - ORIGINAL: if (traitor_data.uplink_handler.contractor_hub.current_contract.status != CONTRACT_STATUS_EXTRACTING)
				if (uplink_computer.opfor_data.contractor_hub.current_contract.handle_extraction(user)) // NOVA EDIT CHANGE - ORIGINAL: if (traitor_data.uplink_handler.contractor_hub.current_contract.handle_extraction(user))
					user.playsound_local(user, 'sound/effects/confirmdropoff.ogg', 100, TRUE)
					uplink_computer.opfor_data.contractor_hub.current_contract.status = CONTRACT_STATUS_EXTRACTING // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.current_contract.status = CONTRACT_STATUS_EXTRACTING

					program_icon_state = "contractor-extracted"
				else
					user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
					error = "Either both you or your target aren't at the dropoff location, or the pod hasn't got a valid place to land. Clear space, or make sure you're both inside."
			else
				user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
				error = "Already extracting... Place the target into the pod. If the pod was destroyed, this contract is no longer possible."

			return TRUE
		if("PRG_contract_abort")
			var/contract_id = uplink_computer.opfor_data.contractor_hub.current_contract.id // NOVA EDIT CHANGE - ORIGINAL: var/contract_id = traitor_data.uplink_handler.contractor_hub.current_contract.id

			uplink_computer.opfor_data.contractor_hub.current_contract = null // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.current_contract = null
			uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED

			program_icon_state = "contractor-contractlist"

			return TRUE
		if("PRG_redeem_TC")
			if (uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem) // NOVA EDIT CHANGE - ORIGINAL: if (traitor_data.uplink_handler.contractor_hub.contract_TC_to_redeem)
				var/obj/item/stack/telecrystal/crystals = new /obj/item/stack/telecrystal(get_turf(user), uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem) // NOVA EDIT CHANGE - ORIGINAL: var/obj/item/stack/telecrystal/crystals = new /obj/item/stack/telecrystal(get_turf(user), traitor_data.uplink_handler.contractor_hub.contract_TC_to_redeem)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.put_in_hands(crystals))
						to_chat(H, span_notice("Your payment materializes into your hands!"))
					else
						to_chat(user, span_notice("Your payment materializes onto the floor."))

				uplink_computer.opfor_data.contractor_hub.contract_TC_payed_out += uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.contract_TC_payed_out += traitor_data.uplink_handler.contractor_hub.contract_TC_to_redeem
				uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem = 0 // NOVA EDIT CHANGE - ORIGINAL: traitor_data.uplink_handler.contractor_hub.contract_TC_to_redeem = 0
				return TRUE
			else
				user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
			return TRUE
		if ("PRG_clear_error")
			error = ""
			return TRUE
		if("PRG_set_first_load_finished")
			first_load = FALSE
			return TRUE
		if("PRG_toggle_info")
			info_screen = !info_screen
			return TRUE
		// NOVA EDIT ADDITION START
		if ("buy_hub")
			if (uplink_computer.opfor_data.mind_reference.current == user)
				var/item = params["item"]
				for (var/datum/contractor_item/hub_item in uplink_computer.opfor_data.contractor_hub.hub_items)
					if (hub_item.name == item)
						hub_item.handle_purchase(uplink_computer.opfor_data.contractor_hub, user)
			else
				error = "Invalid user... You weren't recognized as the user of this system."
		// NOVA EDIT ADDITION END


/datum/computer_file/program/contract_uplink/ui_data(mob/user)
	var/list/data = list()
	var/obj/item/modular_computer/pda/contractor/uplink_computer = computer // NOVA EDIT ADDITION

	data["first_load"] = first_load
	data["logged_in"] = uplink_computer?.opfor_data // NOVA EDIT CHANGE - ORIGINAL: data["logged_in"] = !!traitor_data
	data["station_name"] = GLOB.station_name
	data["info_screen"] = info_screen
	data["error"] = error

	if(!uplink_computer?.opfor_data) // NOVA EDIT CHANGE - ORIGINAL: if(!traitor_data)
		data["ongoing_contract"] = FALSE
		data["extraction_enroute"] = FALSE
		update_computer_icon()
		return data

	var/datum/opposing_force/opfor_data = uplink_computer.opfor_data // NOVA EDIT ADDITION
	data["ongoing_contract"] = !!opfor_data.contractor_hub.current_contract // NOVA EDIT CHANGE - ORIGINAL:
	if(opfor_data.contractor_hub.current_contract) // NOVA EDIT CHANGE - ORIGINAL: if(traitor_data.uplink_handler.contractor_hub.current_contract)
		program_icon_state = "contractor-contract"
		if (opfor_data.contractor_hub.current_contract.status == CONTRACT_STATUS_EXTRACTING) // NOVA EDIT CHANGE - ORIGINAL: if (traitor_data.uplink_handler.contractor_hub.current_contract.status == CONTRACT_STATUS_EXTRACTING)
			data["extraction_enroute"] = TRUE
			program_icon_state = "contractor-extracted"
		else
			data["extraction_enroute"] = FALSE
		var/turf/curr = get_turf(user)
		var/turf/dropoff_turf
		data["current_location"] = "[get_area_name(curr, TRUE)]"
		for (var/turf/content in opfor_data.contractor_hub.current_contract.contract.dropoff.contents) // NOVA EDIT CHANGE - ORIGINAL: for (var/turf/content in traitor_data.uplink_handler.contractor_hub.current_contract.contract.dropoff.contents)
			if (isturf(content))
				dropoff_turf = content
				break
		var/direction
		if(curr.z == dropoff_turf.z) //Direction calculations for same z-level only
			direction = uppertext(dir2text(get_dir(curr, dropoff_turf))) //Direction text (East, etc). Not as precise, but still helpful.
			if(get_area(user) == opfor_data.contractor_hub.current_contract.contract.dropoff) // NOVA EDIT CHANGE - ORIGINAL: if(get_area(user) == traitor_data.uplink_handler.contractor_hub.current_contract.contract.dropoff)
				direction = "LOCATION CONFIRMED"
		else
			direction = "???"
		data["dropoff_direction"] = direction
	data["redeemable_tc"] = opfor_data.contractor_hub.contract_TC_to_redeem // NOVA EDIT CHANGE - ORIGINAL: data["redeemable_tc"] = traitor_data.uplink_handler.contractor_hub.contract_TC_to_redeem
	data["earned_tc"] = opfor_data.contractor_hub.contract_TC_payed_out // NOVA EDIT CHANGE - ORIGINAL: data["earned_tc"] = traitor_data.uplink_handler.contractor_hub.contract_TC_payed_out
	data["contracts_completed"] = opfor_data.contractor_hub.contracts_completed // NOVA EDIT CHANGE - ORIGINAL: data["contracts_completed"] = traitor_data.uplink_handler.contractor_hub.contracts_completed
	for (var/datum/syndicate_contract/contract in opfor_data.contractor_hub.assigned_contracts) // NOVA EDIT CHANGE - ORIGINAL: for (var/datum/syndicate_contract/contract in traitor_data.uplink_handler.contractor_hub.assigned_contracts)
		if(!contract.contract)
			stack_trace("Syndiate contract with null contract objective found in [opfor_data.mind_reference]'s contractor hub!") // NOVA EDIT CHANGE - ORIGINAL:stack_trace("Syndiate contract with null contract objective found in [traitor_data.owner]'s contractor hub!")
			contract.status = CONTRACT_STATUS_ABORTED
			continue
		data["contracts"] += list(list(
			"target" = contract.contract.target,
			"target_rank" = contract.target_rank,
			"payout" = contract.contract.payout,
			"payout_bonus" = contract.contract.payout_bonus,
			"dropoff" = contract.contract.dropoff,
			"id" = contract.id,
			"status" = contract.status,
			"message" = contract.wanted_message
		))
	// NOVA EDIT ADDITION START
	data["contract_rep"] = opfor_data.contractor_hub.contract_rep
	for (var/datum/contractor_item/hub_item in opfor_data.contractor_hub.hub_items)
		data["contractor_hub_items"] += list(list(
			"name" = hub_item.name,
			"desc" = hub_item.desc,
			"cost" = hub_item.cost,
			"limited" = hub_item.limited,
			"item_icon" = hub_item.item_icon
		))
	// NOVA EDIT ADDITION END

	update_computer_icon()
	return data
