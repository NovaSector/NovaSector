/datum/species/shadow
	name = "Shadowling"
	plural_form = "Shadowlings"
	mutantheart = /obj/item/organ/heart/hemophage/shadow
	mutantliver = /obj/item/organ/liver/hemophage
	mutantstomach = /obj/item/organ/stomach/hemophage
	mutanttongue = /obj/item/organ/tongue/hemophage
	mutantlungs = /obj/item/organ/lungs
	mutantappendix = null
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	exotic_bloodtype = BLOOD_TYPE_UNIVERSAL
	sexes = TRUE

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_DRINKS_BLOOD,
	)

/datum/species/shadow/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_SNOUT = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_EARS = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_TAUR = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_HORNS = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_WINGS = list(SPRITE_ACCESSORY_NONE, FALSE),
		FEATURE_LEGS = list(NORMAL_LEGS, FALSE),
	)

/datum/species/shadow/allows_food_preferences()
	return FALSE

/datum/species/shadow/create_pref_blood_perks()
	var/list/to_add = list()
	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Universal Blood",
		SPECIES_PERK_DESC = "[plural_form] have blood that appears to be an amalgamation of all other \
							blood types, made possible thanks to some special antigens produced by \
							their tumor, making them able to receive blood of any other type, so \
							long as it is still human-like blood.",
		),
	)

/datum/species/shadow/on_species_gain(mob/living/carbon/human/human_owner, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	// update the species bodypart index to be digitigrade if applicable
	if(human_owner.dna.features[FEATURE_LEGS] == DIGITIGRADE_LEGS)
		human_owner.dna.species.bodypart_overrides[BODY_ZONE_R_LEG] = /obj/item/bodypart/leg/right/digitigrade/shadow
		human_owner.dna.species.bodypart_overrides[BODY_ZONE_L_LEG] = /obj/item/bodypart/leg/left/digitigrade/shadow

/datum/species/shadow/get_species_description()
	return "Victims of a long extinct space alien. Their flesh is a sickly \
		seethrough filament, their tangled insides in clear view. Their form \
		is a mockery of life, leaving them mostly unable to work with others under \
		normal circumstances."

/datum/species/shadow/get_species_lore()
	return list(
		"Long ago, the Spinward Sector used to be inhabited by terrifying aliens aptly named \"Shadowlings\" \
		after their control over darkness, and tendancy to kidnap victims into the dark maintenance shafts. \
		Around 2558, the long campaign Nanotrasen waged against the space terrors ended with the full extinction of the Shadowlings.",

		"Victims of their kidnappings would become brainless thralls, and via surgery they could be freed from the Shadowling's control. \
		Those more unlucky would have their entire body transformed by the Shadowlings to better serve in kidnappings. \
		Unlike the brain tumors of lesser control, these greater thralls could not be reverted.",

		"With Shadowlings long gone, their will is their own again. But their bodies have not reverted, burning in exposure to light. \
		Nanotrasen has assured the victims that they are searching for a cure. No further information has been given, even years later. \
		Most shadowpeople now assume Nanotrasen has long since shelfed the project.",
	)

/datum/species/shadow/create_pref_unique_perks()
	. = ..()
	var/list/to_add = list()
	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "droplet",
			SPECIES_PERK_NAME = "Hemophagism",
			SPECIES_PERK_DESC = "They hunger for the blood of living beings, \
				dependant on draining it from them to satiate their own need.",
		),
	)
	return to_add

/datum/species/shadow/nightmare
	mutantheart = /obj/item/organ/heart/hemophage/shadow
	no_equip_flags = /datum/species/shadow::no_equip_flags

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_DRINKS_BLOOD,
	)
