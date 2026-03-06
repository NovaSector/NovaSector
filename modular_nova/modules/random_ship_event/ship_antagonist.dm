/datum/antagonist/ship_crew
	name = "\improper Ship Crew"
	roundend_category = "ship crew"
	antagpanel_category = "Random Ship Crew"
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	suicide_cry = "I don't want to die!!"
	///Ship crew datum to keep track of all the players.
	var/datum/team/ship_crew/team

/datum/antagonist/ship_crew/greet()
	. = ..()
	to_chat(owner, "<B>You are part of a ship crew. Follow your captain's orders and complete your mission.</B>")
	owner.announce_objectives()

/datum/antagonist/ship_crew/get_team()
	return team

/datum/antagonist/ship_crew/create_team(datum/team/ship_crew/new_team)
	if(!new_team)
		for(var/datum/antagonist/ship_crew/ship_crew_antag in GLOB.antagonists)
			if(!ship_crew_antag.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [ship_crew_antag]")
				continue
			if(ship_crew_antag.team)
				team = ship_crew_antag.team
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
	return ..()

/datum/team/ship_crew
	name = "\improper Ship Crew"

/// Creates and assigns the primary mission objective to all ship crew members.
/datum/team/ship_crew/proc/forge_objectives()
	var/datum/objective/mission/primary_mission = new()
	primary_mission.team = src
	primary_mission.update_explanation_text()
	objectives += primary_mission
	for(var/datum/mind/crew_member_mind in members)
		var/datum/antagonist/ship_crew/crew_antag = crew_member_mind.has_antag_datum(/datum/antagonist/ship_crew)
		if(crew_antag)
			crew_antag.objectives |= objectives

/datum/objective/mission
	explanation_text = "Complete your ship's mission."

/datum/objective/mission/update_explanation_text()
	explanation_text = "Complete your ship's mission."

/datum/team/ship_crew/roundend_report()
	var/list/report_parts = list()

	report_parts += span_header("Ship Crew were:")

	var/all_dead = TRUE
	for(var/datum/mind/crew_member_mind in members)
		if(considered_alive(crew_member_mind))
			all_dead = FALSE
	report_parts += printplayerlist(members)

	if(!all_dead)
		report_parts += "<span class='greentext big'>The ship crew completed their mission!</span>"
	else
		report_parts += "<span class='redtext big'>The ship crew has failed.</span>"

	return "<div class='panel redborder'>[report_parts.Join("<br>")]</div>"
