/// Rolls the quirk holder's Mammal Pregnancy chance pref against the insemination-route toggle for the signaled orifice.
/datum/quirk/mammal_pregnancy/proc/try_pregnancy_from_climax(mob/living/carbon/human/target, mob/living/carbon/human/climax_partner, climax_into_choice)
	SIGNAL_HANDLER

	if(!ishuman(target) || !ishuman(climax_partner) || target == climax_partner)
		return
	if(target != quirk_holder)
		return
	if(target.has_status_effect(/datum/status_effect/pregnancy))
		return

	var/client/preference_source = GET_CLIENT(target)
	if(!preference_source)
		return

	var/genital_pass = FALSE
	switch(climax_into_choice)
		if(ORGAN_SLOT_VAGINA)
			genital_pass = preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/vaginal_insemination)
		if(CLIMAX_TARGET_ASSHOLE, ORGAN_SLOT_ANUS)
			genital_pass = preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/anal_insemination)
		if(CLIMAX_TARGET_MOUTH)
			genital_pass = preference_source.prefs.read_preference(/datum/preference/toggle/pregnancy/oral_insemination)

	if(!genital_pass)
		return

	if(!prob(preference_source.prefs.read_preference(/datum/preference/numeric/pregnancy/chance)))
		return

	target.apply_status_effect(/datum/status_effect/pregnancy)
