//antag job
/datum/job/infiltrator
	title = ROLE_INFILTRATOR

//antag
/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	roundend_category = "Infiltrators"
	preview_outfit = /datum/outfit/infiltrator_preview
	give_uplink = FALSE
	///The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint

/datum/antagonist/traitor/infiltrator/on_gain()
	equip_guy()
	move_to_spawnpoint()
	return ..()

/datum/antagonist/traitor/infiltrator/proc/equip_guy()
	var/mob/living/carbon/human/infiltrator = owner.current
	infiltrator.equipOutfit(/datum/outfit/infiltrator)
	return

/datum/antagonist/traitor/infiltrator/proc/set_spawnpoint(infil_number)
	spawnpoint = GLOB.infiltrator_start[infil_number]

/datum/antagonist/traitor/infiltrator/proc/move_to_spawnpoint()
	owner.current.forceMove(spawnpoint)
