/datum/round_event_control/cognomerge
	name = "Monadic Cognomerge"
	typepath = /datum/round_event/cognomerge
	weight = 15
	min_players = 5
	max_occurrences = 3
	category = EVENT_CATEGORY_HEALTH
	description = "All crewmembers temporarily gain a negative quirk."
	admin_setup = list(
		/datum/event_admin_setup/input_number/cognomerge/duration,
		/datum/event_admin_setup/listed_options/cognomerge/quirk_selection
	)

/datum/round_event/cognomerge
	announce_when = 1
	start_when = 21
	end_when = 51
	/*
	List of quirks this version of the event can add, only includes those that might produce interesting scenarios and will have time to do so
	Don't forget to update the duplicate list in the admin setup options down below if you modify this one
	*/
	var/list/cognomerge_quirk_pool = list(
		/datum/quirk/item_quirk/allergic/noitem,
		/datum/quirk/clumsy,
		/datum/quirk/frail,
		/datum/quirk/illiterate,
		/datum/quirk/numb,
		/datum/quirk/poor_aim,
		/datum/quirk/softspoken,
		/datum/quirk/cursed,
		/datum/quirk/item_quirk/deafness/noitem,
		/datum/quirk/item_quirk/blindness/noitem,
		/datum/quirk/hemiplegic,
		/datum/quirk/paraplegic/noitem
	)
	//minimum amount of time before the quirk is removed after being added (in seconds)
	var/natural_duration_min = 120
	//maximum amount of time before the quirk is removed after being added (in seconds)
	var/natural_duration_max = 300
	//if an admin sets a specific duration instead, it will be stored here
	var/forced_duration
	//if an admin selects a specific quirk for the event we store it here
	var/datum/quirk/forced_quirk
	//alert sound played during the announcement of this event
	var/audio_alert = 'sound/announcer/notice/notice2.ogg'

/datum/round_event/cognomerge/announce()
	priority_announce("Alert [station_name()]: Unitary conceptual metastasization in progress, temporary cognitive and physiological maluses may result.",
	sound = audio_alert,
	sender_override = "Metaphysical Entity Watchdog")

/datum/round_event/cognomerge/start()
	var/datum/quirk/chosen_quirk = pick(cognomerge_quirk_pool)
	if(forced_quirk)
		chosen_quirk = forced_quirk

	var/duration = rand(natural_duration_min, natural_duration_max) SECONDS
	if(forced_duration)
		duration = forced_duration SECONDS
	end_when = (start_when + ROUND_UP((duration * 0.05) + 5)) //end proc should be called ~10s after quirk removal

	var/list/victims = GLOB.human_list
	for(var/mob/living/carbon/human/victim in victims)
		if(!victim.client)
			continue //skip clientless
		var/turf/victim_turf = get_turf(victim)
		if(!is_station_level(victim_turf.z))
			continue //skip those not on the station level
		if(try_add_quirk(victim, chosen_quirk)) //only set a timer to remove the quirk if adding it succeeds (it will fail if they already possess the quirk)
			addtimer(CALLBACK(victim, TYPE_PROC_REF(/mob/living, remove_quirk), chosen_quirk), duration, TIMER_DELETE_ME)

/datum/round_event/cognomerge/proc/try_add_quirk(mob/living/carbon/human/victim, datum/quirk/chosen_quirk)
	//handle our noitem special cases
	switch(chosen_quirk)
		if(/datum/quirk/item_quirk/allergic/noitem)
			if(victim.has_quirk(/datum/quirk/item_quirk/allergic))
				return FALSE
		if(/datum/quirk/item_quirk/deafness/noitem)
			if(victim.has_quirk(/datum/quirk/item_quirk/deafness))
				return FALSE
		if(/datum/quirk/item_quirk/blindness/noitem)
			if(victim.has_quirk(/datum/quirk/item_quirk/blindness))
				return FALSE
		if(/datum/quirk/paraplegic/noitem)
			if(victim.has_quirk(/datum/quirk/paraplegic))
				return FALSE

	return victim.add_quirk(chosen_quirk)

/datum/round_event/cognomerge/end()
	priority_announce("Update [station_name()]: The assimilatory phase has reached its conclusion, no further health risk is anticipated at this time.",
	sound = audio_alert,
	sender_override = "Metaphysical Entity Watchdog")


//admin options

//duration
/datum/event_admin_setup/input_number/cognomerge/duration
	input_text = "For how many seconds should a quirk be applied?"
	default_value = 120
	max_value = 900
	min_value = 1

/datum/event_admin_setup/input_number/cognomerge/duration/prompt_admins()
	var/customize_duration = tgui_alert(usr, "Set event duration!", event_control.name, list("Random", "Custom"))
	switch(customize_duration)
		if("Custom")
			return ..()
		if("Random")
			chosen_value = null
		else
			return ADMIN_CANCEL_EVENT

/datum/event_admin_setup/input_number/cognomerge/duration/apply_to_event(datum/round_event/cognomerge/event)
	event.forced_duration = chosen_value

//quirk selection
/datum/event_admin_setup/listed_options/cognomerge/quirk_selection
	input_text = "Which quirk should be applied?"

/datum/event_admin_setup/listed_options/cognomerge/quirk_selection/get_list()
	return list(
		/datum/quirk/item_quirk/allergic/noitem,
		/datum/quirk/clumsy,
		/datum/quirk/frail,
		/datum/quirk/illiterate,
		/datum/quirk/numb,
		/datum/quirk/poor_aim,
		/datum/quirk/softspoken,
		/datum/quirk/cursed,
		/datum/quirk/item_quirk/deafness/noitem,
		/datum/quirk/item_quirk/blindness/noitem,
		/datum/quirk/hemiplegic,
		/datum/quirk/paraplegic/noitem
	)

/datum/event_admin_setup/listed_options/cognomerge/quirk_selection/prompt_admins()
	var/specific_quirk_desired = tgui_alert(usr, "Apply a specific quirk?", event_control.name, list("Yes", "No"))
	switch(specific_quirk_desired)
		if("Yes")
			return ..()
		if("No")
			chosen = null
		else
			return ADMIN_CANCEL_EVENT

/datum/event_admin_setup/listed_options/cognomerge/quirk_selection/apply_to_event(datum/round_event/cognomerge/event)
	event.forced_quirk = chosen
