/obj/effect/mob_spawn/ghost_role/human/virtual_domain/islander
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/pirate
	mob_species = /datum/species/skeleton

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/proc/apply_syndiename(mob/living/carbon/human/spawned_human)
	var/bitrunning_alias = spawned_human.client?.prefs?.read_preference(/datum/preference/name/hacker_alias) || pick(GLOB.hacker_aliases)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[bitrunning_alias]")

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/special(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_syndiename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_syndiename(spawned_human)

/datum/outfit/virtual_pirate/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	user.faction |= FACTION_PIRATE
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/outfit/virtual_syndicate
	ears = /obj/item/radio/headset/cybersun

/datum/outfit/virtual_syndicate/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()

/datum/outfit/beachbum_combat/post_equip(mob/living/carbon/human/bum, visualsOnly)
	. = ..()
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = bum.wear_id
	if(istype(id_card))
		id_card.registered_name = bum.real_name
		id_card.update_label()
