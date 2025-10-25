/obj/item/mod/control/pre_equipped/protean
	name = "protean modsuit"
	desc = "The modsuit unit of a Protean, allowing them to retract into it, or to deploy a suit that protects against various environments."
	theme = /datum/mod_theme // Standard theme. TODO: Can be changed with standard mod armors

	applied_core = /obj/item/mod/core/protean
	applied_cell = null // Goes off stomach
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF // funny nanite
	/// Whether or not the wearer can undeploy parts.
	var/modlocked = FALSE
	/// Currently assimilated modsuit
	var/obj/item/mod/control/stored_modsuit
	/// Cached modules from assimilated suits
	var/list/cached_modules = list()
	/// Stored theme from assimilated suit
	var/datum/mod_theme/stored_theme

/datum/mod_theme/protean
	name = "protean"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "protean")
	AddElement(/datum/element/strippable/protean, GLOB.strippable_human_items, TYPE_PROC_REF(/mob/living/carbon/human/, should_strip))

	// Ensure storage module exists (fallback for non-outfit spawns)
	var/obj/item/mod/module/storage/storage = locate() in modules
	if(!storage)
		storage = new()
		install(storage, null, TRUE)

/obj/item/mod/control/pre_equipped/protean/item_ctrl_click(mob/user)
	if(!isprotean(user))
		return ..()

	// Quick-set crew sensors to tracking for protean wearers
	var/obj/item/mod/module/crew_sensor/protean/crew_sensor = locate() in modules
	if(crew_sensor)
		crew_sensor.set_sensor_mode(SENSOR_COORDS)
		balloon_alert(user, "sensors set to tracking")
		return CLICK_ACTION_SUCCESS

	return ..()


/obj/item/mod/control/pre_equipped/protean/Destroy()
	// Eject protean if they're inside
	var/mob/living/carbon/human/protean_inside = locate(/mob/living/carbon/human) in src
	if(protean_inside && isprotean(protean_inside))
		protean_inside.forceMove(get_turf(src))
		to_chat(protean_inside, span_warning("Your suit is being destroyed! You are forcefully ejected!"))

	if(stored_modsuit)
		for(var/obj/item/mod/module/modules in cached_modules)
			if(!modules.removable)
				qdel(modules)
				continue
			modules.forceMove(get_turf(src))

		cached_modules = null
		drop_suit()
		INVOKE_ASYNC(src, PROC_REF(unassimilate_modsuit), null, forced = TRUE)
	return ..()

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	to_chat(user, span_warning("The core is integrated and cannot be removed from the [src]."))
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/emag_act(mob/user, obj/item/card/emag/emag_card)
	to_chat(user, span_warning("The [src] does not respond to the [emag_card]."))
	return FALSE // Nope

/obj/item/mod/control/pre_equipped/protean/acid_act(acidpwr, acid_volume, acid_id)
	. = ..()
	if(modlocked && !isprotean(wearer) && acidpwr >= 50) // Strong acid can force unlock
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
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean") // Your ass is coming off.
		return ..()
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("You empty out all the items from the Protean's internal storage module!"))
		stripper.balloon_alert(stripper, "emptied storage")
		return TRUE

	to_chat(stripper, span_warning("This suit seems to be a part of them. You can't remove it!"))
	stripper.balloon_alert(stripper, "can't strip a protean's suit!")
	return ..()

/obj/item/mod/control/pre_equipped/protean/dropped(mob/user)
	// Don't clean up if a protean is going into the suit
	if(isprotean(user) && locate(/mob/living/carbon/human) in src)
		return
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
	if(wearer)
		if(HAS_TRAIT(src, TRAIT_NODROP))
			REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
		wearer.dropItemToGround(src, TRUE, TRUE, TRUE)

/// Proteans can lock themselves on people.
/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock(forced = FALSE)
	if(modlocked && !forced && !isprotean(wearer))
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
	modlocked = !modlocked

/obj/item/mod/control/pre_equipped/protean/equipped(mob/user, slot, initial)
	. = ..()

	if(isprotean(user))
		return
	if(slot == ITEM_SLOT_BACK && user)
		RegisterSignal(user, COMSIG_OOC_ESCAPE, PROC_REF(ooc_escape))
		if(modlocked)
			ADD_TRAIT(src, TRAIT_NODROP, "protean")
			to_chat(user, span_warning("The suit does not seem to be able to come off..."))
	else
		UnregisterSignal(user, COMSIG_OOC_ESCAPE)

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
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/mob/living/carbon/human/protean_in_suit = protean_core.linked_species.owner

	if(brain?.dead && open && istype(tool, /obj/item/organ/stomach/protean) && do_after(user, 10 SECONDS) && !refactory)
		var/obj/item/organ/stomach = tool
		stomach.Insert(protean_core.linked_species.owner, TRUE, DELETE_IF_REPLACED)
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
		protean_in_suit.say("Alert - Random Access Memory Reset. Current memories lost. Any interactions that were ongoing have been forgotten.", forced = TRUE)
		protean_in_suit.log_message("has had their memory reset.", LOG_ATTACK)
		to_chat(protean_in_suit, span_boldwarning("Your memories have been reset. You cannot remember who reset you or any of the events leading up to your reset."))
		playsound(src, 'sound/machines/synth/synth_yes.ogg', 100)
		playsound(src, 'sound/machines/click.ogg', 100)
		protean_in_suit.SetSleeping(5 SECONDS)


/obj/item/mod/control/pre_equipped/protean/ui_status(mob/user, datum/ui_state/state)
	var/obj/item/mod/core/protean/source = core
	var/datum/species/protean/species = source?.linked_species

	// Proteans can ALWAYS access their suit UI from anywhere
	if(species?.owner == user)
		return UI_INTERACTIVE

	return ..()

/obj/item/mod/control/pre_equipped/protean/attack_hand(mob/living/user, list/modifiers)
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_theme(mob/user, plating)
	var/obj/item/mod/construction/plating/plates = plating
	var/datum/mod_theme/the_theme = GLOB.mod_themes[plates.theme]

	name = initial(name)
	desc = initial(desc)

	for(var/obj/item/part as anything in get_parts())
		part.name = initial(name)
		part.desc = initial(desc)
		if(part.loc == src)
			continue
		retract(null, part, instant = TRUE)

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

	// Check if our storage module has items - must be empty to assimilate
	if(atom_storage)
		if(length(atom_storage.real_location?.contents))
			to_chat(user, span_warning("Your storage module must be empty before you can assimilate another modsuit!"))
			return

	if(!user?.transferItemToLoc(to_assimilate, src, forced))
		balloon_alert(user, "stuck!")
		return

	if(!forced)
		for(var/obj/item/part as anything in get_parts())
			if(part.loc == src)
				continue
			retract(null, part, instant = TRUE)

	stored_modsuit = to_assimilate
	stored_theme = theme // Store the old theme in cache
	theme = to_assimilate.theme // Set new theme
	skin = to_assimilate.skin // Inherit skin
	complexity_max = to_assimilate.complexity_max // CRITICAL: Inherit complexity limit from assimilated suit!
	theme.set_up_parts(src, skin) // Put everything together
	name = to_assimilate.name
	desc = to_assimilate.desc
	extended_desc = to_assimilate.extended_desc

	// Transfer modules - exactly like Bubberstation (install() handles the transfer via forceMove)
	// CRITICAL: Iterate over a COPY because install() modifies the source list!
	var/list/modules_to_transfer = to_assimilate.modules.Copy()
	for(var/obj/item/mod/module/module in modules_to_transfer)
		// Special handling for storage - compare sizes and use the bigger one
		if(istype(module, /obj/item/mod/module/storage))
			var/obj/item/mod/module/storage/our_storage = locate() in modules
			if(our_storage)
				var/obj/item/mod/module/storage/incoming_storage = module
				// Compare max storage space
				if(incoming_storage.max_combined_w_class > our_storage.max_combined_w_class)
					// Incoming is bigger - swap to use it
					cached_modules += our_storage
					uninstall(our_storage, deleting = TRUE)
					to_chat(user, span_notice("[incoming_storage] is larger! Swapping to it and caching your [our_storage]."))
					// Continue to install the larger storage below
				else
					// Ours is bigger or equal - keep it
					cached_modules += module
					to_chat(user, span_notice("[module] stored in reserve, keeping your current [our_storage]!"))
					continue

		// Try to install - install() uses forceMove() to automatically transfer the module
		install(module, user, TRUE)

		// Check if it actually got installed (module is now in our modules list)
		if(module in modules)
			continue

		// If it can't be installed and it's not removable, leave it in original suit
		if(!module.removable)
			continue

		// Otherwise uninstall from old suit and drop to floor
		to_assimilate.uninstall(module)
		module.forceMove(get_turf(src))
		to_chat(user, span_warning("[module] has dropped onto the floor!"))

	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/proc/unassimilate_modsuit(mob/living/user, forced = FALSE)
	if(!stored_modsuit)
		to_chat(user, span_warning("There is no assimilated suit."))
		return
	if(active && !forced)
		balloon_alert(user, "deactivate modsuit")
		return
	if(!(user?.has_active_hand()) && !forced)
		balloon_alert(user, "need active hand")
		return

	if(!forced)
		to_chat(user, span_notice("You begin to pry the assimilated modsuit away."))
		if(!do_after(user, 4 SECONDS))
			return

	for(var/obj/item/part as anything in get_parts())
		if(part.loc == src)
			continue
		retract(null, part, instant = TRUE)

	complexity_max = initial(complexity_max)

	// Transfer all modules back to stored modsuit (EXCEPT storage - we keep ours)
	// Make a copy because install() will modify the list
	var/list/modules_to_return = modules.Copy()
	for(var/obj/item/mod/module/module in modules_to_return)
		// Skip storage modules - we keep the protean's storage
		if(istype(module, /obj/item/mod/module/storage))
			continue

		// Try to install - install() will use forceMove() to transfer
		stored_modsuit.install(module, user, TRUE)

		// Check if it transferred
		if(module in stored_modsuit.modules)
			continue

		// If it failed, drop it
		uninstall(module)
		to_chat(user, span_notice("[module] couldn't fit back, dropping to floor!"))
		module.forceMove(get_turf(src))

	// Restore cached storage (magnate storage) back to the original modsuit
	for(var/obj/item/mod/module/cached in cached_modules)
		stored_modsuit.install(cached, user, TRUE)

		if(cached in stored_modsuit.modules)
			cached_modules -= cached
			continue

		// If it failed, drop it
		to_chat(user, span_warning("[cached] couldn't fit back, dropping to floor!"))
		cached.forceMove(get_turf(src))
		cached_modules -= cached

	theme = stored_theme
	stored_theme = null
	skin = initial(skin)
	theme.set_up_parts(src, skin)
	name = initial(name)
	desc = initial(desc)
	extended_desc = initial(extended_desc)

	if(user.can_put_in_hand(stored_modsuit, user.active_hand_index))
		user.put_in_hand(stored_modsuit, user.active_hand_index)
		stored_modsuit = null
	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/verb/remove_modsuit()
	set name = "Remove Assimilated Modsuit"

	unassimilate_modsuit(usr)

/obj/item/mod/control/pre_equipped/protean/examine(mob/user)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/mob/living/carbon/human/protean_in_suit = protean_core?.linked_species.owner
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
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

/obj/item/mod/control/pre_equipped/protean/proc/ooc_escape(mob/living/carbon/user)
	SIGNAL_HANDLER

	if(isprotean(wearer))
		return
	drop_suit()
	if(modlocked)
		toggle_lock(TRUE)

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
	var/datum/species/protean/species = core.linked_species
	if(species.owner == user)
		return
	if(suit.wearer == source)
		return
	if (!isnull(should_strip_proc_path) && !call(species.owner, should_strip_proc_path)(user))
		return
	suit.balloon_alert_to_viewers("stripping")
	user.visible_message(span_warning("[user] begins to dump the contents of [source]!"))
	ASYNC
		var/datum/strip_menu/protean/strip_menu = LAZYACCESS(strip_menus, species.owner)
		if (isnull(strip_menu))
			strip_menu = new(species.owner, src)
			LAZYSET(strip_menus, species.owner, strip_menu)
		strip_menu.ui_interact(user)

/datum/strip_menu/protean

/datum/strip_menu/protean/ui_status(mob/user, datum/ui_state/state)
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

