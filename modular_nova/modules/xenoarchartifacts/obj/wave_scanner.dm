/obj/item/xenoarch/wave_scanner_backpack
	name = "Alden-Saraspova wave scanner backpack"
	desc = "Old NanoTrasen wave scanner, designed to search and analyze exotic waves."
	slot_flags = ITEM_SLOT_BACK
	icon = 'modular_nova/modules/xenoarchartifacts/icons/tools.dmi'
	worn_icon = 'modular_nova/modules/xenoarchartifacts/icons/worn.dmi'
	icon_state = "wave_scanner"
	worn_icon_state = "wave_scanner"
	w_class = 3

	var/obj/item/xenoarch/searcher/processor

/obj/item/xenoarch/wave_scanner_backpack/Initialize(mapload)
	. = ..()
	processor = new(src, src)

/obj/item/xenoarch/wave_scanner_backpack/ui_action_click()
	toggle_searcher()

// Tries to put searcher in hand
/obj/item/xenoarch/wave_scanner_backpack/verb/toggle_searcher()
	set name = "Toggle Searcher"
	set category = "Object"

	if(!usr)
		return

	if(usr.incapacitated)
		return

	var/mob/user = usr
	if(!user.get_item_by_slot(ITEM_SLOT_BACK) == src)
		to_chat(usr, span_warning("The [src] must be worn properly to use!"))
		return

	if(processor.loc == src)
		// Detach the searcher into the user's hands
		if(!user.put_in_hands(processor))
			to_chat(user, span_warning("You need a free hand to hold the [processor]!"))
			return
		playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
	else
		// Remove from their hands and put back "into" the backpack
		remove_processor()

/obj/item/xenoarch/wave_scanner_backpack/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_BACK)
		remove_processor()

/**
 * Removes processor from hands if the backpack is dropped
 */
/obj/item/xenoarch/wave_scanner_backpack/proc/remove_processor()
	if(!processor)
		return

	if(ismob(processor.loc))
		var/mob/mob_loc = processor.loc
		if(mob_loc.dropItemToGround(processor))
			to_chat(mob_loc, span_notice("The [processor] snaps back into the [src]."))
			playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
	else
		processor.forceMove(src)

/obj/item/xenoarch/wave_scanner_backpack/Destroy()
	if(processor)
		QDEL_NULL(processor)
	return ..()

/obj/item/xenoarch/wave_scanner_backpack/attack_hand(mob/user)
	if(loc == user)
		ui_action_click()
		return
	return ..()

/obj/item/xenoarch/wave_scanner_backpack/attack_hand_secondary(mob/user, list/modifiers)
	attempt_pickup(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/xenoarch/wave_scanner_backpack/attackby(obj/item/attacking_item, mob/user, params)
	if(attacking_item == processor)
		remove_processor()
	else
		return ..()

/obj/item/xenoarch/wave_scanner_backpack/dropped(mob/user)
	. = ..()
	remove_processor()

/obj/item/xenoarch/searcher
	name = "exotic wave searcher"
	desc = "Searches for exotic waves."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/tools.dmi'
	icon_state = "wave_searcher"
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_range = 0
	slot_flags = null
	var/nearest_artifact_distance = -1
	var/last_scan_time = 0
	var/scan_delay = 25

	var/obj/item/xenoarch/wave_scanner_backpack/wavescanner

/obj/item/xenoarch/searcher/Initialize(mapload, source_wavescanner)
	. = ..()
	scan()
	wavescanner = source_wavescanner

/obj/item/xenoarch/searcher/Destroy(force)
	if(wavescanner)
		wavescanner.processor = null
	return ..()

/obj/item/xenoarch/searcher/dropped(mob/user)
	. = ..()
	if(wavescanner)
		wavescanner.remove_processor()
		playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
	else
		playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
		qdel(src)

/obj/item/xenoarch/searcher/afterattack(atom/target, mob/user, proximity, params)
	if(target.loc == loc || target == wavescanner)
		return
	return ..()

/obj/item/xenoarch/searcher/after_throw(datum/callback/callback)
	. = ..()
	if(wavescanner)
		wavescanner.remove_processor()
		playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
	else
		playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 50, FALSE)
		qdel(src)
	return

/obj/item/xenoarch/searcher/attack_self(mob/user)
	return interact(user)

/obj/item/xenoarch/searcher/interact(mob/user)
	var/message = "Background radiation levels detected."
	if(world.time - last_scan_time >= scan_delay)
		playsound(src, 'sound/machines/terminal/terminal_alert.ogg', 25, 10)
		INVOKE_ASYNC(src, .proc/scan)
		if(nearest_artifact_distance >= 0)
			message = "Exotic energy detected in a radius of [nearest_artifact_distance]m"
	else
		message = "Scanning array is recharging."

	to_chat(user, span_info("[message]"))

/**
 * Scans current Z level for rocks with artifacts with them
 */
/obj/item/xenoarch/searcher/proc/scan()
	last_scan_time = world.time
	nearest_artifact_distance = -1
	var/turf/cur_turf = get_turf(src)
	for(var/turf/closed/mineral/strange_rock/artifact_turf in GLOB.artifact_turfs)
		if(!artifact_turf || !cur_turf)
			continue
		if(artifact_turf.z == cur_turf.z)
			var/cur_dist = get_dist(cur_turf, artifact_turf) * 2
			if(nearest_artifact_distance < 0 || cur_dist < nearest_artifact_distance)
				nearest_artifact_distance = cur_dist + rand() * 2 - 1
	visible_message(
		span_info("[src] clicks."),
		blind_message = span_notice("You hear click nearby."),
	)
