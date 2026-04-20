/datum/reagent
	/// Modular version of `chemical_flags`, so we don't have to worry about
	/// it causing conflicts in the future.
	var/chemical_flags_nova = NONE

// ---- Generic metabolism boost ----
// Applied after REAGENT_REVERSE_METABOLISM logic, so it uniformly
// speeds up or slows down ALL reagents regardless of type.

/datum/reagent/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.reagent_metabolism_boost

// ---- Per-category effect modifiers ----
// Scale effect strength independently of consumption speed.
// compute_metabolization() scales the returned volume (affecting metabolization_ratio → effects).
// metabolize_reagent() divides back to restore normal consumption speed.

/datum/reagent/medicine/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.medicine_effect_modifier

/datum/reagent/medicine/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	return ..(affected_mob, seconds_per_tick, metabolized_volume / affected_mob.medicine_effect_modifier)

/datum/reagent/toxin/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	. *= affected_mob.toxin_effect_modifier

/datum/reagent/toxin/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	return ..(affected_mob, seconds_per_tick, metabolized_volume / affected_mob.toxin_effect_modifier)

/datum/reagent/drug/nicotine
	addiction_types = list(/datum/addiction/nicotine = 40)

/datum/reagent/toxin/pestkiller/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(istype(exposed_obj, /obj/structure/spider))
		var/obj/structure/spider/webs_or_something = exposed_obj
		webs_or_something?.take_damage(rand(1, 3), BURN, 0) // slowly but surely damages web structures
