/datum/surgery_operation/limb/amputate/New()
	implements += list(
		/obj/item/machete = 1.25,
	)
	return ..()

// doesn't work on robo limbs
/datum/surgery_operation/limb/amputate/mechanic/New()
	. = ..()
	implements -= list(
		/obj/item/machete,
	)
