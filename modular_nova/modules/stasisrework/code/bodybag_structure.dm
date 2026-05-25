/obj/structure/closet/body_bag/stasis_mortuary
	name = "mortuary stasis bodybag"
	desc = "A body bag designed for the preservation of cadavers via integrated cryogenic technology and an insulative diamond mesh. \
		Due to generator limitations, the stasis effect only works on dead bodies."
	icon = 'modular_nova/modules/stasisrework/icons/stasisbag.dmi'
	icon_state = "greenbodybag"
	foldedbag_path = /obj/item/bodybag/stasis_mortuary
	mob_storage_capacity = 1
	max_mob_size = MOB_SIZE_LARGE

/obj/structure/closet/body_bag/stasis/open(mob/living/user, force = FALSE, special_effects = TRUE)
	for(var/mob/living/M in contents)
		thaw_them(M)
	. = ..()
	if(.)
		mouse_drag_pointer = MOUSE_INACTIVE_POINTER

/obj/structure/closet/body_bag/stasis/close()
	. = ..()
	for(var/mob/living/M in contents)
		if(M.stat == DEAD)
			chill_out(M)
	if(.)
		density = FALSE
		mouse_drag_pointer = MOUSE_ACTIVE_POINTER

/obj/structure/closet/body_bag/stasis/proc/chill_out(mob/living/target)
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)
	target.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
	target.extinguish_mob()

/obj/structure/closet/body_bag/stasis/proc/thaw_them(mob/living/target)
	target.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
