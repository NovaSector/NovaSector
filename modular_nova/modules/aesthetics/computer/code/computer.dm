
/obj/machinery/computer
	var/clickvol = 40
	var/next_clicksound

/obj/machinery/computer/interact(mob/user, special_state)
	. = ..()
	if(world.time > next_clicksound && isliving(user))
		next_clicksound = world.time + 5
		playsound(src, SFX_KEYBOARD, clickvol)
