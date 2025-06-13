//antag job
/datum/job/lone_infiltrator
	title = ROLE_LONE_INFILTRATOR

//antag
/datum/antagonist/traitor/lone_infiltrator
	name = "Lone Infiltrator"
	job_rank = ROLE_LONE_INFILTRATOR
	roundend_category = "Infiltrators"
	preview_outfit = /datum/outfit/lone_infiltrator_preview
	give_uplink = FALSE
	///The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint

/datum/antagonist/traitor/lone_infiltrator/on_gain()
	equip_guy()
	move_to_spawnpoint()
	return ..()

/datum/antagonist/traitor/lone_infiltrator/proc/equip_guy()
	var/mob/living/carbon/human/lone_infil = owner.current
	lone_infil.equipOutfit(/datum/outfit/lone_infiltrator)
	return

/datum/antagonist/traitor/lone_infiltrator/proc/set_spawnpoint(infil_number)
	spawnpoint = GLOB.lone_infil_start[infil_number]

/datum/antagonist/traitor/lone_infiltrator/proc/move_to_spawnpoint()
	owner.current.forceMove(spawnpoint)
