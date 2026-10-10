/// This code injects into the slot-machine curse system to allow it to be curable with holy water, or by limb removal.
/datum/status_effect/slot_machine_curse/on_apply()
	. = ..()
	if(.)
		RegisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB, PROC_REF(on_limb_removed))

/datum/status_effect/slot_machine_curse/Destroy()
	UnregisterSignal(owner, COMSIG_CARBON_REMOVE_LIMB)
	return ..()

/datum/status_effect/slot_machine_curse/proc/on_limb_removed(mob/living/carbon/source, obj/item/bodypart/lost_limb)
	SIGNAL_HANDLER
	if(lost_limb == branded_hand)
		clear_curses()

// Around ten units of holy water metabolized will break the slot-machine curse.
/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(data["deciseconds_metabolized"] < 25 SECONDS)
		return

	var/datum/status_effect/slot_machine_curse/curse = affected_mob.has_status_effect(/datum/status_effect/slot_machine_curse)
	curse?.clear_curses()
