/mob/living/basic/creature
	gold_core_spawnable = NO_SPAWN // we set the variable to NO_SPAWN so it doesn't appear in the gold core spawns.

/mob/living/basic/creature/Initialize(mapload)
	mob_biotypes |= MOB_SPECIAL // we set the MOB_SPECIAL flag as it's one of the exceptions that bioscramblers use, without dropping the MOB_BEAST flag which interacts with the hunter weapons.
	return ..()
