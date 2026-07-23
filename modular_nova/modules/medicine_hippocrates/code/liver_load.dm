/*
 *
 * Every medicine can declare a `liver_load` and the `liver_load_flags` it feeds. Medicines sharing a
 * pool combine their load, and once a pool goes over LIVER_LOAD_FREE_LOAD every medicine drinking
 * from it heals less: efficiency is 1/sqrt(load), so two full-load brute chems each work at ~71%
 * and together still beat one chem alone. 1+1 < 2, but 1+1 > 1. Reagent consumption remains unchanged
 *
 */

GLOBAL_LIST_INIT(liver_load_pools, list(LIVER_LOAD_BRUTE, LIVER_LOAD_BURN, LIVER_LOAD_TOXIN, LIVER_LOAD_OXYGEN))

/datum/reagent/medicine
	/// How hard this medicine leans on the liver. Combines with every other medicine sharing a pool.
	var/liver_load = 0
	/// Bitflags of which liver load pools this medicine feeds. See LIVER_LOAD_* in the nova defines.
	var/liver_load_flags = NONE
	/// Cached healing multiplier from liver load, recomputed every metabolism tick in compute_metabolization().
	var/liver_load_efficiency = 1

/datum/reagents
	/// Combined load per liver load pool, positionally matching GLOB.liver_load_pools. Rebuilt at most once per world tick.
	var/list/liver_load_pool_totals
	/// world.time the liver load pools were last rebuilt at, so we only pay for it once per Life() tick.
	var/liver_load_pools_updated = -1

/**
 * Rebuilds (or returns the cached) combined load for each liver load pool in this holder.
 *
 * Loads are divided by how healthy the patient's liver is.
 *
 * Returns null when the module is switched off or when nothing in the holder carries a load.
 *
 * Arguments:
 * * affected_mob - the carbon metabolizing these reagents.
 */
/datum/reagents/proc/get_liver_load_pools(mob/living/carbon/affected_mob)
	if(liver_load_pools_updated == world.time)
		return liver_load_pool_totals

	liver_load_pools_updated = world.time
	liver_load_pool_totals = null

	if(!CONFIG_GET(flag/medicine_hippocrates) || isnull(affected_mob))
		return null

	var/list/totals
	for(var/datum/reagent/medicine/medicine in reagent_list)
		if(!medicine.liver_load || !medicine.liver_load_flags)
			continue
		if(isnull(totals))
			totals = new_liver_load_pools()
		for(var/index in 1 to length(totals))
			if(medicine.liver_load_flags & GLOB.liver_load_pools[index])
				totals[index] += medicine.liver_load

	if(isnull(totals))
		return null

	// A failing liver clears less of the load, so everything in the pools weighs more.
	var/liver_quality = LIVER_LOAD_NO_LIVER_QUALITY
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver)
		liver_quality = max((liver.maxHealth - liver.damage) / liver.maxHealth, LIVER_LOAD_MIN_LIVER_QUALITY)

	var/worst_load = 0
	for(var/index in 1 to length(totals))
		totals[index] /= liver_quality
		worst_load = max(worst_load, totals[index])

	liver_load_pool_totals = totals

	if(worst_load >= LIVER_LOAD_STRAIN_LOAD)
		affected_mob.apply_status_effect(/datum/status_effect/liver_strain, worst_load)

	return totals

/// Returns a fresh, zeroed set of liver load pool totals.
/proc/new_liver_load_pools()
	var/list/pools = new /list(length(GLOB.liver_load_pools))
	for(var/index in 1 to length(pools))
		pools[index] = 0
	return pools

/**
 * How well this medicine is actually working right now, from 1 (unimpeded) down to
 * LIVER_LOAD_MIN_EFFICIENCY. Driven by the fullest pool this medicine feeds.
 *
 * Arguments:
 * * affected_mob - the carbon metabolizing this reagent.
 */
/datum/reagent/medicine/proc/get_liver_load_efficiency(mob/living/carbon/affected_mob)
	if(!liver_load || !liver_load_flags || isnull(holder))
		return 1

	var/list/totals = holder.get_liver_load_pools(affected_mob)
	if(isnull(totals))
		return 1

	var/worst_load = 0
	for(var/index in 1 to length(totals))
		if(liver_load_flags & GLOB.liver_load_pools[index])
			worst_load = max(worst_load, totals[index])

	if(worst_load <= LIVER_LOAD_FREE_LOAD)
		return 1

	return clamp(1 / sqrt(worst_load), LIVER_LOAD_MIN_EFFICIENCY, 1)

/*
 * The healing hook.
 *
 * compute_metabolization() decides both how much of the reagent is burned this tick AND the
 * metabolization_ratio every medicine scales its healing by, so scaling its result down is all it
 * takes to make a medicine do less per tick. metabolize_reagent() below then puts the full amount
 * back for the actual consumption, so an overloaded liver wastes the chem instead of stretching it.
 */
/datum/reagent/medicine/compute_metabolization(mob/living/carbon/affected_mob, seconds_per_tick)
	var/metabolized_volume = ..()
	liver_load_efficiency = get_liver_load_efficiency(affected_mob)
	return metabolized_volume * liver_load_efficiency

/datum/reagent/medicine/metabolize_reagent(mob/living/carbon/affected_mob, seconds_per_tick, metabolized_volume)
	// Undo the effectiveness scaling from compute_metabolization() - the body burns the whole dose
	// regardless. Clamped to what's actually left, since the round trip through a float multiply and
	// divide can land a hair above where it started.
	if(liver_load_efficiency > 0 && liver_load_efficiency < 1)
		metabolized_volume = min(metabolized_volume / liver_load_efficiency, volume)
	return ..(affected_mob, seconds_per_tick, metabolized_volume)
