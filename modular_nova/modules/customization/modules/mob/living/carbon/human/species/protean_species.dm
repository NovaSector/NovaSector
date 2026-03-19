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
	always_customizable = TRUE

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

	/// Reference to the species modsuit
	var/obj/item/mod/control/pre_equipped/protean/species_modsuit

	/// Reference to the species owner
	var/mob/living/carbon/human/owner
	var/list/organ_slots = list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_HEART, ORGAN_SLOT_STOMACH, ORGAN_SLOT_EYES)
	language_prefs_whitelist = list(/datum/language/monkey)

/datum/species/protean/Destroy(force)
	QDEL_NULL(species_modsuit)
	owner = null
	. = ..()

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()
	owner = gainer
	equip_modsuit(gainer)
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	var/obj/item/mod/core/protean/core = species_modsuit.core
	core?.linked_species = src
	var/static/list/protean_verbs = list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
		/mob/living/carbon/proc/low_power,
		/mob/living/carbon/proc/remove_assimilated_modsuit,
		/mob/living/carbon/proc/remove_assimilated_plating,
	)
	add_verb(gainer, protean_verbs)

/datum/species/protean/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted
	if(!(insert_organ.slot in organ_slots))
		return
	if(insert_organ.organ_flags & (ORGAN_ROBOTIC | ORGAN_NANOMACHINE | ORGAN_UNREMOVABLE))
		return
	addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)

/datum/species/protean/proc/reject_now(mob/living/source, obj/item/organ/organ)
	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your mass rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	// Clean up verbs
	var/static/list/protean_verbs = list(
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
		UnregisterSignal(gainer, COMSIG_CARBON_GAIN_ORGAN)
		// Clean up traits that may be active if protean is transformed or in critical state
		REMOVE_TRAIT(gainer, TRAIT_CRITICAL_CONDITION, PROTEAN_TRAIT)
		gainer.remove_movespeed_modifier(/datum/movespeed_modifier/protean_slowdown)
	if(species_modsuit?.stored_modsuit)
		species_modsuit.unassimilate_modsuit(gainer, TRUE)
	gainer.dropItemToGround(species_modsuit, TRUE)
	if(species_modsuit)
		QDEL_NULL(species_modsuit)
	owner = null

/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	species_modsuit = new()
	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(species_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)

/datum/species/protean/get_default_mutant_bodyparts()
	return list(
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/datum/species/protean/allows_food_preferences()
	return FALSE

/datum/species/protean/get_species_description()
	return list(
		"Trillions of small machines swarm into a single crewmember. This is a Protean, a walking coherent blob of metallic mass, and a churning factory that turns materials into more of itself. \
		Proteans are unkillable. Instead, they shunt themselves away into their core when catastrophic losses to their swarm occur. Their cores also mimic the functions of a modsuit and can even assimilate more functional suits to use. \
		Proteans only have a few vital organs, which can only be replaced via cargo. Their refactory is a miniature factory, and without it, they will face slow, agonizing degradation. Their Orchestrator is a miniature processor required for ease of movement. \
		Proteans are an extremely fragile species, weak in combat, but a powerful aid, or a puppeteer pulling the strings.",
	)

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
		SPECIES_PERK_DESC = "Proteans take extra electrical damage, are easily dismembered, and earn 30% less credits.",
	))

	return perk_descriptions

/datum/species/protean/prepare_human_for_preview(mob/living/carbon/human/protean_preview)
	protean_preview.update_body(TRUE)
