/datum/job/gakster
	title = "Gakster"
	description = "Loot, shoot, scoot, run home and then wake up to do it all over again."
	faction = FACTION_STATION
	total_positions = -1
	spawn_positions = -1
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "GAKSTER"

	outfit = /datum/outfit/job/gakster
	plasmaman_outfit = /datum/outfit/plasmaman/gakster

	paycheck = PAYCHECK_ZERO

	liver_traits = list(TRAIT_ENGINEER_METABOLISM, TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	bounty_types = CIV_JOB_BASIC
	department_for_prefs = /datum/job_department/assistant
	departments_list = list(
		/datum/job_department/assistant,
	)

	family_heirlooms = list(/obj/item/lead_pipe)

	rpg_title = "Dungeon Crawler"
	job_flags = STATION_JOB_FLAGS

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_NODISMEMBER, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_VIRUSIMMUNE, JOB_TRAIT)

/datum/outfit/job/gakster
	name = "Gakster"
	jobtype = /datum/job/gakster

	id_trim = /datum/id_trim/job/assistant/gakster

	uniform = /obj/item/clothing/under/frontier_colonist
	box = null
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/captagon = 1,
	)
	belt = null
	ears = null
	gloves = /obj/item/clothing/gloves/frontier_colonist
	head = null
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	l_pocket = /obj/item/crowbar/red
	r_pocket = /obj/item/flashlight/flare

	backpack = /obj/item/storage/backpack/industrial/frontier_colonist
	satchel = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	duffelbag = /obj/item/storage/backpack/industrial/frontier_colonist
	messenger = /obj/item/storage/backpack/industrial/frontier_colonist/messenger

/datum/outfit/plasmaman/gakster
	name = "Gakster Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/bitrunner
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	head = /obj/item/clothing/head/helmet/space/plasmaman/bitrunner
	r_hand= /obj/item/tank/internals/plasmaman/belt/full
	internals_slot = ITEM_SLOT_HANDS

/datum/id_trim/job/assistant/gakster
	assignment = "Gakster"
