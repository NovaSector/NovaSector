/datum/species/unathi
	name = "Unathi"
	id = SPECIES_UNATHI
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID

	mutanttongue = /obj/item/organ/tongue/unathi
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_LIZARD

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

/datum/species/unathi/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_TAIL = MUTPART_BLUEPRINT("Smooth", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT("Sharp + Light", is_randomizable = TRUE),
		FEATURE_SPINES = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_HORNS = MUTPART_BLUEPRINT("Curled", is_randomizable = FALSE),
		FEATURE_MARKING_GENERIC = MUTPART_BLUEPRINT("Smooth Belly", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/obj/item/organ/tongue/unathi
	liked_foodtypes = GORE | MEAT | SEAFOOD | NUTS
	disliked_foodtypes = GRAIN | DAIRY | CLOTH | GROSS
	toxic_foodtypes = TOXIC


/datum/species/unathi/randomize_features()
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of green or brown colors, with a darker secondary and tertiary
	switch(random)
		if(1)
			main_color = "#11CC00"
			second_color = "#118800"
		if(2)
			main_color = "#55CC11"
			second_color = "#55AA11"
		if(3)
			main_color = "#77AA11"
			second_color = "#668811"
		if(4)
			main_color = "#886622"
			second_color = "#774411"
		if(5)
			main_color = "#33BB11"
			second_color = "#339911"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = second_color
	features[FEATURE_MUTANT_COLOR_THREE] = second_color
	return features

//TODO: be smug that there was a bug here
/datum/species/unathi/get_species_description()
	return "The Tizirans, Unathi, and Ashwalkers encountered on the frontier share a common heritage. Each trace their lineage back to the arid aquifer world of Tizira. \
		The earliest recorded evidence of what would be considered recognizably Tiziran culture dates back around 2200-2400 years before mankind first developed FTL capability. \
		The Unathi can be differentiated by their digitigrade (flat) feet and their stronger tolerance for the cold weightlessness of space."

/datum/species/unathi/get_species_lore()
	return list(
		"https://wiki.novasector13.com/wiki/Lore:Unathi", //I don't know why the Tiziran author chose to separate lines to roughly 160 characters. Was this intended to be tweeted?
		"Unathi are a diaspora of clans spread across a smudge of the Orion Arm of the Milky Way six thousand two hundred light years long, which expands outwards in \
			generally one direction - away from Tizira. Loosely descended from a single exodus from their evolutionary homeworld, none of the Unathi are particularly \
			keen on discussing why they left, nor why they do not rebuild the bridge burnt rashly half a millennium ago. ",
		"The Tizirans, an ancient lizard-like species, originated on the desert world of Tizira and developed a complex society rooted in spirituality and nature. \
			Their history is marked by two major ideologies: the Daysong Way, focused on collective action and unity, and Takuhism, emphasizing personal growth and \
			harmony with nature. Over centuries, Tiziran society evolved from nomadic clans to an advanced civilization, achieving space travel by the 2360s. However, \
			internal divisions deepened between the two philosophies, leading to a cultural schism. As the Tizirans began colonizing space, factions broke away, forming \
			the Unathi and Ashwalkers. This split weakened their unity, ultimately contributing to their vulnerability during the Terran War—a devastating conflict with \
			humanity that shattered their moon, Atra'Kor, and left their civilization in turmoil.",
		"Leaving Tizira over 500 years ago, the Unathi took to the stars, spreading their ways from Tizira, trailing (against the spin) around the Milky Way. Numerous Unathi \
			colonies litter the galaxy, each championed by a few Clans. Rather than a large migratory cluster slowly depositing complacent stragglers, the diaspora spread organically \
			from their chosen homeworld of Moghes. Every so often, a smaller clan will leave their present settlement, via resentment, politicks, a failed coup, etc., and take to the \
			stars to build their own colony elsewhere. The more successful a colony, generally, the fewer clans there are sharing it - with notable exceptions such as Unmatil, with eight clans, and Lazskc, with eleven.",

		"These are an artful and creative bunch - Unathi civilian designs are known for incredibly ornate, beautiful patterns, landscapes, and portraits renowned the galaxy \
			over. Their art assumes many styles, and Unathi artisans are encouraged to pursue self expression as well as represent the distinct feel of their clan. This leads to \
			vibrant color palettes with intense shading, with popular subjects of contemporary Unathi artwork frequently revolving around expansionism, warfare, and glory, \
			accompanied by a pervasive undertone of regret and hollow achievements.",
		"Core to the clans of Unathi are their historical achievements stemming back to the beginning of the diaspora. Great effort is taken to compose orchestras, songs, \
		 	and music which honors this past. Unathi composers are famous for their painstaking attention to detail and complex, beautiful melodies found enjoyable by many across \
		 	the galaxy. Collaboration with artists of all starfaring civilizations, spreading the reach of Unathi music, is highly accepted within broad Unathi culture in their \
		 	journey to create the perfect music to encapsulate the vibe of each clan, and show respect to their ancestors.",
		"Sitting in stark contrast, martial and governmental structures are often megalithic things, extremely minimalistic and harsh in design; in the case of the most wealthy \
			clans, jutting above the horizon in at least some capacity, aiming to project stubbornness and ruggedness to any who approach. These decisions are a form of artistic \
			expression as well - simply very on the nose.",

		"Having taken up their original charter of making contact with their wayward kin—lost in the great exodus following Tizira's first foray into FTL travel—the Expeditionary \
			Corps is once again chasing leads on the Ashwalkers and Unathi. Reports of neolithic reptiles living on the magma world of Indecipheres have piqued the interest of the \
			Expedition, which has set about establishing a presence on the frontier to investigate the matter.",
		"Having taken up their original charter of making contact with their wayward kin which where lost in the great exodus following Tizira's first foray into FTL travel, \
			the Expeditionary Corps is once again chasing leads on the Ashwalkers and Unathi. Reports of neolithic reptiles living on the magma world of Indecipheres has piqued \
			the interest of the Expedition, which has set about establishing a presence on the frontier to investigate the matter.",
	)
