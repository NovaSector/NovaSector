/datum/random_ship_event/nri_police
	name = "NRI Safety Inspection Team"

	ship_template_id = "nri_police"
	ship_name_pool = "hc_police_names"

	message_title = "NRI Voluntary Inspection Request"
	message_content = "Greetings %STATION, this is the %SHIPNAME dispatch outpost. 	The Novaya Rossiyskaya Imperiya is conducting routine safety inspections in this sector, with a focus on %FOCUS. 	We would like to offer your station a voluntary inspection to ensure compliance with Imperial safety standards. 	Participation is completely optional, and stations that volunteer receive %BENEFIT. 	Please let us know if you would like to schedule an inspection. Novaya Rossiyskaya Imperiya collegial secretary out."
	arrival_announcement = "Inspection vessel approaching. Vessel ID tag is %NUMBER1-%NUMBER2-%NUMBER3. 	Vessel Model: Potato Beetle, Flight ETA: three minutes minimal. Vessel is authorized to perform voluntary inspection duties. 	We're clear for close orbit. Please note that all inspection procedures are non-invasive and require station representative accompaniment. 	We appreciate your cooperation in maintaining sector safety standards."
	possible_answers = list("Accept the voluntary inspection.", "Decline the inspection at this time.")

	response_accepted = "Thank you for your cooperation. As a token of appreciation for participating in our voluntary inspection program, a bonus of 10000 credits has been deposited to your station's account. We look forward to a productive inspection. Novaya Rossiyskaya Imperiya collegial secretary out."
	response_rejected = "Understood. We respect your decision. Should you change your mind, please feel free to contact us at a later time."

	announcement_color = "purple"

/datum/random_ship_event/nri_police/generate_message()
	///Station name one is the most important pick and is pretty much the station's main identifier, thus it better be mostly always right.
	var/station_designation = pick_weight(list(
		"Nanotrasen Research Station" = 70,
		"Nanotrasen Refueling Outpost" = 5,
		"Interdyne Pharmaceuticals Chemical Factory" = 5,
		"Free Teshari League Engineering Station" = 5,
		"Agurkrral Military Base" = 5,
		"Sol Federation Embassy" = 5,
		"Novaya Rossiyskaya Imperiya Civilian Port" = 5,
	))
	///Benefits of accepting the inspection
	var/benefit_pick = pick(
		"priority status for emergency response",
		"expedited processing for import permits",
		"complimentary safety equipment upgrades",
		"positive marks in your annual safety review",
	)
	///Inspection focus areas
	var/focus_pick = pick(
		"workplace safety protocols",
		"emergency response procedures",
		"hazardous material storage",
		"life support system maintenance",
	)
	var/built_message_content = replacetext(message_content, "%SHIPNAME", ship_name)
	built_message_content = replacetext(built_message_content, "%BENEFIT", benefit_pick)
	built_message_content = replacetext(built_message_content, "%FOCUS", focus_pick)
	built_message_content = replacetext(built_message_content, "%STATION", station_designation)
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER1", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER2", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER3", pick(GLOB.phonetic_alphabet))
	var/datum/comm_message/message = new /datum/comm_message(message_title, built_message_content, possible_answers)
	message.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(random_ship_event_answered), message, src)
	return message

/datum/random_ship_event/nri_police/on_accept()
	// Give the station a cash bonus for accepting the voluntary inspection
	var/datum/bank_account/bonused_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(bonused_account)
		bonused_account.adjust_money(10000)
		// Successfully added the bonus
	return
