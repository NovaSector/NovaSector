/datum/round_event_control/contractor
	name = "Drifting Contractor"
	typepath = /datum/round_event/ghost_role/contractor
	weight = 8
	max_occurrences = 0
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "A pre-equipped contractor floats towards the station to fulfill contracts."

/datum/round_event/ghost_role/contractor
	minimum_required = 1
	role_name = "Drifting Contractor"
	fakeable = FALSE

/datum/round_event/ghost_role/contractor/spawn_role()
	var/list/candidates = SSpolling.poll_ghost_candidates(
		check_jobban = ROLE_DRIFTING_CONTRACTOR,
		role = ROLE_DRIFTING_CONTRACTOR,
		alert_pic = /obj/item/melee/baton/telescopic/contractor_baton,
		role_name_text = "drifting contractor",
	)
	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected = pick_n_take(candidates)

	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/carp in GLOB.landmarks_list)
		spawn_locs += carp.loc
	if(!length(spawn_locs))
		return MAP_ERROR

	var/mob/living/carbon/human/operative = new(pick(spawn_locs))
	operative.dna.update_dna_identity()
	var/datum/mind/mind = new /datum/mind(selected.key)
	selected.client?.prefs?.apply_prefs_to(operative)
	mind.set_assigned_role(SSjob.get_job_type(/datum/job/drifting_contractor))
	mind.special_role = ROLE_DRIFTING_CONTRACTOR
	mind.active = TRUE
	mind.transfer_to(operative)
	mind.add_antag_datum(/datum/antagonist/contractor)
	mind.handle_exploitables()

	message_admins("[ADMIN_LOOKUPFLW(operative)] has been made into [src] by an event.")
	log_game("[key_name(operative)] was spawned as a [src] by an event.")
	spawned_mobs += operative
	return SUCCESSFUL_SPAWN
