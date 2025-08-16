/datum/dynamic_ruleset/midround/from_ghosts/contractor
	name = "Drifting Contractors"
	config_tag = "Drifting Contractors"
	pref_flag = ROLE_DRIFTING_CONTRACTOR
	preview_antag_datum = /datum/antagonist/contractor
	weight = 6
	min_pop = 25
	min_antag_cap = 2
	minimum_required_age = 14
	midround_type = HEAVY_MIDROUND

/datum/dynamic_ruleset/midround/from_ghosts/contractor/New(list/dynamic_config)
	. = ..()
	if(prob(33))
		max_antag_cap++

/datum/dynamic_ruleset/midround/from_ghosts/contractor/create_execute_args()
	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/carp in GLOB.landmarks_list)
		spawn_locs += carp.loc
	if(!length(spawn_locs))
		log_admin("Cannot accept Drifting Contractors ruleset. Couldn't find any carp spawn points.")
		message_admins("Cannot accept Drifting Contractors ruleset. Couldn't find any carp spawn points.")

	return list(spawn_locs)

/datum/dynamic_ruleset/midround/from_ghosts/contractor/assign_role(datum/mind/candidate, list/spawn_locs)
	var/mob/living/new_character = candidate.current
	new_character.forceMove(pick_n_take(spawn_locs))
	new_character.mind.set_assigned_role(SSjob.get_job_type(/datum/job/drifting_contractor))
	new_character.mind.active = TRUE
	candidate.add_antag_datum(/datum/antagonist/contractor)
