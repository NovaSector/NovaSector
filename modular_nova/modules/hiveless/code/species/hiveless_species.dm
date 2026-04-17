/// Species fueled by a protein bank, with intrinsic biological abilities.
/datum/species/humanoid/hiveless
	name = "Hiveless"
	id = SPECIES_HIVELESS
	/// Ability types granted and revoked with this species.
	var/static/list/ability_types = list(
		/datum/action/cooldown/spell/hiveless/arm_blade,
		/datum/action/cooldown/spell/hiveless/chitinous_armor,
		/datum/action/cooldown/spell/hiveless/spine_spit,
		/datum/action/cooldown/spell/hiveless/regenerate,
		/datum/action/cooldown/spell/hiveless/shriek,
		/datum/action/cooldown/spell/hiveless/fleshmend,
		/datum/action/cooldown/spell/hiveless/shapeshift,
	)
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
		"Rejected from both society and family, these free-thinkers infiltrate cultures not out of malice, \
		but survival. Changelings are a biological scourge born from failed Ordoht terraforming, who cluster \
		into hives and devour flesh of all kinds through shapeshifting, infiltration, and force. Hiveless \
		Changelings have been cast out from their hive, through defect or politic, and thus wield much less \
		destructive power. Disconnected from the hive they were birthed from, they cannot easily assimilate \
		new DNA and transform, and serve no greater purpose.",

		"To the galaxy, they are a terror, a bioweapon claiming pacifism or incapability as a pathetic \
		trick to better end all life in the galaxy. To fully-hived Changelings, they are rejects, possibly \
		traitors, but most importantly: defenseless biomass. To Nanotrasen, they are an opportunity. A \
		small number of Hiveless took the risk of exposing themselves to Corporate in a plea for asylum, \
		and shockingly were granted refuge.",

		"Nanotrasen holds a database of permitted Hiveless and their assumed disguises, allowing them to \
		serve aboard NT stations across the Frontier as standard employees. These registered disguises \
		include deceased NT employees, freshly-invented persons, and occasionally consensual impersonations \
		of willing adults. Corporate keeps their database a tight secret from their many enemies and from \
		SolFed, but for some, the risk is still too high to defect.",
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
	for(var/ability_path in ability_types)
		if(locate(ability_path) in gainer.actions)
			continue
		var/datum/action/cooldown/spell/ability = new ability_path(gainer)
		ability.Grant(gainer)
	make_brain_decoy(gainer)

/datum/species/humanoid/hiveless/on_species_loss(mob/living/carbon/human/loser, datum/species/new_species, pref_load)
	for(var/ability_path in ability_types)
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
