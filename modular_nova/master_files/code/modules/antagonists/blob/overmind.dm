/mob/eye/blob
	end_round_on_victory = FALSE

/mob/eye/blob/Initialize(mapload, starting_points)
	. = ..()
	SSshuttle.clearHostileEnvironment(src)

/mob/eye/blob/proc/victory()
		. = ..()
		SSsecurity_level.set_level(SEC_LEVEL_RED)
