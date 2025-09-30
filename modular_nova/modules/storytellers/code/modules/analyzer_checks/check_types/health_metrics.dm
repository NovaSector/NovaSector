// Specialized check for crew metrics: count and average health
/datum/storytellor_check/crew_metrics
	name = "Crew Metrics Check"

/datum/storytellor_check/crew_metrics/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/crew_count = 0
	var/total_crew_health = 0

	for(var/mob/living/M in GLOB.alive_player_list)
		if(isobserver(M) || M.stat == DEAD)
			continue
		if(M.mind?.has_antag_datum()) // Skip antagonists
			continue

		crew_count++
		total_crew_health += M.health

	if(crew_count > 0)
		inputs.vault[STORY_CREW_COUNT] = crew_count
		inputs.vault[STORY_CREW_AVG_HEALTH] = total_crew_health / crew_count
	else
		inputs.vault[STORY_CREW_COUNT] = 0
		inputs.vault[STORY_CREW_AVG_HEALTH] = 0


	..()

// Specialized check for antagonist metrics: count and average health
/datum/storytellor_check/antag_metrics
	name = "Antagonist Metrics Check"

/datum/storytellor_check/antag_metrics/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/antag_count = 0
	var/total_antag_health = 0

	for(var/mob/living/M in GLOB.alive_player_list)
		if(isobserver(M) || M.stat == DEAD)
			continue
		if(!M.mind?.has_antag_datum()) // Only antagonists
			continue

		antag_count++
		total_antag_health += M.health

	if(antag_count > 0)
		inputs.vault[STORY_ANTAG_COUNT] = antag_count
		inputs.vault[STORY_ANTAG_AVG_HEALTH] = total_antag_health / antag_count
	else
		inputs.vault[STORY_ANTAG_COUNT] = 0
		inputs.vault[STORY_ANTAG_AVG_HEALTH] = 0

	..()
