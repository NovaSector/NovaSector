/// Call on the cum-giver after they finish inside a partner. Rolls the partner's pregnancy-chance pref
/// against the insemination-route toggle for that orifice, applying the pregnancy status effect on success.
/mob/living/carbon/human/proc/try_pregnancy_from_climax(mob/living/carbon/human/target, climax_into_choice)
	if(!ishuman(target) || target == src)
		return
	if(HAS_TRAIT(src, TRAIT_INFERTILE) || HAS_TRAIT(target, TRAIT_INFERTILE))
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
