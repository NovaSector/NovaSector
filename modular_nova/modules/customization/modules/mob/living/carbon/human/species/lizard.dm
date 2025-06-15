/datum/species/lizard
	mutant_bodyparts = list()
	mutant_organs = list()
	payday_modifier = 1.0

/datum/species/lizard/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Smooth", TRUE),
		"snout" = list("Sharp + Light", TRUE),
		"spines" = list("Long + Membrane", TRUE),
		"frills" = list("Short", TRUE),
		"horns" = list("Curled", TRUE),
		"body_markings" = list("Light Belly", TRUE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"taur" = list("None", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/lizard/get_species_description()
	return "The Tizirans, Unathi, and Ashwalkers encountered on the frontier share a common heritage. Each trace their lineage back to the arid aquifer world of Tizira. \
		The earliest recorded evidence of what would be considered recognizably Tiziran culture dates back around 2200-2400 years before mankind first developed FTL capability."

/datum/species/lizard/get_species_lore()
	return list(
		"The Tizirans, an ancient lizard-like species, originated on the desert world of Tizira and developed a complex society rooted in spirituality and nature. \
			Their history is marked by two major ideologies: the Daysong Way, focused on collective action and unity, and Takuhism, emphasizing personal growth and \
			harmony with nature. Over centuries, Tiziran society evolved from nomadic clans to an advanced civilization, achieving space travel by the 2360s. However, \
			internal divisions deepened between the two philosophies, leading to a cultural schism. As the Tizirans began colonizing space, factions broke away, forming \
			the Unathi and Ashwalkers. This split weakened their unity, ultimately contributing to their vulnerability during the Terran War—a devastating conflict with \
			humanity that shattered their moon, Atra'Kor, and left their civilization in turmoil.",
		"During the Terran War, the Tizirans fought a brutal conflict with humanity over territory and survival, which culminated in the destruction of their sacred moon, \
			Atra'Kor. This event caused massive devastation to their home planet and deeply scarred their society. The war ended with the Sagittarius Accords, which imposed a \
			demilitarized zone (DMZ) and heavy trade restrictions on the Tizirans, limiting their expansion and influence. In the aftermath, the Tiziran government collapsed, \
			giving rise to the Talunan Imperium. The Imperium is a more decentralized system, with power divided between the Imperial Throne and local Wards, which handle daily \
			governance. The Imperium focuses on rebuilding, maintaining a strong military presence, and carefully managing relations with other species—especially their allies, \
			the Teshari—while remaining distrustful of humanity and other outsiders.",
		"Having taken up their original charter of making contact with their wayward kin—lost in the great exodus following Tizira's first foray into FTL travel—the Expeditionary \
			Corps is once again chasing leads on the Ashwalkers and Unathi. Reports of neolithic reptiles living on the magma world of Indecipheres have piqued the interest of the \
			Expedition, which has set about establishing a presence on the frontier to investigate the matter.",
		"Talunan flagged vessels are prohibited from crossing the DMZ per the Sagittarius Accords. As a result, there is no official Talunan presence North of their border \
			with SolFed. Unofficially the joint Tiziro-Teshari arm of the Expeditionary Corps acts to fulfill Talunan objectives in and beyond human space.",
		"Having taken up their original charter of making contact with their wayward kin which where lost in the great exodus following Tizira's first foray into FTL travel, \
			the Expeditionary Corps is once again chasing leads on the Ashwalkers and Unathi. Reports of neolithic reptiles living on the magma world of Indecipheres has piqued \
			the interest of the Expedition, which has set about establishing a presence on the frontier to investigate the matter.",
			"Apart from their archeological mission, the Corps is also called upon from time to time to transport or otherwise protect Talunan citizens living outside of the \
			Imperium. Deniable operations to safeguard or extricate Tizirans in what is considered at home to be hostile space are not uncommon.",
	)

/datum/species/lizard/ashwalker/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/silverscale/get_default_mutant_bodyparts()
	var/list/default_parts = ..()
	default_parts["spines"] = list("None", TRUE)
	return default_parts

/datum/species/lizard/randomize_features()
	var/list/features = ..()
	var/main_color = "#[random_color()]"
	var/second_color
	var/third_color
	var/random = rand(1,3)
	switch(random)
		if(1) //First random case - all is the same
			second_color = main_color
			third_color = main_color
		if(2) //Second case, derrivatory shades, except there's no helpers for that and I dont feel like writing them
			second_color = main_color
			third_color = main_color
		if(3) //Third case, more randomisation
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = third_color
	return features

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#009999")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Aquatic", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features["legs"] = "Normal Legs"
	regenerate_organs(lizard, src, visual_only = TRUE)
	lizard.update_body(TRUE)

/datum/species/lizard/ashwalker
	always_customizable = TRUE
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
	)


/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000")
	. = ..(lizard, lizard_color)


/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee")
	lizard.set_eye_color("#0000a0")
	. = ..(lizard, lizard_color)
