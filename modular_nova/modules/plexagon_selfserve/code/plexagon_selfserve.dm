#define PUNCH_ID_INVALID -1
#define PUNCH_ID_OFF_COOLDOWN 0

/datum/mind
	/// Is our mind currently clocked out of their job?
	var/clocked_out_of_job = FALSE

/datum/computer_file/program/crew_self_serve
	filename = "plexagonselfserve"
	filedesc = "Plexagon Punch Clock"
	downloader_category = PROGRAM_CATEGORY_SECURITY
	program_open_overlay = "id"
	extended_desc = "Allows crew members to remotely punch in or out of their job assignment, giving the impression they have a semblance of control over their lives."
	program_flags = PROGRAM_ON_NTNET_STORE
	size = 0
	tgui_id = "NtosSelfServe"
	program_icon = "id-card"
	///What trim is applied to inserted IDs?
	var/target_trim = /datum/id_trim/job/assistant
	///These job datums can't go off-duty
	var/static/list/blacklisted_jobs = typecacheof(list(
		/datum/job/assistant,
		/datum/job/prisoner,
	))

/datum/computer_file/program/crew_self_serve/on_start(mob/living/user)
	. = ..()
	if(!.)
		return FALSE

	if(!computer)
		stack_trace("[src] is running on a null computer!")
		return FALSE

	computer.crew_manifest_update = TRUE
	register_signals()

	return TRUE

/datum/computer_file/program/crew_self_serve/kill_program(mob/user)
	UnregisterSignal(computer, list(COMSIG_MODULAR_COMPUTER_INSERTED_ID, COMSIG_MODULAR_COMPUTER_REMOVED_ID))
	computer.crew_manifest_update = FALSE
	return ..()

/datum/computer_file/program/crew_self_serve/proc/register_signals()
	RegisterSignals(computer, list(COMSIG_MODULAR_COMPUTER_INSERTED_ID, COMSIG_MODULAR_COMPUTER_REMOVED_ID), PROC_REF(id_changed))

/datum/computer_file/program/crew_self_serve/proc/id_changed()
	SIGNAL_HANDLER
	computer.update_static_data_for_all_viewers()

/// Clocks out the currently inserted ID Card
/datum/computer_file/program/crew_self_serve/proc/clock_out(obj/item/card/id/id_card)
	if(!istype(id_card))
		return FALSE

	var/important = is_job_important(id_card)
	if(important)
		if(tgui_alert(usr, "You are a member of security and/or command, make sure that you ahelp before punching out! If you decide to punch back in later, you will need to go to the Head of Personnel or Head of Security. Do you wish to continue?", "[filedesc]", list("No", "Yes")) != "Yes")
			return FALSE

	log_econ("[id_card.registered_name] clocked out from role [id_card.get_trim_assignment()]")
	var/datum/component/off_duty_timer/timer_component = id_card.AddComponent(/datum/component/off_duty_timer, TIMECLOCK_COOLDOWN)
	if(important)
		timer_component.hop_locked = TRUE
		log_econ("[id_card.registered_name] job slot [id_card.get_trim_assignment()] has been locked from clocking back in")
		message_admins("[ADMIN_LOOKUPFLW(usr)] clocked out from [span_comradio("restricted role")]: [id_card.get_trim_assignment()].")
	else
		message_admins("[ADMIN_LOOKUPFLW(usr)] clocked out from role: [id_card.get_trim_assignment()].")

	var/current_assignment = id_card.assignment
	var/datum/id_trim/job/current_trim = id_card.trim
	var/datum/job/clocked_out_job = current_trim.job
	SSjob.FreeRole(clocked_out_job.title)

	aas_config_announce(/datum/aas_config_entry/off_duty, list(
		"PERSON" = id_card.registered_name,
		"RANK" = current_assignment,
	), computer, announcement_line = "Clock Out")
	computer.update_static_data_for_all_viewers()

	SSid_access.apply_trim_to_card(id_card, target_trim, TRUE)
	id_card.assignment = "Off-Duty " + current_assignment
	id_card.update_label()

	GLOB.manifest.modify(id_card.registered_name, id_card.assignment, id_card.get_trim_assignment())
	return TRUE

/// Clocks the currently inserted ID Card back in
/datum/computer_file/program/crew_self_serve/proc/clock_in(obj/item/card/id/id_card)
	if(!istype(id_card))
		return FALSE

	if(id_cooldown_check(id_card))
		return FALSE

	var/datum/component/off_duty_timer/id_component = id_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	var/datum/job/clocked_in_job = id_component.stored_trim.job
	if(!SSjob.OccupyRole(clocked_in_job.title))
		computer.say("[capitalize(clocked_in_job.title)] has no free slots available, unable to punch in!")
		return FALSE


	SSid_access.apply_trim_to_card(id_card, id_component.stored_trim.type, TRUE)
	id_card.assignment = id_component.stored_assignment

	log_econ("[id_card.registered_name] clocked in to role [id_card.get_trim_assignment()]")
	message_admins("[ADMIN_LOOKUPFLW(usr)] clocked in to role: [id_card.get_trim_assignment()].")

	aas_config_announce(/datum/aas_config_entry/off_duty, list(
		"PERSON" = id_card.registered_name,
		"RANK" = id_card.assignment,
	), computer, announcement_line = "Clock In")
	GLOB.manifest.modify(id_card.registered_name, id_card.assignment, id_card.get_trim_assignment())

	qdel(id_component)
	id_card.update_label()
	computer.update_static_data_for_all_viewers()

	return TRUE

/// Is the job of the inserted ID being worked by a job that in an important department? If so, this proc will return TRUE.
/datum/computer_file/program/crew_self_serve/proc/is_job_important(obj/item/card/id/id_card)
	if(!istype(id_card))
		return FALSE

	var/datum/id_trim/job/current_trim = id_card.trim
	var/datum/job/clocked_in_job = current_trim.job
	if((/datum/job_department/command in clocked_in_job.departments_list) || (/datum/job_department/security in clocked_in_job.departments_list))
		return TRUE

	return FALSE

/// Is the inserted ID on cooldown? return -1 if invalid ID, 0 if ID is not on cooldown, and remaining time until cooldown ends otherwise.
/datum/computer_file/program/crew_self_serve/proc/id_cooldown_check(obj/item/card/id/id_card)
	if(!istype(id_card))
		return PUNCH_ID_INVALID

	var/datum/component/off_duty_timer/id_component = id_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return PUNCH_ID_INVALID

	if(!id_component.on_cooldown)
		return PUNCH_ID_OFF_COOLDOWN

	return max(TIMECLOCK_COOLDOWN - (world.time - id_component.init_time), 0)

/// Returns the remaining time left for the ID, as a minutes:seconds string.
/datum/computer_file/program/crew_self_serve/proc/id_cooldown_minutes_seconds(obj/item/card/id/id_card)
	var/remaining_cooldown_time = id_cooldown_check(id_card)
	if (remaining_cooldown_time == PUNCH_ID_INVALID)
		return "--:--"

	var/cooldown_remaining_minutes = num2text(floor(remaining_cooldown_time / (1 MINUTES)))
	if (length(cooldown_remaining_minutes) == 1)
		cooldown_remaining_minutes = addtext("0", cooldown_remaining_minutes)
	var/cooldown_remaining_seconds = num2text(floor(remaining_cooldown_time / (1 SECONDS)) % (60))
	if (length(cooldown_remaining_seconds) == 1)
		cooldown_remaining_seconds = addtext("0", cooldown_remaining_seconds)

	return addtext(cooldown_remaining_minutes, ":", cooldown_remaining_seconds)

/// Is the inserted ID locked from clocking in? returns TRUE if the ID is locked
/datum/computer_file/program/crew_self_serve/proc/id_locked_check(obj/item/card/id/id_card)
	if(!istype(id_card))
		return FALSE

	var/datum/component/off_duty_timer/id_component = id_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	if(id_component.hop_locked)
		return TRUE

	return FALSE

/// Is the inserted ID off-duty? Returns true if the ID is off-duty
/datum/computer_file/program/crew_self_serve/proc/off_duty_check(obj/item/card/id/auth_card)
	if(!istype(auth_card))
		return FALSE

	var/datum/component/off_duty_timer/id_component = auth_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	return TRUE

/// Places any items inside of the `eligible_items` list to a lockbox, to be opened by the player when they clock back in.
/datum/computer_file/program/crew_self_serve/proc/secure_items(mob/living/carbon/human/human_user, obj/item/card/id/id_card, list/eligible_items)
	var/obj/item/storage/lockbox/timeclock/shame_box = new /obj/item/storage/lockbox/timeclock(get_turf(id_card), id_card)
	if(QDELETED(shame_box))
		stack_trace("Failed to create lockbox for [id_card.registered_name] trim clock-out.")
		return FALSE

	var/list/held_contents = human_user.get_contents()
	if(!held_contents)
		CRASH("Lockbox secure items: no items found on [id_card.registered_name]. That's probably incorrect!")

	var/list/shamebox_items = list()
	for(var/obj/item/found_item in held_contents)
		if(!is_type_in_list(found_item, eligible_items))
			continue
		human_user.transferItemToLoc(found_item, shame_box, force = TRUE, silent = TRUE)
		LAZYADD(shamebox_items, "[found_item.name]")

	if(!length(shame_box.contents))
		qdel(shame_box)
		return TRUE

	shame_box.locked_contents = english_list(shamebox_items)
	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, human_user)
	sparks.attach(human_user.loc)
	sparks.start()
	to_chat(human_user, span_warning("You feel weight lifted off your shoulders as items are teleported off your body!"))
	to_chat(human_user, span_notice("Items moved to lockbox: [shame_box.locked_contents]."))
	computer.say(
		message = "Nanotrasen contracts stipulate that company issued batons, masks, restraints, and other equipment are not to be used for recreational purposes. Your restricted items have been placed in a lockbox to be retrieved after punch in.",
		forced = TRUE,
	)
	return TRUE

/datum/computer_file/program/crew_self_serve/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/obj/item/card/id/inserted_auth_card = computer.stored_id
	var/mob/living/carbon/human/human_user = usr
	var/datum/mind/user_mind = usr.mind
	if(!user_mind || !human_user || !inserted_auth_card)
		return

	switch(action)
		if("PRG_change_status")
			if(!inserted_auth_card)
				return

			if(is_type_in_typecache(user_mind.assigned_role.type, blacklisted_jobs))
				playsound(computer, 'modular_nova/modules/emotes/sound/emotes/synth_no.ogg', 50, FALSE)
				return

			if(off_duty_check(inserted_auth_card))
				if(!inserted_auth_card)
					return

				if(!clock_in(inserted_auth_card))
					return

				user_mind.clocked_out_of_job = FALSE

				computer.update_static_data_for_all_viewers()
				playsound(computer, 'sound/machines/ping.ogg', 50, FALSE)

			else
				if(!clock_out(inserted_auth_card))
					return

				secure_items(human_user, inserted_auth_card, eligible_items = SELF_SERVE_RETURN_ITEMS)
				user_mind.clocked_out_of_job = TRUE

				computer.update_static_data_for_all_viewers()
				playsound(computer, 'sound/machines/ping.ogg', 50, FALSE)
				computer.remove_id(human_user, silent = TRUE)

			return TRUE

		if("PRG_eject_id")
			computer.remove_id(human_user, silent = TRUE)

			return TRUE

/datum/computer_file/program/crew_self_serve/ui_data(mob/user)
	var/list/data = list()
	var/obj/item/card/id/inserted_auth_card = computer.stored_id
	data["authCard"] = inserted_auth_card ? inserted_auth_card.name : "-----"
	data["authCardHOPLocked"] = id_locked_check(inserted_auth_card)
	data["authCardTimeLocked"] = id_cooldown_check(inserted_auth_card) > 0
	data["authCardTimeRemaining"] = id_cooldown_minutes_seconds(inserted_auth_card)

	return data

/datum/computer_file/program/crew_self_serve/ui_static_data(mob/user)
	var/list/data = list()
	var/obj/item/card/id/inserted_auth_card = computer.stored_id
	if(inserted_auth_card)
		data["authIDName"] = inserted_auth_card.registered_name ? inserted_auth_card.registered_name : "-----"
		data["authIDRank"] = inserted_auth_card.assignment ? inserted_auth_card.assignment : "Unassigned"
		data["authCardHOPLocked"] = id_locked_check(inserted_auth_card)
		data["trimClockedOut"] = off_duty_check(inserted_auth_card)
		if(inserted_auth_card.trim)
			var/datum/id_trim/card_trim = inserted_auth_card.trim
			data["trimAssignment"] = card_trim.assignment ? card_trim.assignment : ""
		else
			data["trimAssignment"] = ""
	else
		data["authIDName"] = ""
		data["authIDRank"] = ""
		data["trimClockedOut"] = FALSE
		data["trimAssignment"] = ""

	return data

/datum/aas_config_entry/off_duty
	name = "Departmental Alert: Off-duty Announcement"
	announcement_lines_map = list(
		"Clock Out" = "%PERSON, %RANK has gone off-duty.",
		"Clock In" = "%PERSON has returned to their assignment as %RANK",
	)
	vars_and_tooltips_map = list(
		"PERSON" = "will be replaced with their name.",
		"RANK" = "with their job."
	)

#undef PUNCH_ID_INVALID
#undef PUNCH_ID_OFF_COOLDOWN
