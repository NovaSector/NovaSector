/// Allows usage of the item as a blanket to cover others
/datum/component/cloth_blanket
	var/datum/weakref/signal_sleeper
	var/datum/weakref/parent_weakref
	/// The sprite rotation degree - how many degrees we need to turn the item to get to the left/right side
	var/rotation_degree = 0

/datum/component/cloth_blanket/Initialize(mapload)
	. = ..()

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	parent_weakref = WEAKREF(parent)

	var/obj/item/parent_cloth = parent_weakref?.resolve()
	parent_cloth.register_item_context()

/datum/component/cloth_blanket/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_REQUESTING_CONTEXT_FOR_TARGET, PROC_REF(add_item_context))
	RegisterSignal(parent, COMSIG_ITEM_PRE_ATTACK_SECONDARY, PROC_REF(cover_somebody))

/datum/component/cloth_blanket/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_REQUESTING_CONTEXT_FOR_TARGET, COMSIG_ITEM_PRE_ATTACK_SECONDARY)

/datum/component/cloth_blanket/proc/coverup(mob/living/sleeper)
	var/obj/item/parent_cloth = parent_weakref?.resolve()
	rotation_degree = sleeper.lying_prev

	parent_cloth.layer = ABOVE_MOB_LAYER
	parent_cloth.pixel_x = rotation_degree & EAST ? sleeper.pixel_x + 2 : sleeper.pixel_x - 2 // making sure the jacket doesn't cover the sleeper's face
	parent_cloth.pixel_y = sleeper.pixel_y
	parent_cloth.balloon_alert(sleeper, "covered")

	signal_sleeper = WEAKREF(sleeper)
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(sleeper, COMSIG_MOVABLE_MOVED, PROC_REF(smooth_clothes))
	RegisterSignal(sleeper, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(smooth_clothes))
	RegisterSignal(sleeper, COMSIG_QDELETING, PROC_REF(smooth_clothes))

	parent_cloth.transform = turn(parent_cloth.transform, rotation_degree) // rotating the sprite to match the direction of the sleeper

// cleaning the signals and rotating the clothes back to original state
/datum/component/cloth_blanket/proc/uncoverup(mob/living/sleeper)
	var/obj/item/parent_cloth = parent_weakref?.resolve()
	UnregisterSignal(parent, COMSIG_ITEM_PICKUP)
	UnregisterSignal(sleeper, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(sleeper, COMSIG_LIVING_SET_BODY_POSITION)
	UnregisterSignal(sleeper, COMSIG_QDELETING)
	signal_sleeper = null
	parent_cloth.transform = turn(parent_cloth.transform, -rotation_degree)

/datum/component/cloth_blanket/proc/add_item_context(obj/item/source, list/context, mob/living/target, mob/living/user)
	SIGNAL_HANDLER

	if(isliving(target) && target.body_position == LYING_DOWN)
		context[SCREENTIP_CONTEXT_RMB] = "Cover"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/datum/component/cloth_blanket/proc/on_pickup(datum/source, mob/grabber)
	SIGNAL_HANDLER

	var/mob/living/sleeper = signal_sleeper?.resolve()
	uncoverup(sleeper)

/datum/component/cloth_blanket/proc/cover_somebody(obj/item/source, mob/living/target, mob/user, params)
	SIGNAL_HANDLER

	if(!user.CanReach(target))
		return
	if(target.body_position != LYING_DOWN)
		return
	var/obj/item/parent_cloth = parent_weakref?.resolve()
	if(!user.dropItemToGround(parent_cloth))
		return

	parent_cloth.forceMove(get_turf(target))
	parent_cloth.balloon_alert(user, "covered")
	coverup(target)
	parent_cloth.add_fingerprint(user)

	. = COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

// the clothes fall off if the sleeper moves/stands up/gets disintegrated by admins
/datum/component/cloth_blanket/proc/smooth_clothes(mob/living/sleeper)
	SIGNAL_HANDLER

	var/obj/item/parent_cloth = parent_weakref?.resolve()
	parent_cloth.balloon_alert(sleeper, "smoothed clothes")
	parent_cloth.layer = initial(parent_cloth.layer)
	uncoverup(sleeper)
