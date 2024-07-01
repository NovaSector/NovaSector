// MOTH LORE OVERRIDES

/datum/species/moth
	name = "\improper Mothperson"
	wikilink = "Lore:Moths"

/datum/species/moth/get_species_description()
	return "Highly adapted for the rigors of space, the insectoid Mothpeople (known as Falida in their home tongue) bear compound eyes, chitinous exoskeletons with ornately patterned wings capable of notable agility in zero-gravity conditions, and articulated antennae of considerable size. Many bear fluff-like coverings reminiscent of Terran moths (hence their name) and may sport vibrant patterning."

/datum/species/moth/get_species_lore()
	return list(
		"Having lost their homeworld long ago, the gregarious and communally-driven Mothfolk are based almost entirely out of an armada of generational ships known as the Grand Mothic Fleet. Created in the waning decades of their late ancestral home, many of these ships were built to house tens of thousands of people in cramped and uncomfortable circumstances. Many vessels did not survive long past the initial exodus, but those that have are now patchwork amalgamations of tenacity, engineering ingenuity and raw perseverance - all hallmarks of the Mothic spirit. This collectivist angle is prominent throughout their society and culture, often favoring the group over the individual in most circumstances.",

		"Inexplicably, little is known about the exact circumstances that led to the demise of the Mothic homeworld, with very little evidence or documentation having endured in their time spent searching for a new world since. This appears to bother them less than you might expect, seemingly having made peace with their history, and looking past a time that no longer has any bearing on their present, day-to-day needs.",

		"Though initially having met humanity in less-than-ideal circumstances after having been driven to piracy in the wake of vast fuel shortages, a surprising coalescence of cultural exchanges in food, entertainment and technology have led the two races to share a warm friendship, and many Mothic Fleet personnel can be seen working aboard human ships and stations. Resource scarcity and the costs of ongoing maintenance within the Fleet have stalled their advances in spaceflight technology, allowing Humanity to ultimately catch up and exceed them - a fact that sometimes bristles with the Fleet's best and brightest."
	)

/datum/species/moth/create_pref_unique_perks()
	return list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "feather-alt",
			SPECIES_PERK_NAME = "Nullgrav-adapted Wings",
			SPECIES_PERK_DESC = "Mothpeople can fly in pressurized, zero-g environments. They can also safely stall short falls using their wings, even in normal gravity.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "tshirt",
			SPECIES_PERK_NAME = "Fibrous Metabolism",
			SPECIES_PERK_DESC = "Mothpeople have been known to consume clothing in times of need (or out of preference) and are capable of metabolising many types of cloth as food.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Flammable Flight Membranes",
			SPECIES_PERK_DESC = "Exposure to fire and flame can cause a Mothperson's wing membranes to burn completely off!",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "Severe Photosensitivity",
			SPECIES_PERK_DESC = "Eyes adapted for the low-light interiors of generational ships have left the Mothpeople very sensitive to light - make sure to use a welding mask when performing repair work!"
		),
	)
