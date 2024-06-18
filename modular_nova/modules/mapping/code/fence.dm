// Fences and stuff

// Interlink specific fences so people can't cut their way into restricted areas
/obj/structure/fence/interlink
	name = "reinforced fence"
	desc = "The latest in Nanotrasen development: A reinforced metal fence. This'll keep those pesky assistants out!"
	cuttable = FALSE
	invulnerable = TRUE // This only prevents cutting through with wirecutters; everything below handles the rest.
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	move_resist = INFINITY
