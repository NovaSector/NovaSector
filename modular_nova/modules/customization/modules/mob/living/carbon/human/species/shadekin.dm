/// Maximum HSV value (brightness) allowed for shadekin colors. Range is 0-100.
#define SHADEKIN_MAX_BRIGHTNESS 35

/datum/species/shadekin
	name = "Shadekin"
	id = SPECIES_SHADEKIN
	mutanttongue = /obj/item/organ/tongue/shadekin
	mutantears = /obj/item/organ/ears/shadekin
	mutantbrain = /obj/item/organ/brain/shadekin
	mutanteyes = /obj/item/organ/eyes/shadekin
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	species_language_holder = /datum/language_holder/shadekin
	language_prefs_whitelist = list(/datum/language/marish/empathy = TRUE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
		TRAIT_NIGHT_VISION,
		TRAIT_NOBREATH,
	)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/shadekin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/shadekin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/shadekin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/shadekin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/shadekin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/shadekin,
	)

/datum/species/shadekin/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Shade", is_randomizable = TRUE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_EARS = MUTPART_BLUEPRINT("Shade Ears", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = TRUE, is_feature = TRUE),
	)

/datum/species/shadekin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lightbulb",
		SPECIES_PERK_NAME = "Dark Regeneration",
		SPECIES_PERK_DESC = "Shadekins regenerate their physical wounds while in the darkness.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "crutch",
		SPECIES_PERK_NAME = "Light Averse",
		SPECIES_PERK_DESC = "Shadekins move slightly slower while in the light.",
	))

	return to_add

/// Clamps a hex color's brightness (HSV value) to SHADEKIN_MAX_BRIGHTNESS.
/datum/species/shadekin/proc/clamp_color_brightness(color)
	if(!color)
		return "#000000"
	var/list/hsv = rgb2num(color, COLORSPACE_HSV)
	if(hsv[3] > SHADEKIN_MAX_BRIGHTNESS)
		hsv[3] = SHADEKIN_MAX_BRIGHTNESS
		return rgb(hsv[1], hsv[2], hsv[3], space = COLORSPACE_HSV)
	return color

/// Clamps all mutant colors and bodypart colors on the target to max brightness.
/datum/species/shadekin/proc/clamp_primary_colors(mob/living/carbon/human/target)
	// Clamp the primary mutant color, which is what is used for the bodyparts
	target.dna.features[FEATURE_MUTANT_COLOR] = clamp_color_brightness(target.dna.features[FEATURE_MUTANT_COLOR])

	// Clamp primary mutant color on all mutant bodyparts (ears, tail, horns, etc.)
	for(var/part_key, part_entry in target.dna.mutant_bodyparts)
		var/datum/mutant_bodypart/part = part_entry
		if(!istype(part))
			continue
		part.set_primary_color(clamp_color_brightness(part.get_primary_color()))

	// Update draw_color on bodypart overlays so they reflect the clamped colors
	for(var/obj/item/bodypart/bodypart as anything in target.bodyparts)
		for(var/datum/bodypart_overlay/mutant/overlay in bodypart.bodypart_overlays)
			if(!overlay.feature_key)
				continue
			var/datum/mutant_bodypart/mutant_part = target.dna.mutant_bodyparts[overlay.feature_key]
			if(!istype(mutant_part))
				continue
			overlay.set_appearance_from_dna(target.dna)

/datum/species/shadekin/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	clamp_primary_colors(target)

/datum/species/shadekin/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#202020"
			secondary_color = "#303030"
			tertiary_color = "#2a2a2a"
		if(2)
			main_color = "#4a1225"
			secondary_color = "#521220"
			tertiary_color = "#3d1a2a"
		if(3)
			main_color = "#4a3a12"
			secondary_color = "#4a4218"
			tertiary_color = "#3d3820"
		if(4)
			main_color = "#3d1040"
			secondary_color = "#351250"
			tertiary_color = "#3a2035"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/shadekin/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(!pref_load)
		clamp_primary_colors(human_who_gained_species)

/datum/species/shadekin/prepare_human_for_preview(mob/living/carbon/human/shadekin)
	var/main_color = "#222222"
	var/secondary_color = "#383838"
	var/tertiary_color = "#383838"
	shadekin.dna.features[FEATURE_MUTANT_COLOR] = main_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	shadekin.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	shadekin.dna.mutant_bodyparts[FEATURE_EARS] = build_mutant_part("Shade Ears", list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_SNOUT] = build_mutant_part(SPRITE_ACCESSORY_NONE, list(main_color, secondary_color, tertiary_color))
	shadekin.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Shade", list(main_color, secondary_color, tertiary_color))
	shadekin.set_eye_color("#5ec7e4")
	regenerate_organs(shadekin, src, visual_only = TRUE)
	shadekin.update_body(TRUE)

/datum/species/shadekin/get_species_description()
	return list(
		"Shadekin first came about like dust bunnies that collect under a bed, of the collective consciousness \
		\"Welcome, sibling,\" the first words felt in a sea of thought, guiding them to their first connection. ",
		"Shadekin do not respirate, and their bodies are reformed in the darkness, although frail.",
	)

/datum/species/shadekin/get_species_lore()
	return list(
		"It is unclear when exactly Shadekin first spawned, though it is assumedly a relatively recent development. \
		They formed in dark and abandoned places where they are not witnessed-- observation would dispel their creation. \
		When the process completed, the Shadekin collected its ability to move its limbs and communicate from surrounding minds \
		and finally, it formed its first thought, the realization that it is alive.",

		"Shadekin are pitch darkness given form. Light seems to pass through their bodies, which tires them. They do not cast shadows. \
		Shadekin elude definition in terms of size and appearance, as no two Shadekin are the same-- they tend to take features from the species around them \
		that would otherwise not be seen as theirs. For example, Shadekin spawned in Tizira tend to have horns or frill-like ears. \
		An average Shadekin would be slightly shorter than a human, with a similar lifespan. Shadekin that do not use other species' naming conventions will \
		tend to name themselves after their place in the community, like a job or societal function.",

		"Shadekin are capable of reproducing sexually, though their minds need diverse surroundings to properly develop, making them fairly self-guided. \
		Despite this, Shadekin easily find a space of their own, and become staples of their communities. They are more expressive than other species to compensate for a lack of psionic connection. \
		Their language, Marish, is purely empathic and cannot be spoken by psychopaths. Their eye color is an important part of their biology, as it indicates temperament.",

		"A Shadekin is never truly alone, however, as Shadekin have formed in number on the treacherous moon Neoma, due to its darkness and isolation. \
		While there is no central Shadekin government, this is the closest thing Shadekin have to a homeworld, devoid of light due to its orbit around Lusine, an extremely hot world that keeps Neoma's surface approaching habitable. \
		It has become a notable tourist attraction in the few habitable areas. Neoma serves an important function of containing the collective knowledge of Shadekin society and its covens.",

		"Covens are groups of Shadekin formed to maintain themselves and records of their existence, as well as guide new Shadekin as they develop. \
		They are rarely associated with ideology alone, rather concepts and what they imply, and within a coven exist Coteries, interest groups within a coven, tailored to a specific aspect. \
		In this regard, covens are societies in and of themselves, organized in a somewhat tribal manner. Covens do not solely exist on Neoma, they are spread throughout the universe, \
		but most covens at least have archives on the moon, called \"Mindtrusts\".",
	)

#undef SHADEKIN_MAX_BRIGHTNESS
