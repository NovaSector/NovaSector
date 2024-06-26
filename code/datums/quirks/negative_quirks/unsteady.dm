// this quirk just intends to make it harder to run from danger
// kinda like glass jaw quirk, only applies to brute
// this however does not render unconscious, just knocks down like a slip

/datum/quirk/unsteady
	name = "Unsteady"
	desc = "You are easy to knock down, and fall often when hit or pushed."
	icon = FA_ICON_VOLUME_XMARK
	value = -4
	mob_trait = TRAIT_UNSTEADY
	gain_text = span_danger("You feel like you could fall over easily.")
	lose_text = span_notice("You feel steady again.")
	medical_record_text = "The patient finds it remarkably easy to fall over due to external influence."
	hardcore_value = 4

/datum/quirk_constant_data/unsteady
	associated_typepath = /datum/quirk/unsteady
	customization_options = list(/datum/preference/numeric/unsteady_pushfactor, /datum/preference/numeric/unsteady_hurtfactor, /datum/preference/numeric/unsteady_stunlength, /datum/preference/numeric/unsteady_damagethreshold)

/datum/quirk/unsteady/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(ouchie))

/datum/quirk/unsteady/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE)

// for getting hit
/datum/quirk/unsteady/proc/ouchie(mob/living/carbon/source, damage, damagetype, def_zone, blocked, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(damagetype != BRUTE)
		return
	if(damage < /datum/preference/numeric/unsteady_damagethreshold)
		return

	//don't display the message if already downed
	if(!source.IsUnconscious())
		source.visible_message(
			span_warning("[source] falls over in a scramble!"),
			span_userdanger("You fall over in a scramble!"),
			vision_distance = COMBAT_MESSAGE_RANGE,
	)
	source.Knockdown(/datum/preference/numeric/unsteady_stunlength SECONDS)
