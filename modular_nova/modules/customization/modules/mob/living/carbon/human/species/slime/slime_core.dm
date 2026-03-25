/// A global list of dead/ejected oozeling cores.
GLOBAL_LIST_EMPTY_TYPED(dead_slime_cores, /obj/item/organ/brain/slime)

/obj/item/organ/brain/slime
	name = "core"
	desc = "The center core of a slimeperson, technically their 'extract.' Where the cytoplasm, membrane, and organelles come from; perhaps this is also a mitochondria?"
	zone = BODY_ZONE_CHEST
	icon = 'modular_nova/master_files/icons/obj/surgery.dmi'
	icon_state = "slime_core"

	throw_range = 9 //Oh! That's a baseball!
	throw_speed = 0.5
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | LAVA_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	var/obj/effect/death_melt_type = /obj/effect/temp_visual/wizard/out
	var/core_color = COLOR_WHITE

	var/core_ejected = FALSE
	var/gps_active = TRUE

	/// Is someone currently pouring plasma on us?
	var/being_repaired = FALSE

	var/datum/dna/stored_dna
	/// The mind of the oozeling that became this core.
	/// This MUST be named `mind`, in order to allow IS_[antag] macros to work on cores.
	var/datum/mind/mind
	/// The original language holder of the oozeling who died.
	var/datum/language_holder/stored_language_holder

///////
/// Core storage
//
	var/list/stored_quirks = list()
	var/list/stored_items = list()
	var/alist/items_per_slot = alist()

	///Item types that should never be stored in core and will drop on death. Takes priority over allowed lists.
	var/static/list/bannedcore = typecacheof(list(/obj/item/disk/nuclear))
	//Extraneous organs not of oozeling origin. Usually cyber implants.
	var/static/list/allowed_organ_types = typecacheof(list(
		/obj/item/organ/antennae,
		/obj/item/organ/frills,
		/obj/item/organ/horns,
		/obj/item/organ/snout,
		/obj/item/organ/spines,
		/obj/item/organ/tail,
		/obj/item/organ/wings,
		/obj/item/organ/alien,
		/obj/item/organ/cyberimp,
		/obj/item/organ/eyes/robotic/glow,
		/obj/item/organ/heart/cursed,
		/obj/item/organ/vocal_cords,
	))
	//Quirks that roll unique effects or gives items to each new body should be saved between bodies.
	var/static/list/saved_quirks = typecacheof(list(
		/datum/quirk/dnr,
		/datum/quirk/indebted,
		/datum/quirk/item_quirk/addict,
		/datum/quirk/item_quirk/allergic,
		/datum/quirk/item_quirk/bald,
		/datum/quirk/item_quirk/brainproblems,
		/datum/quirk/item_quirk/clown_enjoyer,
		/datum/quirk/item_quirk/family_heirloom,
		/datum/quirk/item_quirk/fluoride_stare,
		/datum/quirk/item_quirk/immunodeficiency,
		/datum/quirk/item_quirk/mime_fan,
		/datum/quirk/item_quirk/musician,
		/datum/quirk/item_quirk/nearsighted,
		/datum/quirk/item_quirk/photographer,
		/datum/quirk/item_quirk/poster_boy,
		/datum/quirk/item_quirk/scarred_eye,
		/datum/quirk/item_quirk/signer,
		/datum/quirk/item_quirk/tagger,
		/datum/quirk/phobia,
	))
	/// Quirks that should just be completely skipped.
	var/static/list/skip_quirks = typecacheof(list(
		/datum/quirk/item_quirk/food_allergic,
		/datum/quirk/prosthetic_limb,
		/datum/quirk/prosthetic_organ,
		/datum/quirk/quadruple_amputee,
		/datum/quirk/tin_man,
	))

	var/rebuilt = TRUE
	var/datum/action/cooldown/membrane_murmur/membrane_mur

/obj/item/organ/brain/slime/Initialize(mapload, mob/living/carbon/organ_owner, list/examine_list)
	. = ..()
	membrane_mur = new
	colorize()

/obj/item/organ/brain/slime/Destroy(force)
	GLOB.dead_slime_cores -= src
	QDEL_NULL(membrane_mur)
	QDEL_NULL(stored_dna)
	QDEL_LIST(stored_quirks)
	QDEL_NULL(stored_language_holder)

	mind = null

	if(stored_items)
		var/drop_loc = drop_location()
		if(drop_loc)
			drop_items_to_ground(drop_loc, explode = TRUE)
		else
			QDEL_LIST(stored_items)

	items_per_slot = null

	return ..()

/**
* Colors the slime's core (their brain) the same as their first mutant color.
*/
/obj/item/organ/brain/slime/proc/colorize()
	if(isjellyperson(owner))
		core_color = owner.dna.features[FEATURE_MUTANT_COLOR]
		add_atom_colour(core_color, FIXED_COLOUR_PRIORITY)

/obj/item/organ/brain/slime/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(istype(held_item, /obj/item/reagent_containers))
		context[SCREENTIP_CONTEXT_LMB] = "Pour Beaker (Requires 100u Plasma)"
	if(!held_item)
		if(length(stored_items))
			context[SCREENTIP_CONTEXT_LMB] = "Steal Items"
		if(gps_active)
			context[SCREENTIP_CONTEXT_RMB] = "Disable GPS Signal"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/organ/brain/slime/examine()
	. = ..()
	if(gps_active)
		. += span_notice("A dim light lowly pulsates from the center of the core, indicating an outgoing signal from a tracking microchip.")
		. += span_red("You could probably use the core in-hand to snuff out the tracking signal and retrieve the items within it.")
	else
		. += span_red("You could probably use the core in-hand to retrieve the items within it.")
	if(HAS_TRAIT(brainmob, TRAIT_DNR))
		. += span_warning("It looks dull and faded, as if the soul within the core had moved on...")
	else if((brainmob && (brainmob.client || brainmob.get_ghost())) || (mind?.current && (mind.current.client || mind.current.get_ghost())) || decoy_override)
		if(isnull(stored_dna))
			. += span_hypnophrase("Something looks wrong with this core, you don't think plasma will fix this one, maybe there's another way?")
		else
			. += span_hypnophrase("You remember that <i>slowly</i> pouring a big beaker of ground plasma on it by hand, if it's non-embodied, would make it regrow one.")
	. += span_notice("<i>You can take a closer look to see what may be inside...</i>")

/obj/item/organ/brain/slime/examine_more(mob/user)
	. = ..()
	. += span_notice("You look closer through the core's hazy interior and see...")
	if(length(stored_items))
		for(var/atom/movable/item as anything in stored_items)
			. += " [icon2html(item, user)] <a href='byond://?src=[REF(src)];core_item=[REF(item)]'>[item.get_examine_name(user)]</a>"
		. += span_notice("floating inside...")
	else
		. += span_notice("...nothing of interest.")

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
			span_warning("[user]'s hand slips out of the core before [user.p_they()] can cause any harm!"),
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

/obj/item/organ/brain/slime/attack_self_secondary(mob/user, modifiers) // Allows a player to deactivate the GPS signal on a slime core, RMB since we want to avoid accidental RRs
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
			span_warning("[user]'s hand slips out of the core before [user.p_they()] can cause any harm!"),
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

/obj/item/organ/brain/slime/proc/drop_items(mob/living/user, list/items_to_drop)
	if(user.get_active_held_item() != src)
		to_chat(user, span_userdanger("Hold [src] in your hand to extract items from it!"))
		return
	if(DOING_INTERACTION_WITH_TARGET(user, src) || !length(items_to_drop))
		return

	var/our_name = brainmob ? key_name(brainmob) : name
	user.log_message("is stripping [our_name] of [english_list(items_to_drop)].", LOG_ATTACK, color="red")
	log_message("is being stripped of [english_list(items_to_drop)] by [key_name(user)].", LOG_VICTIM, color="orange", log_globally=FALSE)
	brainmob?.log_message("is being stripped of [english_list(items_to_drop)] by [key_name(user)].", LOG_VICTIM, color="orange", log_globally=FALSE)

	user.visible_message(
		span_warning("[user] begins jamming [user.p_their()] hand into [src]! Slime goes everywhere!"),
		span_notice("You jam your hand into [src], feeling for the densest point, your prize!"),
		span_notice("You hear an obscene squelching sound.")
	)
	playsound(user, 'sound/items/handling/surgery/organ1.ogg', 80, TRUE)

	if(!do_after(user, 15 SECONDS, src))
		user.visible_message(
			span_warning("[user]'s hand slips out of [src] before [user.p_they()] can cause any harm!"),
			span_notice("Your hand slips out of the goopy core before you could find find anything."),
			span_notice("You hear a resounding plop.")
		)
		return
	user.visible_message(
			span_warning("[user] forcefully extracts items from [src]!"),
			span_notice("You managed to find what you were looking for, and it falls to the ground."),
			span_notice("You hear a wet squelching sounds.")
		)
	playsound(user, 'sound/effects/wounds/crackandbleed.ogg', 80, TRUE)
	drop_items_to_ground(user.drop_location(), dropping = items_to_drop)

	user.log_message("has stripped [our_name] of [english_list(items_to_drop)].", LOG_ATTACK, color = "red")
	log_message("has been stripped of [english_list(items_to_drop)] by [key_name(user)].", LOG_VICTIM, color = "orange", log_globally = FALSE)
	brainmob?.log_message("has been stripped of [english_list(items_to_drop)] by [key_name(user)].", LOG_VICTIM, color = "orange", log_globally = FALSE)

/obj/item/organ/brain/slime/on_mob_insert(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	colorize()
	GLOB.dead_slime_cores -= src
	core_ejected = FALSE
	RegisterSignal(organ_owner, COMSIG_LIVING_DEATH, PROC_REF(on_slime_death))

/obj/item/organ/brain/slime/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_LIVING_DEATH)

/obj/item/organ/brain/slime/proc/on_slime_death(mob/living/carbon/victim)
	SIGNAL_HANDLER
	if(is_reserved_level(victim.z) && !istype(get_area(victim), /area/shuttle))
		return
	var/turf/victim_loc = victim.drop_location()
	UnregisterSignal(victim, COMSIG_LIVING_DEATH)
	mind = victim.mind || victim.last_mind
	copy_mind_and_dna(victim)
	addtimer(CALLBACK(src, PROC_REF(core_ejection), victim, victim_loc), 0) // explode them after the current proc chain ends, to avoid weirdness

/obj/item/organ/brain/slime/proc/copy_mind_and_dna(mob/living/carbon/human/slime)
	if(QDELETED(mind))
		mind = brainmob?.mind || slime.mind || slime.last_mind

	if(isnull(slime.dna))
		QDEL_NULL(stored_dna)
	else
		if(QDELETED(stored_dna))
			stored_dna = new
		slime.dna.copy_dna(stored_dna)

	var/datum/language_holder/slime_language_holder = slime.get_language_holder()
	if(slime_language_holder)
		stored_language_holder = new slime_language_holder.type
		stored_language_holder.copy_languages(slime_language_holder)

	if(slime.blooper_id)
		set_blooper(slime.blooper_id)
		blooper_pitch = slime.blooper_pitch
		blooper_pitch_range = slime.blooper_pitch_range
		blooper_volume = slime.blooper_volume
		blooper_speed = slime.blooper_speed

///////
/// CORE EJECTION PROC
/// Makes it so that when a slime dies, their core ejects and their body is qdel'd.

/obj/item/organ/brain/slime/proc/core_ejection(mob/living/carbon/human/victim, turf/loc_override)
	if(core_ejected)
		return

	GLOB.dead_slime_cores |= src
	core_ejected = TRUE
	victim.visible_message(
		span_warning("[victim]'s body completely dissolves, collapsing outwards!"),
		span_notice("Your body completely dissolves, collapsing outwards!"),
		span_notice("You hear liquid splattering."),
	)
	var/turf/death_turf = loc_override || get_turf(victim)
	var/mob/living/basic/mining/legion/legionbody = astype(victim.loc)
	for(var/datum/quirk/quirk in victim.quirks) // Store certain quirks safe to transfer between bodies.
		if(!is_type_in_typecache(quirk, saved_quirks) || is_type_in_typecache(quirk, skip_quirks))
			continue
		quirk.remove_from_current_holder(quirk_transfer = TRUE)
		stored_quirks |= quirk

	store_item_slots(victim)
	victim.drop_all_held_items()
	process_items(victim) // Start moving items before anything else can touch them.

	if(victim.get_organ_slot(ORGAN_SLOT_BRAIN) == src)
		Remove(victim)
	//Make this check more generalized later. For antags that eat people as they kill. Make sure they drop their
	//contents after death; that is if that is how that item or antag works.
	forceMove(legionbody || death_turf)
	wash(CLEAN_WASH)
	new death_melt_type(death_turf, victim.dir)

	do_steam_effects(death_turf)
	playsound(victim, 'sound/effects/blob/blobattack.ogg', 80, TRUE)

	if(gps_active) // adding the gps signal if they have activated the ability
		AddComponent(/datum/component/gps, "[victim.real_name]'s Core")

	if(brainmob)
		if(stored_language_holder)
			brainmob.get_language_holder()?.copy_languages(stored_language_holder)

		membrane_mur.Grant(brainmob)

	if(stored_dna)
		rebuilt = FALSE
		victim.transfer_observers_to(src)

	qdel(victim)

	SEND_SIGNAL(mind, COMSIG_SLIME_CORE_EJECTED, src)

/obj/item/organ/brain/slime/proc/store_item_slots(mob/living/carbon/human/victim)
	items_per_slot = alist()
	// instantly retract any modsuits, to avoid jank
	if(istype(victim.back, /obj/item/mod/control))
		var/obj/item/mod/control/mod_control = victim.back
		for(var/obj/item/part as anything in mod_control.mod_parts)
			mod_control.retract(null, part)
	// also retract any deployables
	if(victim.wear_suit)
		var/datum/component/toggle_attached_clothing/hood_component = victim.wear_suit.GetComponent(/datum/component/toggle_attached_clothing)
		hood_component?.remove_deployable()
	for(var/obj/item/equipped as anything in victim.get_equipped_items(INCLUDE_POCKETS))
		if(equipped.item_flags & (DROPDEL | ABSTRACT | HAND_ITEM))
			continue
		if(HAS_TRAIT(equipped, TRAIT_NODROP))
			continue
		var/slot = victim.get_slot_by_item(equipped)
		if(slot)
			items_per_slot[equipped] = slot

/obj/item/organ/brain/slime/proc/do_steam_effects(turf/loc)
	return // uncomment after upstream merge
	/* var/datum/effect_system/steam_spread/steam = new()
	steam.set_up(10, FALSE, loc)
	steam.start() */

///////
/// CHECK FOR REPAIR SECTION
/// Makes it so that when a slime's core has plasma poured on it, it builds a new body and moves the brain into it.

/obj/item/organ/brain/slime/check_for_repair(obj/item/item, mob/user)
	if(item.is_drainable() && item.reagents.has_reagent(/datum/reagent/toxin/plasma)) //attempt to heal the brain

		if(HAS_TRAIT(brainmob, TRAIT_DNR))
			to_chat(user, span_warning("The soul of [src] has departed..."))
			user.balloon_alert(user, "core's soul has departed...")
			return FALSE

		if(item.reagents.get_reagent_amount(/datum/reagent/toxin/plasma) < 100)
			user.balloon_alert(user, "too little plasma!")
			return FALSE

		user.visible_message(
			span_notice("[user] starts to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its cytoskeleton outwards..."),
			span_notice("You start to slowly pour the contents of [item] onto [src]. It seems to bubble and roil, beginning to stretch its membrane outwards..."),
			span_hear("You hear bubbling.")
		)
		user.balloon_alert_to_viewers("pouring plasma...")

		if(brainmob)
			brainmob.notify_revival("Someone is pouring plasma on your core!", source = src)
			brainmob.grab_ghost()

		being_repaired = TRUE
		if(!do_after(user, 30 SECONDS, src))
			being_repaired = FALSE
			to_chat(user, span_warning("You failed to pour the contents of [item] onto [src]!"))
			return FALSE
		being_repaired = FALSE

		if(HAS_TRAIT(brainmob, TRAIT_DNR))
			to_chat(user, span_warning("The soul of [src] has departed..."))
			user.balloon_alert(user, "core's soul has departed...")
			return FALSE

		if(item.reagents.get_reagent_amount(/datum/reagent/toxin/plasma) < 100) // minor exploit but might as well patch it
			user.balloon_alert(user, "too little plasma!")
			return FALSE

		user.visible_message(
			span_notice("[user] pours the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane."),
			span_notice("You pour the contents of [item] onto [src], causing it to form a proper cytoplasm and outer membrane."),
			span_hear("You hear a splat.")
		)

		item.reagents.remove_reagent(/datum/reagent/toxin/plasma, 100)
		rebuild_body(user)
		return TRUE
	return ..()

// Don't decay if someone's pouring plasma on us, or if we're inside a legion.
/obj/item/organ/brain/slime/on_death(seconds_per_tick)
	if(!istype(loc, /mob/living/basic/mining/legion) && !being_repaired)
		return ..()

///////
/// PROCESS ITEMS FOR CORE EJECTION
/// Processes different types of items and prepares them to be stored when the core is ejected.

/obj/item/organ/brain/slime/proc/process_items(mob/living/carbon/human/victim) // Handle all items to be stored into core.
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

	for(var/datum/action/item_action/activate_pill/pill_action in victim.actions) // Store dental implants
		pill_action.Remove(victim)
		var/obj/pill = pill_action.target
		if(istype(pill))
			process_and_store_item(pill, victim)

	for(var/obj/item/implant/curimplant in victim.implants) // Process and store implants
		if(curimplant.removed(victim))
			var/obj/item/implantcase/case =  new /obj/item/implantcase
			case.imp = curimplant
			curimplant.forceMove(case) //Recase implant it doesn't like to be moved without it.
			case.update_appearance()
			process_and_store_item(case, victim)

	for(var/obj/item/organ/organ as anything in victim.organs) // Process and store organ implants and related organs
		if(is_type_in_typecache(organ, allowed_organ_types))
			organ.Remove(victim)
			process_and_store_item(organ, victim)

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

/obj/item/organ/brain/slime/proc/drop_items_to_ground(turf/turf, list/dropping = stored_items, explode = FALSE)
	for(var/atom/movable/item as anything in dropping)
		if(!(item in stored_items))
			continue
		if(istype(item, /obj/item/implantcase)) // Delete implants that aren't re-implanted. For now.
			qdel(item)
		else if(explode)
			brainmob.dropItemToGround(item)
		else
			item.forceMove(turf)
		stored_items -= item

/obj/item/organ/brain/slime/proc/reequip_items(mob/living/carbon/human/body)
	for(var/i, slot in items_per_slot)
		var/obj/item/item = i
		if(QDELETED(item))
			continue
		body.equip_to_slot(item, slot)
		if(body.get_item_by_slot(slot) == item)
			stored_items -= item
	items_per_slot.Cut()

/obj/item/organ/brain/slime/proc/rebuild_body(mob/user, nugget = TRUE) as /mob/living/carbon/human
	if(rebuilt)
		return owner

	GLOB.dead_slime_cores -= src
	set_organ_damage(0) // heals the brain fully

	if(istype(loc, /mob/living/basic/mining/legion))
		var/mob/living/basic/mining/legion/legion = loc
		legion.gib()
	else if(istype(loc, /obj/effect/abstract/chasm_storage))
		// oh fuck we're reviving in a chasm somehow, uhhhh, quick, find us the nearest non-chasm turf
		for(var/turf/turf as anything in spiral_range_turfs(5, get_turf(src), TRUE))
			if(!isopenturf(turf) || isgroundlessturf(turf) || turf.is_blocked_turf(exclude_mobs = TRUE))
				continue
			forceMove(turf)
			break

	if(gps_active) // making sure the gps signal is removed if it's active on revival
		qdel(GetComponent(/datum/component/gps))

	//we have the plasma. we can rebuild them.
	brainmob?.mind?.grab_ghost()
	if(isnull(mind))
		if(isnull(brainmob))
			user?.balloon_alert(user, "this core is not a viable candidate for repair!")
			return null
		if(isnull(brainmob.stored_dna))
			user?.balloon_alert(user, "this core does not contain any dna!")
			return null
		if(isnull(brainmob.client))
			user?.balloon_alert(user, "this core does not contain a mind!")
			return null

	if(ismob(loc))
		var/mob/holder = loc
		holder.dropItemToGround(src, force = TRUE, silent = TRUE)

	var/mob/living/carbon/human/new_body = new /mob/living/carbon/human(drop_location())

	rebuilt = TRUE

	var/client/original_client = brainmob?.client || mind?.current?.client
	original_client?.prefs?.safe_transfer_prefs_to(new_body)
	if(stored_language_holder)
		new_body.get_language_holder()?.copy_languages(stored_language_holder)
		QDEL_NULL(stored_language_holder)
	if(blooper_id)
		new_body.set_blooper(blooper_id)
		new_body.blooper_pitch = blooper_pitch
		new_body.blooper_pitch_range = blooper_pitch_range
		new_body.blooper_volume = blooper_volume
		new_body.blooper_speed = blooper_speed
	new_body.underwear = "Nude"
	new_body.undershirt = "Nude"
	new_body.socks = "Nude"
	stored_dna.copy_dna(new_body.dna, COPY_DNA_SE | COPY_DNA_SPECIES)
	new_body.real_name = new_body.dna.real_name
	new_body.name = new_body.dna.real_name
	new_body.updateappearance(mutcolor_update = TRUE)
	new_body.domutcheck()
	new_body.forceMove(drop_location())
	if(!nugget)
		new_body.set_nutrition(NUTRITION_LEVEL_FED)
		reequip_items(new_body)
	REMOVE_TRAIT(new_body, TRAIT_NO_TRANSFORM, REF(src))
	if(!isnull(stored_quirks))
		for(var/datum/quirk/quirk in stored_quirks)
			quirk.add_to_holder(new_body, quirk_transfer = TRUE) // Return their old quirk to them.
		stored_quirks.Cut()
	if(original_client)
		SSquirks.AssignQuirks(new_body, original_client, blacklist = assoc_to_keys(skip_quirks)) // Still need to copy over the rest of their quirks.
	replace_into(new_body)
	if(nugget)
		for(var/obj/item/bodypart/bodypart as anything in new_body.bodyparts)
			if(istype(bodypart, /obj/item/bodypart/chest))
				continue
			bodypart.drop_limb() // Drop limb should delete the limb for oozelings unless someone changes it.
		new_body.set_blood_volume(BLOOD_VOLUME_OKAY)
		new_body.visible_message(span_warning("[new_body]'s torso \"forms\" from [new_body.p_their()] core, yet to form the rest."))
		to_chat(owner, span_purple("Your torso fully forms out of your core, yet to form the rest."))
		//Make oozelings revive similar to other species.
		new_body.set_jitter_if_lower(200 SECONDS)
		INVOKE_ASYNC(new_body, TYPE_PROC_REF(/mob, emote), "scream")
	else
		new_body.visible_message(
			span_warning("[new_body]'s body fully forms from [new_body.p_their()] core!"),
			span_purple("Your body fully forms from your core!")
		)

	if(!QDELETED(brainmob))
		membrane_mur.Remove(brainmob)
	brainmob?.mind?.transfer_to(new_body)
	new_body.grab_ghost()
	transfer_observers_to(new_body)
	to_chat(owner, span_danger("[CONFIG_GET(string/blackoutpolicy)]"))

	drop_items_to_ground(new_body.drop_location())

	if(mind)
		SEND_SIGNAL(mind, COMSIG_SLIME_REVIVED, new_body, src)
	return new_body

/obj/item/organ/brain/slime/Topic(href, list/href_list)
	. = ..()
	if(href_list["core_item"])
		if(!core_ejected || !iscarbon(usr) || !usr.can_perform_action(src, NEED_DEXTERITY | NEED_HANDS | FORBID_TELEKINESIS_REACH | ALLOW_RESTING))
			return
		var/obj/item/core_item = locate(href_list["core_item"]) in stored_items
		if(core_item)
			drop_items(usr, list(core_item))

ADMIN_VERB(cmd_admin_heal_slime, R_ADMIN, "Heal Slime Core", "Use this to heal Slime cores.", ADMIN_CATEGORY_DEBUG, obj/item/organ/brain/slime/core in GLOB.dead_slime_cores)
	if(QDELETED(core))
		to_chat(user, span_boldannounce("Invalid Slime Core."), confidential = TRUE)
		return
	var/mob/living/carbon/human/new_body = core.rebuild_body(nugget = FALSE)

	var/log_msg
	var/msg
	if(!isnull(new_body))
		log_msg = "[key_name(user)] healed / revived [key_name(new_body)]"
		msg = span_danger("Admin [key_name_admin(user)] healed / revived [ADMIN_LOOKUPFLW(new_body)]!")
	else
		log_msg = "[key_name(user)] attempted to heal / revive [key_name(core)]. A body was not reconstructed."
		msg = span_danger("Admin [key_name_admin(user)] attempted to heal / revive [ADMIN_LOOKUPFLW(core)]! A body was not reconstructed.")
	log_admin(log_msg)
	message_admins(msg)
	admin_ticket_log(new_body, log_msg)
	BLACKBOX_LOG_ADMIN_VERB("Heal Slime Core")

/obj/item/organ/brain/slime/oversized
	brain_size = 2
