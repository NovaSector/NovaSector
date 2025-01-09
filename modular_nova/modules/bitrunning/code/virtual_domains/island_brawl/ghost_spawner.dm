/obj/effect/mob_spawn/ghost_role/human/virtual_domain/islander
	random_appearance = FALSE

/datum/outfit/beachbum_combat/post_equip(mob/living/carbon/human/bum, visualsOnly)
	. = ..()
	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = bum.wear_id
	if(istype(id_card))
		id_card.registered_name = bum.real_name
		id_card.update_label()
