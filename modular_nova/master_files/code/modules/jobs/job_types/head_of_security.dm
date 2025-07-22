/datum/outfit/job/hos
	messenger = /obj/item/storage/backpack/messenger/sec

/datum/outfit/job/hos/pre_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	backpack_contents += list(
		/obj/item/melee/baton/security/stunsword/loaded = 1,
	)
