
/*
 * Groan Tube (thing that goes UUAAAA AAAUUU)
 */
/obj/item/toy/groan_tube
	name = "groan tube"
	desc = "UUAAAA...   AAAUUUU"
	icon = 'modular_iris/icons/obj/toy.dmi'
	icon_state = "groan_tube"
	verb_say = "groans"
	COOLDOWN_DECLARE(groan_cooldown)
	var/flipped = FALSE
	var/cooldown_time = 20

/obj/item/toy/groan_tube/attack_self(mob/user)
	if(COOLDOWN_FINISHED(src, groan_cooldown))
		to_chat(user, span_notice("You flip \the [src]."))
		flick("groan_tube_flip", src)
		if(flipped)
			playsound(loc, 'modular_iris/sound/items/aaau.ogg', 50, FALSE, 3)
			say("AAAUUU")
		else
			playsound(loc, 'modular_iris/sound/items/uuua.ogg', 50, FALSE, 3)
			say("UUAAAA")

		flipped = !flipped
		COOLDOWN_START(src, groan_cooldown, cooldown_time)
		return
	..()
