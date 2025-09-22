/datum/antagonist/ninja/addMemories()
	antag_memory += "I am an elite operative executing a co-ordinated strike for the benefit of Cybersun Industries."
	antag_memory += "Precision is my weapon. Shadows are my armor. Without them, I am nothing."

/datum/objective/assassinate/headhunter
	name = "head-hunter"

/datum/objective/assassinate/headhunter/check_completion()
	if(completed)
		return TRUE
	if(!considered_alive(target) || considered_afk(target)) //not complete but dead/cryod? complete anyway
		return TRUE
	return FALSE

/// handled by COMSIG_CARBON_GAIN_WOUND to check if wounds applied to the target are objective completing
/datum/objective/assassinate/headhunter/proc/check_wound(datum/source, datum/wound/wound, obj/item/bodypart/limb)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human = source
	if(!istype(human))
		return
	if(!istype(wound, /datum/wound/cranial_fissure) || !istype(limb, /obj/item/bodypart/head))
		return
	//clean the signal
	UnregisterSignal(human, COMSIG_CARBON_GAIN_WOUND)
	//replace the cranial fissure with beheading
	wound.remove_wound_from_victim()
	limb.dismember(BRUTE, FALSE, WOUND_SLASH)
	//mark complete
	completed = TRUE

/datum/objective/assassinate/headhunter/update_explanation_text()
	. = ..()
	if(target?.current)
		explanation_text = "Assassinate the [target.assigned_role.title], [target.name]; by dismembering [target.current.p_their()] head with your katana."
	else
		explanation_text = "Objective revoked."

/// find a valid command member to target
/datum/objective/assassinate/headhunter/find_target(dupe_search_range, list/blacklist)
	var/list/possible_targets = list()
	var/list/existing_targets = list()

	for(var/datum/objective/assassinate/headhunter/obj in owner.objectives)
		existing_targets |= obj.target

	var/opt_in_disabled = CONFIG_GET(flag/disable_antag_opt_in_preferences)
	for(var/mob/living/possible_target in get_active_player_list(TRUE, TRUE, TRUE))
		if(possible_target.mind in existing_targets)
			continue
		if(!is_valid_target(possible_target.mind))
			continue
		if(!opt_in_disabled && !opt_in_valid(possible_target.mind))
			continue
		possible_targets += possible_target.mind

	target = pick(possible_targets)
	RegisterSignal(target.current, COMSIG_CARBON_GAIN_WOUND, PROC_REF(check_wound))
	update_explanation_text()
	return target

/datum/objective/assassinate/headhunter/is_valid_target(datum/mind/possible_target)
	/// target non-central command members only
	var/target_in_command_dept = FALSE
	if(!possible_target)
		return FALSE
	for(var/department in possible_target.assigned_role.departments_list)
		if(department == /datum/job_department/central_command)
			return FALSE
		if(department == /datum/job_department/command)
			target_in_command_dept = TRUE
			break
	if(!target_in_command_dept)
		return FALSE
	return ..()

/// changes the cyborg hijack objective into an optional one to aid with the primary
/datum/objective/cyborg_hijack
	explanation_text = "(Optional) Use your gloves to convert a cyborg to aid you."

/// the goon drive is now only for lowpop shifts without command members to hunt
/datum/antagonist/ninja/addObjectives()
	var/list/commandies = list()
	for(var/mob/living/crew as anything in get_active_player_list(TRUE, TRUE, TRUE))
		if(/datum/job_department/central_command in crew.mind?.assigned_role.departments_list)
			continue
		if(/datum/job_department/command in crew.mind?.assigned_role.departments_list)
			commandies |= crew.mind

	if(length(commandies) >= 3)
		var/lethality = rand(1, 3)
		for(var/i in 1 to lethality)
			var/datum/objective/assassinate/headhunter/strike_fear = new /datum/objective/assassinate/headhunter()
			strike_fear.owner = owner
			strike_fear.find_target()
			objectives += strike_fear

		//Cyborg Hijack: Flag set to complete in the DrainAct in ninjaDrainAct.dm
		var/datum/objective/cyborg_hijack/hijack = new /datum/objective/cyborg_hijack()
		objectives += hijack
	else
		//Break into science and mess up their research. Only add this objective if there is not enough command
		var/datum/objective/research_secrets/sabotage_research = new /datum/objective/research_secrets()
		objectives += sabotage_research

	//Survival until end
	var/datum/objective/survival = new /datum/objective/survive()
	survival.owner = owner
	objectives += survival

/// support for optional objective (cyborg hijack)
/datum/antagonist/ninja/roundend_report()
	var/list/report = list()
	if(!owner)
		CRASH("Antagonist datum without owner")
	report += printplayer(owner)

	var/objectives_complete = TRUE
	if(length(objectives))
		report += printobjectives(objectives)
		for(var/datum/objective/objective in objectives)
			if(istype(objective, /datum/objective/cyborg_hijack))
				continue
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	if(!length(objectives) || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful at spreading fear among NT!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed the Cybersun!</span>"
	return report.Join("<br>")

/datum/antagonist/ninja/greet()
	SEND_SOUND(owner.current, sound('sound/music/antag/ninja_greeting.ogg'))
	to_chat(owner.current, span_danger("I am an elite operative executing a co-ordinated strike for the benefit of Cybersun Industries."))
	to_chat(owner.current, span_warning("Precision is my weapon. Shadows are my armor. Without them, I am nothing."))
	to_chat(owner.current, span_notice("The station is located to your [dir2text(get_dir(owner.current, locate(world.maxx/2, world.maxy/2, owner.current.z)))]. A thrown ninja star will be a great way to get there."))
	owner.announce_objectives()

/// removes ninja glove security records console interaction
/obj/machinery/computer/records/security/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	balloon_alert(ninja, "nothing happens!")

