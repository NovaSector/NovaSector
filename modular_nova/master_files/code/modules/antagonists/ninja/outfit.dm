/datum/outfit/ninja
	skillchips = list(/obj/item/skillchip/matrix_taunt)


/datum/outfit/ninja/post_equip(mob/living/carbon/human/ninja)
	. = ..()
	//remove big explosion charge
	var/obj/item/grenade/c4/ninja/charge = locate() in ninja
	qdel(charge)
