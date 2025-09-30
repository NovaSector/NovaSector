/datum/random_ship_event/hc_police
	name = "HC Safety Inspection Team"

	ship_template_id = "hc_police"
	ship_name_pool = "hc_police_prefix"

	message_title = "HC Voluntary Inspection Request"
	message_content = "Greetings %STATION, this is the %SHIPNAME patrol vessel. \
		The Heliostatic Coalition is conducting routine safety inspections in this sector, with a focus on %FOCUS. \
		We would like to offer your station a voluntary inspection to ensure compliance with Coalition safety standards. \
		Participation is completely optional, and stations that volunteer receive a complimentary funding package.	\
		Please let us know if you would like to schedule an inspection. Heliostatic Coalition departmental secretary out."
	arrival_announcement = "Inspection vessel approaching. Vessel ID tag is %NUMBER1-%NUMBER2-%NUMBER3. \
		Vessel Model: Strider, Flight ETA: three minutes minimal. Vessel is authorized to perform inspection duties. We're clear for close orbit."

	possible_answers = list("Accept the inspection.", "Decline the inspection at this time.")
	response_accepted = "Thank you for your cooperation. As a token of appreciation for participating in our voluntary inspection program, a bonus of 10000 credits has been deposited to your station's account. Heliostatic Coalition departmental secretary out."
	response_rejected = "Understood. We respect your decision. Should you change your mind, please feel free to contact us at a later time."

	announcement_color = "purple"

/datum/random_ship_event/hc_police/New()
	. = ..()
	var/list/prefixes = strings("random_ships_nova.json", "hc_police_prefix")
	var/list/suffixes = strings("random_ships_nova.json", "hc_police_suffix")
	if(prefixes && suffixes && prefixes.len && suffixes.len)
		var/prefix = pick(prefixes)
		var/suffix = pick(suffixes)
		ship_name = "[prefix] [suffix]"

/datum/random_ship_event/hc_police/generate_message()
	///Inspection focus areas
	var/focus_pick = pick(
		"workplace safety protocols",
		"emergency response procedures",
		"hazardous material storage",
		"life support system maintenance",
	)
	var/built_message_content = replacetext(message_content, "%SHIPNAME", ship_name)
	built_message_content = replacetext(built_message_content, "%FOCUS", focus_pick)
	built_message_content = replacetext(built_message_content, "%STATION", station_name())
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER1", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER2", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER3", pick(GLOB.phonetic_alphabet))
	var/datum/comm_message/message = new /datum/comm_message(message_title, built_message_content, possible_answers)
	message.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(random_ship_event_answered), message, src)
	return message

/datum/random_ship_event/hc_police/on_accept()
	// Give the station a cash bonus for accepting the voluntary inspection
	var/datum/bank_account/bonused_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(bonused_account)
		bonused_account.adjust_money(10000)
		// Successfully added the bonus
	return
