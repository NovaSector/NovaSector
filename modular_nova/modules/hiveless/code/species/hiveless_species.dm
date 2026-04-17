/// Ability types granted and revoked with the hiveless species.
GLOBAL_LIST_INIT(hiveless_ability_types, list(
	/datum/action/cooldown/spell/hiveless/arm_blade,
	/datum/action/cooldown/spell/hiveless/chitinous_armor,
	/datum/action/cooldown/spell/hiveless/spine_spit,
	/datum/action/cooldown/spell/hiveless/regenerate,
	/datum/action/cooldown/spell/hiveless/shriek,
	/datum/action/cooldown/spell/hiveless/fleshmend,
	/datum/action/cooldown/spell/hiveless/shapeshift,
))

/// Crew-friendly species fueled by a protein bank, with intrinsic biological abilities.
/datum/species/humanoid/hiveless
	name = "Hiveless"
	id = SPECIES_HIVELESS
	mutantstomach = /obj/item/organ/stomach/hiveless
	mutanttongue = /obj/item/organ/tongue/hiveless
	meat = /obj/item/food/meat/slab/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	heatmod = 1.5
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_BRAINLESS_CARBON,
		TRAIT_CAN_STRIP,
		TRAIT_CHANGELING_HIVEMIND,
		TRAIT_FAKE_SOULLESS,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)

/datum/species/humanoid/hiveless/get_species_description()
	return "A Changeling severed from its Hive; born without one, forcibly purged, or left behind when a \
		Hive collapsed. Hiveless retain their kin's shapeshifting biology and residual psionic capabilities, \
		but without the Neural Chorus to guide them they act as independent agents... Often more sharply \
		self-aware than their tethered cousins, and just as often dangerously unstable."

/datum/species/humanoid/hiveless/get_species_lore()
	return list(
		"Not all Changelings belong to a Hive. Some are born without connection; others are intentionally \
		severed, forcibly purged, or left behind during Hive collapse events. These outliers are referred \
		to as Hiveless, and they represent one of the greatest unknowns in the SolFed's Changeling database.",

		"Hiveless Changelings retain psionic capabilities, including limited telepathy, but lack access \
		to the Neural Chorus that binds standard Hive minds together. Without this tether, they are cut \
		off from collective memory, directive guidance, and shared emotional resonance.",

		"Paradoxically, this disconnection amplifies individual sapience. Many Hiveless exhibit highly \
		developed personalities, independent goals, and complex reasoning skills, sometimes even emotional \
		nuance. However, this autonomy often comes at the cost of mental instability, identity crises, or \
		dangerously erratic behavior.",
	)

/datum/species/humanoid/hiveless/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "dna",
		SPECIES_PERK_NAME = "Inherited Biology",
		SPECIES_PERK_DESC = "Some vestigial shard from their previous hivemind still linger inside them,\
		granting them access to some manipulations of the flesh"
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "brain",
		SPECIES_PERK_NAME = "Vestigial Brain",
		SPECIES_PERK_DESC = "Decapitation or brain destruction won't kill a Hiveless, and they read as soulless and \
			brainless to certain scanners.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "comment-dots",
		SPECIES_PERK_NAME = "Residual Psionics",
		SPECIES_PERK_DESC = "Cut off from the Neural Chorus but not entirely silent. A Hiveless can still \
			cast a thought across the Changeling psionic network with the :g channel, reaching any kin \
			who still listens.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "drumstick-bite",
		SPECIES_PERK_NAME = "Obligate Carnivore",
		SPECIES_PERK_DESC = "Hiveless biology only accepts raw protein — meat, gore, seafood. Vegetables \
			and fruit are toxic. Without an incoming supply, their internal protein reserves drain \
			steadily until they start taking damage from hunger.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "fire",
		SPECIES_PERK_NAME = "Flammable Flesh",
		SPECIES_PERK_DESC = "Unstable biology burns readily. Hiveless take 50% more damage from heat and \
			fire sources, and most of their abilities are disabled while they are on fire.",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "syringe",
		SPECIES_PERK_NAME = "BZ Sensitivity",
		SPECIES_PERK_DESC = "BZ metabolites scramble what's left of a Hiveless's psionic network, shutting \
			down all of their biological abilities until the chemical clears their bloodstream.",
	))

	return to_add

/datum/species/humanoid/hiveless/prepare_human_for_preview(mob/living/carbon/human/human)
	. = ..()
	human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/changeling(human), ITEM_SLOT_OCLOTHING)
	human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/changeling(human), ITEM_SLOT_HEAD)
	human.update_body(TRUE)

/datum/species/humanoid/hiveless/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE, replace_missing = TRUE)
	. = ..()
	if(!ishuman(gainer))
		return
	for(var/ability_path in GLOB.hiveless_ability_types)
		if(locate(ability_path) in gainer.actions)
			continue
		var/datum/action/cooldown/spell/ability = new ability_path(gainer)
		ability.Grant(gainer)
	make_brain_decoy(gainer)

/datum/species/humanoid/hiveless/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	for(var/ability_path in GLOB.hiveless_ability_types)
		var/datum/action/cooldown/spell/ability = locate(ability_path) in loser.actions
		if(ability)
			qdel(ability)
	unmake_brain_decoy(loser)
	return ..()

/// Marks the carrier's brain as non-vital and decoy, so decapitation doesn't kill them.
/datum/species/humanoid/hiveless/proc/make_brain_decoy(mob/living/carbon/human/carrier)
	var/obj/item/organ/brain/brain = carrier.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!brain)
		return
	brain.organ_flags &= ~ORGAN_VITAL
	brain.decoy_override = TRUE

/// Restores the brain's vital flag when the species is lost.
/datum/species/humanoid/hiveless/proc/unmake_brain_decoy(mob/living/carbon/human/carrier)
	var/obj/item/organ/brain/brain = carrier.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!brain)
		return
	brain.organ_flags |= ORGAN_VITAL
	brain.decoy_override = FALSE
