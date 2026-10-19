// Rebalances the healing and side effects of common medicines while being modular.
// Each chemical is configured in the MAIN block with plain per-5-units values, example: brute_heal_per_5u = 15, heals 15 brute from 5u.
// To balance another chemical, copy an entry in MAIN, change the numbers, and add it to the override list below.
// If your chemical has special effects beyond brute, burn, stamina, or organ damage, you will need to implement them within apply_balanced_effects() or handle them separately in the chemical's own on_mob_life.

// VARIABLES
/datum/reagent/medicine
	/// Brute healed per 5u
	var/brute_heal_per_5u = 0
	/// Burn healed per 5u
	var/burn_heal_per_5u = 0
	/// Damage of the healed type above which the severe_* values are used instead, 0 to never use them
	var/severe_damage_threshold = 0
	/// Brute healed per 5u above severe_damage_threshold
	var/severe_brute_heal_per_5u = 0
	/// Burn healed per 5u above severe_damage_threshold
	var/severe_burn_heal_per_5u = 0
	/// Stamina damage dealt per 5u
	var/stamina_damage_per_5u = 0
	/// Organ damage dealt per 5u, as list(ORGAN_SLOT_X = amount)
	var/list/organ_damage_per_5u

// MAIN
// Brute
/datum/reagent/medicine/c2/libital
	brute_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_LIVER = 4)

/datum/reagent/medicine/c2/probital
	brute_heal_per_5u = 15
	stamina_damage_per_5u = 15

/datum/reagent/medicine/sal_acid
	brute_heal_per_5u = 5
	severe_damage_threshold = 60
	severe_brute_heal_per_5u = 40

// Burn
/datum/reagent/medicine/c2/aiuri
	burn_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_EYES = 3)

/datum/reagent/medicine/c2/lenturi
	burn_heal_per_5u = 15
	organ_damage_per_5u = list(ORGAN_SLOT_STOMACH = 5)

/datum/reagent/medicine/oxandrolone
	burn_heal_per_5u = 5
	severe_damage_threshold = 60
	severe_burn_heal_per_5u = 40

// Replace each reagent's existing on_mob_life body and call the shared implementation directly.
// You need to include this macro for each reagent type you want to apply the balance effects to.
#define BALANCE_ON_MOB_LIFE(reagent_type) reagent_type/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio) { . = ..(); return apply_balanced_effects(affected_mob, seconds_per_tick, metabolization_ratio) }
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/c2/libital)
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/c2/probital)
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/sal_acid)
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/c2/aiuri)
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/c2/lenturi)
BALANCE_ON_MOB_LIFE(/datum/reagent/medicine/oxandrolone)
#undef BALANCE_ON_MOB_LIFE

/// Applies the per-5u values. ratio / REM is the units metabolized this tick, so scale = units / 5.
/datum/reagent/medicine/proc/apply_balanced_effects(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	var/scale = metabolization_ratio / (REM * 5)
	var/need_mob_update = FALSE
	if(brute_heal_per_5u)
		var/brute_heal = (severe_damage_threshold && affected_mob.get_brute_loss() > severe_damage_threshold) ? severe_brute_heal_per_5u : brute_heal_per_5u
		need_mob_update += affected_mob.adjust_brute_loss(-brute_heal * scale * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	if(burn_heal_per_5u)
		var/burn_heal = (severe_damage_threshold && affected_mob.get_fire_loss() > severe_damage_threshold) ? severe_burn_heal_per_5u : burn_heal_per_5u
		need_mob_update += affected_mob.adjust_fire_loss(-burn_heal * scale * normalise_creation_purity(), updating_health = FALSE, required_bodytype = affected_bodytype)
	if(stamina_damage_per_5u)
		need_mob_update += affected_mob.adjust_stamina_loss(stamina_damage_per_5u * scale, updating_stamina = FALSE)
	for(var/organ_slot in organ_damage_per_5u)
		need_mob_update += affected_mob.adjust_organ_loss(organ_slot, organ_damage_per_5u[organ_slot] * scale, required_organ_flag = affected_organ_flags)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

