#define CYBORG_PICKED_UP_FILTER "cyborg_pickup"

/// Cheap component that handles extra behavior for cyborg items, like an outline, or properly resetting modules if they're dropped
/datum/component/cyborg_hand_item
	var/outline_colour = "#fcff00"
	/// The cyborg that's actually holding us
	var/datum/weakref/holding_robot

/datum/component/cyborg_hand_item/Initialize(mob/living/silicon/robot/host)
	if (!isitem(parent) || !iscyborg(host))
		return COMPONENT_INCOMPATIBLE

	holding_robot = WEAKREF(host)
	var/obj/item/thing = parent
	RegisterSignal(thing, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(before_unequip))
	RegisterSignal(thing, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))
	thing.add_filter(CYBORG_PICKED_UP_FILTER, 9, list("type" = "outline", "color" = outline_colour, "size" = 1))

/datum/component/cyborg_hand_item/proc/before_unequip(obj/item/thing)
	SIGNAL_HANDLER

	// clear our module here since we just dropped the item to avoid shenanigans
	// looks jank, but the other alternative is a low-level /mob proc and NOBODY wants that
	var/mob/living/silicon/robot/robor = holding_robot.resolve()
	if (robor.module_active == thing)
		robor.deselect_module(robor.active_hand_index)

/datum/component/cyborg_hand_item/proc/on_dropped(obj/item/dropped_outlined_thing)
	SIGNAL_HANDLER

	dropped_outlined_thing.remove_filter(CYBORG_PICKED_UP_FILTER)
	qdel()

#undef CYBORG_PICKED_UP_FILTER
