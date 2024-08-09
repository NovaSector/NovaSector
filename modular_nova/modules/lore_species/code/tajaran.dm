/datum/species/tajaran/get_species_description()
	return "Hailing from the Saggitarius Arm, the Tajaran are a species of \
		feline humanoids bearing a surprising similarity to terran felines. \
		Tails, whiskers, clawed hands, pointed ears, meows, the whole deal."

/datum/species/tajaran/get_species_lore()
	return list(
		"A curiously familiar species to those coming from human circles, Tajarans were at first called \"Catmen\" \
		before Humanity actually caught wind of their name. For good reason, considering their entire anatomy is very \
		similar to that of a terran cat, save for being bipedal. \
		Originally evolved to handle harsh cold climates, Tajarans sport a coat of fluff that varies in thickness \
		depending on which planet said Tajaran grew up on.",

		"One of the oldest players of the galactic stage, Tajarans come from a wildly diverse corner \
		of space known as the \"Shattered Empire\", an immensely large span of stars deeply colonized by their kin. \
		After a coup known as the Fracture, the Six and One became the new ruling body of the Shattered Empire, stemming directly \
		from the Six Houses of the Scalpel. Of these are House Astameur, House Morikann, House Parigari, House Toranga, House Ussirune \
		and House Verikami. We do not talk about the Seventh House. \
		Modern Tajaran individuals are either Contracted to one of the houses through a House Contract, or remain unHoused.",

		"The first contact between Tajarans and Humans happened when a House Ussirune merchantcraft approached a struggling, \
		isolated human colony and opened trading lines with it, saving the colony from a shortage-induced collapse. \
		While friendly first-contact experiences were had with various different Houses, colonies unlucky to be found by \
		House Morikann (or worse, the Seventh House) did not fare as well. Diplomacy with the Tajaran houses is, and will always be, a juggling act.",

		"Outside of their relevant houses, Tajaran high culture revolves about two concept: \"Face\", and \"Heart\". \
		\"Face\" is a Tajaran concept denoting prestige and peer recognition, whereas \"Heart\" is a concept representing boorishness and raw power. \
		Commoners are typically Faceless due to their lack of reputation, but to be strong yet lack stylishness leads one to be called \"Heartsick\". \
		Being contracted to a house comes with obligations but also with privileges, including the use of the house's Face and good standing.",
	)

/datum/species/tajaran/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "paw",
			SPECIES_PERK_NAME = "Catlike Grace",
			SPECIES_PERK_DESC = "Due to the combination of their whiskers, tail(s) and an excellent \
				vestibular system, instead of being knocked down from falling, Tajarans only receive \
				a short slowdown. Conveniently, this means Tajarans are unhurt by high falls.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "Sensitive Hearing",
			SPECIES_PERK_DESC = "Tajarans are more sensitive to loud sounds, such as flashbangs.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "shower",
			SPECIES_PERK_NAME = "Hydrophobia",
			SPECIES_PERK_DESC = "Due to their innate instincts to avoid water from living in cold \
				climates, Tajarans tend to not like getting soaked with water.",
		),
	)
