/*
 * MEDICINE_HIPPOCRATES - mending
 *
 * Sutures and meshes stop dumping their whole heal into a limb the instant they're applied. Instead
 * they leave the limb mending over time. Reapplying refreshes that limb's timer rather than stacking
 * a second dose, so you can't burst a fight's worth of damage off in a couple of clicks - but on a
 * single limb the total healing over the effect's lifetime beats the instant version, which makes
 * them nicer for patching people up out of combat.
 *
 * One status effect per mob tracks every mending limb, and it heals at a single global rate (the best
 * dressing applied), spread across those limbs. Suturing many limbs lets you choose where the healing
 * goes; it does not multiply how fast you heal overall.
 */

/// Index into a mending_limbs entry: brute healed per second.
#define MENDING_BRUTE_RATE 1
/// Index into a mending_limbs entry: burn healed per second.
#define MENDING_BURN_RATE 2
/// Index into a mending_limbs entry: deciseconds of mending left on this limb.
#define MENDING_TIME_LEFT 3

/datum/status_effect/mending
	id = "mending"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/mending
	remove_on_fullheal = TRUE
	/// Assoc list of body zone -> list(brute per second, burn per second, deciseconds remaining).
	var/list/mending_limbs

/datum/status_effect/mending/on_apply()
	mending_limbs = list()
	return TRUE

/**
 * Starts, or refreshes, mending on a single limb.
 *
 * Refreshing takes the better rate of the two and the longer of the two timers, so topping a limb up
 * with a worse suture never makes the patient worse off, and never stacks into burst healing either.
 *
 * Arguments:
 * * body_zone - the zone that was treated.
 * * brute_rate - brute healed per second.
 * * burn_rate - burn healed per second.
 * * mending_duration - how long the limb should mend for, in deciseconds.
 */
/datum/status_effect/mending/proc/mend_limb(body_zone, brute_rate, burn_rate, mending_duration)
	var/list/existing = mending_limbs[body_zone]
	if(existing)
		existing[MENDING_BRUTE_RATE] = max(existing[MENDING_BRUTE_RATE], brute_rate)
		existing[MENDING_BURN_RATE] = max(existing[MENDING_BURN_RATE], burn_rate)
		existing[MENDING_TIME_LEFT] = max(existing[MENDING_TIME_LEFT], mending_duration)
		return

	mending_limbs[body_zone] = list(brute_rate, burn_rate, mending_duration)

/**
 * Whether a limb is already mending at least as well as the passed dressing would.
 *
 * Used to decide whether a re-application has anything to add. No time component: a limb stays
 * "saturated" for the whole time it's mending, so the answer never flips back and forth while a
 * treatment is still running.
 *
 * Arguments:
 * * body_zone - the zone to check.
 * * brute_rate - brute per second the dressing would apply.
 * * burn_rate - burn per second the dressing would apply.
 */
/datum/status_effect/mending/proc/is_limb_saturated(body_zone, brute_rate, burn_rate)
	var/list/mending = mending_limbs[body_zone]
	if(!mending)
		return FALSE

	return mending[MENDING_BRUTE_RATE] >= brute_rate && mending[MENDING_BURN_RATE] >= burn_rate

/datum/status_effect/mending/proc/distribute_budget(list/wants, budget)
	var/list/granted = list()
	if(!length(wants) || budget <= 0)
		return granted

	var/list/ordered = sortTim(wants, GLOBAL_PROC_REF(cmp_numeric_asc), associative = TRUE)
	var/remaining = budget
	var/count = length(ordered)
	for(var/obj/item/bodypart/limb as anything in ordered)
		var/give = min(wants[limb], remaining / count)
		if(give > 0)
			granted[limb] = give
			remaining -= give
		count--
	return granted

/datum/status_effect/mending/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		qdel(src)
		return

	// Global throughput cap: the whole effect heals at the best single dressing's rate, no matter how
	// many limbs are mending. Suturing five limbs heals the same total per second as suturing one - it
	// just lets you spread that healing where you want it, rather than multiplying it.
	var/brute_rate = 0
	var/burn_rate = 0
	var/list/brute_wants = list()
	var/list/burn_wants = list()
	// Copied because finished limbs get dropped from the list as we go.
	for(var/body_zone in mending_limbs.Copy())
		var/list/mending = mending_limbs[body_zone]
		mending[MENDING_TIME_LEFT] -= seconds_between_ticks * 10

		var/obj/item/bodypart/limb = carbon_owner.get_bodypart(body_zone)
		// Limb got blown off or swapped out for a prosthetic mid-mend, nothing left to knit back together.
		if(isnull(limb) || !IS_ORGANIC_LIMB(limb))
			mending_limbs -= body_zone
			continue

		brute_rate = max(brute_rate, mending[MENDING_BRUTE_RATE])
		burn_rate = max(burn_rate, mending[MENDING_BURN_RATE])
		var/brute_want = min(mending[MENDING_BRUTE_RATE] * seconds_between_ticks, limb.brute_dam)
		var/burn_want = min(mending[MENDING_BURN_RATE] * seconds_between_ticks, limb.burn_dam)
		if(brute_want > 0)
			brute_wants[limb] = brute_want
		if(burn_want > 0)
			burn_wants[limb] = burn_want

		if(mending[MENDING_TIME_LEFT] <= 0)
			mending_limbs -= body_zone

	var/list/brute_granted = distribute_budget(brute_wants, brute_rate * seconds_between_ticks)
	var/list/burn_granted = distribute_budget(burn_wants, burn_rate * seconds_between_ticks)

	var/list/healed_limbs = brute_granted.Copy()
	for(var/limb in burn_granted)
		healed_limbs[limb] = TRUE

	var/healed_anything = FALSE
	var/overlays_changed = FALSE
	for(var/obj/item/bodypart/limb as anything in healed_limbs)
		var/brute = brute_granted[limb]
		var/burn = burn_granted[limb]
		if(brute > 0 || burn > 0)
			healed_anything = TRUE
			overlays_changed |= limb.heal_damage(brute = brute, burn = burn, updating_health = FALSE)

	if(healed_anything)
		carbon_owner.updatehealth()
	if(overlays_changed)
		carbon_owner.update_damage_overlays()

	if(!length(mending_limbs))
		qdel(src)

/atom/movable/screen/alert/status_effect/mending
	name = "Mending"
	desc = "Dressings are knitting your injuries back together. Reapplying them refreshes the treatment - it won't speed it up."
	icon_state = "fleshmend"

/**
 * Convenience wrapper for applying mending without having to fish the status effect out yourself.
 *
 * Arguments:
 * * body_zone - the zone that was treated.
 * * brute_rate - brute healed per second.
 * * burn_rate - burn healed per second.
 * * mending_duration - how long the limb should mend for, in deciseconds.
 */
/mob/living/carbon/proc/start_mending(body_zone, brute_rate, burn_rate, mending_duration)
	var/datum/status_effect/mending/effect = has_status_effect(/datum/status_effect/mending)
	if(isnull(effect))
		effect = apply_status_effect(/datum/status_effect/mending)
	if(isnull(effect))
		return

	effect.mend_limb(body_zone, brute_rate, burn_rate, mending_duration)

#undef MENDING_BRUTE_RATE
#undef MENDING_BURN_RATE
#undef MENDING_TIME_LEFT
