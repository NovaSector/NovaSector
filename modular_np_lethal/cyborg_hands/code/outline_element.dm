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
	RegisterSignal(thing, COMSIG_ITEM_STORED, PROC_REF(on_stored))
	RegisterSignal(thing, COMSIG_ITEM_DROPPED, PROC_REF(on_dropped))
	thing.add_filter(CYBORG_PICKED_UP_FILTER, 9, list("type" = "outline", "color" = outline_colour, "size" = 1))

/datum/component/cyborg_hand_item/proc/clear_module(forced = FALSE)
	// clear the cyborg's module here since we just dropped the item to avoid shenanigans
	// looks jank, but the other alternative is a low-level /mob proc and NOBODY wants that
	var/obj/item/thing = parent
	var/mob/living/silicon/robot/robor = holding_robot.resolve()
	if (forced || robor.module_active == thing)
		robor.deselect_module(robor.active_hand_index)
	if (forced)
		robor.hud_used.persistent_inventory_update()

/datum/component/cyborg_hand_item/proc/cleanup()
	var/obj/item/thing = parent
	thing.remove_filter(CYBORG_PICKED_UP_FILTER)
	qdel()

/datum/component/cyborg_hand_item/proc/before_unequip(obj/item/thing)
	SIGNAL_HANDLER

	clear_module()

/datum/component/cyborg_hand_item/proc/on_stored(obj/item/thing)
	SIGNAL_HANDLER
	// we want to both clear the module and then cleanup

	clear_module(forced = TRUE)
	cleanup()

/datum/component/cyborg_hand_item/proc/on_dropped(obj/item/dropped_outlined_thing)
	SIGNAL_HANDLER
	clear_module() //just to be like, extra sure, i guess?
	cleanup()

#undef CYBORG_PICKED_UP_FILTER
