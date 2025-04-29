// Display healing effect if we actually healed
/datum/symptom/heal/Heal(mob/living/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

// Display_heal_visual procs for adding visual effects to virus healing
/datum/symptom/heal/proc/display_heal_visual(mob/living/living_mob)
	new /obj/effect/temp_visual/heal(get_turf(living_mob), COLOR_EFFECT_HEAL_RED)

// We ask for the stealth effect specifically as this is the only effect where the whole joke is to pass as dead, so you shouldnt be seen as being healing.
/datum/symptom/heal/coma/display_heal_visual(mob/living/living_mob)
	if(deathgasp)
		return
	return ..()

// We overwrite every symptom to use our proc
/datum/symptom/heal/starlight/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

/datum/symptom/heal/darkness/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

/datum/symptom/heal/coma/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

/datum/symptom/heal/water/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

/datum/symptom/heal/plasma/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)

/datum/symptom/heal/radiation/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	. = ..()
	if(!.)
		return
	display_heal_visual(M)
