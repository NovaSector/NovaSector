//map
/datum/lazy_template/infiltrator_memory
	key = LAZY_TEMPLATE_KEY_INFIL_MEMORY
	map_dir = "_maps/nova/lazy_templates"
	map_name = "infiltrator_memory"

//map spawn landmark
/obj/effect/landmark/start/lone_infil/Initialize(mapload)
	..()
	GLOB.lone_infil_start += loc
	return INITIALIZE_HINT_QDEL

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

//outfits
/datum/outfit/lone_infiltrator
	name = "Syndicate Operative - Infiltrator"

	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative

/datum/outfit/lone_infiltrator/post_equip(mob/living/carbon/human/equipped)
	equipped.faction |= ROLE_SYNDICATE
	SSquirks.AssignQuirks(equipped, equipped.client, TRUE, TRUE, null, FALSE, equipped)

/datum/outfit/lone_infiltrator_preview
	name = "Lone Infiltrator (Preview only)"
