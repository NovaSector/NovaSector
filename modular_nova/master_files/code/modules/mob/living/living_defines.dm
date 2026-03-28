/mob/living
	plane = GAME_PLANE // FOV adjustment
	max_stamina = 162 // originally 120, update for stamina crit

	/// Multiplier for medicine effect strength. Does not change consumption speed.
	var/medicine_effect_modifier = 1
	/// Multiplier for toxin effect strength. Does not change consumption speed.
	var/toxin_effect_modifier = 1
	/// Multiplier for ALL reagent metabolization speed. Applied after REAGENT_REVERSE_METABOLISM logic,
	/// so it uniformly speeds up or slows down everything regardless of reagent type.
	var/reagent_metabolism_boost = 1

	var/blood_volume_normal = BLOOD_VOLUME_NORMAL
	/// Player Panel Code
	var/admin_frozen = FALSE
	var/admin_sleeping = FALSE
