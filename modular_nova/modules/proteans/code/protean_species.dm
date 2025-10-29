/datum/species/protean
	id = SPECIES_PROTEAN
	examine_limb_id = SPECIES_PROTEAN

	name = "Protean"
	sexes = TRUE

	siemens_coeff = 1.5 // Electricty messes you up.
	payday_modifier = 0.7 // 30 percent poorer

	exotic_bloodtype = BLOOD_TYPE_NANITE_SLURRY
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	meat = /obj/item/stack/sheet/iron

	mutant_bodyparts = list()
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
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/protean,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/protean,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/protean,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/protean,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/protean,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/protean,
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
		TRAIT_STABLEHEART, // Orchestrator module handles heart/movement
		TRAIT_NOHUNGER, // They will have metal stored in the stomach. Fuck nutrition code.
		TRAIT_LIMBATTACHMENT,

		// Synthetic lifeforms
		TRAIT_GENELESS,
		TRAIT_NO_HUSK,
		TRAIT_NO_DNA_SCRAMBLE,
		TRAIT_SYNTHETIC, // Not used in any code, but just in case
		TRAIT_TOXIMMUNE,
		TRAIT_NEVER_WOUNDED, // Does not wound.
		TRAIT_VIRUSIMMUNE, // So they can't roll for fake virus, they can't get sick anyways

		// Extra cool stuff
		TRAIT_RADIMMUNE,
		TRAIT_EASYDISMEMBER,
		TRAIT_RDS_SUPPRESSED,
		TRAIT_MADNESS_IMMUNE,

		// Seperate handling will be used. Proteans never truely "die". They get stuck in their suit.
		TRAIT_NODEATH,

		//TRAIT_VENTCRAWLER_NUDE, - A tease. If you want to give a species vent crawl. God help your soul. But I won't stop you from learning that hard lesson.
	)

	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	reagent_flags = PROCESS_PROTEAN

	/// Reference to the protean's integrated modsuit
	var/obj/item/mod/control/pre_equipped/protean/species_modsuit

	/// Reference to the mob that owns this species datum
	var/mob/living/carbon/human/owner
	/// List of organ slots that this species can use (only accepts robotic/nanomachine organs)
	var/list/organ_slots = list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_HEART, ORGAN_SLOT_STOMACH, ORGAN_SLOT_EYES)
	language_prefs_whitelist = list(/datum/language/monkey)

/mob/living/carbon/human/species/protean
	race = /datum/species/protean

/datum/species/protean/Destroy(force)
	// Unregister signals before cleanup
	if(species_modsuit)
		UnregisterSignal(species_modsuit, COMSIG_PREQDELETED)

	QDEL_NULL(species_modsuit)
	owner = null
	return ..()

/datum/species/protean/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	// Ensure storage exists before job outfit is equipped
	if(!species_modsuit)
		return
	var/obj/item/mod/module/storage/storage = locate() in species_modsuit.modules
	if(!storage)
		storage = new()
		species_modsuit.install(storage, equipping, TRUE)

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	// If we're switching from protean to protean (SAD/pref reload), preserve the old modsuit
	var/obj/item/mod/control/pre_equipped/protean/old_protean_suit = null
	if(istype(old_species, /datum/species/protean))
		var/datum/species/protean/old_protean = old_species
		old_protean_suit = old_protean.species_modsuit
		// Temporarily prevent deletion of the old suit
		old_protean.species_modsuit = null

	. = ..()
	owner = gainer

	// If we have an old protean suit, reuse it instead of creating new one
	if(old_protean_suit)
		species_modsuit = old_protean_suit
		// Re-equip to back slot if needed
		if(gainer.back != species_modsuit)
			var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
			if(item_in_slot && item_in_slot != species_modsuit)
				if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
					stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species re-gain. Type: [item_in_slot]")
				gainer.dropItemToGround(item_in_slot, force = TRUE)
			gainer.equip_to_slot_if_possible(species_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)
	else
		equip_modsuit(gainer)

	// Register signal to block non-forced deletion of the modsuit, we do this because the species datum gets deleted -after- the worn items (e.g. the modsuit). So in order to not hang a ref we only let the species datum itself delete its modsuit.
	RegisterSignal(species_modsuit, COMSIG_PREQDELETED, PROC_REF(on_species_modsuit_qdeleted))

	RegisterSignal(src, COMSIG_OUTFIT_EQUIP, PROC_REF(outfit_handling))
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	var/obj/item/mod/core/protean/core = species_modsuit.core
	core?.linked_species = src
	gainer.verbs += /mob/living/carbon/proc/protean_ui
	gainer.verbs += /mob/living/carbon/proc/protean_heal
	gainer.verbs += /mob/living/carbon/proc/lock_suit
	gainer.verbs += /mob/living/carbon/proc/suit_transformation
	gainer.verbs += /mob/living/carbon/proc/low_power
	gainer.verbs += /mob/living/carbon/proc/speak_through_modsuit
	gainer.verbs += /mob/living/carbon/proc/eject_assimilated_modsuit

	// Grant shapeshifting ability
	var/datum/action/innate/alter_form/quirk/shapeshift_action = new()
	shapeshift_action.Grant(gainer)

	// Ensure protean has correct organs (fixes quirk/preference organ replacement)
	var/obj/item/organ/brain/current_brain = gainer.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(current_brain, /obj/item/organ/brain/protean))
		current_brain?.Remove(gainer)
		qdel(current_brain)
		var/obj/item/organ/brain/protean/new_brain = new()
		new_brain.Insert(gainer, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/// Signal handler: detects when non-protean organ is inserted and schedules its rejection. Only accepts robotic/nanomachine organs.
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

/// Performs the actual organ rejection, removing incompatible organ and dropping it. Called by organ_reject after 1s delay.
/datum/species/protean/proc/reject_now(mob/living/source, obj/item/organ/organ)

	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your mass rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/// Block deletion of their suit under normal circumstances, it's not removable.
/datum/species/protean/proc/on_species_modsuit_qdeleted(datum/source, force)
	SIGNAL_HANDLER
	if(!force)
		return TRUE


/// Creates and equips a new protean modsuit to the protean's back slot. Drops any existing back item.
/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	species_modsuit = new()
	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(species_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)

/// Signal handler for COMSIG_OUTFIT_EQUIP. Handles protean outfit logic: assimilates modsuits, ensures storage module, transfers backpack contents.
/datum/species/protean/proc/outfit_handling(datum/species/protean, datum/outfit/outfit, visuals_only)
	SIGNAL_HANDLER
	var/get_a_job = istype(outfit, /datum/outfit/job)
	var/obj/item/mod/control/suit
	if(ispath(outfit.back, /obj/item/mod/control))
		var/control_path = outfit.back
		suit = new control_path()
		INVOKE_ASYNC(species_modsuit, TYPE_PROC_REF(/obj/item/mod/control/pre_equipped/protean, assimilate_modsuit), owner, suit, TRUE)
		INVOKE_ASYNC(species_modsuit, TYPE_PROC_REF(/obj/item/mod/control, quick_activation))

	var/obj/item/mod/module/storage/storage = locate() in species_modsuit.modules // Give a storage if we don't have one.
	if(!storage)
		storage = new()
		species_modsuit.install(storage, owner, TRUE)

	// Install crew sensor module if not present
	var/obj/item/mod/module/crew_sensor/protean/crew_sensor = locate() in species_modsuit.modules
	if(!crew_sensor)
		crew_sensor = new()
		species_modsuit.install(crew_sensor, owner, TRUE)

	// Install GPS module if not present
	var/obj/item/mod/module/gps/protean/gps_module = locate() in species_modsuit.modules
	if(!gps_module)
		gps_module = new()
		species_modsuit.install(gps_module, owner, TRUE)

	// Outfit system already equipped backpack_contents, we just add bonus iron sheets
	if(get_a_job)
		owner.equip_to_storage(new /obj/item/stack/sheet/iron/twenty(owner), ITEM_SLOT_BACK, TRUE, TRUE)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	if(gainer)
		UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)

	// If we're changing to another protean (SAD/pref reload), don't delete the suit
	// The new protean species will reuse it in on_species_gain
	if(!istype(new_species, /datum/species/protean))
		if(species_modsuit?.stored_modsuit)
			species_modsuit.unassimilate_modsuit(owner, TRUE)
		gainer.dropItemToGround(species_modsuit, TRUE)
		if(species_modsuit)
			QDEL_NULL(species_modsuit)

	owner = null

/datum/species/protean/get_default_mutant_bodyparts()
	return list(
		"legs" = list("Normal Legs", FALSE)
	)

/datum/species/protean/allows_food_preferences()
	return FALSE

/datum/species/protean/get_species_description()
	return "Trillions of small machines swarm into a single crewmember. This is a Protean, a walking coherent blob of metallic mass."

/datum/species/protean/get_species_lore()
	return list(
		"Proteans are unkillable. Instead, they shunt themselves away into their core when catastrophic losses to their swarm occur. \
		Their cores also mimic the functions of a modsuit and can even assimilate more functional suits to use.",
		"Proteans only have a few vital organs, which can only be replaced via cargo. \
		Their refactory is a miniature factory, and without it, they will face slow, agonizing degradation. \
		Their Orchestrator is a miniature processor required for ease of movement.",
		"Proteans are an extremely fragile species, weak in combat, but a powerful aid, or a puppeteer pulling the strings.",
	)
