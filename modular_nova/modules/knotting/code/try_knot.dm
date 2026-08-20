/// Call on the knotter after they finish inside a partner.
/mob/living/proc/try_knot(mob/living/partner, climax_into_choice)
	var/static/list/knottable_climax_targets = list(
		ORGAN_SLOT_VAGINA,
		CLIMAX_TARGET_ASSHOLE,
		ORGAN_SLOT_ANUS,
		CLIMAX_TARGET_MOUTH,
	)

	if(!isliving(partner) || partner == src)
		return
	if(!HAS_TRAIT(src, TRAIT_CAN_KNOT))
		return
	if(HAS_TRAIT(src, TRAIT_KNOTTED) || HAS_TRAIT(partner, TRAIT_KNOTTED))
		return

	if(!ishuman(src))
		return
	var/mob/living/carbon/human/knotter = src
	if(!knotter.has_penis(REQUIRE_GENITAL_EXPOSED))
		return

	var/client/partner_client = GET_CLIENT(partner)
	if(!partner_client?.prefs?.read_preference(/datum/preference/toggle/knotting/receive))
		return

	if(!(climax_into_choice in knottable_climax_targets))
		return

	knotter.AddComponent(/datum/component/knotted, partner, climax_into_choice)
