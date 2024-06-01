/obj/item/stack/medical/wound_recovery/robofoam_super/afterattack(obj/item/clothing/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !istype(target))
		return FALSE
	if(!use(1, check = TRUE))
		return FALSE
	target.balloon_alert(user, "repairing...")
	if(!do_after(user, 10 SECONDS, target))
		return FALSE
	if(!use(1, check = TRUE))
		return FALSE
	target.repair(user)
	playsound(target, treatment_sound, 100, TRUE)
	use(1)
