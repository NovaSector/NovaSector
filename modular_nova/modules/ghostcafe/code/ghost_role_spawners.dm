/obj/effect/mob_spawn/ghost_role/robot
	name = "Ghost Role Robot"
	prompt_name = "a robot"
	you_are_text = "You are a robot. This probably shouldn't be happening."
	flavour_text = "You are a robot. This probably shouldn't be happening."
	mob_type = /mob/living/silicon/robot

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe
	name = "Cafe Robotic Storage"
	prompt_name = "a ghost cafe robot"
	infinite_use = TRUE
	deletes_on_zero_uses_left = FALSE
	icon = 'modular_nova/modules/ghostcafe/icons/robot_storage.dmi'
	icon_state = "robostorage"
	anchored = TRUE
	density = FALSE
	spawner_job_path = /datum/job/ghostcafe
	you_are_text = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	mob_type = /mob/living/silicon/robot/model/roleplay
	loadout_enabled = TRUE
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe/special(mob/living/silicon/robot/spawned_robot, mob/mob_possessor, apply_prefs)
	. = ..()
	if(spawned_robot.client)
		spawned_robot.custom_name = null
		spawned_robot.updatename(spawned_robot.client)
		spawned_robot.transfer_silicon_prefs(spawned_robot.client)
		spawned_robot.gender = NEUTER
		var/area/A = get_area(src)
		//spawned_robot.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE) SKYRAT PORT -- Needs to be completely rewritten
		spawned_robot.AddElement(/datum/element/dusts_on_catatonia)
		spawned_robot.AddElement(/datum/element/dusts_on_leaving_area, list(A.type) + GLOB.ghost_cafe_areas)
		spawned_robot.RegisterSignal(spawned_robot, COMSIG_MOVABLE_USING_RADIO, TYPE_PROC_REF(/mob/living, on_using_radio))
		ADD_TRAIT(spawned_robot, TRAIT_SIXTHSENSE, TRAIT_GHOSTROLE)
		ADD_TRAIT(spawned_robot, TRAIT_FREE_GHOST, TRAIT_GHOSTROLE)
		to_chat(spawned_robot,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/D = new(spawned_robot)
		D.Grant(spawned_robot)

/obj/effect/mob_spawn/ghost_role/human/ghostcafe
	name = "Cafe Sleeper"
	prompt_name = "a ghost cafe human"
	infinite_use = TRUE
	deletes_on_zero_uses_left = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	density = FALSE
	spawner_job_path = /datum/job/ghostcafe
	outfit = /datum/outfit/ghostcafe
	you_are_text = "You are a Cafe Visitor!"
	flavour_text = "You are off-duty and have decided to visit your favourite cafe. Enjoy yourself."
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	loadout_enabled = TRUE
	quirks_enabled = TRUE

/obj/effect/mob_spawn/ghost_role/human/ghostcafe/special(mob/living/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	if(spawned_human.client)
		var/area/A = get_area(src)
		spawned_human.AddElement(/datum/element/dusts_on_catatonia)
		spawned_human.AddElement(/datum/element/dusts_on_leaving_area, list(A.type) + GLOB.ghost_cafe_areas)
		spawned_human.RegisterSignal(spawned_human, COMSIG_MOVABLE_USING_RADIO, TYPE_PROC_REF(/mob/living, on_using_radio))
		ADD_TRAIT(spawned_human, TRAIT_SIXTHSENSE, TRAIT_GHOSTROLE)
		ADD_TRAIT(spawned_human, TRAIT_FREE_GHOST, TRAIT_GHOSTROLE)
		ADD_TRAIT(spawned_human, TRAIT_NOBREATH, TRAIT_GHOSTROLE)
		to_chat(spawned_human,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/dchat_toggle_ability = new(spawned_human)
		dchat_toggle_ability.Grant(spawned_human)

/mob/living/proc/on_using_radio(atom/movable/talking_movable)
	SIGNAL_HANDLER

	var/area/target_area = get_area(talking_movable)
	if(target_area.type in GLOB.ghost_cafe_areas)
		return COMPONENT_CANNOT_USE_RADIO

/datum/outfit/ghostcafe
	name = "Cafe Visitor"
	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/advanced/chameleon/ghost_cafe
	back = /obj/item/storage/backpack/chameleon
	backpack_contents = list(/obj/item/storage/box/syndie_kit/chameleon/ghostcafe = 1)

/datum/outfit/ghostcafe/pre_equip(mob/living/carbon/human/visitor, visuals_only = FALSE)
	..()
	if (isplasmaman(visitor))
		backpack_contents += list(/obj/item/tank/internals/plasmaman/belt/full = 2)
	if(isvox(visitor) || isvoxprimalis(visitor))
		backpack_contents += list(/obj/item/tank/internals/nitrogen/belt/full = 2)

/datum/action/toggle_dead_chat_mob
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"
	name = "Toggle deadchat"
	desc = "Turn off or on your ability to hear ghosts."

/datum/action/toggle_dead_chat_mob/Trigger(trigger_flags)
	if(!..())
		return 0
	var/mob/M = target
	if(HAS_TRAIT_FROM(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE))
		REMOVE_TRAIT(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE)
		to_chat(M,span_notice("You're no longer hearing deadchat."))
	else
		ADD_TRAIT(M,TRAIT_SIXTHSENSE,TRAIT_GHOSTROLE)
		to_chat(M,span_notice("You're once again hearing deadchat."))

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe
	name = "cafe costuming kit"
	desc = "Look just the way you did in life - or better!"
	icon_state = "ghostcostuming"
	storage_type = /datum/storage/chameleon_cafe

/datum/storage/chameleon_cafe
	max_specific_storage = WEIGHT_CLASS_HUGE // This is ghost cafe only, balance is not given a shit about.
	max_slots = 14 // Holds all the starting stuff, plus a bit of change.
	max_total_storage = 50 // To actually acommodate the stuff being added.

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe/PopulateContents() // Doesn't contain a PDA, for isolation reasons.
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)
	new /obj/item/hhmirror/syndie(src)

/obj/item/card/id/advanced/chameleon/ghost_cafe
	name = "\improper Cafe ID"
	desc = "An ID straight from God."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_age = null
	trim = /datum/id_trim/admin
	wildcard_slots = WILDCARD_LIMIT_ADMIN

