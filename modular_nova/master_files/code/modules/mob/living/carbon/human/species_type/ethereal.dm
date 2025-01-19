/datum/species/ethereal/on_species_gain(mob/living/carbon/human/new_ethereal, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/datum/action/sing_tones/sing_action = new
	sing_action.Grant(new_ethereal)

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
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "music",
			SPECIES_PERK_NAME = "Musical Discharger",
			SPECIES_PERK_DESC = "Ethereals can sing musical tones using their electric discharger.",
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
