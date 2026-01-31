/obj/item/organ/brain/slime
	name = "core"
	desc = "The central core of a slimeperson, technically their 'extract.' Where the cytoplasm, membrane, and organelles come from; perhaps this is also a mitochondria?"
	zone = BODY_ZONE_CHEST
	/// This is the VFX for what happens when they melt and die.
	var/obj/effect/death_melt_type = /obj/effect/temp_visual/wizard/out
	/// Color of the slimeperson's 'core' brain, defaults to white.
	var/core_color = COLOR_WHITE
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "slime_core"
	/// This tracks whether their core has been ejected or not after they die.
	var/core_ejected = FALSE
	/// This tracks whether their GPS microchip is enabled or not, only becomes TRUE on activation of the below ability /datum/action/innate/core_signal.
	var/gps_active = TRUE
	throw_range = 9 //Oh! That's a baseball!
	throw_speed = 0.5
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | LAVA_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	/// A little glow so they're more noticeable on death
	light_system = OVERLAY_LIGHT
	light_range = 1.5
	light_power = 0.25
	/// Core storage
	var/list/stored_items = list()
	/// Item types that should never be stored in core and will drop on death. Takes priority over allowed lists.
	var/static/list/bannedcore = typecacheof(list(/obj/item/disk/nuclear))

/obj/item/organ/brain/slime/Initialize(mapload, mob/living/carbon/organ_owner, list/examine_list)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "slime", BUBBLE_ICON_PRIORITY_ORGAN)
	register_context()
	colorize()

/obj/item/organ/brain/slime/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	// code it so it checks on whenever you have beaker or not
	if(istype(held_item, /obj/item/reagent_containers))
		context[SCREENTIP_CONTEXT_LMB] = "Pour Beaker (Requires 100u Plasma)"
	if(!held_item)
		if(length(stored_items))
			context[SCREENTIP_CONTEXT_LMB] = "Steal Items"
		if(gps_active)
			context[SCREENTIP_CONTEXT_RMB] = "Disable GPS Signal"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/organ/brain/slime/examine(mob/user)
	. = ..()
	// this is horrible but i want to keep this in the right order
	if(gps_active)
		. += span_notice("A dim light lowly pulsates from the center of the core, indicating an outgoing signal from a tracking microchip.")
	if(length(stored_items))
		. += span_red("You could probably use it in-hand to steal the items within.")
	if(gps_active)
		. += span_red("You could alternatively snuff out the tracking signal by right-clicking.")
	if(IS_HERETIC(user))
		. += span_green("Using your Mansus Grasp, you can immediately regenerate their core. This is necessary in order to sacrifice them.")
	. += span_hypnophrase("You remember that <i>slowly</i> pouring a big beaker of plasma on it by hand, if it's non-embodied, would make it regrow one.")

/obj/item/organ/brain/slime/Destroy(force)
	if(stored_items)
		var/drop_loc = drop_location()
		if(drop_loc)
			drop_items_to_ground(drop_loc, explode = TRUE)
		else
			QDEL_LIST(stored_items)
	return ..()

/obj/item/organ/brain/slime/proc/process_items(mob/living/carbon/human/victim)
	var/list/focus_slots = list(
		ITEM_SLOT_SUITSTORE,
		ITEM_SLOT_BELT,
		ITEM_SLOT_ID,
		ITEM_SLOT_LPOCKET,
		ITEM_SLOT_RPOCKET
	)

	for(var/islot in focus_slots) // Focus on storage items and any others that drop when uniform is unequiped
		var/obj/item/item = victim.get_item_by_slot(islot)
		if(QDELETED(item))
			continue
		victim.temporarilyRemoveItemFromInventory(item, force = TRUE, idrop = FALSE)
		process_and_store_item(item, victim)

	var/obj/item/back_item = victim.back
	if(!QDELETED(back_item))
		victim.temporarilyRemoveItemFromInventory(back_item, force = TRUE, idrop = FALSE)
		process_and_store_item(back_item, victim) // Jank to handle modsuit covering items, so it's removed first. Fix this.

	var/obj/item/bodypart/chest/target_chest = victim.get_bodypart(BODY_ZONE_CHEST) // Store chest cavity item
	if(istype(target_chest))
		process_and_store_item(target_chest.cavity_item, victim)

	for(var/obj/item/item as anything in victim.get_equipped_items(INCLUDE_POCKETS)) // Store rest of equipment
		if(QDELETED(item))
			continue
		victim.temporarilyRemoveItemFromInventory(item, force = TRUE, idrop = FALSE)
		process_and_store_item(item, victim)

/obj/item/organ/brain/slime/proc/process_and_store_item(atom/movable/item, mob/living/carbon/human/victim) // Helper proc to finally move items
	if(QDELETED(item))
		return
	if(!isnull(item.contents))
		for(var/atom/movable/content_item as anything in item.get_all_contents())
			if(is_type_in_typecache(content_item, bannedcore))
				content_item.forceMove(victim.drop_location()) // Move item from container to victims turf if banned
	if(is_type_in_typecache(item, bannedcore))
		item.forceMove(victim.drop_location()) // Move banned item from victim to the victim's turf if banned.
	else
		item.forceMove(src)
		stored_items |= item

/obj/item/organ/brain/slime/proc/drop_items_to_ground(turf/turf, explode = FALSE)
	for(var/atom/movable/item as anything in stored_items)
		if(explode)
			brainmob.dropItemToGround(item, force = TRUE)
		else
			item.forceMove(turf)
	stored_items.Cut()

/**
* Allows a player to dump their items or deactivate the GPS signal and the core glow
*/
/obj/item/organ/brain/slime/attack_self(mob/living/user)
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return

	if(!length(stored_items))
		to_chat(user, span_notice("There is nothing remaining inside [src]!"))
		return

	user.visible_message(
		span_warning("[user] begins jamming [user.p_their()] hand into a slime core! Slime goes everywhere!"),
		span_notice("You jam your hand into [src], feeling for any dense objects. Slime covers your arm."),
		span_notice("You hear an obscene squelching sound.")
	)
	playsound(user, 'sound/items/handling/surgery/organ1.ogg', 80, TRUE)

	if(!do_after(user, 15 SECONDS, src))
		user.visible_message(
			span_warning("[user]'s hand slips out of the core before [user.p_they()] can cause any harm!'"),
			span_notice("Your hand slips out of the goopy core before you can find any dense objects inside."),
			span_notice("You hear a resounding plop.")
		)
		return

	user.visible_message(
		span_warning("[user] crunches something deep in [src]! It gradually stops glowing."),
		span_notice("You find several dense objects, forcing them out of the core, items start to spill."),
		span_notice("You hear a wet squelching sounds.")
	)
	drop_items_to_ground(user.drop_location())
	playsound(user, 'sound/effects/wounds/crackandbleed.ogg', 80, TRUE)
	return

/obj/item/organ/brain/slime/attack_self_secondary(mob/user, modifiers)
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return

	if(!gps_active)
		to_chat(user, span_notice("There is no signal inside [src]!"))
		return

	user.visible_message(
		span_warning("[user] begins jamming [user.p_their()] hand into a slime core! Slime goes everywhere!"),
		span_notice("You jam your hand into [src], feeling for the blinking light! Slime covers your arm."),
		span_notice("You hear an obscene squelching sound.")
	)
	playsound(user, 'sound/items/handling/surgery/organ1.ogg', 80, TRUE)

	if(!do_after(user, 15 SECONDS, src))
		user.visible_message(
			span_warning("[user]'s hand slips out of the core before [user.p_they()] can cause any harm!'"),
			span_notice("Your hand slips out of the goopy core before you can find it's densest point."),
			span_notice("You hear a resounding plop.")
		)
		return

	if(gps_active)
		user.visible_message(
			span_warning("[user] crunches something deep in [src]! It gradually stops glowing."),
			span_notice("You find the densest point, crushing it in your palm. The blinking light in the core slowly dissipates."),
			span_notice("You hear a wet crunching sound."))
		set_light_on(FALSE)
		gps_active = FALSE
		qdel(GetComponent(/datum/component/gps))

	return

/obj/item/organ/brain/slime/on_mob_insert(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	colorize()
	core_ejected = FALSE
	RegisterSignal(organ_owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_slime_death))

/obj/item/organ/brain/slime/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_LIVING_DEATH)

/**
* Colors the slime's core (their brain) the same as their first mutant color.
*/
/obj/item/organ/brain/slime/proc/colorize()
	if(owner && isjellyperson(owner))
		core_color = owner.dna.features[FEATURE_MUTANT_COLOR]
		light_color = core_color
		add_atom_colour(core_color, FIXED_COLOUR_PRIORITY)

/**
* Handling for tracking when the slime in question dies which then segues into the core ejection proc.
*/
/obj/item/organ/brain/slime/proc/on_slime_death(mob/living/victim, new_stat)
	SIGNAL_HANDLER

	if(new_stat != DEAD || IS_CHANGELING(victim) || is_reserved_level(victim.z) && !istype(get_area(victim.loc), /area/shuttle)) // Changelings and bitrunning/deathmatch gamers are exempt
		return

	addtimer(CALLBACK(src, PROC_REF(core_ejection), victim), 0) // Explode them after the current proc chain ends, to avoid weirdness

/**
* CORE EJECTION PROC -
* Makes it so that when a slime dies, their core ejects and their body is qdel'd.
*/
/obj/item/organ/brain/slime/proc/core_ejection(mob/living/victim, new_stat, turf/loc_override)
	if(core_ejected)
		return
	core_ejected = TRUE
	victim.visible_message(span_warning("[victim]'s body completely dissolves, collapsing outwards!"), span_notice("Your body completely dissolves, collapsing outwards!"), span_notice("You hear liquid splattering."))
	var/atom/death_loc = victim.drop_location()
	process_items(victim) // Start moving items before anything else can touch them.
	if(victim.get_organ_slot(ORGAN_SLOT_BRAIN) == src)
		Remove(victim)
	if(death_loc)
		forceMove(death_loc)
	src.wash(CLEAN_WASH)
	new death_melt_type(death_loc, victim.dir)

	do_steam_effects(get_turf(victim))
	playsound(victim, 'sound/effects/blob/blobattack.ogg', 80, TRUE)

	if(gps_active) // adding the gps signal if they have activated the ability
		AddComponent(/datum/component/gps, "![victim]'s Core")

	qdel(victim)
	UnregisterSignal(victim, COMSIG_LIVING_DEATH)

/**
* Procs the ethereal jaunt liquid effect when the slime dissolves on death.
*/
/obj/item/organ/brain/slime/proc/do_steam_effects(turf/loc)
	var/datum/effect_system/steam_spread/steam = new()
	steam.set_up(10, FALSE, loc)
	steam.start()

/**
* CHECK FOR REPAIR SECTION
* Makes it so that when a slime's core has plasma poured on it, it builds a new body and moves the brain into it.
*/
/obj/item/organ/brain/slime/check_for_repair(obj/item/item, mob/user)

	if(isnull(brainmob))
		user.balloon_alert(user, "[src] is not a viable candidate for repair!")
		return TRUE
	brainmob.grab_ghost()
	if(isnull(brainmob.stored_dna))
		user.balloon_alert(user, "[src] does not contain any dna!")
		return TRUE
	if(isnull(brainmob.client))
		user.balloon_alert(user, "[src] does not contain a mind!")
		return TRUE

	if(istype(item, /obj/item/melee/touch_attack/mansus_fist))
		regenerate(nugget = FALSE, heretic_revival = TRUE)
		return TRUE

	if(!item.is_drainable() || item.reagents.get_reagent_amount(/datum/reagent/toxin/plasma) < 100)
		return FALSE

	user.visible_message(
		span_notice("[user] starts to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its cytoskeleton outwards..."),
		span_notice("You start to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its membrane outwards...")
	)
	user.balloon_alert_to_viewers("pouring plasma...")

	brainmob?.notify_revival("Someone is pouring plasma on your core!", sound = null, source = src) // no sound since it's a whopping 60 second wait time after this
	if(!do_after(user, 60 SECONDS, src))
		to_chat(user, span_warning("You failed to pour the contents of [item] onto [src]!"))
		return TRUE

	user.visible_message(
		span_notice("[user] pours the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane."),
		span_notice("You pour the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane.")
	)

	item.reagents.clear_reagents() //removes the whole shit
	regenerate()
	return TRUE

/obj/item/organ/brain/slime/proc/regenerate(nugget = TRUE, heretic_revival = FALSE)
	//we have the plasma. we can rebuild them.
	set_organ_damage(-maxHealth) //fully heals the brain

	if(istype(loc, /obj/effect/abstract/chasm_storage))
		// oh fuck we're reviving in a chasm somehow, uhhhh, quick, find us the nearest non-chasm turf
		for(var/turf/turf as anything in spiral_range_turfs(5, get_turf(src), TRUE))
			if(!isopenturf(turf) || isgroundlessturf(turf) || turf.is_blocked_turf(exclude_mobs = TRUE))
				continue
			forceMove(turf)
			break

	if(gps_active) // making sure the gps signal is removed if it's active on revival
		qdel(GetComponent(/datum/component/gps))

	var/mob/living/carbon/human/new_body = new /mob/living/carbon/human(src.loc)

	brainmob.client?.prefs?.safe_transfer_prefs_to(new_body)
	new_body.underwear = "Nude"
	new_body.bra = "Nude"
	new_body.undershirt = "Nude" //Which undershirt the player wants
	new_body.socks = "Nude" //Which socks the player wants
	brainmob.stored_dna.copy_dna(new_body.dna, transfer_flags = COPY_DNA_SE|COPY_DNA_SPECIES)
	new_body.dna.features[FEATURE_MUTANT_COLOR] = new_body.dna.features[FEATURE_MUTANT_COLOR]
	new_body.dna.update_uf_block(FEATURE_MUTANT_COLOR)
	new_body.real_name = new_body.dna.real_name
	new_body.name = new_body.dna.real_name
	new_body.updateappearance(mutcolor_update=1)
	new_body.domutcheck()
	new_body.forceMove(get_turf(src))
	new_body.set_blood_volume(BLOOD_VOLUME_SAFE + 60)
	SSquirks.AssignQuirks(new_body, brainmob.client)
	src.replace_into(new_body)
	if(nugget)
		for(var/obj/item/bodypart/bodypart as anything in new_body.bodyparts)
			if(!istype(bodypart, /obj/item/bodypart/chest))
				bodypart.drop_limb()
				continue
		new_body.visible_message(span_warning("[new_body]'s torso \"forms\" from [new_body.p_their()] core, yet to form the rest."))
	if(heretic_revival) // Let's revive them, and keep them at hard crit so they can be sacrificed
		new_body.set_brute_loss(200, updating_health = TRUE)
	to_chat(owner, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))
	to_chat(owner, span_purple("Your torso fully forms out of your core, yet to form the rest."))
	new_body.set_jitter_if_lower(200 SECONDS)
	new_body.emote("scream")
	drop_items_to_ground(new_body.drop_location())
	return TRUE


/**
 * Toggle Death Signal simply adds and removes the trait required for slimepeople to transmit a GPS signal upon core ejection.
 */
/datum/action/innate/core_signal
	name = "Toggle Core Signal"
	desc = "Interface with the microchip placed in your core, modifying if it emits a GPS signal or not; due to how thick your liquid body is, the signal won't reach out until your core is outside of it."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	button_icon_state = "slime_core"
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE

/datum/action/innate/core_signal/Activate()
	var/mob/living/carbon/human/slime = owner
	var/obj/item/organ/brain/slime/core = slime.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(slime_restricted && !isjellyperson(slime))
		return
	if(core.gps_active)
		to_chat(owner,span_notice("You tune out the electromagnetic signals from your core so they are ignored by GPS receivers upon its rejection."))
		core.gps_active = FALSE
	else
		to_chat(owner, span_notice("You fine-tune the electromagnetic signals from your core to be picked up by GPS receivers upon its rejection."))
		core.gps_active = TRUE
