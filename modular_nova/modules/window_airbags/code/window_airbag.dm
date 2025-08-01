#define DISARM_TIME (3 SECONDS)

/obj/structure/window/reinforced/fulltile/Initialize(mapload, direct)
	. = ..()
	AddElement(/datum/element/airbag)

/obj/structure/window/plasma/fulltile/Initialize(mapload, direct)
	. = ..()
	AddElement(/datum/element/airbag)

/**
 * Airbag Element
 *
 * Basically a fancy create on destroy.
 */
/datum/element/airbag
	/// The type we spawn when our parent is destroyed
	var/airbag_type = /obj/item/airbag/immediate_arm
	/// The type we spawn when we are disarmed.
	var/disarmed_type = /obj/item/airbag

/datum/element/airbag/Attach(datum/target)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_DESTRUCTION, PROC_REF(deploy_airbag))
	RegisterSignal(target, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(on_interact))
	RegisterSignal(target, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM, PROC_REF(on_requesting_context_from_item))

/datum/element/airbag/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, list(COMSIG_ATOM_DESTRUCTION, COMSIG_CLICK_CTRL_SHIFT, COMSIG_ATOM_REQUESTING_CONTEXT_FROM_ITEM))

/datum/element/airbag/proc/deploy_airbag(atom/movable/destroying_atom, damage_flag)
	SIGNAL_HANDLER
	new airbag_type(get_turf(destroying_atom))

/datum/element/airbag/proc/on_interact(atom/movable/clicked_atom, mob/living/clicker)
	SIGNAL_HANDLER
	if(!clicker.can_interact_with(clicked_atom) || !clicker.can_perform_action(clicked_atom, ALLOW_RESTING))
		return
	INVOKE_ASYNC(src, PROC_REF(disarm_airbag), clicked_atom, clicker)

/datum/element/airbag/proc/disarm_airbag(atom/movable/clicked_atom, mob/living/clicker)
	var/empty_hand = LAZYACCESS(clicker.get_empty_held_indexes(), 1)
	if(!empty_hand)
		clicked_atom.balloon_alert(clicker, "no empty hand!")
		return
	clicked_atom.balloon_alert_to_viewers("disarming airbag...")
	if(do_after(clicker, DISARM_TIME, clicked_atom))
		playsound(clicked_atom, 'sound/machines/click.ogg', 75, TRUE, -3)
		clicker.put_in_hands(new disarmed_type(clicker))
		Detach(clicked_atom)

/datum/element/airbag/proc/on_requesting_context_from_item(atom/source, list/context, obj/item/held_item, mob/user)
	SIGNAL_HANDLER
	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Disarm airbag"
	return CONTEXTUAL_SCREENTIP_SET

// A fun little gadget!
/obj/item/airbag
	name = "airbag"
	desc = "A small package with an explosive attached. Stand clear!"
	icon = 'modular_nova/modules/inflatables/icons/inflatable.dmi'
	icon_state = "airbag_safe"
	base_icon_state = "airbag"
	max_integrity = 10
	/// The time in which we deploy
	var/detonate_time = 2 SECONDS
	/// The item we drop on detonation
	var/drop_type = /obj/structure/inflatable/window_airbag
	/// Are we immediately armed?
	var/immediate_arm = FALSE
	/// Are we currently armed?
	var/armed = FALSE
	/// The sound we play when armed
	var/armed_sound = 'modular_nova/modules/window_airbags/sound/airbag_arm.ogg'
	/// The sound we play when we go bang
	var/bang_sound = 'modular_nova/modules/window_airbags/sound/airbag_bang.ogg'

/obj/item/airbag/Initialize(mapload)
	. = ..()
	if(immediate_arm)
		arm()
		anchored = TRUE

/obj/item/airbag/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[armed ? "armed" : "safe"]"

/obj/item/airbag/attack_self(mob/user, modifiers)
	. = ..()
	arm()

/obj/item/airbag/proc/arm()
	if(armed)
		return
	if(!anchored)
		addtimer(CALLBACK(src, PROC_REF(deploy_anchor)), 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(bang)), detonate_time)
	armed = TRUE
	playsound(src, armed_sound, 50)
	update_appearance()

// Anchors the airbag to the ground, namely to prevent air movement.
/obj/item/airbag/proc/deploy_anchor()
	if(!isturf(loc) || anchored)
		return
	anchored = TRUE

// Detonates the airbag, dropping the item and playing the sound.
/obj/item/airbag/proc/bang()
	var/obj/created_object = new drop_type(get_turf(src))
	playsound(src, bang_sound, 50, pressure_affected = FALSE)
	do_smoke(1, 1, created_object, get_turf(src))
	qdel(src)

/obj/item/airbag/immediate_arm
	immediate_arm = TRUE

/obj/structure/inflatable/window_airbag
	name = "window airbag"
	desc = "A quick deploying airbag that seals holes when a window is broken!"
	icon_state = "airbag_wall"
	torn_type = null // No debris left behind!
	deflated_type = null

#undef DISARM_TIME
