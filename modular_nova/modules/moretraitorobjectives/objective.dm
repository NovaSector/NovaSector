#define PAYDAY_EASY 15000
#define PAYDAY_MEDIUM 27500
#define PAYDAY_HARD 45000
#define PAYDAY_DIFFICULTIES list(PAYDAY_EASY, PAYDAY_MEDIUM, PAYDAY_HARD)

/datum/objective/heist
	name = "heist a payday"
	explanation_text = "Score yourself a payday."
	admin_grantable = TRUE

/datum/objective/heist/New(text)
	. = ..()
	target_amount = pick(PAYDAY_DIFFICULTIES)
	update_explanation_text()

/datum/objective/heist/update_explanation_text()
	. = ..()
	explanation_text = "Liberate [target_amount] Cr or more from the station's bank accounts or bank consoles, stored within a holochip or on an ID's bank account."

/datum/objective/heist/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/mind in owners)
		if(!isliving(mind.current))
			continue

		var/list/all_items = mind.current.get_all_contents()
		for(var/obj/item in all_items)
			if(HAS_TRAIT(item, TRAIT_ITEM_OBJECTIVE_BLOCKED))
				continue

			if(istype(item, /obj/item/holochip))
				var/obj/item/holochip/loot
				if(loot.credits >= target_amount)
					return TRUE

			if(istype(item, /obj/item/card/id))
				var/obj/item/card/id/card
				if(card.registered_account)
					var/datum/bank_account/piggy_bank
					if(piggy_bank.account_balance >= target_amount)
						return TRUE
	return FALSE

#undef PAYDAY_EASY
#undef PAYDAY_MEDIUM
#undef PAYDAY_HARD
#undef PAYDAY_DIFFICULTIES


/datum/objective/alexandria
	name = "destroy the station archives"
	explanation_text = "Destroy Nanotrasen's archives."
	admin_grantable = TRUE
	var/list/cabinet_list = list()
	var/purged_medical_archives = FALSE
	var/purged_security_archives = FALSE

/datum/objective/alexandria/New(text)
	. = ..()
	cabinet_list = build_cabinet_list()
	for(var/obj/cabinet as anything in cabinet_list)
		RegisterSignal(cabinet, COMSIG_QDELETING, PROC_REF(remove_cabinet_from_list))
	update_explanation_text()

/datum/objective/alexandria/proc/build_cabinet_list()
	//employment cabinets
	for(var/obj/cabinet as anything in GLOB.employmentCabinets)
		cabinet_list += cabinet
	//medical cabinets
	for(var/area/station/medical/medbay/area in GLOB.areas)
		for(var/area_turf in area.get_turfs_from_all_zlevels())
			var/obj/structure/filingcabinet/medical/cabinet = locate() in area_turf
			if(cabinet)
				cabinet_list += cabinet
	//security cabinets
	for(var/area/station/security/area in GLOB.areas)
		for(var/area_turf in area.get_turfs_from_all_zlevels())
			var/obj/structure/filingcabinet/security/cabinet = locate() in area_turf
			if(cabinet)
				cabinet_list += cabinet
	return cabinet_list

/datum/objective/alexandria/proc/remove_cabinet_from_list(datum/cabinet, force)
	SIGNAL_HANDLER
	UnregisterSignal(cabinet, COMSIG_QDELETING)
	LAZYREMOVE(cabinet_list, cabinet)
	return NONE

/datum/objective/alexandria/update_explanation_text()
	. = ..()
	var/cabinet_list_string
	for(var/obj/cabinet as anything in cabinet_list)
		cabinet_list_string += "• [get_area(cabinet)]\n"
	if(cabinet_list_string)
		explanation_text = "Purge the security and medical records console ONCE. \n\
			Destroy the medical, security and employment archive cabinets in the following locations: \n\
			[cabinet_list_string]"

/datum/objective/alexandria/check_completion()
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/mind in owners)
		if(!isliving(mind.current))
			continue
	if(!length(cabinet_list) && purged_medical_archives && purged_security_archives)
		return TRUE
	return FALSE

// records console proc to check for objective completion
/obj/machinery/computer/records/proc/handle_traitor_objective(mob/living/carbon/human/user)
	if(!user)
		return
	var/datum/mind/user_mind = user.mind ? user.mind : user.last_mind
	if(!user_mind)
		return
	var/datum/antagonist/traitor/antag_datum = user_mind.has_antag_datum(/datum/antagonist/traitor)
	if(!antag_datum)
		return
	var/datum/objective/alexandria/objective = locate() in antag_datum.objectives
	if(objective)
		if(istype(src, /obj/machinery/computer/records/medical))
			objective.purged_medical_archives = TRUE
		else if(istype(src, /obj/machinery/computer/records/security))
			objective.purged_security_archives = TRUE
