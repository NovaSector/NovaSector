/// Iron blood type for proteans
/datum/blood_type/iron
	name = BLOOD_TYPE_IRON
	dna_string = "Iron"
	color = BLOOD_COLOR_IRON
	reagent_type = /datum/reagent/iron
	blood_flags = BLOOD_COVER_ALL

/datum/species/protean
	id = SPECIES_PROTEAN
	examine_limb_id = SPECIES_PROTEAN

	name = "Protean"
	sexes = TRUE

	siemens_coeff = 1.5 // Electricity messes you up.
	payday_modifier = 1 // 30 percent poorer

	exotic_bloodtype = BLOOD_TYPE_IRON
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	meat = /obj/item/stack/sheet/iron

	mutantbrain = /obj/item/organ/brain/protean
	mutantheart = /obj/item/organ/heart/protean
	mutantstomach = /obj/item/organ/stomach/protean
	mutantlungs = null
	mutantliver = /obj/item/organ/liver/protean
	mutantappendix = null
	mutanteyes = /obj/item/organ/eyes/robotic/protean
	mutantears = /obj/item/organ/ears/cybernetic/protean
	mutanttongue = /obj/item/organ/tongue/cybernetic/protean

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/protean,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/protean,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/protean,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/protean,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/protean,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/protean,
	)

	inherent_traits = list(
		// Default Species
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,

		// Needed to exist without dying and robot specific stuff.
		TRAIT_NOBREATH,
		TRAIT_ROCK_EATER,
		TRAIT_STABLEHEART,
		TRAIT_NOHUNGER,
		TRAIT_LIMBATTACHMENT,

		// Synthetic lifeforms
		TRAIT_GENELESS,
		TRAIT_NO_HUSK,
		TRAIT_NO_DNA_SCRAMBLE,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_SYNTHETIC,
		TRAIT_TOXIMMUNE,
		TRAIT_NEVER_WOUNDED,
		TRAIT_VIRUSIMMUNE,

		// Extra cool stuff
		TRAIT_RADIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_RDS_SUPPRESSED,
		TRAIT_MADNESS_IMMUNE,

		// Separate handling will be used. Proteans never truly "die". They get stuck in their suit.
		TRAIT_NODEATH,
	)

	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	reagent_flags = PROCESS_SYNTHETIC

	var/list/organ_slots = list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_HEART, ORGAN_SLOT_STOMACH, ORGAN_SLOT_EYES)
	language_prefs_whitelist = list(/datum/language/monkey)

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	// Add protean limb component to all bodyparts
	for(var/obj/item/bodypart/limb as anything in gainer.bodyparts)
		limb.AddComponent(/datum/component/protean_limb)
	equip_modsuit(gainer)
	RegisterSignal(gainer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	RegisterSignal(gainer, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB, PROC_REF(check_limb_attach))
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(gainer)
	var/obj/item/mod/core/protean/core = suit?.core
	core?.linked_protean = gainer
	var/list/protean_verbs = list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
		/mob/living/carbon/proc/low_power,
		/mob/living/carbon/proc/remove_assimilated_modsuit,
		/mob/living/carbon/proc/remove_assimilated_plating,
	)
	add_verb(gainer, protean_verbs)

/// Replaces organs for protean ones, handling situations where organs are inserted via surgery or changed through quirks/mutations
/datum/species/protean/proc/replace_incompatible_organs(mob/living/carbon/human/target)
	var/list/slot_to_type = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/protean,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/protean,
	)
	for(var/slot in slot_to_type)
		var/obj/item/organ/existing = target.get_organ_slot(slot)
		if(existing?.organ_flags & (ORGAN_NANOMACHINE | ORGAN_ROBOTIC))
			continue
		var/replacement_type = slot_to_type[slot]
		var/obj/item/organ/replacement = new replacement_type()
		replacement.copy_traits_from(existing)
		qdel(existing)
		replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/species/protean/proc/organ_reject(mob/living/source, obj/item/organ/inserted, special)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted
	if(!(insert_organ.slot in organ_slots))
		return
	if(insert_organ.organ_flags & (ORGAN_ROBOTIC | ORGAN_NANOMACHINE | ORGAN_UNREMOVABLE))
		return
	if(special)
		addtimer(CALLBACK(src, PROC_REF(assimilate_organ), source, inserted, special), 0)
	else
		addtimer(CALLBACK(src, PROC_REF(assimilate_organ), source, inserted, special), 1 SECONDS)

/// Assimilates a non-nanomachine organ, destroying it and replacing the slot with a protean equivalent.
/datum/species/protean/proc/assimilate_organ(mob/living/source, obj/item/organ/organ, special)
	qdel(organ)
	if(!special)
		to_chat(source, span_notice("Your nanomass assimilates the foreign organ."))
		source.balloon_alert_to_viewers("assimilated!", vision_distance = 1)
	replace_incompatible_organs(source, special)

/// Adds the protean limb component to any new limb attached to a protean.
/datum/species/protean/proc/check_limb_attach(mob/living/carbon/source, obj/item/bodypart/new_limb, special)
	SIGNAL_HANDLER
	if(!new_limb.GetComponent(/datum/component/protean_limb))
		new_limb.AddComponent(/datum/component/protean_limb)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	// Clean up verbs
	var/list/protean_verbs = list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
		/mob/living/carbon/proc/low_power,
		/mob/living/carbon/proc/remove_assimilated_modsuit,
		/mob/living/carbon/proc/remove_assimilated_plating,
	)
	remove_verb(gainer, protean_verbs)
	if(gainer)
		UnregisterSignal(gainer, list(COMSIG_CARBON_GAIN_ORGAN, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB))
		// Clean up traits that may be active if protean is transformed or in critical state
		REMOVE_TRAIT(gainer, TRAIT_CRITICAL_CONDITION, PROTEAN_TRAIT)
		gainer.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(gainer)
	if(suit?.stored_modsuit)
		suit.unassimilate_modsuit(gainer, TRUE)
	gainer.dropItemToGround(suit, TRUE)
	if(suit)
		qdel(suit)
	set_protean_modsuit(null)
	// Remove protean limb components from all bodyparts
	for(var/obj/item/bodypart/limb as anything in gainer.bodyparts)
		qdel(limb.GetComponent(/datum/component/protean_limb))

/// Creates and equips the protean's modsuit to the given mob's back slot, storing the ref on the chest component.
/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	var/obj/item/mod/control/pre_equipped/protean/new_suit = new()
	set_protean_modsuit(new_suit)
	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(new_suit, ITEM_SLOT_BACK, disable_warning = TRUE)

/datum/species/protean/get_default_mutant_bodyparts()
	return list(
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/datum/species/protean/allows_food_preferences()
	return FALSE

/datum/species/protean/get_species_description()
	return "A coherent nanomachine swarm shaped into humanoid form. Fragile but unkillable, \
		Proteans retreat into their modsuit core when critically damaged and sustain themselves by consuming metal."

/datum/species/protean/get_species_lore()
	return list(
		"Proteans are a synthetic species composed of a nanomachine swarm housed within a specialized modsuit. \
		Rather than possessing a traditional biological form, their bodies are constructed from billions of microscopic machines \
		that can reshape themselves as needed. When critically damaged, a Protean retreats into its modsuit core to rebuild, \
		making them effectively immortal as long as their core remains intact. They sustain themselves by consuming metal, \
		which fuels their nanomachine processes.",
	)

/datum/species/protean/create_pref_unique_perks()
	var/list/perk_descriptions = list()

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "robot",
		SPECIES_PERK_NAME = "Nanomachine Swarm",
		SPECIES_PERK_DESC = "Proteans are immortal nanomachine swarms. When critically damaged, they retreat into their modsuit core rather than dying.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "shield-halved",
		SPECIES_PERK_NAME = "Modsuit Assimilation",
		SPECIES_PERK_DESC = "Proteans can absorb other modsuits into their own, gaining their appearance and modules.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "cube",
		SPECIES_PERK_NAME = "Metal Metabolism",
		SPECIES_PERK_DESC = "Proteans cannot eat normal food. They sustain themselves by consuming metal sheets, processed by their refactory organ.",
	))

	perk_descriptions += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "bolt",
		SPECIES_PERK_NAME = "Fragile Construction",
		SPECIES_PERK_DESC = "Proteans take extra electrical damage and are easily dismembered.",
	))

	return perk_descriptions

/datum/species/protean/prepare_human_for_preview(mob/living/carbon/human/protean_preview)
	protean_preview.update_body(TRUE)

/// Override so outfits don't break proteans when they try to force a backpack item from an outfit
/mob/living/carbon/human/equipOutfit(outfit, visuals_only = FALSE)
	dna?.species.pre_equip_outfit(src)
	. = ..()
	dna?.species.post_equip_outfit(src)

/datum/species/proc/pre_equip_outfit(mob/living/carbon/human/equipping)
	return

/datum/species/proc/post_equip_outfit(mob/living/carbon/human/equipping)
	return

/// Temporarily drops and destroys the protean modsuit to free the back slot for the outfit's back item.
/datum/species/protean/pre_equip_outfit(mob/living/carbon/human/equipping)
	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(equipping)
	if(!suit)
		return
	if(HAS_TRAIT(suit, TRAIT_NODROP))
		REMOVE_TRAIT(suit, TRAIT_NODROP, "protean")
	equipping.temporarilyRemoveItemFromInventory(suit, force = TRUE)
	set_protean_modsuit(null)
	qdel(suit)

/// After outfit equipping, converts whatever the outfit put in the back slot into a protean modsuit.
/// Non-protean modsuits get assimilated (theme + modules). Other items get replaced.
/datum/species/protean/post_equip_outfit(mob/living/carbon/human/equipping)
	if(get_protean_modsuit(equipping))
		return
	var/obj/item/back_item = equipping.get_item_by_slot(ITEM_SLOT_BACK)
	var/obj/item/mod/control/outfit_modsuit = istype(back_item, /obj/item/mod/control) ? back_item : null
	// Save storage contents — assimilation and qdel both scatter them
	var/obj/item/storage_source = outfit_modsuit ? locate(/obj/item/mod/module/storage) in outfit_modsuit.modules : back_item
	var/list/saved_contents = storage_source?.contents?.Copy()
	// Retract deployed modsuit parts before removing from inventory
	if(outfit_modsuit)
		for(var/obj/item/part as anything in outfit_modsuit.get_parts())
			if(part.loc != outfit_modsuit)
				outfit_modsuit.retract(equipping, part, instant = TRUE)
		outfit_modsuit.toggle_activate(equipping, force_deactivate = TRUE)
	// Swap: remove outfit item, equip protean modsuit, assimilate or discard
	if(back_item)
		equipping.temporarilyRemoveItemFromInventory(back_item, force = TRUE)
	equip_modsuit(equipping)
	var/obj/item/mod/control/pre_equipped/protean/new_suit = get_protean_modsuit(equipping)
	if(outfit_modsuit)
		outfit_modsuit.forceMove(equipping)
		new_suit?.assimilate_modsuit(equipping, outfit_modsuit, forced = TRUE)
	else if(back_item)
		// Move items out before qdeling so they aren't destroyed with it
		for(var/obj/item/saved in saved_contents)
			saved.moveToNullspace()
		qdel(back_item)
	// Restore contents into protean modsuit storage
	var/obj/item/mod/module/storage/protean_storage = locate() in new_suit?.modules
	for(var/obj/item/saved in saved_contents)
		if(!QDELETED(saved))
			saved.forceMove(protean_storage)
