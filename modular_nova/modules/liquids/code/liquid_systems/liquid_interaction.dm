///This element allows for items to interact with liquids on turfs.
/datum/element/liquids_interaction

/datum/element/liquids_interaction/Attach(datum/target)
	. = ..()

	if(!istype(target, /obj/item))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ITEM_INTERACTING_WITH_ATOM, PROC_REF(item_interaction)) // The only signal allowing item -> turf interaction

/datum/element/liquids_interaction/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, COMSIG_ITEM_INTERACTING_WITH_ATOM)

/datum/element/liquids_interaction/proc/item_interaction(datum/source, mob/living/user, atom/target, modifiers)
	SIGNAL_HANDLER

	var/turf/turf_target = target
	if(!isturf(target) || !turf_target.liquids)
		return NONE

	var/obj/item/source_item = source
	if(source_item.attack_liquids_turf(turf_target, user, turf_target.liquids))
		return ITEM_INTERACT_SUCCESS

/**
 * What happens when you attack a liquids turf with this attom
 * Arguments:
 * * target_turf - On which turf this is occurring
 * * user - Who is attacking?
 * * liquids - The liquids we are interacting with
 */
/atom/proc/attack_liquids_turf(turf/target_turf, mob/living/user, obj/effect/abstract/liquid_turf/liquids)
	return
