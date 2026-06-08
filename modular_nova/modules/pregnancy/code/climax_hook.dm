/// Rolls the quirk holder's Mammal Pregnancy chance pref after an internal climax into them.
/datum/quirk/mammal_pregnancy/proc/try_pregnancy_from_climax(mob/living/carbon/human/target, mob/living/carbon/human/climax_partner, climax_into_choice, receiving_climax = FALSE)
	SIGNAL_HANDLER

	if(!receiving_climax)
		return
	if(!ishuman(target) || !ishuman(climax_partner) || target == climax_partner)
		return
	if(target != quirk_holder)
		return
	if(target.has_status_effect(/datum/status_effect/pregnancy))
		return

	if(!prob(pregnancy_chance))
		return

	target.apply_status_effect(/datum/status_effect/pregnancy, src)
