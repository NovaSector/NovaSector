/datum/outfit/job/curator
	skillchips = list(/obj/item/skillchip/xenoarch_magnifier)

/datum/outfit/job/curator/pre_equip(mob/living/carbon/human/H, visuals_only = FALSE)
	if(visuals_only)
		return ..()
	backpack_contents[/obj/item/book/kindred] = 1
	return ..()
