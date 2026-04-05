//TODO: fix names

//Instead of just slapping a pure damage reduction I'm giving them armor instead, difference is that it can be pierced by weapons and stuff
/datum/armor/polysmorph
	melee = 15
	bullet = 10
	wound = 25 //strong bones, not giving them full blunt immunity
	acid = 80 //their blood is literally acid

//Stronger legs, or something like that
/datum/movespeed_modifier/polysmorph
	movetypes = GROUND
	multiplicative_slowdown = -0.1 //10% faster

/datum/actionspeed_modifier/polysmorph
	multiplicative_slowdown = 0.1 //10% slower

//ACTUAL SPECIES CODE HERE
/mob/living/carbon/human/species/polysmorph
	race = /datum/species/polysmorph

/datum/species/polysmorph
	id = SPECIES_POLYSMORPH
	name = "Polysmorph"
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_ACIDBLOOD,
	)
	family_heirlooms = list(
		/obj/item/toy/plush/rouny,
		/obj/item/clothing/mask/facehugger/toy
		)

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	coldmod = 0.75
	heatmod = 1.5
	species_language_holder = /datum/language_holder/polysmorph
	exotic_bloodtype = BLOOD_TYPE_POLYSMORPH
	meat = /obj/item/food/meat/slab/xeno
	skinned_type = /obj/item/stack/sheet/animalhide/xeno
	gib_anim = "gibbed-a"
	species_cookie = /obj/item/food/meat/slab

	digitigrade_customization = DIGITIGRADE_OPTIONAL //'technically' optional, both types are digi
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/polysmorph,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/polysmorph,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/polysmorph,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/polysmorph,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/polysmorph,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/polysmorph,
	)

	mutantbrain = /obj/item/organ/brain/polysmorph
	mutanteyes = /obj/item/organ/eyes/polysmorph
	mutanttongue = /obj/item/organ/tongue/polysmorph
	mutantliver = /obj/item/organ/liver/polysmorph
	mutantstomach = /obj/item/organ/stomach/polysmorph
	mutantlungs = /obj/item/organ/lungs/polysmorph
	mutantheart = /obj/item/organ/heart/polysmorph
	mutantappendix = null
	mutant_organs = list(
		/obj/item/organ/alien/plasmavessel/roundstart,
		/obj/item/organ/alien/resinspinner/roundstart,
		/obj/item/organ/alien/hivenode_polysmorph,
		)

/datum/species/polysmorph/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Polysmorph Tail", is_randomizable = FALSE),
		FEATURE_XENODORSAL = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE),
		FEATURE_XENOHEAD = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = TRUE),
	)

/datum/species/polysmorph/on_species_gain(mob/living/carbon/human/polysmorph, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	polysmorph.physiology.armor = polysmorph.physiology.armor.add_other_armor(/datum/armor/polysmorph)
	polysmorph.add_movespeed_modifier(/datum/movespeed_modifier/polysmorph)
	polysmorph.add_actionspeed_modifier(/datum/actionspeed_modifier/polysmorph)

/datum/species/polysmorph/on_species_loss(mob/living/carbon/human/polysmorph, datum/species/new_species, pref_load)
	. = ..()
	polysmorph.physiology.armor = polysmorph.physiology.armor.subtract_other_armor(/datum/armor/polysmorph)
	polysmorph.remove_movespeed_modifier(/datum/movespeed_modifier/polysmorph)
	polysmorph.remove_actionspeed_modifier(/datum/actionspeed_modifier/polysmorph)

/datum/species/polysmorph/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.dna.features["mcolor"] = "#444466"
	human_for_preview.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Polysmorph Tail", MUTANT_INDEX_COLOR_LIST = list("#444466", "#FFFFFF", "#FFFFFF"))
	human_for_preview.dna.mutant_bodyparts["xenodorsal"] = list(MUTANT_INDEX_NAME = "Polysmorph Double", MUTANT_INDEX_COLOR_LIST = list("#444466", "#FFFFFF", "#FFFFFF"))
	human_for_preview.dna.mutant_bodyparts["xenohead"] = list(MUTANT_INDEX_NAME = "Polysmorph Queen", MUTANT_INDEX_COLOR_LIST = list("#444466", "#FFFFFF", "#FFFFFF"))
	regenerate_organs(human_for_preview)
	human_for_preview.update_body(is_creating = TRUE)

/datum/species/polysmorph/get_species_description()
	return "https://web.archive.org/web/20250430125713/https://wiki.yogstation.net/wiki/Polysmorph"

/datum/species/polysmorph/get_species_lore()
	return list(
		"The final failures in the attempts at creating xenomorphs hybrids to access the alien hivemind, polysmorphs were spawned \
		in now-abandoned planetary and space colonies where they were studied. After it was discovered that the hybrids had their \
		link to the hivemind cut, the project that birthed them was abandoned.",

		"While deprived of the link to the hivemind, polysmorphs still retain an instinctual tendency toward certain roles \
		depending on their dome. Drones tend to be workers, sentinels lean toward military and law enforcement, praetorians \
		generally take care of logistics and management, and queens are drawn to scientific research.",

		"As of today, the polysmorphs are scattered across the stars, working along other species. Those who couldn't \
		adapt have been relegated to menial jobs in remote locations and their situation is mostly unknown.",
	)

/datum/species/polysmorph/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "running",
		SPECIES_PERK_NAME = "Predator Genes",
		SPECIES_PERK_DESC = "Polysmorphs keep a fraction of the agility found in their xenomorph ancestors. \
							Their movement speed is slightly faster than most races.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "low-vision",
		SPECIES_PERK_NAME = "Darkvision",
		SPECIES_PERK_DESC = "Polysmorphs have an advanced set of eyes hidden inside their domed head. \
							These eyes can see much better in the darkness than the average crewmember.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "lungs",
		SPECIES_PERK_NAME = "Devolved Vessels",
		SPECIES_PERK_DESC = "Polysmorphs have a set of plasma vessels, degraded and fused with human lungs through the spawning process. \
							This mutated organ lets polysmorphs breathe both plasma and oxygen safely, but is easily hurt from breathing in hot air.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "bone",
		SPECIES_PERK_NAME = "Exoskeletal",
		SPECIES_PERK_DESC = "Polysmorphs have a rigid exoskeleton lining their bodies, making them harder to wound.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "filter",
		SPECIES_PERK_NAME = "Reckless Filtration",
		SPECIES_PERK_DESC = "Polysmorphs have alien livers capable of filtering out toxins much faster than most races. \
							Despite this, it's not very tough, and takes more damage from processing too many toxins at once.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "commenting",
		SPECIES_PERK_NAME = "Alien Ssssspeech",
		SPECIES_PERK_DESC = "Polysmorphs have a mouthed tongue similar to xenomorphs, but without the teeth. \
							They have a tendency to hisssss when ssssspeaking.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "wrench",
		SPECIES_PERK_NAME = "Indextrous",
		SPECIES_PERK_DESC = "Polysmorphs have large claw-like fingers built for slicing rather than quick or precise motions. \
							They use tools and items a bit slower than most races.",
	))

	return perk_descriptions
