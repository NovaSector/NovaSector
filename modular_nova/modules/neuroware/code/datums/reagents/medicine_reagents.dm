/datum/reagent/medicine/brain_neuroware
	name = "ntnetsys.robot-diag.exe"
	description = "Repairs basic brain traumas in synthetics."
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/brain_neuroware)

/datum/reagent/medicine/brain_neuroware/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	return ..()

/datum/reagent/medicine/reset_neuroware
	name = "ntnetsys.robot-antivirus.exe"
	description = "Deletes neuroware programs in synthetics."
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0
	metabolization_rate = 2 * REAGENTS_METABOLISM

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/reset_neuroware)

/datum/reagent/medicine/reset_neuroware/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	var/remove_amount = 1 * REM * seconds_per_tick;
	for(var/thing in affected_mob.reagents.reagent_list)
		var/datum/reagent/reagent = thing
		if((reagent.chemical_flags & REAGENT_NEUROWARE) && (reagent != src))
			affected_mob.reagents.remove_reagent(reagent.type, remove_amount)
	return ..()

/datum/reagent/medicine/synaptizine/synth
	name = "synaptuner.zhe"
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/synaptizine/synth)

/datum/reagent/medicine/psicodine/synth
	name = "zen-firstaid.zhe"
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/psicodine/synth)

/datum/reagent/medicine/morphine/synth
	name = "AnaSynthic.zhe"
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/morphine/synth)

/datum/reagent/medicine/lidocaine/synth
	name = "NGesic.zhe"
	chemical_flags = REAGENT_NEUROWARE
	process_flags = REAGENT_SYNTHETIC
	self_consuming = TRUE
	purge_multiplier = 0

NEUROWARE_METABOLIZE_HELPER(/datum/reagent/medicine/morphine/synth)
