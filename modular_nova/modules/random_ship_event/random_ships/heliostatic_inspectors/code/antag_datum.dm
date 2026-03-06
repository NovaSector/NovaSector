/datum/antagonist/cop
	name = "\improper HC Police Officer"
	roundend_category = "hc cops"
	antagpanel_category = "HC Police"
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	///Team datum for admin tracking
	var/datum/team/cop/crew

/datum/antagonist/cop/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/cop/get_team()
	return crew

/datum/antagonist/cop/create_team(datum/team/cop/new_team)
	if(!new_team)
		for(var/datum/antagonist/cop/cop in GLOB.antagonists)
			if(!cop.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [cop]")
				continue

			if(cop.crew)
				crew = cop.crew
				return

		// No existing team was found, time to create one.
		crew = new /datum/team/cop
		crew.forge_objectives()
		return

	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization: [new_team.type].")

	crew = new_team

/datum/antagonist/cop/on_gain()
	if(crew)
		objectives |= crew.objectives

	return ..()

/datum/antagonist/cop/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)

/datum/antagonist/cop/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	owner_mob.remove_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)
	return ..()

/datum/team/cop
	name = "\improper HC police patrol"

/datum/team/cop/proc/forge_objectives()
	add_objective(new /datum/objective/policing)
	add_objective(new /datum/objective/inspect_area)
	add_objective(new /datum/objective/survey)
	add_objective(new /datum/objective/steal_n_of_type/contraband)
	add_objective(new /datum/objective/dock)
	add_objective(new /datum/objective/survive)

	for(var/datum/mind/member_mind in members)
		var/datum/antagonist/cop/cop = member_mind.has_antag_datum(/datum/antagonist/cop)

		if(!cop)
			continue

		cop.objectives |= objectives

/datum/objective/policing
	name = "safety inspection"
	explanation_text = "Conduct a voluntary safety inspection of the station. Delegate responsibilities among the inspection team. Maintain professional and courteous demeanor at all times."
	martyr_compatible = TRUE

/datum/objective/inspect_area
	name = "inspect area"
	explanation_text = "Inspect certain department for safety compliance. Provide constructive feedback and recommendations."
	///Area picked for an entirely roleplay objective.
	var/inspection_area
	martyr_compatible = TRUE

/datum/objective/inspect_area/New(text)
	. = ..()
	inspection_area = pick(INSPECTION_LIST)

/datum/objective/inspect_area/update_explanation_text()
	..()
	if(inspection_area)
		explanation_text = "Inspect [inspection_area] department for safety compliance. Provide constructive feedback and recommendations for improvement."
	else
		explanation_text = "Perform a general station safety inspection and provide recommendations for improvement."

/datum/objective/survey
	name = "safety survey"
	martyr_compatible = TRUE
	admin_grantable = TRUE
	///Area picked for an entirely roleplay objective.
	var/survey_area

/datum/objective/survey/New(text)
	. = ..()
	survey_area = pick(INSPECTION_LIST)

/datum/objective/survey/update_explanation_text()
	..()
	if(survey_area)
		explanation_text = "Conduct a safety survey over [survey_area] department. Gather feedback from staff and identify potential safety concerns."
	else
		explanation_text = "Conduct a general station safety survey. Gather feedback from staff and identify potential safety concerns."

/datum/objective/steal_n_of_type/contraband
	name = "secure hazardous materials"
	explanation_text = "Secure potentially hazardous materials for safekeeping or disposal."

/datum/objective/steal_n_of_type/contraband/New()
	. = ..()
	amount = rand(CONFISCATE_LOWER, CONFISCATE_HIGHER)
	explanation_text = "Secure at least [amount] potentially hazardous items for safekeeping or disposal."
	update_explanation_text()
	return

/datum/objective/steal_n_of_type/contraband/check_completion()
	return completed //I am letting them roleplay this out, just like the other objectives.

/datum/objective/dock
	name = "remain docked"
	explanation_text = "Dock to the station to conduct the inspection. Remain in the sector until the inspection is complete."
	martyr_compatible = TRUE

/datum/objective/dock/New()
	. = ..()
	explanation_text = "Dock to the [station_name()] to conduct the voluntary safety inspection. Remain in the sector until the inspection is complete."
	update_explanation_text()
	return
