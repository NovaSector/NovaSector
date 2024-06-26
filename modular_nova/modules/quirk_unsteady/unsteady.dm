/datum/quirk/unsteady
	name = "Unsteady"
	desc = "You are easy to knock down, and fall often when hit or pushed."
	icon = FA_ICON_VOLUME_XMARK
	value = -4
	gain_text = span_danger("You feel like you could fall over easily.")
	lose_text = span_notice("You feel steady again.")
	medical_record_text = "The patient finds it remarkably easy to fall over due to external influence."
	hardcore_value = 4

	var/unsteady_damagethreshold = UNSTEADY_DAMAGETHRESHOLD

	var/unsteady_hurtchance = UNSTEADY_HURTCHANCE

	var/unsteady_pushchance = UNSTEADY_PUSHCHANCE

	var/unsteady_stunlength = UNSTEADY_STUNLENGTH

/datum/quirk_constant_data/unsteady/New()
	customization_options = subtypesof(/datum/preference/numeric/unsteady)

	return ..()

/datum/quirk/unsteady/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(ouchie))

/datum/quirk/unsteady/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE)

// for getting hit
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
	source.Knockdown(unsteady_stunlength SECONDS)
