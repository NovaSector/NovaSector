// Modular C2 medicine balance. To add a chemical, copy one entry in the MAIN block and change the numbers.
// Every value is "per 5 units" of the chemical, e.g. brute_heal_per_5u = 15 heals 15 brute from 5u.
// Core files are untouched; USE_BALANCE replaces the chem's upstream on_mob_life with the shared proc at the bottom.
#define USE_BALANCE on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio) { . = ..(); return apply_balanced_effects(affected_mob, seconds_per_tick, metabolization_ratio) }

// Default values for C2 chemicals.
/datum/reagent/medicine/c2
	/// Brute healed per 5u
	var/brute_heal_per_5u = 15
	/// Burn healed per 5u
	var/burn_heal_per_5u = 15
	/// Stamina damage dealt per 5u
	var/stamina_damage_per_5u = 0
	/// Organ damage dealt per 5u, as list(ORGAN_SLOT_X = amount)
	var/list/organ_damage_per_5u

/*
/// XXX Comment explaining how to insert new entries here.
*/

/datum/reagent/medicine/c2/libital
	brute_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_LIVER = 3.75)
	USE_BALANCE

/datum/reagent/medicine/c2/probital
	brute_heal_per_5u = 15
	stamina_damage_per_5u = 37.5
	USE_BALANCE

/datum/reagent/medicine/c2/aiuri
	burn_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_EYES = 3.125)
	USE_BALANCE

/datum/reagent/medicine/c2/lenturi
	burn_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_STOMACH = 5)
	USE_BALANCE

/// Applies the per-5u values. One tick metabolizes 0.4u, so per tick = amount * 0.4 / 5.
/datum/reagent/medicine/c2/proc/apply_balanced_effects(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	var/scale = 0.08 * metabolization_ratio * seconds_per_tick
	var/need_mob_update = FALSE
	if(brute_heal_per_5u)
		need_mob_update += affected_mob.adjust_brute_loss(-brute_heal_per_5u * scale * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	if(burn_heal_per_5u)
		need_mob_update += affected_mob.adjust_fire_loss(-burn_heal_per_5u * scale * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	if(stamina_damage_per_5u)
		need_mob_update += affected_mob.adjust_stamina_loss(stamina_damage_per_5u * scale, updating_stamina = FALSE)
	for(var/organ_slot in organ_damage_per_5u)
		need_mob_update += affected_mob.adjust_organ_loss(organ_slot, organ_damage_per_5u[organ_slot] * scale, required_organ_flag = affected_organ_flags)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

#undef USE_BALANCE
