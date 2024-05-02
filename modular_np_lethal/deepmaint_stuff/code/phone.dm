/obj/item/gakster_phone
	name = "\improper MODlink transmitter"
	desc = "An intricate piece of machinery that creates a holographic video call with another MODlink-compatible device."
	icon = 'icons/obj/antags/gang/cell_phone.dmi'
	icon_state = "phone_off"
	actions_types = list(/datum/action/item_action/call_link)
	w_class = WEIGHT_CLASS_SMALL
	/// The MODlink datum we operate.
	var/datum/mod_link/mod_link
	/// Initial frequency of the MODlink.
	var/starting_frequency = "NT"
	/// An additional name tag for the scryer, seen as "MODlink scryer - [label]"
	var/label

/obj/item/gakster_phone/Initialize(mapload)
	. = ..()
	mod_link = new(
		src,
		starting_frequency,
		CALLBACK(src, PROC_REF(get_user)),
		CALLBACK(src, PROC_REF(can_call)),
		CALLBACK(src, PROC_REF(make_link_visual)),
		CALLBACK(src, PROC_REF(get_link_visual)),
		CALLBACK(src, PROC_REF(delete_link_visual))
	)
	START_PROCESSING(SSobj, src)

/obj/item/gakster_phone/Destroy()
	QDEL_NULL(mod_link)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gakster_phone/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>in hand</b> to set <b>name</b>.")

/obj/item/gakster_phone/dropped(mob/living/user)
	. = ..()
	mod_link?.end_call()

/obj/item/gakster_phone/attack_self(mob/user, modifiers)
	var/new_label = reject_bad_text(tgui_input_text(user, "Change the visible name", "Set Name", label, MAX_NAME_LEN))
	if(!user.is_holding(src))
		return
	if(!new_label)
		balloon_alert(user, "invalid name!")
		return
	label = new_label
	balloon_alert(user, "name set")
	update_name()

/obj/item/gakster_phone/update_name(updates)
	. = ..()
	name = "[initial(name)][label ? " - [label]" : ""]"

/obj/item/gakster_phone/ui_action_click(mob/user)
	if(mod_link.link_call)
		mod_link.end_call()
	else
		call_link(user, mod_link)

/obj/item/gakster_phone/proc/get_user()
	var/mob/living/carbon/user = loc
	if(istype(user))
		return user
	return null

/obj/item/gakster_phone/proc/can_call()
	var/mob/living/user = loc
	return istype(user) && user.stat < DEAD

/obj/item/gakster_phone/proc/make_link_visual()
	var/mob/living/user = mod_link.get_user_callback.Invoke()
	user.update_worn_neck()
	icon_state = "phone_on"
	return make_link_visual_generic(mod_link, PROC_REF(on_overlay_change))

/obj/item/gakster_phone/proc/get_link_visual(atom/movable/visuals)
	return get_link_visual_generic(mod_link, visuals, PROC_REF(on_user_set_dir))

/obj/item/gakster_phone/proc/delete_link_visual()
	var/mob/living/user = mod_link.get_user_callback.Invoke()
	if(!QDELETED(user))
		user.update_worn_neck()
	icon_state = "phone_off"
	return delete_link_visual_generic(mod_link)

/obj/item/gakster_phone/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	. = ..()
	if(iseffect(speaker))
		return
	if((speaker != loc) && !(speaker in loc))
		return
	mod_link.visual.say(raw_message, sanitize = FALSE, message_range = 3)

/obj/item/gakster_phone/proc/on_overlay_change(atom/source, cache_index, overlay)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(update_link_visual)), 1 TICKS, TIMER_UNIQUE)

/obj/item/gakster_phone/proc/update_link_visual()
	if(QDELETED(mod_link.link_call))
		return
	var/mob/living/user = loc
	mod_link.visual.cut_overlay(mod_link.visual_overlays)
	mod_link.visual_overlays = user.overlays - user.active_thinking_indicator
	mod_link.visual.add_overlay(mod_link.visual_overlays)

/obj/item/gakster_phone/proc/on_user_set_dir(atom/source, dir, newdir)
	SIGNAL_HANDLER
	on_user_set_dir_generic(mod_link, newdir || SOUTH)
