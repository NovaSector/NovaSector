/datum/surgery_step/sever_limb/New()
	implements += list(
		/obj/item/machete = 75,
	)
	return ..()

// doesn't work on robo limbs
/datum/surgery_step/sever_limb/mechanic/New()
	. = ..()
	implements -= list(
		/obj/item/machete,
	)
