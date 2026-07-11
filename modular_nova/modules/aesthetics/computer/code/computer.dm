
/obj/machinery/computer
	/// The time the next keyboard clicksound is allowed to be played at
	var/next_clicksound

/obj/machinery/computer/interact(mob/user, special_state)
	. = ..()
	if(world.time > next_clicksound && isliving(user))
		next_clicksound = world.time + 5
		playsound(src, SFX_KEYBOARD, 40)
