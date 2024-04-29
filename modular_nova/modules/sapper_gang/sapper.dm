/datum/antagonist/sapper
	name = "\improper Sapper Gang"
	job_rank = ROLE_TRAITOR
	roundend_category = "sapper gang"
	antagpanel_category = "Sapper Gang"
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	var/datum/team/sapper/gang

/datum/antagonist/sapper/greet()
	. = ..()
	to_chat(owner, "<B>You're an illegal credits miner, build to defend your mining machines and your ship to harvest as many credits as you can!</B>")
	owner.announce_objectives()

/datum/antagonist/sapper/get_team()
	return gang

/datum/antagonist/sapper/create_team(datum/team/sapper/new_team)
	if(!new_team)
		for(var/datum/antagonist/sapper/sapper in GLOB.antagonists)
			if(!sapper.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [sapper]")
				continue
			if(sapper.gang)
				gang = sapper.gang
				return
		if(!new_team)
			gang = new /datum/team/sapper
			gang.forge_objectives()
			return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	gang = new_team

/datum/antagonist/sapper/on_gain()
	if(gang)
		objectives |= gang.objectives
	. = ..()

/datum/team/sapper
	name = "\improper Sapper gang"

/datum/team/sapper/proc/forge_objectives()
	var/datum/objective/sapper/sapper_objective = new()
	sapper_objective.team = src
	for(var/obj/machinery/computer/piratepad_control/sapper/cargo_hold as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/piratepad_control/sapper))
		var/area/area = get_area(cargo_hold)
		if(istype(area, /area/shuttle/pirate))
			sapper_objective.cargo_hold = cargo_hold
			break
	sapper_objective.update_explanation_text()
	objectives += sapper_objective
	for(var/datum/mind/mind in members)
		var/datum/antagonist/sapper/sapper = mind.has_antag_datum(/datum/antagonist/sapper)
		if(sapper)
			sapper.objectives |= objectives

/datum/objective/sapper
	var/obj/machinery/computer/piratepad_control/sapper/cargo_hold
	explanation_text = "Use your credit miner machines to convert energy into cash."

/datum/objective/sapper/update_explanation_text()
	if(cargo_hold)
		var/area/storage_area = get_area(cargo_hold)
		explanation_text = "Acquire as much credits as you can from the station's powernet and cash it out into the [storage_area.name] cargo hold."

/datum/objective/sapper/proc/get_loot_value()
	return cargo_hold ? cargo_hold.points : 0

/datum/team/sapper/roundend_report()
	var/list/parts = list()

	parts += "<span class='header'>Sapper Gang were:</span>"
	parts += printplayerlist(members)
	var/datum/objective/sapper/sapper_objective = locate() in objectives
	parts += "Total cash out: [sapper_objective.get_loot_value()] credits"
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/map_template/shuttle/pirate/sapper
	prefix = "_maps/shuttles/nova/"
	suffix = "sapper"
	name = "Sapper ship (Default)"
