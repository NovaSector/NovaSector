/*
 * MEDICINE_HIPPOCRATES - mending
 *
 * Sutures and meshes stop dumping their whole heal into a limb the instant they're applied. Instead
 * they leave the limb mending over time.
 *
 * One status effect per mob tracks every mending limb. Each limb mends at its own rate, so treating
 * several limbs treats several limbs-
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

/datum/status_effect/mending/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		qdel(src)
		return

	var/healed_anything = FALSE
	var/overlays_changed = FALSE
	// Copied because finished limbs get dropped from the list as we go.
	for(var/body_zone in mending_limbs.Copy())
		var/list/mending = mending_limbs[body_zone]
		mending[MENDING_TIME_LEFT] -= seconds_between_ticks * 10

		var/obj/item/bodypart/limb = carbon_owner.get_bodypart(body_zone)
		// Limb got blown off or swapped out for a prosthetic mid-mend, nothing left to knit back together.
		if(isnull(limb) || !IS_ORGANIC_LIMB(limb))
			mending_limbs -= body_zone
			continue

		var/brute = min(mending[MENDING_BRUTE_RATE] * seconds_between_ticks, limb.brute_dam)
		var/burn = min(mending[MENDING_BURN_RATE] * seconds_between_ticks, limb.burn_dam)
		if(brute > 0 || burn > 0)
			healed_anything = TRUE
			overlays_changed |= limb.heal_damage(brute = brute, burn = burn, updating_health = FALSE)

		if(mending[MENDING_TIME_LEFT] <= 0)
			mending_limbs -= body_zone

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
