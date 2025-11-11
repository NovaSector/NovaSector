/obj/item/mod/control/pre_equipped/protean
	name = "protean modsuit"
	desc = "The modsuit unit of a Protean, allowing them to retract into it, or to deploy a suit that protects against various environments."
	theme = /datum/mod_theme // Uses standard theme by default, can be changed by assimilating other MODsuits

	applied_core = /obj/item/mod/core/protean
	applied_cell = null // Goes off stomach
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF // funny nanite
	/// Whether or not the wearer can undeploy parts.
	var/modlocked = FALSE
	/// The MODsuit that's been absorbed by the protean
	var/obj/item/mod/control/stored_modsuit
	/// The appearance theme from the absorbed MODsuit
	var/datum/mod_theme/stored_theme
	/// The original storage module from the assimilated suit (cached to return when unassimilating)
	var/obj/item/mod/module/storage/cached_storage
	/// List of modules that came from the assimilated suit (to return during unassimilation)
	var/list/obj/item/mod/module/cached_modules = list()

/datum/mod_theme/protean
	name = "protean"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	AddElement(/datum/element/strippable/protean, GLOB.strippable_human_items, TYPE_PROC_REF(/mob/living/carbon/human/, should_strip))

	// Make sure there's always an extended storage module, even if spawned outside of normal outfit system
	var/obj/item/mod/module/storage/storage = locate() in modules
	if(!storage)
		storage = new /obj/item/mod/module/storage/large_capacity()
		install(storage, null, TRUE)

	// Override the on_exit signal handler to prevent the protean core from being uninstalled
	// The protean core is integrated and must never be removed
	RegisterSignal(src, COMSIG_ATOM_EXITED, PROC_REF(on_exit_protean), override = TRUE)

/obj/item/mod/control/pre_equipped/protean/Destroy()
	// If a protean is folded up inside, kick them out before deleting the suit
	var/mob/living/carbon/human/protean_inside = locate(/mob/living/carbon/human) in src
	if(!QDELETED(protean_inside) && isprotean(protean_inside))
		protean_inside.forceMove(get_turf(src))
		to_chat(protean_inside, span_warning("Your suit is being destroyed! You are forcefully ejected!"))

	// Safety check: only unassimilate if stored_modsuit exists and isn't deleted
	if(stored_modsuit && !QDELETED(stored_modsuit) && !QDELETED(src))
		INVOKE_ASYNC(src, PROC_REF(unassimilate_modsuit_destroy), stored_modsuit)

	// Clean up cached storage and modules if they still exist
	if(cached_storage)
		QDEL_NULL(cached_storage)
	cached_modules.Cut()

	return ..()

/// Async-safe version of unassimilate_modsuit for Destroy() calls
/obj/item/mod/control/pre_equipped/protean/proc/unassimilate_modsuit_destroy(obj/item/mod/control/to_unassimilate)
	if(QDELETED(src) || QDELETED(to_unassimilate))
		return
	unassimilate_modsuit(null, forced = TRUE)

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	to_chat(user, span_warning("The core is integrated and cannot be removed from the [src]."))
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/emag_act(mob/user, obj/item/card/emag/emag_card)
	to_chat(user, span_warning("The [src] does not respond to the [emag_card]."))
	return FALSE // Nope

/obj/item/mod/control/pre_equipped/protean/acid_act(acidpwr, acid_volume, acid_id)
	. = ..()
	if(modlocked && !isprotean(wearer) && acidpwr >= 50) // Strong enough acid can eat through the lock
		visible_message(span_warning("[src]'s locking mechanisms corrode and fail!"))
		toggle_lock(TRUE)
		playsound(src, 'sound/items/tools/welder2.ogg', 50, TRUE)
		return

/obj/item/mod/control/pre_equipped/protean/emp_act(severity)
	. = ..()
	if(modlocked && !isprotean(wearer))
		var/unlock_chance = (severity == EMP_HEAVY) ? 100 : 50
		if(prob(unlock_chance))
			visible_message(span_warning("[src]'s systems glitch out and unlock!"))
			toggle_lock(TRUE)
			playsound(src, 'sound/machines/nuke/angry_beep.ogg', 50, TRUE)

/obj/item/mod/control/pre_equipped/protean/screwdriver_act(mob/living/user, obj/item/tool)
	if(modlocked && !isprotean(wearer) && !open)
		balloon_alert(user, "unscrewing panel...")
		if(!do_after(user, 3 SECONDS, wearer))
			return ITEM_INTERACT_BLOCKING
		open = TRUE
		balloon_alert(user, "panel opened")
		to_chat(user, span_notice("You unscrew the maintenance panel. Now you need to cut the wires..."))
		playsound(src, 'sound/items/tools/screwdriver_operating.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/mod/control/pre_equipped/protean/wirecutter_act(mob/living/user, obj/item/tool)
	if(modlocked && !isprotean(wearer) && open)
		balloon_alert(user, "cutting wires...")
		if(!do_after(user, 4 SECONDS, wearer))
			return ITEM_INTERACT_BLOCKING
		balloon_alert(user, "wires cut")
		to_chat(user, span_notice("You cut through the locking wires. Now you can pry it off..."))
		playsound(src, 'sound/items/tools/wirecutter.ogg', 50, TRUE)
		ADD_TRAIT(src, TRAIT_PROTEAN_UNLOCKABLE, "tool_unlock")
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/mod/control/pre_equipped/protean/crowbar_act(mob/living/user, obj/item/tool)
	// Priority 1: If suit is open, allow normal module removal
	if(open && !modlocked)
		return ..()

	// Priority 2: If suit is locked and unlockable, allow forced removal
	if(modlocked && !isprotean(wearer) && HAS_TRAIT(src, TRAIT_PROTEAN_UNLOCKABLE))
		balloon_alert(user, "prying off...")
		if(!do_after(user, 5 SECONDS, wearer))
			return ITEM_INTERACT_BLOCKING
		visible_message(span_warning("[user] forcefully pries [src] off [wearer]!"))
		toggle_lock(TRUE)
		drop_suit()
		open = FALSE
		REMOVE_TRAIT(src, TRAIT_PROTEAN_UNLOCKABLE, "tool_unlock")
		playsound(src, 'sound/items/tools/crowbar.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/item/mod/control/pre_equipped/protean/canStrip(mob/who)
	return TRUE

/obj/item/mod/control/pre_equipped/protean/doStrip(mob/stripper, mob/owner) // Custom stripping code.
	if(!isprotean(wearer)) // Strip it normally
		return ..()
	// Protean wearing their own suit - only allow emptying storage
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("You empty out all the items from the Protean's internal storage module!"))
		stripper.balloon_alert(stripper, "emptied storage")
		return TRUE

	to_chat(stripper, span_warning("This suit seems to be a part of them. You can't remove it!"))
	stripper.balloon_alert(stripper, "can't strip a protean's suit!")
	return ..()

/obj/item/mod/control/pre_equipped/protean/equipped(mob/user, slot, initial)
	. = ..()
	// Add TRAIT_NODROP when a protean equips it (like entombed does - "glues" it to back)
	if(isprotean(user) && (slot & slot_flags))
		ADD_TRAIT(src, TRAIT_NODROP, SPECIES_TRAIT)

/obj/item/mod/control/pre_equipped/protean/visual_equipped(mob/user, slot, initial = FALSE)
	. = ..()
	// Set ABSTRACT when equipped to back slot to prevent dragging between slots (like modsuits do when active)
	if(slot & slot_flags)
		item_flags |= ABSTRACT
	else
		item_flags &= ~ABSTRACT

/obj/item/mod/control/pre_equipped/protean/dropped(mob/user)
	// Remove TRAIT_NODROP when dropped (like entombed does - allows retrieval if gibbed)
	REMOVE_TRAIT(src, TRAIT_NODROP, SPECIES_TRAIT)

	// Don't dump items or unset wearer if a protean is folding themselves into the suit
	// We keep them as wearer so modules continue to work in suit mode
	if(isprotean(user) && (locate(/mob/living/carbon/human) in src))
		// Skip the item dumping but don't call parent (which would unset wearer)
		return

	. = ..()

/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
	if(!QDELETED(wearer))
		// Manually unset wearer (since dropped() won't be called normally)
		var/mob/living/carbon/temp_wearer = wearer
		if(wearer)
			unset_wearer()
		temp_wearer.dropItemToGround(src, TRUE, TRUE, TRUE)

/// Handle drag-drop onto user - if hands are full, try to equip to back or open storage instead of dropping
/obj/item/mod/control/pre_equipped/protean/proc/on_mousedrop_onto(datum/source, atom/over_object, mob/user)
	SIGNAL_HANDLER

	if(over_object == user && iscarbon(user))
		var/mob/living/carbon/carbon_user = user

		// If already equipped to this user, allow normal unequip behavior
		if(carbon_user.get_item_by_slot(ITEM_SLOT_BACK) == src)
			return NONE

		// If item is already in user's inventory (hands or other slot), allow normal behavior
		if(src.loc == carbon_user || (istype(src.loc, /obj/item) && src.loc.loc == carbon_user))
			return NONE

		// Check if user's hands are full
		var/hands_full = !carbon_user.get_empty_held_index_for_side(LEFT_HANDS) && !carbon_user.get_empty_held_index_for_side(RIGHT_HANDS)

		// If hands are full and item is on ground, try to equip to back first, otherwise open storage
		if(hands_full)
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH | ALLOW_RESTING))
				return NONE

			// Try to equip to back slot if possible
			if(carbon_user.can_equip(src, ITEM_SLOT_BACK, disable_warning = TRUE))
				add_fingerprint(user)
				INVOKE_ASYNC(carbon_user, TYPE_PROC_REF(/mob/living/carbon, equip_to_slot), src, ITEM_SLOT_BACK)
				return COMPONENT_CANCEL_MOUSEDROP_ONTO

			// Can't equip to back, open storage instead
			var/obj/item/mod/module/storage/storage_module = locate() in modules
			if(storage_module?.atom_storage)
				add_fingerprint(user)
				INVOKE_ASYNC(storage_module.atom_storage, TYPE_PROC_REF(/datum/storage, open_storage), user)
				return COMPONENT_CANCEL_MOUSEDROP_ONTO
	return NONE

/// Lets proteans lock the suit onto someone so they can't take it off
/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock(forced = FALSE)
	modlocked = !modlocked

/obj/item/mod/control/pre_equipped/protean/attack_hand_secondary(mob/user, list/modifiers)
	if(!iscarbon(user))
		return ..()
	var/mob/living/carbon/human/carbon_user = user
	// Prevent proteans from unequipping their integrated suit by clicking it
	if(isprotean(carbon_user) && carbon_user.back == src)
		balloon_alert(user, "integrated suit!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	// Prevent non-proteans from removing locked suits
	if(modlocked && !isprotean(carbon_user) && carbon_user.back == src)
		balloon_alert(user, "suit is locked!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/obj/item/mod/control/pre_equipped/protean/choose_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "it refuses to listen")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/toggle_activate(mob/user, force_deactivate)
	if(!force_deactivate && modlocked && !isprotean(user) && active)
		balloon_alert(user, "it doesn't turn off")
		return FALSE
	if(!active && user.has_status_effect(/datum/status_effect/protean_low_power_mode))
		balloon_alert(user, "low power")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/quick_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "it won't undeploy")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/retract(mob/user, obj/item/part, instant)
	if(!isprotean(user) && modlocked && active && !instant)
		balloon_alert(user, "that button is unresponsive")
		return FALSE
	return ..()

/// Protean Revivial

/obj/item/mod/control/pre_equipped/protean/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/datum/species/protean/linked_species = protean_core?.linked_species_ref?.resolve()
	if(protean_core && isnull(linked_species))
		protean_core.linked_species_ref = null
	if(!linked_species?.owner)
		return ..()
	// Safety check: ensure owner exists before accessing properties
	var/mob/living/carbon/human/protean_in_suit = linked_species.owner
	if(!protean_in_suit)
		return ..()
	var/obj/item/organ/brain/protean/brain = protean_in_suit.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_in_suit.get_organ_slot(ORGAN_SLOT_STOMACH)

	if(brain?.dead && open && istype(tool, /obj/item/organ/stomach/protean) && do_after(user, 10 SECONDS) && !refactory)
		var/obj/item/organ/stomach = tool
		if(isnull(linked_species))
			return ITEM_INTERACT_BLOCKING
		stomach.Insert(linked_species.owner, TRUE, DELETE_IF_REPLACED)
		balloon_alert(user, "inserted!")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		// Immediate revival - no timer!
		balloon_alert_to_viewers("repairing systems")
		addtimer(CALLBACK(brain, TYPE_PROC_REF(/obj/item/organ/brain/protean, revive)), 15 SECONDS)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mod/construction/plating))
		if(stored_modsuit)
			balloon_alert(user, "remove assimilated suit")
			return ITEM_INTERACT_BLOCKING
		if(active)
			balloon_alert(user, "turn it off")
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("You begin to copy [tool], destroying it in the process!"))
		if(!do_after(user, 4 SECONDS))
			return ITEM_INTERACT_BLOCKING
		assimilate_theme(user, tool)
		qdel(tool)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mod/control))
		if(active)
			balloon_alert(user, "turn it off")
			return ITEM_INTERACT_BLOCKING

		// Only block other protean modsuits to prevent recursion
		if(istype(tool, /obj/item/mod/control/pre_equipped/protean))
			balloon_alert(user, "incompatable")
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("The suit begins to slowly absorb [tool]!"))
		if(!do_after(user, 4 SECONDS))
			return ITEM_INTERACT_BLOCKING
		assimilate_modsuit(user, tool)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_SUCCESS

	///Memory Wipe Via Pen

	if(brain?.dead && istype(tool, /obj/item/pen))
		to_chat(user, span_notice("You begin to reset the protean's random access memory using a pen."))
		user.balloon_alert_to_viewers("resetting memory")
		user.visible_message(span_boldwarning("[user] is reaching a pen into [protean_in_suit]!"))
		playsound(src, 'sound/machines/synth/synth_no.ogg', 100)
		if(!do_after(user, 10 SECONDS))
			return

		// Eject assimilated modsuit before reset
		if(stored_modsuit)
			unassimilate_modsuit(protean_in_suit, forced = TRUE)
			to_chat(user, span_notice("The assimilated modsuit is ejected during the reset process."))

		protean_in_suit.say("Alert - Random Access Memory Reset. Current memories lost. Any interactions that were ongoing have been forgotten.", forced = TRUE)
		protean_in_suit.log_message("has had their memory reset.", LOG_ATTACK)
		to_chat(protean_in_suit, span_boldwarning("Your memories have been reset. You cannot remember who reset you or any of the events leading up to your reset."))

		// Add blackout effect to prevent abuse
		protean_in_suit.set_eye_blur_if_lower(80 SECONDS)
		protean_in_suit.adjust_temp_blindness(20 SECONDS)

		playsound(src, 'sound/machines/synth/synth_yes.ogg', 100)
		playsound(src, 'sound/machines/click.ogg', 100)
		protean_in_suit.SetSleeping(5 SECONDS)

/obj/item/mod/control/pre_equipped/protean/ui_status(mob/user, datum/ui_state/state)
	var/obj/item/mod/core/protean/source = core
	var/datum/species/protean/linked_species = source?.linked_species_ref?.resolve()
	if(source && isnull(linked_species))
		source.linked_species_ref = null
		return ..()

	// Proteans can ALWAYS access their suit UI from anywhere
	// Safety check: ensure owner exists before comparing
	if(linked_species?.owner == user)
		return UI_INTERACTIVE

	return ..()

/obj/item/mod/control/pre_equipped/protean/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	// Update interaction flags when equipped/unequipped to prevent dropping when hands are full
	update_interaction_flags()

/// Override on_exit to prevent the protean core from being uninstalled
/// The protean core is integrated and must never be removed
/obj/item/mod/control/pre_equipped/protean/proc/on_exit_protean(datum/source, atom/movable/part, direction)
	SIGNAL_HANDLER

	// CRITICAL: Never allow the protean core to be uninstalled or moved
	// The core is integrated and must stay with the protean modsuit
	if(part == core)
		// Force the core back into the modsuit if it somehow tries to exit
		if(part.loc != src)
			part.forceMove(src)
		return

	// Replicate parent on_exit behavior for all other items
	if(part.loc == src)
		return
	if(part.loc == wearer)
		return
	if(part in modules)
		uninstall(part)
		return
	if(part in get_parts())
		if(QDELING(part) && !QDELING(src))
			qdel(src)
			return
		var/datum/mod_part/part_datum = get_part_datum(part)
		if(part_datum.sealed)
			seal_part(part, is_sealed = FALSE)
		if(isnull(part.loc))
			return
		if(!wearer)
			part.forceMove(src)
			return
		INVOKE_ASYNC(src, PROC_REF(retract), wearer, part, /* instant = */ TRUE)

/obj/item/mod/control/pre_equipped/protean/proc/update_interaction_flags()
	var/obj/item/mod/core/protean/protean_core = core
	// If worn by the protean owner, don't require hands to interact (prevents dropping when opening UI with full hands)
	var/datum/species/protean/linked_species = protean_core?.linked_species_ref?.resolve()
	if(protean_core && isnull(linked_species))
		protean_core.linked_species_ref = null
	// Safety check: ensure owner exists before comparing
	if(istype(protean_core) && linked_species?.owner && linked_species.owner == wearer && wearer)
		interaction_flags_click = ALLOW_RESTING
	else
		interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING

/// Helper proc to clean up old modsuit parts before set_up_parts() is called
/// Deletes old mod_part datums and part items to prevent hard deletes
/obj/item/mod/control/pre_equipped/protean/proc/cleanup_old_parts()
	// Retract all deployed parts first
	if(active)
		for(var/obj/item/part as anything in get_parts())
			if(part.loc != src)
				retract(null, part, instant = TRUE)

	// Get all old parts (including control unit, but we'll skip that)
	var/list/old_parts = get_parts(all = TRUE)

	// Delete old mod_part datums and part items
	for(var/obj/item/part as anything in old_parts)
		// Skip the control unit itself (it's in the list but we don't delete it)
		if(part == src)
			continue

		// Safety check: ensure part still exists
		if(QDELETED(part))
			continue

		// Get the mod_part datum for this part
		// Use a safe lookup to avoid CRASH if part is invalid
		var/datum/mod_part/part_datum = null
		var/part_key = "[part.slot_flags]"

		// Try to find the datum in mod_parts dictionary directly
		if(part_key in mod_parts)
			part_datum = mod_parts[part_key]
			// Verify it's the correct part
			if(part_datum && part_datum.part_item == part)
				// Remove from mod_parts dictionary
				mod_parts -= part_key
				// Delete the datum
				qdel(part_datum)

		// Delete the part item itself
		qdel(part)

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_theme(mob/user, plating)
	var/obj/item/mod/construction/plating/plates = plating
	var/datum/mod_theme/the_theme = GLOB.mod_themes[plates.theme]

	name = initial(name)
	desc = initial(desc)

	// CRITICAL: Clean up old parts BEFORE changing theme to prevent hard deletes
	// set_up_parts() doesn't clean up old parts, so we must do it manually
	cleanup_old_parts()

	theme = the_theme
	the_theme.set_up_parts(src, the_theme.default_skin)
	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_modsuit(mob/user, modsuit, forced)
	var/obj/item/mod/control/to_assimilate = modsuit

	if(stored_modsuit)
		to_chat(user, span_warning("Can't absorb two modsuits!"))
		if(forced)
			stack_trace("assimilate_modsuit: Tried to assimilate modsuit while there's already a stored modsuit. stored_modsuit: [stored_modsuit], new_modsuit: [to_assimilate]")
		return

	if(!user?.transferItemToLoc(to_assimilate, src, forced))
		balloon_alert(user, "stuck!")
		return

	// CRITICAL: transferItemToLoc only UNEQUIPS, doesn't move! Must forceMove into src
	// This prevents the modsuit from being dropped on the ground and equipped by others
	to_assimilate.forceMove(src)

	stored_modsuit = to_assimilate
	stored_theme = theme // Store the old theme in cache

	// CRITICAL: Clean up old parts BEFORE changing theme to prevent hard deletes
	// set_up_parts() doesn't clean up old parts, so we must do it manually
	// Must exclude stored_modsuit from deletion
	cleanup_old_parts()

	theme = to_assimilate.theme // Set new theme
	skin = to_assimilate.skin // Inherit skin
	theme.set_up_parts(src, skin) // Creates new parts (doesn't clean up old ones)
	// MUST set complexity_max AFTER set_up_parts(), as set_up_parts() overwrites it with theme default!
	complexity_max = to_assimilate.complexity_max // CRITICAL: Inherit complexity limit from assimilated suit!
	name = to_assimilate.name
	desc = to_assimilate.desc
	extended_desc = to_assimilate.extended_desc

	// Extract items from BOTH storages before we do anything
	// Also collect items directly in modsuit contents (excluding modules, parts, mobs, stored_modsuit)
	var/list/all_items = list()
	var/obj/item/mod/module/storage/our_storage = locate() in modules
	var/obj/item/mod/module/storage/incoming_storage = locate() in to_assimilate.modules

	// Get list of parts to exclude from item collection
	var/list/parts_to_exclude = get_parts(all = TRUE)

	// Collect items directly in modsuit contents (excluding modules, parts, mobs, stored_modsuit)
	for(var/obj/item/thing in src.contents)
		// Skip modules, parts, mobs, and stored_modsuit
		if(thing in modules)
			continue
		if(thing in parts_to_exclude)
			continue
		if(istype(thing, /mob))
			continue
		if(thing == stored_modsuit)
			continue
		// This is an actual item that should be in storage
		all_items += thing

	// Get items from our storage
	if(our_storage?.atom_storage?.real_location)
		for(var/obj/item/thing in our_storage.atom_storage.real_location.contents)
			// Avoid duplicates
			if(thing in all_items)
				continue
			all_items += thing
			thing.forceMove(src) // Move items out temporarily

	// Get items from incoming storage
	if(incoming_storage?.atom_storage?.real_location)
		for(var/obj/item/thing in incoming_storage.atom_storage.real_location.contents)
			// Avoid duplicates
			if(thing in all_items)
				continue
			all_items += thing
			thing.forceMove(src) // Move items out temporarily

	// Transfer all the modules from the absorbed suit to ours
	// We copy the list first because install() modifies it as we go
	var/list/modules_to_transfer = to_assimilate.modules.Copy()
	for(var/obj/item/mod/module/module in modules_to_transfer)
		// Storage modules need special handling - we compare sizes and keep the bigger one
		if(istype(module, /obj/item/mod/module/storage))
			if(our_storage)
				var/obj/item/mod/module/storage/incoming_storage_module = module
				// Check which storage module can hold more stuff
				if(incoming_storage_module.max_combined_w_class > our_storage.max_combined_w_class)
					// The new storage is bigger, so replace ours with it
					to_chat(user, span_notice("Upgrading to [incoming_storage_module] (larger capacity)!"))
					uninstall(our_storage, deleting = TRUE)
					qdel(our_storage) // Delete the old protean storage (it's ours, we can delete it)
					our_storage = null
					// CRITICAL: Uninstall from old suit FIRST to clean up signals and mod reference
					// Then continue below to install the bigger storage into our suit
					to_assimilate.uninstall(module)
					cached_storage = incoming_storage_module // Cache it so we can return it later!
					// Note: We'll track this module in cached_modules after it's installed below
					// Let it continue below to install the bigger storage
				else
					// Our storage is bigger or equal, so keep it and cache theirs for return
					to_chat(user, span_notice("Keeping your [our_storage], caching incoming [module] for return."))
					// CRITICAL: Uninstall from old suit FIRST to clean up signals and mod reference
					to_assimilate.uninstall(module)
					// CRITICAL: Explicitly clear mod reference and ensure signals are unregistered
					module.mod = null
					// Move cached module to protean modsuit contents to keep it safe
					module.forceMove(src)
					cached_storage = module // Cache it to return when unassimilating!
					continue

		// CRITICAL: Uninstall from old suit FIRST to clear module.mod reference
		to_assimilate.uninstall(module)

		// Try to install the module into our suit
		install(module, user)

		// Check if it actually made it in (will be in our modules list if successful)
		if(module in modules)
			// Track this module as coming from the assimilated suit (including storage if it replaced ours)
			cached_modules += module
			continue

		// If we can't install it and it's permanently attached, just leave it in the original suit
		if(!module.removable)
			continue

		// If we can't use it, drop it on the ground
		module.forceMove(get_turf(src))
		to_chat(user, span_warning("[module] has dropped onto the floor!"))

	// Now transfer ALL items (from both storages) into whichever storage we have (or drop them if no storage)
	var/obj/item/mod/module/storage/final_storage = locate() in modules
	if(length(all_items))
		if(!final_storage?.atom_storage)
			// No storage module? Drop everything
			to_chat(user, span_warning("No storage module! Dropping [length(all_items)] items on the floor."))
			for(var/obj/item/thing in all_items)
				thing.forceMove(get_turf(user))
		else
			// Try to fit items in storage, drop what doesn't fit
			to_chat(user, span_notice("Transferring [length(all_items)] items into storage..."))
			for(var/obj/item/thing in all_items)
				if(!final_storage.atom_storage.attempt_insert(thing, user, messages = FALSE))
					thing.forceMove(get_turf(user))
					to_chat(user, span_warning("[thing] couldn't fit! Dropped on floor."))

	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/proc/unassimilate_modsuit(mob/living/user, forced = FALSE)
	// Safety check: ensure we're not deleted
	if(QDELETED(src))
		return

	if(!stored_modsuit)
		if(user)
			to_chat(user, span_warning("There is no assimilated suit."))
		return

	// Safety check: ensure stored_modsuit isn't deleted
	if(QDELETED(stored_modsuit))
		stored_modsuit = null
		if(user)
			to_chat(user, span_warning("The assimilated suit was destroyed."))
		return

	if(active && !forced)
		if(user)
			balloon_alert(user, "deactivate modsuit")
		return
	if(user && !(user.has_active_hand()) && !forced)
		balloon_alert(user, "need active hand")
		return

	if(!forced)
		to_chat(user, span_notice("You begin to pry the assimilated modsuit away."))
		if(!do_after(user, 4 SECONDS))
			return

	// Don't manually retract parts - let set_up_parts() handle cleanup to avoid hard deletes
	complexity_max = initial(complexity_max)

	// Return only the modules that originally came from the assimilated suit
	// Make a copy because we'll be modifying the list
	var/list/modules_to_return = cached_modules.Copy()
	var/obj/item/mod/module/storage/protean_storage = locate() in modules

	// Transfer cached modules back to stored modsuit
	for(var/obj/item/mod/module/module in modules_to_return)
		// CRITICAL: Never transfer the protean core - it's integrated and must stay with the protean modsuit
		// The core is stored in the 'core' variable, not in modules, but add safety check just in case
		if(module == core)
			stack_trace("Protean core found in cached_modules during unassimilation! This should never happen.")
			cached_modules -= module
			continue

		// Skip storage modules - they're handled separately
		if(istype(module, /obj/item/mod/module/storage))
			continue

		// Check if module still exists and is still in our modules list
		if(QDELETED(module) || !(module in modules))
			cached_modules -= module
			continue

		// Uninstall from protean suit
		uninstall(module)

		// Try to install back into the unassimilated suit
		stored_modsuit.install(module, user, TRUE)

		// Check if it transferred successfully
		if(module in stored_modsuit.modules)
			cached_modules -= module
			continue

		// If it failed, drop it
		to_chat(user, span_notice("[module] couldn't fit back, dropping to floor!"))
		module.forceMove(get_turf(src))
		cached_modules -= module

	// Return the original storage module to the assimilated suit WITH all items
	if(cached_storage)
		// Extract all items from protean's current storage
		var/list/items_to_return = list()
		if(protean_storage?.atom_storage?.real_location)
			for(var/obj/item/thing in protean_storage.atom_storage.real_location.contents)
				items_to_return += thing
				thing.forceMove(src) // Move out temporarily

		// Check if the cached storage is currently installed (we kept the larger one during assimilation)
		if((cached_storage == protean_storage) && (cached_storage in modules))
			// The cached storage is currently being used by the protean
			// Uninstall it first WITH deleting = TRUE to prevent item dump
			uninstall(cached_storage, deleting = TRUE)

			// Return it to the unassimilated suit
			stored_modsuit.install(cached_storage, user, TRUE)

			// CRITICAL: Put all items back into the cached storage after reinstalling
			var/items_restored = 0
			for(var/obj/item/thing in items_to_return)
				if(cached_storage.atom_storage?.attempt_insert(thing, user, messages = FALSE))
					items_restored++
				else
					// Item doesn't fit, drop to floor
					thing.forceMove(get_turf(stored_modsuit))
					to_chat(user, span_warning("[thing] couldn't fit in returned storage, dropped on floor!"))

			// Give protean a new expanded storage (their default type)
			var/obj/item/mod/module/storage/large_capacity/new_protean_storage = new()
			install(new_protean_storage, user, TRUE)
			to_chat(user, span_notice("Returned original storage module to suit with [items_restored]/[length(items_to_return)] items, installed new expanded storage."))
		else
			// The cached storage is NOT currently installed (protean's storage was larger)
			// Transfer items from protean's storage to the original cached storage, then return it
			stored_modsuit.install(cached_storage, user, TRUE)

			// Try to fit all items into the returned storage
			var/items_transferred = 0
			var/list/items_for_protean = list()
			for(var/obj/item/thing in items_to_return)
				if(cached_storage.atom_storage?.attempt_insert(thing, user, messages = FALSE))
					items_transferred++
				else
					// Item doesn't fit in smaller storage, keep it for protean
					items_for_protean += thing

			to_chat(user, span_notice("Returned original storage with [items_transferred]/[length(items_to_return)] items."))

			// Ensure protean still has their storage module (it should still be installed)
			if(protean_storage && (protean_storage in modules))
				// Put remaining items back into protean's storage
				var/protean_items_restored = 0
				for(var/obj/item/thing in items_for_protean)
					if(protean_storage.atom_storage?.attempt_insert(thing, user, messages = FALSE))
						protean_items_restored++
					else
						// Item doesn't fit, drop to floor
						thing.forceMove(get_turf(src))
						to_chat(user, span_warning("[thing] couldn't fit in protean storage, dropped on floor!"))
				if(length(items_for_protean) > 0)
					to_chat(user, span_notice("Kept [protean_items_restored]/[length(items_for_protean)] items in protean storage."))
			else
				// Emergency: protean lost their storage, create a new one and put items in it
				var/obj/item/mod/module/storage/large_capacity/emergency_storage = new()
				install(emergency_storage, user, TRUE)
				var/emergency_items_restored = 0
				for(var/obj/item/thing in items_for_protean)
					if(emergency_storage.atom_storage?.attempt_insert(thing, user, messages = FALSE))
						emergency_items_restored++
					else
						thing.forceMove(get_turf(src))
						to_chat(user, span_warning("[thing] couldn't fit in emergency storage, dropped on floor!"))
				to_chat(user, span_warning("Emergency: Reinstalled protean storage with [emergency_items_restored]/[length(items_for_protean)] items."))

		cached_storage = null // Clear the cache
		cached_modules.Cut() // Clear the cached modules list
	else
		// Fallback: if no cached storage (shouldn't happen), create a basic one for the returned suit
		to_chat(user, span_warning("WARNING: No cached storage found, creating basic storage for returned suit."))
		var/obj/item/mod/module/storage/replacement_storage = new()
		stored_modsuit.install(replacement_storage, user, TRUE)

		if(protean_storage?.atom_storage?.real_location)
			for(var/obj/item/thing in protean_storage.atom_storage.real_location.contents)
				if(!replacement_storage.atom_storage?.attempt_insert(thing, user, messages = FALSE))
					thing.forceMove(get_turf(stored_modsuit))
					to_chat(user, span_warning("[thing] couldn't fit in returned storage, dropped on floor!"))

	// CRITICAL: Clean up old parts BEFORE changing theme back to prevent hard deletes
	// set_up_parts() doesn't clean up old parts, so we must do it manually
	cleanup_old_parts()

	theme = stored_theme
	stored_theme = null
	skin = initial(skin)
	theme.set_up_parts(src, skin)
	name = initial(name)
	desc = initial(desc)
	extended_desc = initial(extended_desc)

	// Ensure protean has an extended storage module after restoration (set_up_parts doesn't create modules)
	var/obj/item/mod/module/storage/final_check = locate() in modules
	if(!final_check)
		var/obj/item/mod/module/storage/large_capacity/emergency_storage = new()
		install(emergency_storage, user, TRUE)
		to_chat(user, span_warning("Emergency: Installed extended storage for protean (shouldn't happen, report if you see this)."))

	if(!forced && user.can_put_in_hand(stored_modsuit, user.active_hand_index))
		user.put_in_hand(stored_modsuit, user.active_hand_index)
		stored_modsuit = null
	else
		// If forced (pen reset) or can't put in hand, drop to floor
		stored_modsuit.forceMove(get_turf(src))
		stored_modsuit = null
	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/verb/remove_modsuit()
	set name = "Remove Assimilated Modsuit"

	unassimilate_modsuit(usr)

/obj/item/mod/control/pre_equipped/protean/examine(mob/user)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/datum/species/protean/linked_species = protean_core?.linked_species_ref?.resolve()
	if(protean_core && isnull(linked_species))
		protean_core.linked_species_ref = null
	if(!linked_species?.owner)
		return ..()
	// Safety check: ensure owner exists before accessing properties
	var/mob/living/carbon/human/protean_in_suit = linked_species.owner
	if(!protean_in_suit)
		return ..()
	var/obj/item/organ/brain/protean/brain = protean_in_suit.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_in_suit.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/t_He = protean_in_suit.p_They()
	var/t_him = protean_in_suit.p_them()
	var/t_has = protean_in_suit.p_have()
	var/t_is = protean_in_suit.p_are()

	// Show crew sensor status
	var/obj/item/mod/module/crew_sensor/protean/crew_sensor = locate() in modules
	if(crew_sensor)
		switch(crew_sensor.sensor_mode)
			if(SENSOR_OFF)
				. += "Its sensors appear to be disabled."
			if(SENSOR_LIVING)
				. += "Its binary life sensors appear to be enabled."
			if(SENSOR_VITALS)
				. += "Its vital tracker appears to be enabled."
			if(SENSOR_COORDS)
				. += "Its vital tracker and tracking beacon appear to be enabled."
		if(isprotean(user))
			. += span_notice("<b>Ctrl-Click</b> to quickly set sensors to tracking.")

	if(!isnull(brain) || istype(brain))
		. += span_notice("<b>Control Shift Click</b> to open Protean strip menu.")
		if(brain.dead)
			if(!open)
				. += isnull(refactory) ? span_warning("This Protean requires critical repairs! <b>Screwdriver them open.</b>... There does seem to be a tiny reset hole on the top of the Protean, it seems a <b>Pen</b> might fit in there.. ") : span_notice("<b>Repairing systems...</b>") //Small line for how to memory reset a protean here too.
			else
				. += isnull(refactory) ? span_warning("<b>Insert a new refactory</b>") : span_notice("<b>Refactory Installed! Repairing systems...</b>")
		if(protean_in_suit.key && !protean_in_suit.client)  // We have to put these here because you're examining an object, and not a carbon, and players otherwise can't tell if anyone is home.
			. += span_deadsay("[t_He] [t_has] entered stasis and [t_has] been completely unresponsive to anything for [round(((world.time - protean_in_suit.lastclienttime) / (1 MINUTES)),1)] minutes. [t_He] may snap out of it soon.")
		if(!protean_in_suit.key)
			. += span_deadsay("[t_He] [t_is] totally listless. The stresses of life in deep-space must have been too much for [t_him]. Any recovery is unlikely.")

/**
 * Protean stripping while they're in the suit.
 * Yeah I guess stripping is an element. Carry on, citizen.
 */
/datum/element/strippable/protean

/datum/element/strippable/protean/Attach(datum/target, list/items, should_strip_proc_path)
	. = ..()
	RegisterSignal(target, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(click_control_shit))

/datum/element/strippable/protean/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_CLICK_CTRL_SHIFT)

/datum/element/strippable/protean/proc/click_control_shit(datum/source, mob/user)
	SIGNAL_HANDLER

	var/obj/item/mod/control/pre_equipped/protean/suit = source
	if(!istype(suit))
		return
	var/obj/item/mod/core/protean/core = suit.core
	var/datum/species/protean/linked_species = core?.linked_species_ref?.resolve()
	if(core && isnull(linked_species))
		core.linked_species_ref = null

	// Check if there's a wearer (someone wearing the protean suit)
	if(!suit.wearer)
		return

	// Safety check: ensure owner exists before comparing
	var/is_protean_owner = (linked_species?.owner && linked_species.owner == user)

	// If the protean owner is accessing while someone is wearing them,
	// open the WEARER's interaction menu instead (Nova ERP panel)
	if(is_protean_owner && ishuman(suit.wearer))
		var/mob/living/carbon/human/wearer_human = suit.wearer
		// Check if the wearer has the interactable component (Nova interaction menu)
		var/datum/component/interactable/interaction_component = wearer_human.GetComponent(/datum/component/interactable)
		if(interaction_component)
			// INVOKE_ASYNC required - ui_interact can block, can't call from signal handler
			INVOKE_ASYNC(interaction_component, TYPE_PROC_REF(/datum/component/interactable, ui_interact), user)
			return CLICK_ACTION_SUCCESS
		// If no interaction component, fall through to strip menu

	// If not the protean owner, check strip permissions
	if(!is_protean_owner)
		// Safety check: ensure owner exists before calling
		if(linked_species?.owner && !isnull(should_strip_proc_path) && !call(linked_species.owner, should_strip_proc_path)(user))
			return

	// Show visual feedback (skip for protean owner since they're inside)
	if(!is_protean_owner)
		suit.balloon_alert_to_viewers("stripping")
		user.visible_message(span_warning("[user] begins to dump the contents of [source]!"))

	// INVOKE_ASYNC required - ui_interact can block, can't call from signal handler
	INVOKE_ASYNC(src, PROC_REF(open_strip_menu), user, linked_species)

/datum/element/strippable/protean/proc/open_strip_menu(mob/user, datum/species/protean/linked_species)
	// Safety check: ensure owner exists before accessing
	if(!linked_species?.owner)
		return
	var/datum/strip_menu/protean/strip_menu = LAZYACCESS(strip_menus, linked_species.owner)
	if (isnull(strip_menu))
		strip_menu = new(linked_species.owner, src)
		LAZYSET(strip_menus, linked_species.owner, strip_menu)
	strip_menu.ui_interact(user)

/datum/strip_menu/protean

/datum/strip_menu/protean/ui_status(mob/user, datum/ui_state/state)
	// Check if user is the protean owner (inside the suit)
	var/obj/item/mod/control/pre_equipped/protean/suit = ui_host()
	if(istype(suit))
		var/obj/item/mod/core/protean/core = suit.core
		var/datum/species/protean/linked_species = core?.linked_species_ref?.resolve()
		if(linked_species?.owner == user)
			// Protean owner can always use strip menu while alive
			if(user.stat == DEAD)
				return UI_CLOSE
			return UI_INTERACTIVE

	// Normal strip menu permissions for others
	return min(
		ui_status_only_living(user, owner),
		ui_status_user_has_free_hands(user, owner),
		ui_status_user_is_adjacent(user, owner, allow_tk = FALSE),
		HAS_TRAIT(user, TRAIT_CAN_STRIP) ? UI_INTERACTIVE : UI_UPDATE,
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, owner),
		),
	)

