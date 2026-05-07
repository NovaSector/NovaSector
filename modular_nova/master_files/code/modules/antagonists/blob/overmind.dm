/mob/eye/blob
	end_round_on_victory = FALSE

/mob/eye/blob/Initialize(mapload, starting_points)
	. = ..()
	SSshuttle.clearHostileEnvironment(src)
