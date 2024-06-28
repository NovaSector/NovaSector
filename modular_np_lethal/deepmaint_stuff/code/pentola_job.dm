/datum/job/pentola
	title = "Pentola Worker"
	description = "Doctors, fixers, bartenders, mechanics - all manner of people keep Sector 9's pentola running. Sell goods and services at reasonable prices. Send gaksters on quests to die. "
	faction = FACTION_STATION
	total_positions = -1
	spawn_positions = -1
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "PENTOLA"

	outfit = /datum/outfit/job/pentola
	plasmaman_outfit = /datum/outfit/plasmaman/pentola

	paycheck = PAYCHECK_ZERO

	liver_traits = list(TRAIT_ENGINEER_METABOLISM, TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	bounty_types = CIV_JOB_BASIC
	department_for_prefs = /datum/job_department/assistant
	departments_list = list(
		/datum/job_department/assistant,
	)

	family_heirlooms = list(/obj/item/lead_pipe)

	rpg_title = "Travelling Merchant"
	job_flags = STATION_JOB_FLAGS

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_VIRUSIMMUNE, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_INFIL_BUFF, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_LIMBATTACHMENT, JOB_TRAIT)

/datum/outfit/job/pentola
	name = "Pentola Worker"
	jobtype = /datum/job/pentola

	id_trim = /datum/id_trim/job/assistant/gakster

	uniform = /obj/item/clothing/under/frontier_colonist
	box = null
	backpack_contents = list(
		/obj/item/gakster_phone = 1,
		/obj/item/choice_beacon/pentola
	)
	belt = null
	ears = null
	gloves = /obj/item/clothing/gloves/frontier_colonist
	head = null
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	l_pocket = /obj/item/crowbar/red
	r_pocket = /obj/item/flashlight/seclite

	backpack = /obj/item/storage/backpack/industrial/frontier_colonist
	satchel = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	duffelbag = /obj/item/storage/backpack/industrial/frontier_colonist
	messenger = /obj/item/storage/backpack/industrial/frontier_colonist/messenger

/datum/outfit/job/gakster/post_equip(mob/living/carbon/human/user, visualsOnly = FALSE)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(make_secure_container), user), 5 SECONDS)


/datum/outfit/plasmaman/pentola
	name = "Gakster Pentola Worker"

	uniform = /obj/item/clothing/under/plasmaman/bitrunner
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	head = /obj/item/clothing/head/helmet/space/plasmaman/bitrunner
	r_hand= /obj/item/tank/internals/plasmaman/belt/full
	internals_slot = ITEM_SLOT_HANDS

/datum/id_trim/job/assistant/pentola
	assignment = "Pentola Worker"
