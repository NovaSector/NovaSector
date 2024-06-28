/datum/job/pinata
	title = "Piñata"
	description = "The psychosis meds ran out. Your supplier never got back to you. This was long ago now. \
		You've been abandoned by all that once made you, and there is only one hope to leave."
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 1
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "PINATA"

	outfit = /datum/outfit/job/pinata
	plasmaman_outfit = /datum/outfit/plasmaman/pinata

	paycheck = PAYCHECK_ZERO

	liver_traits = list(TRAIT_ENGINEER_METABOLISM, TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_BASIC
	department_for_prefs = /datum/job_department/science
	departments_list = list(
		/datum/job_department/science,
	)

	family_heirlooms = list(/obj/item/lead_pipe)

	rpg_title = "Lunatic"
	job_flags = STATION_JOB_FLAGS | JOB_CANNOT_OPEN_SLOTS & ~JOB_REOPEN_ON_ROUNDSTART_LOSS

/datum/job/pinata/get_radio_information()
	return span_engradio("Choom you got this, it's time to cut loose no holding back. \
		It's just you and the road, no doubters to slow you down now. \
		So show 'em who you are. What you're made of. \
		You're special, remember?")

/datum/job/pinata/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_VIRUSIMMUNE, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_NO_EXTRACT, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_CHUNKYFINGERS, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_STABLEHEART, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_STABLELIVER, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_LIMBATTACHMENT, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_NOSOFTCRIT, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_NOHARDCRIT, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_ANALGESIA, JOB_TRAIT)
	ADD_TRAIT(spawned, TRAIT_NOBLOOD, JOB_TRAIT)

/datum/job/pinata/get_latejoin_spawn_point()
	var/list/spawn_markers_to_use = list()
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name != job_spawn_title)
			continue
		spawn_markers_to_use += spawn_point
	return pick(spawn_markers_to_use)

/datum/outfit/job/pinata
	name = "Piñata"
	jobtype = /datum/job/pinata

	id_trim = /datum/id_trim/job/science_guard/pinata

	uniform = /obj/item/clothing/under/syndicate/nova/interdyne/miner
	box = null
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/captagon = 1,
		/obj/item/motiondetector = 1,
	)
	belt = null
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/tackler/security
	head = /obj/item/clothing/head/helmet/lethal_pinata_helmet
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/deforest/psifinil
	r_pocket = /obj/item/flashlight/flare

	backpack = /obj/item/storage/backpack/industrial/frontier_colonist
	satchel = /obj/item/storage/backpack/industrial/frontier_colonist/satchel
	duffelbag = /obj/item/storage/backpack/industrial/frontier_colonist
	messenger = /obj/item/storage/backpack/industrial/frontier_colonist/messenger

/datum/outfit/job/pinata/post_equip(mob/living/carbon/human/squaddie, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/radio = squaddie.ears
	radio.set_frequency(FREQ_CENTCOM)
	radio.freqlock = RADIO_FREQENCY_LOCKED

	squaddie.mind?.adjust_experience(/datum/skill/athletics, 10000000)

	var/list/implants_to_add = list(
		/obj/item/organ/internal/ears/cybernetic/whisper,
		/obj/item/organ/internal/cyberimp/chest/nutriment/plus,
		/obj/item/organ/internal/cyberimp/chest/reviver,
		/obj/item/organ/internal/cyberimp/chest/scanner,
		/obj/item/organ/internal/cyberimp/brain/anti_drop,
		/obj/item/organ/internal/cyberimp/sensory_enhancer,
		/obj/item/organ/internal/cyberimp/mouth/breathing_tube,
		/obj/item/organ/internal/eyes/robotic/binoculars,
	)
	for(var/iterated_implant in implants_to_add)
		var/obj/item/organ/new_implant = new iterated_implant()
		new_implant.Insert(squaddie)

	squaddie.physiology.stamina_mod = 0.5

	return ..()

/datum/outfit/plasmaman/pinata
	name = "Piñata Plasmaman"

	uniform = /obj/item/clothing/under/plasmaman/syndicate
	gloves = /obj/item/clothing/gloves/color/plasmaman/black
	head = /obj/item/clothing/head/helmet/space/plasmaman/syndie
	r_hand= /obj/item/tank/internals/plasmaman/belt/full
	internals_slot = ITEM_SLOT_HANDS

/datum/id_trim/job/science_guard/pinata
	assignment = "Pinata"

/obj/effect/landmark/start/lethal_pinata
	delete_after_roundstart = FALSE
	name = "Piñata"

///Try to attach this bodypart to a mob, while replacing one if it exists, deletes the old limb if successful
/obj/item/bodypart/proc/replace_limb_evil(mob/living/carbon/limb_owner, special)
	if(!istype(limb_owner))
		return
	var/obj/item/bodypart/old_limb = limb_owner.get_bodypart(body_zone)
	if(old_limb)
		old_limb.drop_limb(TRUE)

	. = try_attach_limb(limb_owner, special)
	if(!.) //If it failed to replace, re-attach their old limb as if nothing happened.
		old_limb.try_attach_limb(limb_owner, TRUE)
	else
		qdel(old_limb)
