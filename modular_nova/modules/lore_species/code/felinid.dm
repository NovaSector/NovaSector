/datum/species/human/felinid/get_species_description()
	return "One of the most common (and earliest) Marsian Animalid biomodification strains, the Felinid phenotype of demihumanity bears a varied mix of predominately feline traits, such as extended cat-like ears, slit pupils, prominent incisors, elongated nails and one (or more) cat-like tails. They are also often sensitive to sound, and dislike water."

/datum/species/human/felinid/get_species_lore()
	return list(
		"Historically the poster-children of the early enmity shown towards Marsian biomodders during the push to establish genetic alterations as fashion and self-actualization choices, the Felinid phenotype of the Animalid-class was one of the first widely popularized genelines made available for civilian use.",

		"Persecuted heavily in many parts of inner SolFed space, the frontier remains home to an especially large population of felinid families. As the geneline is entirely capable of propagating itself without laboratory aid, many modern felinids have simply been born into their traits by virtue of their parentage, whereas others may visit clinics as their 'ancestors' once did.",

		"Imbued with a propensity for lithe and flexible frames, many felinids have found work in mercenary and engineering professions capable of exploiting their innate traits - such as their attenuation to sound, ability to weather short falls without significant injury, and sensitive hearing."
	)

/datum/species/human/felinid/create_pref_unique_perks()
	return list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "grin-tongue",
			SPECIES_PERK_NAME = "Mild Coagulant Saliva",
			SPECIES_PERK_DESC = "Felinid saliva contains a mild coagulant, allowing them to lick their wounds to reduce bleeding.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "Catlike Grace",
			SPECIES_PERK_DESC = "Felinids almost always land on their feet, and micro-adaptations in their legs mean they rarely take significant damage from anything but the largest, most serious falls."
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "Sensitive Hearing",
			SPECIES_PERK_DESC = "Felinids are more sensitive to loud sounds, such as flashbangs, and may sustain aural injuries quicker than others.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "shower",
			SPECIES_PERK_NAME = "Mild Hydrophobia",
			SPECIES_PERK_DESC = "Felinids generally do not enjoy getting wet.",
		),
	)
