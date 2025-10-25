#define SOLFED_AMT "amount"
#define SOLFED_VOTES "votes"
#define SOLFED_DECLARED "declared"
#define SOLFED_FINE_AMOUNT -20000

#define EMERGENCY_RESPONSE_POLICE "WOOP WOOP THAT'S THE SOUND OF THE POLICE"
#define EMERGENCY_RESPONSE_ATMOS "DISCO INFERNO"
#define EMERGENCY_RESPONSE_EMT "AAAAAUGH, I'M DYING, I NEEEEEEEEEED A MEDIC BAG"
#define EMERGENCY_RESPONSE_EMAG "AYO THE PIZZA HERE"
#define MESSAGE_SOLFED "Sol Federation"

GLOBAL_VAR(caller_of_911)
GLOBAL_VAR(call_911_msg)
GLOBAL_VAR(pizza_order)
GLOBAL_VAR(fedmessage)

GLOBAL_VAR_INIT(solfed_tech_charge, -15000)
GLOBAL_LIST_INIT(pizza_names, list(
	"Dixon Buttes",
	"I. C. Weiner",
	"Seymour Butz",
	"I. P. Freely",
	"Pat Myaz",
	"Vye Agra",
	"Harry Balsack",
	"Lee Nover",
	"Maya Buttreeks",
	"Amanda Hugginkiss",
	"Bwight K. Brute", // Github Copilot suggested dwight from the office like 10 times
	"John Nanotrasen",
	"Mike Rotch",
	"Hugh Jass",
	"Oliver Closeoff",
	"Hugh G. Recktion",
	"Phil McCrevis",
	"Willie Lickerbush",
	"Ben Dover",
	"Steve", // REST IN PEACE MAN
	"Avery Goodlay",
	"Anne Fetamine",
	"Amanda Peon",
	"Tara Newhole",
	"Penny Tration",
	"Joe Mama"
))
GLOBAL_LIST_INIT(emergency_responders, list())
GLOBAL_LIST_INIT(solfed_responder_info, list(
	"911_responders" = list(
		SOLFED_AMT = 0,
		SOLFED_VOTES = 0,
		SOLFED_DECLARED = FALSE
	),
	"standard_espatiers" = list(
		SOLFED_AMT = 0,
		SOLFED_VOTES = 0,
		SOLFED_DECLARED = FALSE
	),
	"grand_espatiers" = list(
		SOLFED_AMT = 0,
		SOLFED_VOTES = 0,
		SOLFED_DECLARED = FALSE
	),
	"dogginos" = list(
		SOLFED_AMT = 0,
		SOLFED_VOTES = 0,
		SOLFED_DECLARED = FALSE
	),
	"dogginos_manager" = list(
		SOLFED_AMT = 0,
		SOLFED_VOTES = 0,
		SOLFED_DECLARED = FALSE
	)
))
GLOBAL_LIST_INIT(call911_do_and_do_not, list(
	EMERGENCY_RESPONSE_EMT = "You SHOULD call EMTs for:\n\
		Large or excessive amounts of dead bodies, emergency medical situations that the station can't handle, etc.\n\
		You SHOULD NOT call EMTs for:\n\
		The Captain stubbing their toe, one or two dead bodies, minor viral outbreaks, etc.\n\
		Are you sure you want to call EMTs?",
	EMERGENCY_RESPONSE_POLICE = "You SHOULD call Marshals for:\n\
		Security ignoring Command, Security violating civil rights, Security engaging in Mutiny, \
		General Violation of Sol Federation Citizen Rights by Command/Security, etc.\n\
		You SHOULD NOT call Marshals for:\n\
		Corporate affairs, manhunts, settling arguments, etc.\n\
		Are you sure you want to call Marshals?",
	EMERGENCY_RESPONSE_ATMOS = "You SHOULD call Advanced Atmospherics for:\n\
		Stationwide atmospherics loss, wide-scale supermatter delamination related repairs, unending fires filling the hallways, or department-sized breaches with Engineering and Atmospherics unable to handle it, etc. \n\
		You SHOULD NOT call Advanced Atmospherics for:\n\
		A trashcan on fire in the library, a single breached room, heating issues, etc. - especially with capable Engineers/Atmos Techs.\n\
		There is a response fee of [abs(GLOB.solfed_tech_charge)] credits per emergency responder.\n\
		Are you sure you want to call Advanced Atmospherics?"
))

/*
	LANDMARKS
*/
/obj/effect/landmark/start/solfed
	name = "Solfed General"
	icon_state = "solfed_standard"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/solfed_leader
	name = "Solfed Leadership"
	icon_state = "solfed_leader"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/solfed_military
	name = "Solfed Military"
	icon_state = "solfed_military"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/solfed_military_leader
	name = "Solfed Military Leadership"
	icon_state = "solfed_military_leader"
	icon = 'modular_nova/master_files/icons/mob/landmarks.dmi'
/// Internal. Polls ghosts and sends in a team of space cops according to the alert level, accompanied by an announcement.
/obj/machinery/computer/communications/proc/call_911(ordered_team)
	/// How big do you want the response team to be?
	var/team_size
	/// Which ERT antag do we deploy?
	var/datum/antagonist/ert/cops_to_send
	/// What is the announcecment message?
	var/announcement_message = "sussus amogus"
	/// Who is sending this announcement?
	var/announcer = "Sol Federation Marshal Department"
	/// Ghost volunteer option text.
	var/poll_question = "fuck you leatherman"
	/// Gang phone number system (might remove, cause SOLFED already has secure comms)
	var/cell_phone_number = "911"
	/// What is the check for 911 respponders
	var/list_to_use = "911_responders"
	switch(ordered_team)
		if(EMERGENCY_RESPONSE_POLICE)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/request_911/police
			announcement_message = "Crewmembers of [station_name()]. this is the Sol Federation. We've received a request for immediate marshal support, and we are \
				sending our best marshals to support your station.\n\n\
				If the first responders request that they need SWAT support to do their job, or to report a faulty 911 call, we will send them in at additional cost to your station to the \
				tune of $20,000.\n\n\
				The transcript of the call is as follows:\n\
				[GLOB.call_911_msg]"
			announcer = "Sol Federation Marshal Department"
			poll_question = "The station has called for the Marshals. Will you respond?"
		if(EMERGENCY_RESPONSE_ATMOS)
			team_size = tgui_input_number(usr, "How many techs would you like dispatched?", "How badly did you screw up?", 3, 3, 1)
			cops_to_send = /datum/antagonist/ert/request_911/atmos
			announcement_message = "Crewmembers of [station_name()]. this is the Sol Federation's 811 dispatch. We've received a report of stationwide structural damage, atmospherics loss, fire, or otherwise, and we are \
				sending an Advanced Atmospherics team to support your station.\n\n\
				The transcript of the call is as follows:\n\
				[GLOB.call_911_msg]"
			announcer = "Sol Federation 811 Dispatch - Advanced Atmospherics"
			poll_question = "The station has called for an advanced engineering support team. Will you respond?"
			cell_phone_number = "911"	//This needs to stay so they can communicate with SWAT
		if(EMERGENCY_RESPONSE_EMT)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/request_911/emt
			announcement_message = "Crewmembers of [station_name()]. this is the Sol Federation. We've received a request for immediate medical support, and we are \
				sending our best emergency medical technicians to support your station.\n\n\
				If the first responders request that they need SWAT support to do their job, or to report a faulty 911 call, we will send them in at additional cost to your station to the \
				tune of $20,000.\n\n\
				The transcript of the call is as follows:\n\
				[GLOB.call_911_msg]"
			announcer = "Sol Federation EMTs"
			poll_question = "The station has called for medical support. Will you respond?"
		if(EMERGENCY_RESPONSE_EMAG)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/pizza/false_call
			announcement_message = "Thank you for ordering from Dogginos, [GLOB.pizza_order]! We're sending you that extra-large party package pizza delivery \
				right away!\n\n\
				Thank you for choosing our premium Fifteen Minutes or Less delivery option! Our pizza will be at your doorstep at [station_name()] as soon as possible thanks \
				to our lightning-fast warp drives installed on all Dogginos delivery shuttles!\n\
				Distance from your chosen Dogginos: 70,000 Lightyears"
			announcer = "Dogginos"
			poll_question = "The station has ordered $35,000 in pizza. Will you deliver?"
			cell_phone_number = "Dogginos"
			list_to_use = "dogginos"
	priority_announce(announcement_message, announcer, 'sound/effects/families_police.ogg', has_important_message=TRUE, color_override = "yellow")
	var/list/candidates = SSpolling.poll_ghost_candidates(
		poll_question,
		check_jobban = ROLE_DEATHSQUAD,
		alert_pic = /obj/item/solfed_reporter,
		role_name_text = cops_to_send::name,
	)

	if(length(candidates))
		//Pick the (un)lucky players
		var/agents_number = min(team_size, candidates.len)

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		GLOB.solfed_responder_info[list_to_use][SOLFED_AMT] = agents_number
		while(agents_number && candidates.len)
			var/spawn_loc = spawnpoints[index + 1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/cop = new(spawn_loc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
			cop.PossessByPlayer(chosen_candidate.key)

			//Give antag datum
			var/datum/antagonist/ert/request_911/ert_antag = new cops_to_send

			cop.mind.add_antag_datum(ert_antag)
			cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
			SSjob.send_to_late_join(cop)
			cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

			if(cops_to_send == /datum/antagonist/ert/request_911/atmos) // charge for atmos techs
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(GLOB.solfed_tech_charge)
			else
				var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
				phone.gang_id = cell_phone_number
				phone.name = "[cell_phone_number] branded cell phone"
				phone.w_class = WEIGHT_CLASS_SMALL	//They get that COMPACT phone hell yea
				var/phone_equipped = phone.equip_to_best_slot(cop)
				if(!phone_equipped)
					to_chat(cop, "Your [phone.name] has been placed at your feet.")
					phone.forceMove(get_turf(cop))

			//Logging and cleanup
			log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
			if(cops_to_send == /datum/antagonist/ert/request_911/atmos)
				log_game("[abs(GLOB.solfed_tech_charge)] has been charged from the station budget for [key_name(cop)]")
			agents_number--
	GLOB.cops_arrived = TRUE
	return TRUE

/obj/machinery/computer/communications/proc/pre_911_check(mob/user)
	if (!authenticated_as_silicon_or_captain(user))
		return FALSE

	if (GLOB.cops_arrived)
		to_chat(user, span_warning("911 has already been called this shift!"))
		playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
		return FALSE

	if (!issilicon(user))
		var/obj/item/held_item = user.get_active_held_item()
		var/obj/item/card/id/id_card = held_item?.GetID()
		if (!istype(id_card))
			to_chat(user, span_warning("You need to swipe your ID!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
		if (!(ACCESS_CAPTAIN in id_card.access))
			to_chat(user, span_warning("You are not authorized to do this!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
	else
		to_chat(user, "The console refuses to let you dial 911 as an AI or Cyborg!")
		return FALSE
	return TRUE

/// Message button interaction if the players want to use this button, It only allows organics and not AI or Cyborgs. As this is a big 'im screwed' button
/obj/machinery/computer/communications/proc/message_federation(mob/user)
	if (!authenticated_as_silicon_or_captain(user))
		return FALSE

	if (!issilicon(user))
		var/obj/item/held_item = user.get_active_held_item()
		var/obj/item/card/id/id_card = held_item?.GetID()
		if (!istype(id_card))
			to_chat(user, span_warning("You need to swipe your ID!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
		if (!(ACCESS_CAPTAIN in id_card.access))
			to_chat(user, span_warning("You are not authorized to do this!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
	else
		to_chat(user, "The console refuses to let you to message the Federation as an AI or Cyborg!")
		return FALSE
	return TRUE

/// Does the final checks if a player is messaging solfed, providing final considerations and what consequences may come.
/obj/machinery/computer/communications/proc/finalizing_solfedmessage(mob/user)
	/// Notifies admins in case player is considering messaging solfed.
	message_admins("[ADMIN_LOOKUPFLW(user)] is considering contacting the Sol Federation Regional Command.")
	/// First Question
	var/call_solfed_check1 = "Are you sure you want to message the Sol Federation? Un-necessary communications may result in a \
		large fine or 25 years in federal prison."
	/// Boolean for Solfed message
	if(tgui_input_list(user, call_solfed_check1, "Call 911", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the faulty SolFed call consequences.")
	/// Variable for reason in calling the feeds
	var/reason_to_call_da_feds = stripped_input(user, "What do you wish to call the Federation for?", "Call the Federation", null, MAX_MESSAGE_LEN)
	if(!reason_to_call_da_feds)
		to_chat(user, "You decide not to call the Federation.")
		return

	GLOB.fedmessage = reason_to_call_da_feds

	reason_to_call_da_feds = span_adminnotice("<b><font color=yellow>SOLFED:</font>[ADMIN_FULLMONTY(user)] [ADMIN_CENTCOM_REPLY(user)]:</b> [reason_to_call_da_feds]")
	for(var/client/staff as anything in GLOB.admins)
		if(staff?.prefs.read_preference(/datum/preference/toggle/comms_notification))
			SEND_SOUND(staff, sound('sound/misc/server-ready.ogg'))
	to_chat(GLOB.admins, reason_to_call_da_feds, type = MESSAGE_TYPE_PRAYER, confidential = TRUE)

	log_game("[key_name(user)] has called the Sol Federation for the following reason:\n[GLOB.fedmessage]")
	deadchat_broadcast(" has called the Sol Federation for the following reason:\n[GLOB.fedmessage]", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)

	to_chat(user, span_notice("Authorization confirmed. SolFed Intervention request sent, standby for official instructions."))
	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

/obj/machinery/computer/communications/proc/calling_911(mob/user, called_group_pretty = "EMTs", called_group = EMERGENCY_RESPONSE_EMT)
	message_admins("[ADMIN_LOOKUPFLW(user)] is considering calling the Sol Federation [called_group_pretty].")
	var/call_911_msg_are_you_sure = "Are you sure you want to call 911? Faulty 911 calls results in a $20,000 fine and a 5 year superjail \
		sentence."
	if(tgui_input_list(user, call_911_msg_are_you_sure, "Call 911", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the faulty 911 call consequences.")
	if(tgui_input_list(user, GLOB.call911_do_and_do_not[called_group], "Call [called_group_pretty]", list("Yes", "No")) != "Yes")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has read and acknowleged the recommendations for what to call and not call [called_group_pretty] for.")
	var/reason_to_call_911 = stripped_input(user, "What do you wish to call 911 [called_group_pretty] for?", "Call 911", null, MAX_MESSAGE_LEN)
	if(!reason_to_call_911)
		to_chat(user, "You decide not to call 911.")
		return
	GLOB.cops_arrived = TRUE
	GLOB.call_911_msg = reason_to_call_911
	GLOB.caller_of_911 = user.name
	log_game("[key_name(user)] has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]")
	message_admins("[ADMIN_LOOKUPFLW(user)] has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]")
	deadchat_broadcast(" has called the Sol Federation [called_group_pretty] for the following reason:\n[GLOB.call_911_msg]", span_name("[user.real_name]"), user, message_type = DEADCHAT_ANNOUNCEMENT)

	call_911(called_group)
	to_chat(user, span_notice("Authorization confirmed. 911 call dispatched to the Sol Federation [called_group_pretty]."))
	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

/datum/antagonist/ert/request_911
	name = "911 Responder"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE SOL FEDERATION!!"
	var/department = "Some stupid shit"

/datum/antagonist/ert/request_911/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted(null, H)
		H.wanted_lvl = giving_wanted_lvl
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl


/datum/antagonist/ert/request_911/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

/datum/antagonist/ert/request_911/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate SolFed [department] assistance!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow first responders!\n"
	missiondesc += "<BR><B>911 Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_911_msg]"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact [GLOB.caller_of_911] and assist them in resolving the matter."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the rights of Sol Federation citizens on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If you believe yourself to be in danger, unable to do the job assigned to you due to a dangerous situation, \
		or that the 911 call was made in error, you can use the S.W.A.T. Backup Caller in your backpack to vote on calling a S.W.A.T. team to assist in the situation."
	missiondesc += "<BR> <B>4.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911
	name = "911 Response: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/solfed_reporter/espatier_caller = 1)

	id_trim = /datum/id_trim/space_police

/datum/outfit/request_911/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID_to_give = human_to_equip.wear_id
	if(istype(ID_to_give))
		shuffle_inplace(ID_to_give.access) // Shuffle access list to make NTNet passkeys less predictable
		ID_to_give.registered_name = human_to_equip.real_name
		if(human_to_equip.age)
			ID_to_give.registered_age = human_to_equip.age
		ID_to_give.update_label()
		ID_to_give.update_icon()
		human_to_equip.update_ID_card()

/*
*	POLICE
*/

/datum/antagonist/ert/request_911/police
	name = "Marshal"
	role = "Marshal"
	department = "Marshal"
	outfit = /datum/outfit/request_911/police

/datum/outfit/request_911/police
	name = "911 Response: Marshal"
	back = /obj/item/storage/backpack/satchel
	uniform = /obj/item/clothing/under/solfed
	suit = /obj/item/clothing/suit/armor/vest/sol
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/soft/black
	suit_store = /obj/item/gun/energy/disabler
	belt = /obj/item/melee/baton/security/loaded
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/sol = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol = 4,
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/solfed_reporter/espatier_caller = 1,
		/obj/item/beamout_tool = 1,
	)

	id_trim = /datum/id_trim/solfed

/*
*	ADVANCED ATMOSPHERICS
*/

/datum/antagonist/ert/request_911/atmos
	name = "Adv. Atmos Tech"
	role = "Adv. Atmospherics Technician"
	department = "Advanced Atmospherics"
	outfit = /datum/outfit/request_911/atmos

/datum/outfit/request_911/atmos
	name = "811 Response: Advanced Atmospherics"
	back = /obj/item/mod/control/pre_equipped/advanced/atmos
	uniform = /obj/item/clothing/under/solfed/emergencyfire
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_solfed/atmos
	mask = /obj/item/clothing/mask/gas/atmos/glass
	belt = /obj/item/storage/belt/utility/full/powertools/ircd
	suit_store = /obj/item/tank/internals/oxygen/yellow
	id = /obj/item/card/id/advanced/solfed
	backpack_contents = list(/obj/item/storage/box/rcd_ammo = 1,
		/obj/item/storage/box/smart_metal_foam = 1,
		/obj/item/multitool = 1,
		/obj/item/extinguisher/advanced = 1,
		/obj/item/rwd/loaded = 1,
		/obj/item/beamout_tool = 1,
		/obj/item/solfed_reporter/espatier_caller = 1,
	)
	id_trim = /datum/id_trim/solfed/atmos

/*
*	EMT
*/

/datum/antagonist/ert/request_911/emt
	name = "Emergency Medical Technician"
	role = "EMT"
	department = "EMT"
	outfit = /datum/outfit/request_911/emt

/datum/outfit/request_911/emt
	name = "911 Response: EMT"
	back = /obj/item/storage/backpack/medic
	uniform = /obj/item/clothing/under/solfed/emergencymed
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_solfed/med
	mask = /obj/item/clothing/mask/gas/alt
	glasses = /obj/item/clothing/glasses/hud/health
	head = /obj/item/clothing/head/helmet/toggleable/sf_hardened/emt
	id = /obj/item/card/id/advanced/solfed
	suit = /obj/item/clothing/suit/armor/sf_hardened/emt
	gloves = /obj/item/clothing/gloves/latex/nitrile
	belt = /obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/storage/medkit/civil_defense
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/emergency_bed = 1,
		/obj/item/storage/box/medipens = 1,
		/obj/item/solfed_reporter/espatier_caller = 1,
		/obj/item/beamout_tool = 1,
	)

	id_trim = /datum/id_trim/solfed/med

/datum/antagonist/ert/request_911/military_squadron
	name = "SolFed Espatier Squadron"
	role = "Solfed Espatier"
	department = "SolFed Military"
	outfit = /datum/outfit/request_911/military_squadron

/datum/antagonist/ert/request_911/military_squadron/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to backup the 911 first responders, as they have reported for your assistance..\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the first responders using the Cell Phone in your backpack to figure out the situation."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes the work of the first responders."
	missiondesc += "<BR> <B>3.</B> Use lethal force in the arrest of the suspects if they will not comply, or the station refuses to comply."
	missiondesc += "<BR> <B>4.</B> If you believe the station is engaging in treason and is firing upon first responders and S.W.A.T. members, use the \
		Treason Reporter in your backpack to call the military."
	missiondesc += "<BR> <B>5.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/military_squadron
	name = "911 Response: Solfed Espatier Squadron"
	back = /obj/item/storage/backpack
	uniform = /obj/item/clothing/under/solfed
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_solfed/sec
	head = /obj/item/clothing/head/helmet/sf_peacekeeper
	belt = /obj/item/gun/energy/disabler
	suit = /obj/item/clothing/suit/armor/sf_peacekeeper
	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	l_hand = /obj/item/gun/ballistic/shotgun/riot/sol
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/lethalshot = 2,
		/obj/item/solfed_reporter/espatier_platoon_caller = 1,
		/obj/item/beamout_tool = 1,
	)

	id_trim = /datum/id_trim/solfed

/datum/antagonist/ert/request_911/military_platoon
	name = "Sol Federation Military"
	role = "Private"
	department = "SolFed Military"
	outfit = /datum/outfit/request_911/military_platoon

/datum/antagonist/ert/request_911/military_platoon/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the SWAT Team and the First Responders via your cell phone to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Arrest all suspects involved in the treason attempt."
	missiondesc += "<BR> <B>3.</B> Assume control of the station for the Sol Federation, and initiate evacuation procedures to get non-offending citizens \
		away from the scene."
	missiondesc += "<BR> <B>4.</B> If you need to use lethal force, do so, but only if you must."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/military_platoon
	name = "911 Response: SolFed Military"

	uniform = /obj/item/clothing/under/solfed/marines
	head = /obj/item/clothing/head/helmet/solfed
	mask = /obj/item/clothing/mask/gas/alt
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/sol/marine
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/military
	neck = /obj/item/clothing/neck/mantle/solfed

	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/solfed
	ears = /obj/item/radio/headset/headset_solfed/sec
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
	)

	id_trim = /datum/id_trim/solfed

/obj/item/solfed_reporter
	name = "SolFed reporter"
	desc = "Use this in-hand to vote to call SolFed backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	/// Was the reporter turned on?
	var/activated = FALSE
	/// What antagonist should be required to use the reporter?
	var/type_to_check = /datum/antagonist/ert/request_911
	/// What table should we be incrementing votes in and checking against in the solfed responders global?
	var/type_of_callers = "911_responders"
	/// What source should be supplied for the announcement message?
	var/announcement_source = "Sol Federation"
	/// Should the station be issued a fine when the vote completes?
	var/fine_station = TRUE
	/// What poll message should we show to the ghosts when they are asked to join the squad?
	var/ghost_poll_msg = "example crap"
	/// How many ghosts should we pick from the applicants to become members of the squad?
	var/amount_to_summon = 4
	/// What antagonist type should we give to the ghosts?
	var/type_to_summon = /datum/antagonist/ert/request_911/military_squadron
	/// What table should be be incrementing amount in in the solfed responders global?
	var/summoned_type = "swat"
	/// What name and ID should be on the cell phone given to the squad members?
	var/cell_phone_number = "911"
	/// What jobban should we be checking for the ghost polling?
	var/jobban_to_check = ROLE_DEATHSQUAD
	/// What announcement message should be displayed if the vote succeeds?
	var/announcement_message = "Example announcement message"

/obj/item/solfed_reporter/proc/pre_checks(mob/user)
	if(GLOB.solfed_responder_info[type_of_callers][SOLFED_AMT] == 0)
		to_chat(user, span_warning("There are no responders. You likely spawned this in as an admin. Please don't do this."))
		return FALSE
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("You don't know how to use this!"))
		return FALSE
	return TRUE

/obj/item/solfed_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/solfed_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.solfed_responder_info[type_of_callers][SOLFED_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.solfed_responder_info[type_of_callers][SOLFED_VOTES]++
		var/current_votes = GLOB.solfed_responder_info[type_of_callers][SOLFED_VOTES]
		var/amount_of_responders = GLOB.solfed_responder_info[type_of_callers][SOLFED_AMT]
		to_chat(user, span_warning("You have activated the device. \
		Current Votes: [current_votes]/[amount_of_responders] votes."))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.solfed_responder_info[type_of_callers][SOLFED_DECLARED] = TRUE
			if(fine_station)
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(SOLFED_FINE_AMOUNT) // paying for the gas to drive all the fuckin' way out to the frontier

			priority_announce(announcement_message, announcement_source, 'sound/effects/families_police.ogg', has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(
				ghost_poll_msg,
				jobban_to_check,
				alert_pic = /obj/item/solfed_reporter,
				role_name_text = summoned_type,
			)

			if(candidates.len)
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.solfed_responder_info[summoned_type][SOLFED_AMT] = agents_number

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(agents_number && candidates.len)
					var/spawn_loc = spawnpoints[index + 1]
					//loop through spawnpoints one at a time
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					//Spawn the body
					var/mob/living/carbon/human/cop = new(spawn_loc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.PossessByPlayer(chosen_candidate.key)

					//Give antag datum
					var/datum/antagonist/ert/request_911/ert_antag = new type_to_summon

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
					SSjob.send_to_late_join(cop)
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = cell_phone_number
					phone.name = "[cell_phone_number] branded cell phone"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "Your [phone.name] has been placed at your feet.")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--

/obj/item/solfed_reporter/espatier_caller
	name = "Solfed Military backup caller"
	desc = "Use this in-hand to vote to call SolFed military backup. If half your team votes for it, a military squadron will be dispatched."
	type_to_check = /datum/antagonist/ert/request_911
	type_of_callers = "911_responders"
	announcement_source = "Sol Federation Military Command"
	fine_station = FALSE
	ghost_poll_msg = "The Sol-Fed 911 services have requested military backup. Do you wish to become an Espatier?"
	amount_to_summon = 6
	type_to_summon = /datum/antagonist/ert/request_911/military_squadron
	summoned_type = "standard_espatiers"
	announcement_message = "Hello Crewmembers, Our on-station emergency services teams have requested for Military Aid, Either for their active safety \
	or the current situation has caused reasonable escallation, please remain calm and cooperate with any requests or orders made by our Espatier Squadron. For your safety and others."

/obj/item/solfed_reporter/espatier_caller/questions(mob/user)
	var/question = "Does the situation require additional military backup, involve the station impeding you from doing your job, \
		or involve the station making a fraudulent 911 call and needing an arrest made on the caller?"
	if(tgui_input_list(user, question, "Military backup Caller", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request for military backup")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon military backup.")
	return TRUE

/obj/item/solfed_reporter/espatier_platoon_caller
	name = "Solfed Platoon Radio Caller"
	desc = "Use this in hand to report that the active situation is noticably worse or out of control."
	type_to_check = /datum/antagonist/ert/request_911/military_squadron
	type_of_callers = "standard_espatiers"
	announcement_source = "Sol Federation Military Command"
	fine_station = FALSE
	ghost_poll_msg = "The situation is completely out of hand and our Espatiers need backup, volunteer to become a Grand Response Espatier?"
	amount_to_summon = 12
	type_to_summon = /datum/antagonist/ert/request_911/military_platoon
	summoned_type = "grand_espatiers"
	announcement_message = "Attention station and its crew the active situation has devolved, and is too much to bear for our currently deployed squadron of espatiers. \
	A Sol Federation Espatier Platoon is being disbatched to your station, Cooperate with any and all instructions given by any SolFed Personnel, A full station-wide evacuation \
	may be enacted for your safety. Again please cooperate with any and all instructions from SolFed Personnel."

/obj/item/solfed_reporter/espatier_platoon_caller/questions(mob/user)
	var/list/list_of_questions = list(
		"Grand threats are threats in which mass casualties, treason against the federation, xenomorphs, and other threats that would be \
			a danger to the greater galactic community, such as resonance cascade, runaway blob, etc.",
		"Did the station crew members attack you and your fellow Espatiers?",
		"Did the station crew members actively prevent you from completing your mission, or objectives?",
		"Were you and your fellow Espatiers unable to contain or handle the situation on your own?",
		"Are you surer you wish to declare a grand threat of any kind is present? Misuse of this can and will result in \
			administrative action against your account."
	)
	for(var/question in list_of_questions)
		if(tgui_input_list(user, question, "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to call the platoon... yet...")
			return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the consequences of a false claim of a grand threat administratively, \
		and has voted that the station is engaging a Grand Threat.")
	return TRUE

/obj/item/solfed_reporter/pizza_managers
	name = "Dogginos uncompliant customer reporter"
	desc = "Use this in-hand to vote to call for Dogginos Regional Managers if the station refuses to pay for their pizza. \
		If half your delivery squad votes for it, Dogginos Regional Managers will be dispatched."
	type_to_check = /datum/antagonist/ert/pizza/false_call
	type_of_callers = "dogginos"
	announcement_message = "Hey there, custo-mores! Our delivery drivers have reported that you guys are having some issues with payment for your order that \
		you placed at the Dogginos that's the seventh furthest Dogginos in the galaxy from your station, and we want to ensure maximum customer satisfaction and \
		employee satisfaction as well.\n\
		We've gone ahead and sent some some of our finest regional managers to handle the situation.\n\
		We hope you enjoy your pizzas, and that we'll be able to receive the bill of $35,000 plus the fifteen percent tip for our drivers shortly!"
	announcement_source = "Dogginos"
	fine_station = FALSE
	ghost_poll_msg = "Dogginos is sending regional managers to get the station to pay up the pizza money they owe. Are you ready to do some Customer Relations?"
	amount_to_summon = 8
	type_to_summon = /datum/antagonist/ert/pizza/leader/false_call
	summoned_type = "dogginos_manager"
	cell_phone_number = "Dogginos"

/obj/item/solfed_reporter/pizza_managers/questions(mob/user)
	if(tgui_input_list(user, "Is the station refusing to pay their bill of $35,000, including a fifteen percent tip for delivery drivers?", "Dogginos Uncompliant Customer Reporter", list("Yes", "No")) != "Yes")
		to_chat(user, "You decide not to request management assist you with the delivery.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon Dogginos management to resolve the lack of payment.")
	return TRUE

/datum/antagonist/ert/pizza/false_call
	outfit = /datum/outfit/centcom/ert/pizza/false_call

/datum/outfit/centcom/ert/pizza/false_call
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/knife,
		/obj/item/storage/box/ingredients/italian,
		/obj/item/solfed_reporter/pizza_managers,
	)
	r_hand = /obj/item/pizzabox/meat
	l_hand = /obj/item/pizzabox/vegetable

/datum/antagonist/ert/pizza/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for Dogginos as a delivery person.</font></B>"
	missiondesc += "<BR>You are here to deliver some pizzas from Dogginos!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow Dogginos employees!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Deliver the pizzas ordered by [GLOB.pizza_order]."
	missiondesc += "<BR> <B>2.</B> Collect the bill, which totals to $35,000 plus a fifteen percent tip for delivery drivers."
	missiondesc += "<BR> <B>3.</B> If they refuse to pay, you may summon the Dogginos Regional Managers to help resolve the issue."
	to_chat(owner, missiondesc)

/datum/antagonist/ert/pizza/leader/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for Dogginos as a Regional Manager.</font></B>"
	missiondesc += "<BR>You are here to resolve a dispute with some customers who refuse to pay their bill!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow Dogginos employees!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Collect the money owed by [GLOB.pizza_order], which amounts to $35,000 plus a fifteen percent tip for the delivery drivers."
	missiondesc += "<BR> <B>2.</B> Use any means necessary to collect the owed funds. The thousand degree knife in your backpack will help in this task."
	to_chat(owner, missiondesc)

/obj/item/beamout_tool
	name = "beam-out tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beam-out  process to return to Sol Federation space. It will bring anyone you are pulling with you."
	icon = 'modular_nova/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Sol Federation.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")

#undef EMERGENCY_RESPONSE_POLICE
#undef EMERGENCY_RESPONSE_ATMOS
#undef EMERGENCY_RESPONSE_EMT
#undef EMERGENCY_RESPONSE_EMAG
#undef MESSAGE_SOLFED
