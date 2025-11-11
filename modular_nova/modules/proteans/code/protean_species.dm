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

		// Proteans have an integrated modsuit (prevents entombed quirk)
		TRAIT_INTEGRATED_MODSUIT,

		//TRAIT_VENTCRAWLER_NUDE, - A tease. If you want to give a species vent crawl. God help your soul. But I won't stop you from learning that hard lesson.
	)

	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	reagent_flags = PROCESS_PROTEAN

	// Set robotic organs to prevent organic organ rejection
	mutantbrain = /obj/item/organ/brain/protean
	mutantheart = /obj/item/organ/heart/protean
	mutantstomach = /obj/item/organ/stomach/protean
	mutantliver = /obj/item/organ/liver/protean
	mutanteyes = /obj/item/organ/eyes/robotic/protean
	mutantears = /obj/item/organ/ears/cybernetic/protean
	mutanttongue = /obj/item/organ/tongue/cybernetic/protean
	mutantlungs = null // No lungs
	mutantappendix = null // No appendix

	language_prefs_whitelist = list(/datum/language/monkey)

	/// Reference to the mob that owns this species datum (for signals and callbacks)
	var/mob/living/carbon/human/owner
	/// List of organ slots that are CHECKED by rejection system (brain protected, heart/stomach can be replaced, eyes checked)
	/// Organs NOT in this list are completely ignored and can be installed/removed freely
	var/list/organ_slots = list(
		ORGAN_SLOT_BRAIN, // Always protected - must be protean core
		ORGAN_SLOT_HEART, // Can be replaced with any robotic heart (lose orchestrator function!)
		ORGAN_SLOT_STOMACH, // Can be replaced with any robotic stomach (lose refactory function!)
		ORGAN_SLOT_EYES, // Can be replaced with any robotic eyes
		// TONGUE, EARS, VOICE, HUD, ARM_AUGS not in list = can be installed freely without checks
	)
	/// The shapeshift action
	var/datum/action/innate/alter_form/quirk/shapeshift_action = new()

/mob/living/carbon/human/species/protean
	race = /datum/species/protean

/// Helper to get the protean's modsuit (stored on brain organ for proper lifecycle management)
/datum/species/protean/proc/get_modsuit()
	if(!owner)
		return null
	var/obj/item/organ/brain/protean/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		return null
	return brain.linked_modsuit

/datum/species/protean/Destroy(force)
	// Modsuit cleanup now handled by brain organ's Destroy()
	// Unregister signal from modsuit if it still exists
	var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
	if(modsuit)
		UnregisterSignal(modsuit, COMSIG_QDELETING)
	if(owner)
		UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
	UnregisterSignal(src, COMSIG_OUTFIT_EQUIP)

	if(shapeshift_action)
		QDEL_NULL(shapeshift_action)
	owner = null
	return ..()

/datum/species/protean/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	// Ensure storage exists before job outfit is equipped
	var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
	if(!modsuit)
		return
	var/obj/item/mod/module/storage/storage = locate() in modsuit.modules
	if(!storage)
		// Give proteans expanded storage by default (better than basic, not OP like bluespace)
		storage = new /obj/item/mod/module/storage/large_capacity()
		modsuit.install(storage, equipping, TRUE)

/datum/species/protean/on_species_gain(mob/living/carbon/human/gainer, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	// If we're switching from protean to protean (SAD/pref reload), preserve the old modsuit by transferring it to new brain
	var/obj/item/mod/control/pre_equipped/protean/old_protean_suit = null
	if(istype(old_species, /datum/species/protean))
		var/datum/species/protean/old_protean = old_species
		old_protean_suit = old_protean.get_modsuit()

	. = ..()
	owner = gainer
	gainer.bubble_icon = "machine" // Robot speech bubble

	// CRITICAL: Ensure protean has correct brain FIRST (fixes quirk/preference organ replacement and ghost role spawns)
	// This MUST happen before any modsuit creation, as modsuit is linked to the brain
	var/obj/item/organ/brain/current_brain = gainer.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(current_brain, /obj/item/organ/brain/protean))
		current_brain?.Remove(gainer)
		qdel(current_brain)
		var/obj/item/organ/brain/protean/new_brain = new()
		new_brain.Insert(gainer, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		current_brain = new_brain

	// Get the protean brain (now guaranteed to be correct type)
	var/obj/item/organ/brain/protean/brain = current_brain
	if(!istype(brain))
		stack_trace("Protean on_species_gain: Failed to create protean brain!")
		return

	// If we have an old protean suit, transfer it to the new brain
	if(old_protean_suit)
		brain.linked_modsuit = old_protean_suit
		// Re-equip to back slot if needed
		if(gainer.back != old_protean_suit)
			var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
			if(item_in_slot && item_in_slot != old_protean_suit)
				if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
					stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species re-gain. Type: [item_in_slot]")
				gainer.dropItemToGround(item_in_slot, force = TRUE)
			gainer.equip_to_slot_if_possible(old_protean_suit, ITEM_SLOT_BACK, disable_warning = TRUE)
	else
		equip_modsuit(gainer)

	// Register signal to block non-forced deletion of the modsuit (now on brain's modsuit)
	var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
	if(modsuit)
		RegisterSignal(modsuit, COMSIG_QDELETING, PROC_REF(on_species_modsuit_qdeleted))

	RegisterSignal(src, COMSIG_OUTFIT_EQUIP, PROC_REF(outfit_handling))
	RegisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(organ_reject))
	var/obj/item/mod/core/protean/core = modsuit?.core
	core?.linked_species_ref = WEAKREF(src)
	// Add protean-specific verbs (using add_verb for proper UI refresh)
	add_verb(gainer, list(
		/mob/living/carbon/proc/protean_ui,
		/mob/living/carbon/proc/protean_heal,
		/mob/living/carbon/proc/lock_suit,
		/mob/living/carbon/proc/suit_transformation,
		/mob/living/carbon/proc/low_power,
		/mob/living/carbon/proc/speak_through_modsuit,
		/mob/living/carbon/proc/eject_assimilated_modsuit,
	))

	// Grant shapeshifting ability
	shapeshift_action = new
	shapeshift_action.Grant(gainer)

/// Signal handler: detects when incompatible organ is inserted and schedules its rejection.
/// Brain MUST be protean-specific. Other organs can be ANY robotic/nanomachine organ (but will lose special functions).
/datum/species/protean/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
	SIGNAL_HANDLER

	if(isnull(source))
		return
	var/obj/item/organ/insert_organ = inserted

	// Only check organs in our whitelist
	if(!(insert_organ.slot in organ_slots))
		return

	// Brain MUST be protean-specific
	if(insert_organ.slot == ORGAN_SLOT_BRAIN)
		if(!istype(insert_organ, /obj/item/organ/brain/protean))
			to_chat(source, span_warning("Your nanite mass rejects [insert_organ] - only a protean core can control the swarm!"))
			addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)
			return

	// All other organs: accept ANY robotic/nanomachine organ, reject organic
	if(insert_organ.organ_flags & (ORGAN_ROBOTIC | ORGAN_NANOMACHINE | ORGAN_UNREMOVABLE))
		// Warn if replacing critical organs with non-protean versions
		if(insert_organ.slot == ORGAN_SLOT_HEART && !istype(insert_organ, /obj/item/organ/heart/protean))
			to_chat(source, span_warning("This heart lacks orchestrator functions - you'll suffer movement penalties!"))
		if(insert_organ.slot == ORGAN_SLOT_STOMACH && !istype(insert_organ, /obj/item/organ/stomach/protean))
			to_chat(source, span_warning("This stomach lacks refactory functions - you won't be able to heal or process metal!"))
		return // Accept it

	// Reject organic organs
	addtimer(CALLBACK(src, PROC_REF(reject_now), source, inserted), 1 SECONDS)

/// Performs the actual organ rejection, removing incompatible organ and dropping it. Called by organ_reject after 1s delay.
/datum/species/protean/proc/reject_now(mob/living/source, obj/item/organ/organ)

	organ.Remove(source)
	organ.forceMove(get_turf(source))
	to_chat(source, span_danger("Your mass rejected [organ]!"))
	organ.balloon_alert_to_viewers("rejected!", vision_distance = 1)

/// If the suit is deleted somehow...
/datum/species/protean/proc/on_species_modsuit_qdeleted(datum/source, force)
	SIGNAL_HANDLER
	return

/// Creates and equips a new protean modsuit to the protean's back slot. Drops any existing back item.
/// Links the new modsuit to the protean brain organ for proper lifecycle management.
/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
	var/obj/item/organ/brain/protean/brain = gainer.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		stack_trace("equip_modsuit called on non-protean or missing protean brain!")
		return FALSE

	// Create new modsuit and link it to brain
	var/obj/item/mod/control/pre_equipped/protean/new_modsuit = new()
	brain.linked_modsuit = new_modsuit

	var/obj/item/item_in_slot = gainer.get_item_by_slot(ITEM_SLOT_BACK)
	if(item_in_slot)
		if(HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			stack_trace("Protean modsuit forced dropped a TRAIT_NODROP item on species equip. Type: [item_in_slot]")
		gainer.dropItemToGround(item_in_slot, force = TRUE)
	return gainer.equip_to_slot_if_possible(new_modsuit, ITEM_SLOT_BACK, disable_warning = TRUE)

/// Signal handler for COMSIG_OUTFIT_EQUIP. Handles protean outfit logic: assimilates modsuits, ensures storage module, transfers backpack contents.
/datum/species/protean/proc/outfit_handling(datum/species/protean, datum/outfit/outfit, visuals_only)
	SIGNAL_HANDLER
	var/get_a_job = istype(outfit, /datum/outfit/job)

	// Ensure critical organs exist (important for midround antags that bypass normal organ generation)
	if(!owner.get_organ_slot(ORGAN_SLOT_HEART))
		var/obj/item/organ/heart/protean/new_heart = new()
		new_heart.Insert(owner, special = TRUE)
	if(!owner.get_organ_slot(ORGAN_SLOT_STOMACH))
		var/obj/item/organ/stomach/protean/new_stomach = new()
		new_stomach.Insert(owner, special = TRUE)

	// Ensure perscom action is granted (important for midround antags)
	var/obj/item/organ/brain/protean/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain?.internal_computer)
		var/perscom_granted = FALSE
		for(var/datum/action/item_action/protean/open_internal_computer/perscom in brain.actions)
			if(perscom in owner.actions)
				perscom_granted = TRUE
				break
		if(!perscom_granted)
			for(var/datum/action/item_action/protean/open_internal_computer/perscom in brain.actions)
				perscom.Grant(owner)

	// Handle modsuit assimilation and post-setup async to prevent signal handler blocking
	var/obj/item/mod/control/suit
	if(ispath(outfit.back, /obj/item/mod/control))
		var/control_path = outfit.back
		suit = new control_path()
		// Use INVOKE_ASYNC to prevent signal handler from blocking, then chain to post-setup
		INVOKE_ASYNC(src, PROC_REF(handle_modsuit_assimilation), owner, suit, outfit, get_a_job)
	else
		// No modsuit to assimilate, just do post-setup directly
		INVOKE_ASYNC(src, PROC_REF(finish_outfit_setup), owner, outfit, get_a_job)

/// Handles modsuit assimilation and activation, then chains to post-setup. Called async from outfit_handling.
/datum/species/protean/proc/handle_modsuit_assimilation(mob/living/carbon/human/protean_owner, obj/item/mod/control/suit, datum/outfit/outfit, get_a_job)
	var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
	if(!modsuit)
		return
	modsuit.assimilate_modsuit(protean_owner, suit, TRUE)
	modsuit.quick_activation()
	finish_outfit_setup(protean_owner, outfit, get_a_job)

/// Handles post-assimilation outfit setup: storage modules, suit_store items, and iron sheets. Called after assimilation completes.
/datum/species/protean/proc/finish_outfit_setup(mob/living/carbon/human/protean_owner, datum/outfit/outfit, get_a_job)
	var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
	if(!modsuit)
		return

	var/obj/item/mod/module/storage/storage = locate() in modsuit.modules // Give an extended storage if we don't have one.
	if(!storage)
		storage = new /obj/item/mod/module/storage/large_capacity()
		modsuit.install(storage, protean_owner, TRUE)

	// Only install crew sensors and GPS for jobs, not antags
	if(get_a_job)
		// Install crew sensor module if not present
		var/obj/item/mod/module/crew_sensor/protean/crew_sensor = locate() in modsuit.modules
		if(!crew_sensor)
			crew_sensor = new()
			modsuit.install(crew_sensor, protean_owner, TRUE)

		// Install GPS module if not present
		var/obj/item/mod/module/gps/protean/gps_module = locate() in modsuit.modules
		if(!gps_module)
			gps_module = new()
			modsuit.install(gps_module, protean_owner, TRUE)

	// Handle suit_store items (like ninja katana) - create and add to storage
	// Proteans don't have a suit slot, so we manually create the suit_store item
	if(outfit.suit_store)
		var/obj/item/suit_item = protean_owner.get_item_by_slot(ITEM_SLOT_SUITSTORE)
		if(!suit_item && ispath(outfit.suit_store)) // If not equipped, create it
			suit_item = new outfit.suit_store(protean_owner)
		if(suit_item)
			if(suit_item.loc == protean_owner) // If it's on the mob, remove it first
				protean_owner.temporarilyRemoveItemFromInventory(suit_item, force = TRUE)
			if(!storage.atom_storage?.attempt_insert(suit_item, protean_owner, messages = FALSE))
				suit_item.forceMove(get_turf(protean_owner))
				to_chat(protean_owner, span_warning("[suit_item] couldn't fit in storage!"))

	// Outfit system already equipped backpack_contents, we just add bonus iron sheets
	if(get_a_job)
		protean_owner.equip_to_storage(new /obj/item/stack/sheet/iron/twenty(protean_owner), ITEM_SLOT_BACK, TRUE, TRUE)

/// Override to give proteans a special oversized refactory instead of normal oversized stomach
/datum/species/protean/gain_oversized_organs(mob/living/carbon/human/human_holder, datum/quirk/oversized/oversized_quirk)
	if(isnull(human_holder.loc))
		return // preview characters don't need funny organs, prevents a runtime

	var/obj/item/organ/stomach/protean/old_refactory = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(old_refactory?.is_oversized) // don't override augments that are already oversized
		return

	var/obj/item/organ/stomach/protean/oversized/new_refactory = new() // RIP AND TEAR YOUR HUGE NANITES!
	oversized_quirk.old_organs += list(old_refactory)

	new_refactory.Insert(human_holder, special = TRUE)
	to_chat(human_holder, span_warning("Your refactory expands to massive proportions!"))
	if(old_refactory)
		old_refactory.moveToNullspace()
		STOP_PROCESSING(SSobj, old_refactory)

/datum/species/protean/on_species_loss(mob/living/carbon/human/gainer, datum/species/new_species, pref_load)
	. = ..()
	if(gainer)
		UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
		gainer.bubble_icon = initial(gainer.bubble_icon) // Restore normal speech bubble
		// Remove protean verbs (using remove_verb for proper UI refresh)
		remove_verb(gainer, list(
			/mob/living/carbon/proc/protean_ui,
			/mob/living/carbon/proc/protean_heal,
			/mob/living/carbon/proc/lock_suit,
			/mob/living/carbon/proc/suit_transformation,
			/mob/living/carbon/proc/low_power,
			/mob/living/carbon/proc/speak_through_modsuit,
			/mob/living/carbon/proc/eject_assimilated_modsuit,
		))
	UnregisterSignal(src, COMSIG_OUTFIT_EQUIP)
	if(shapeshift_action)
		QDEL_NULL(shapeshift_action)
	// Drop assimilated modsuits (modsuit cleanup will be handled by brain removal)
	if(!istype(new_species, /datum/species/protean) && !QDELETED(gainer))
		var/obj/item/mod/control/pre_equipped/protean/modsuit = get_modsuit()
		if(!QDELETED(modsuit))
			if(modsuit.stored_modsuit)
				modsuit.unassimilate_modsuit(owner, TRUE)
			gainer.dropItemToGround(modsuit, TRUE)
			// Don't qdel here - let brain's Destroy() handle it for proper cleanup

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
