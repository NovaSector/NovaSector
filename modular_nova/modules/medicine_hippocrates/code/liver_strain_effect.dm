/*
 *
 * Applied by /datum/reagents/proc/get_liver_load_pools() while any liver load pool is over
 * LIVER_LOAD_STRAIN_LOAD. Refreshed every metabolism tick that the cocktail keeps up, and expires on
 * its own once the patient is back down to a sane number of medicines.
 */
/datum/status_effect/liver_strain
	id = "liver_strain"
	status_type = STATUS_EFFECT_REFRESH
	duration = LIVER_LOAD_STRAIN_DURATION
	tick_interval = 2 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/liver_strain
	remove_on_fullheal = TRUE
	/// The fullest liver load pool that applied us, used to scale how rough the side effects are.
	var/strain = LIVER_LOAD_STRAIN_LOAD

/datum/status_effect/liver_strain/on_creation(mob/living/new_owner, new_strain = LIVER_LOAD_STRAIN_LOAD)
	strain = new_strain
	return ..()

/datum/status_effect/liver_strain/refresh(effect, new_strain = LIVER_LOAD_STRAIN_LOAD)
	strain = max(strain, new_strain)
	return ..()

/datum/status_effect/liver_strain/tick(seconds_between_ticks)
	// Everything past the free load is what actually makes you feel sick.
	var/excess = strain - LIVER_LOAD_FREE_LOAD
	owner.adjust_disgust(2 * excess * seconds_between_ticks)
	owner.adjust_dizzy_up_to(1 SECONDS * excess * seconds_between_ticks, 20 SECONDS)
	owner.adjust_drowsiness_up_to(0.5 SECONDS * excess * seconds_between_ticks, 15 SECONDS)

	if(SPT_PROB(4 * excess, seconds_between_ticks))
		to_chat(owner, span_warning("[pick("Your stomach turns over.", "A wave of grogginess washes over you.", "Your gut aches dully.", "You feel wrung out and queasy.")]"))

	// Overmedication decays on its own so a cocktail that has since worn off stops nagging the patient.
	strain = max(strain - (0.1 * seconds_between_ticks), LIVER_LOAD_FREE_LOAD)

/atom/movable/screen/alert/status_effect/liver_strain
	name = "Overmedicated"
	desc = "Your liver is struggling to keep up with everything in your bloodstream. Your medicines aren't doing you as much good as they should, and you feel awful besides."
	icon_state = "stoned"
