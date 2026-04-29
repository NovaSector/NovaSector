/**
 * Call on the knotter (the one climaxing) after they finish inside a partner.
 * Mirrors the pregnancy-trigger pattern in [modular_nova/modules/pregnancy/code/climax_hook.dm].
 *
 */
/mob/living/proc/try_knot(mob/living/partner, climax_into_choice)
	if(!isliving(partner) || partner == src)
		return
	if(!HAS_TRAIT(src, TRAIT_CAN_KNOT))
		return

	// Penis check — currently humans-only; cyborg knotting would need a separate code path.
	if(!ishuman(src))
		return
	var/mob/living/carbon/human/knotter = src
	if(!knotter.has_penis(REQUIRE_GENITAL_EXPOSED))
		return

	// Partner's receive pref gate.
	var/client/partner_client = GET_CLIENT(partner)
	if(!partner_client?.prefs?.read_preference(/datum/preference/toggle/knotting/receive))
		return

	// Only penetrative orifices get knotted.
	if(!(climax_into_choice in list(ORGAN_SLOT_VAGINA, "asshole", ORGAN_SLOT_ANUS, "mouth")))
		return

	// No double-knotting the same partner.
	if(partner.GetComponent(/datum/component/knotted))
		return

	knotter.AddComponent(/datum/component/knotted, partner, climax_into_choice)
