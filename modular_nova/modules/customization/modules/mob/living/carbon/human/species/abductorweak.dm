/datum/species/abductor/abductorweak
	name = "Rogue"
	id = SPECIES_ABDUCTORWEAK
	examine_limb_id = SPECIES_ABDUCTOR
	sexes = TRUE
	inherent_traits = list(
		TRAIT_CHUNKYFINGERS_IGNORE_BATON,
		TRAIT_NOBREATH,
		TRAIT_NOHUNGER,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
	)

/datum/species/abductor/abductorweak
	disallow_customizable_dna_features = FALSE

	mutanttongue = /obj/item/organ/tongue/abductor
	mutantheart = /obj/item/organ/heart
	mutantstomach = null
	mutantlungs = null
	mutantbrain = /obj/item/organ/brain/abductor
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/abductor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/abductor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/abductor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/abductor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/abductor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/abductor,
	)

/datum/species/abductor/abductorweak/get_physical_attributes()
	return "Rogues do not need to breathe, eat, have a stomach, or lungs but their naturally chunky tridactyl hands make it hard to operate generic equipment."

/datum/species/abductor/abductorweak/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.show_to(human_who_gained_species)

/datum/species/abductor/abductorweak/on_species_loss(mob/living/carbon/human/former_rogue, datum/species/new_species, pref_load)
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.hide_from(former_rogue)

/datum/species/abductor/abductorweak/get_species_description()
	return list(
		"Rogues are naturally three fingered, pale skinned inquisitive aliens who can't communicate well to the average crew-member \
		without either a Text-To-Speech device or a replacement voicebox. They originate from the Abductors, but know little more than the average crewman.",
	)

/datum/species/abductor/abductorweak/get_species_lore()
	return list(
		"The Rogues are a, as the name implies, rogue offshoot of the Abductors. \
		While they themselves do not abduct or experiment on other species, generally, the stigma \
			associated with their progenitors is something all Rogues have to deal with if they do not undergo \
			any form of cosmetic changes. And many do opt in for cosmetic changes, being almost unrecognizable as Rogues \
			but still holding that innate need for discovery or change. All of the Original Rogues had their memories of the \
			Abductors seemingly removed before fleeing, and the future generations were told no stories of their origins.",
	)

/datum/species/abductor/abductorweak/create_pref_traits_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_WIND,
		SPECIES_PERK_NAME = "Lungs Optional",
		SPECIES_PERK_DESC = "Rogues don't need to breathe, though exposure to a vacuum is still a hazard. \
			Some Rogues elect to have new lungs placed inside them, usually for some degree of expression, more rarely for experimentation.",
	))
	return perks

/datum/species/abductor/abductorweak/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK, // It may be a stretch to call nohunger a neutral perk but the Abductor's tongue describes it as much, so.
		SPECIES_PERK_ICON = FA_ICON_UTENSILS,
		SPECIES_PERK_NAME = "Hungry for Knowledge",
		SPECIES_PERK_DESC = "Rogues have a greater hunger for knowledge and expression than food, and as such don't need to eat. \
			Which is fortunate, as their natural speech matrix prevents them from consuming food.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_VOLUME_XMARK,
		SPECIES_PERK_NAME = "Superlingual Matrix",
		SPECIES_PERK_DESC = "Rogues cannot physically speak with their natural tongue. \
			They instead naturally communicate telepathically to other Rogues, a process which all other species cannot hear. \
			Great for secret conversations, not so great for ordering something from the bar. \
			Many Rogues who plan to leave their homes or join another species usually replace their matrix with a cybernetic or replacement voice box.",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HANDSHAKE_SLASH,
		SPECIES_PERK_NAME = "Tridactyl Hands",
		SPECIES_PERK_DESC = "Rogue hands are not designed for human equipment. Utilizing the station's equipment is difficult for them.\
		Some Rogues often replace their natural hands with cybernetic hands, or genetically augment themselves and change their hands to something else.",
	))
	return perks


/obj/item/firing_pin/abductor/pin_auth(mob/living/user)
	. = ..()
	if(.)
		return

	return isrogue(user) // Lets rogues use them as well as abductors
