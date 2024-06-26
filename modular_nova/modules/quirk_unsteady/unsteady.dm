/datum/quirk/unsteady
	name = "Unsteady"
	desc = "You are easy to knock down, and fall often when hit or pushed."
	icon = "tg-bad-touch"
	value = 0 // much like death degredation, effects can be negated in configuration
	gain_text = span_danger("You feel like you could fall over easily.")
	lose_text = span_notice("You feel steady again.")
	medical_record_text = "The patient finds it remarkably easy to fall over due to external influence."

	// the minimum amount of damage required to knockdown
	var/unsteady_damagethreshold = UNSTEADY_DAMAGETHRESHOLD
	// chance to knockdown when hit over threshold
	var/unsteady_hurtchance = UNSTEADY_DAMAGECHANCE
	// length of the knockdown
	var/unsteady_stunlength = UNSTEADY_STUNLENGTH

/datum/quirk_constant_data/unsteady
    associated_typepath = /datum/quirk/unsteady

/datum/quirk_constant_data/unsteady/New()
	customization_options = subtypesof(/datum/preference/numeric/unsteady)

	return ..()

/datum/quirk/unsteady/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(ouchie))

	// update vars on preferences
	var/datum/preferences/clientpreferences = client_source.prefs

	unsteady_damagethreshold = clientpreferences.read_preference(/datum/preference/numeric/unsteady/unsteady_damagethreshold)
	unsteady_hurtchance = clientpreferences.read_preference(/datum/preference/numeric/unsteady/unsteady_hurtfactor)
	unsteady_stunlength = clientpreferences.read_preference(/datum/preference/numeric/unsteady/unsteady_stunlength)

/datum/quirk/unsteady/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE)

/datum/quirk/unsteady/proc/ouchie(mob/living/carbon/source, damage, damagetype, def_zone, blocked, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(damagetype != BRUTE)
		return
	if(damage < unsteady_damagethreshold)
		return
	if (!prob(unsteady_hurtchance))
		return

	//don't display the message if already downed
	if(!source.IsUnconscious())
		source.visible_message(
			span_warning("[source] falls over in a scramble!"),
			span_userdanger("You fall over in a scramble!"),
			vision_distance = COMBAT_MESSAGE_RANGE,
	)

	// get down on the floor, break it down
	source.Knockdown(unsteady_stunlength SECONDS)
