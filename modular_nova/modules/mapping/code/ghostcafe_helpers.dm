/*

Instead of continuing to chase down headsets that keep popping up, let's just snuff their ability to communicate at the ghost cafe.

*/

/obj/structure/cafejammer
	name = "cafe radio jammer"
	desc = "Device used to disrupt nearby radio communication. Extra, extra large range."
	var/range = 60
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	invisibility = INVISIBILITY_ABSTRACT

/obj/structure/cafejammer/Initialize(mapload)
	. = ..()
	GLOB.active_jammers |= src

/obj/structure/cafejammer/Destroy()
	GLOB.active_jammers -= src
	return ..()
