// HUMAN LORE OVERRIDES

/datum/species/human/get_species_description()
	return "Descending originally from primate lifeforms found upon Earth in what is now known as the Sol system, humanity is known across the galaxy for its wide, seemingly limitless propensity to vary in expression, form, and factor. Widespread embracing of genetic biomodification has resulted in a people who frequently defy direct description."

/datum/species/human/get_species_lore()
	return list(
		"Owing to a historical culture inexorably steeped in maritime and military tradition, veneration of the exemplary and a drive to push ever forwards into the unknown expanse in their time before spaceflight, humanity has become one of the eminent races in the galaxy from their home in the Sol system.",

		"Distinctly cultured per-planet, a Terran human may appear vastly different from a Marsian human, and the same again for a Saturnian, owing to the vast, intractable differences born by only meagre astronomical units distances apart. Marsians in particular are renowned for their wild and progressive uptake of genetic biomodification, birthing the new classification of 'demihumanity' in their quest to augment themselves for a variety of reasons with features adjacent to animals, plants, and more.",

		"From the clamor of the Sol Federation's systems to the bustling Core Worlds of Ceti Epsilon and even the far reaches of the rimworlds in the widening frontier, humanity is an ever-present and perpetually changing force, with no two humans ever quite like the other. This unstoppable drive is both a blessing and curse however, as the extent of human ambition frequently manifests itself in sprawling corporate 'games' and relics of decay and abandonment, such as the failed Pluto project."
	)

/datum/species/human/create_pref_unique_perks()
	// I'm giving them one here because it looks weird for them not to have one (and on /tg/ they're supposed to have Asimov + Command features, which we've commented out.)
	return list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Common Physiology",
			SPECIES_PERK_DESC = "Many advances in medical science have been pioneered by Human corporations, meaning that treatment is often straightforward and readily accessible."
		)
	)
