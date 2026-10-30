/datum/species/vulpkanin
	name = "Vulpkanin"
	id = SPECIES_VULP
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

	mutanttongue = /obj/item/organ/tongue/vulpkanin
	species_language_holder = /datum/language_holder/vulpkanin
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_MAMMAL
	meat = /obj/item/food/meat/slab/corgi
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

/datum/species/vulpkanin/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Fox", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Mammal, Long", is_randomizable = TRUE),
		FEATURE_EARS = MUTPART_BLUEPRINT("Fox", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/obj/item/organ/tongue/vulpkanin
	liked_foodtypes = RAW | MEAT
	disliked_foodtypes = CLOTH
	toxic_foodtypes = TOXIC


/datum/species/vulpkanin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly brightish, animal, matching colors
	switch(random)
		if(1)
			main_color = "#FFAA00"
			second_color = "#FFDD44"
		if(2)
			main_color = "#FF8833"
			second_color = "#FFAA33"
		if(3)
			main_color = "#FFCC22"
			second_color = "#FFDD88"
		if(4)
			main_color = "#FF8800"
			second_color = "#FFFFFF"
		if(5)
			main_color = "#999999"
			second_color = "#EEEEEE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

/datum/species/vulpkanin/get_random_body_markings(list/passed_features)
	var/name = pick("Fox", "Floof", "Floofer")
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vulpkanin/get_species_description()
	return "Vulpkanin are often described as 'misleadingly similar to human foxes'. Their outward appearance is typical - four limbs, two eyes, a mouth, the likes of most sapient life found in the known galaxy."

/datum/species/vulpkanin/get_species_lore()
	return list(
		"While most furred animals form Keratin to produce body hair, Vulpkanin instead produce fur made out of Spidroin. While this insulates them much better, this protein is quite more flammable and may rapidly catch on fire if exposed. Vulpkanin are equally capable of producing such proteins via glands located all over their skin. This not only allows them to rapidly regrow burnt fur but also weave complex patterns from their hands, which evolved as a method to secure shelter during the formative years of their existance.",

		"Their legs' muscular and vascular structures allows every vulpkanin to 'leap' a distance forward, far further than a baseline human can typically lunge. Special tendons, pressure sacs and hollow tibias combine together to allow a sudden end to any chase. Their recovery from said tackles tend to not be any better than a baseline human's, however.",

		"Vulpkanen no longer have a single homeworld. When their star unexpectedly turned supernova, Vulpkanen who could flee did so in 'The Exodus.' Prior to the Exodus, Vulpkanin were competitively monarchical, with over a thousand kings fighting at any given time. This eventually gave rise to the Zealot-King, sole leader of their homeworld. Tto be a Zealot-King, one had to be physically, mentally, and spiritually strong, a rather obvious display of how old the Vulpkanin self-betterment doctrine is. They were typically the strongest warlord on their homeworld, capable of holding a stake on the Zealot’s throne by force alone. In this case, the most relevant and logistics-capable of them had started a several hundred years regime change into an absolute monarchy, former generals becoming advisers, advisers becoming jurors. The last Zealot-King was known as Setath Sho Rhell-Zennha, a prime mover in the Vulpkanin Exodus.",

		"For their failures in preventing the Exodus, Setath Sho Rhell-Zennha was executed on live television. he downfall of royalty in the Post-Exodus Vulpkanin era - what is now known as the ‘Modern’ era - has deeply affected its culture: not only has it shifted the focus of excellence from a single member of society to its entire populace, it has led to the actual use of 'noble' terms as an insulting, demeaning adjective for things. Pretending to have royal blood is a social death sentence for a Vulpkanin. With the death of the Zealot-King, the only remaining upper echelon of leaders within Vulpkanin society were the Advisors of the Vulpkan’aan court. ",

		"Practice of Vulpkanin star worship varied from person to person, as each Vulpkanin alive tended to congregate around worship of a particular star’s assigned deity. A common ritual by Vulpkanin astrologers past the invention of electricity was to use keen instruments to essentially listen into a star’s output of radio waves, divining messages from what was called ‘celestial noise.’ This pattern of low-frequency noise would be adjusted, tuned, and remixed until coherent patterns were made more obvious; used for ritual, future-telling, and sometimes even to name children, all by assigning certain patterns to different motions of the body used in the non-verbal communication aspects of Canilunzt. Most contemporary Vulpkanin music would use the output of different stars as a sort of ‘bassline’, thought to promote healthy living. Different positions of their homeworld’s moons over their sun would hold great significance in astrology as well, an equivalent of human zodiac signs previously existing based on what shape the moons would create, depicted as different circular drawings. "
	)

/datum/species/vulpkanin/prepare_human_for_preview(mob/living/carbon/human/vulp)
	var/main_color = "#FF8800"
	var/second_color = "#FFFFFF"

	vulp.dna.features[FEATURE_MUTANT_COLOR] = main_color
	vulp.dna.features[FEATURE_MUTANT_COLOR_TWO] = second_color
	vulp.dna.features[FEATURE_MUTANT_COLOR_THREE] = second_color
	vulp.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part("Mammal, Long", list(main_color, main_color, main_color))
	vulp.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Husky", list(second_color, main_color, main_color))
	vulp.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Wolf", list(main_color, second_color, second_color))
	regenerate_organs(vulp, src, visual_only = TRUE)
	vulp.update_body(TRUE)
