/datum/mutation/psionic_resonance
	name = "Psionic Resonance"
	desc = "The subject's neurology resonates with latent psionic potential."
	quality = POSITIVE
	locked = TRUE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_purple("A pressure inside your skull resolves into sudden clarity.")
	text_lose_indication = span_notice("The strange clarity behind your thoughts grows quiet.")

/datum/mutation/psionic_resonance/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return

	acquirer.awaken_psionics(PSIONIC_DEFAULT_POINTS, source = PSIONIC_SOURCE_MUTATION)
