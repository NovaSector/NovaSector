/obj/effect/mob_spawn/ghost_role/human/virtual_domain/pirate
	mob_species = /datum/species/skeleton

/datum/outfit/virtual_pirate/post_equip(mob/living/carbon/human/user, visualsOnly)
	. = ..()
	user.faction |= FACTION_PIRATE
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = user.wear_id
	if(istype(id_card))
		id_card.registered_name = user.real_name
		id_card.update_label()
