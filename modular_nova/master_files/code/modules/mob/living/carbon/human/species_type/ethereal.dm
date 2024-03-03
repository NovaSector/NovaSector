/datum/species/ethereal/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bolt",
			SPECIES_PERK_NAME = "Shockingly Tasty",
			SPECIES_PERK_DESC = "Ethereals can feed on electricity from APCs, and do not otherwise need to eat; they're also immune to damage from shocks, gathering power from them instead!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "lightbulb",
			SPECIES_PERK_NAME = "Disco Ball",
			SPECIES_PERK_DESC = "Ethereals passively generate their own light.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "gem",
			SPECIES_PERK_NAME = "Crystal Core",
			SPECIES_PERK_DESC = "The Ethereal's heart will encase them in crystal should they die, returning them to life after a time.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "fist-raised",
			SPECIES_PERK_NAME = "Elemental Attacker",
			SPECIES_PERK_DESC = "Ethereals deal burn damage with their punches instead of brute.",
		),
	)

	return to_add

/mob/living/carbon/human/proc/ethereal_electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE, jitter_time = 0 SECONDS, stutter_time = 0 SECONDS, stun_duration = 0 SECONDS)
	SEND_SIGNAL(src, COMSIG_LIVING_ELECTROCUTE_ACT, shock_damage, source, siemens_coeff, flags)
	if((flags & SHOCK_TESLA) && HAS_TRAIT(src, TRAIT_TESLA_SHOCKIMMUNE))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_SHOCKIMMUNE))
		return FALSE
	if(!(flags & SHOCK_ILLUSION))
		adjustFireLoss(shock_damage)
		Knockdown(0)
		adjust_jitter(0)
		adjust_stutter(0)
		do_sparks(5, TRUE, source)
		playsound(src, SFX_SPARKS, 75, TRUE, -1)
	else
		adjustStaminaLoss(shock_damage)
	if(!(flags & SHOCK_SUPPRESS_MESSAGE))
		visible_message(
			span_danger("[src] was shocked by \the [source], absorbing it into their body!"), \
			span_userdanger("You feel a powerful shock coursing through your body, easily handling it!"), \
			span_hear("You hear a heavy electrical crack.") \
		)
	if (!(flags & SHOCK_NO_HUMAN_ANIM))
		electrocution_animation(1 SECONDS)
