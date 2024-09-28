/mob/living/basic/creature
	gold_core_spawnable = NO_SPAWN //we set the variable to no spawn so it doesnt appear in the gold core spawns
	mob_biotypes = MOB_BEAST|MOB_SPECIAL //we set the mob_special type as its one of the exceptions that bioscramblers use, without dropping the mob_beast type which interacts with the hunter weapons.
