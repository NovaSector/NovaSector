#define ANTAG_GROUP_SHIP_CREW "Random Ship Crew"

/datum/antagonist/ship_crew
	name = "\improper Ship Crew"
	job_rank = ROLE_TRAITOR
	roundend_category = "ship crew"
	antagpanel_category = ANTAG_GROUP_SHIP_CREW
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	suicide_cry = "I don't want to die!!"
	var/datum/team/ship_crew/team

/datum/antagonist/ship_crew/greet()
	. = ..()
	to_chat(owner, "<B>You are part of a ship crew. Follow your captain's orders and complete your mission.</B>")
	owner.announce_objectives()

/datum/antagonist/ship_crew/get_team()
	return team

/datum/antagonist/ship_crew/create_team(datum/team/ship_crew/new_team)
	if(!new_team)
		for(var/datum/antagonist/ship_crew/S in GLOB.antagonists)
			if(!S.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [S]")
				continue
			if(S.team)
				team = S.team
				return
		if(!new_team)
			team = new /datum/team/ship_crew
			team.forge_objectives()
			return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/ship_crew/on_gain()
	if(team)
		objectives |= team.objectives
	. = ..()

/datum/team/ship_crew
	name = "\improper Ship Crew"

/datum/team/ship_crew/proc/forge_objectives()
	var/datum/objective/mission/primary_mission = new()
	primary_mission.team = src
	primary_mission.update_explanation_text()
	objectives += primary_mission
	for(var/datum/mind/M in members)
		var/datum/antagonist/ship_crew/S = M.has_antag_datum(/datum/antagonist/ship_crew)
		if(S)
			S.objectives |= objectives

/datum/objective/mission
	explanation_text = "Complete your ship's mission."

/datum/objective/mission/update_explanation_text()
	explanation_text = "Complete your ship's mission."

/datum/team/ship_crew/roundend_report()
	var/list/parts = list()

	parts += span_header("Ship Crew were:")

	var/all_dead = TRUE
	for(var/datum/mind/M in members)
		if(considered_alive(M))
			all_dead = FALSE
	parts += printplayerlist(members)

	if(!all_dead)
		parts += "<span class='greentext big'>The ship crew completed their mission!</span>"
	else
		parts += "<span class='redtext big'>The ship crew has failed.</span>"

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
