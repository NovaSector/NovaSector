/mob/living
	var/piggyback_flags = RIDER_NEEDS_ARMS

/// Allows the attached item to enable saddle mechanics on the mob wearing it.
/datum/component/carbon_saddle
	var/piggyback_flags = RIDER_NEEDS_ARM|RIDING_TAUR

/datum/component/carbon_saddle/Initialize(piggyback_flags)
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if (!isnull(piggyback_flags))
		src.piggyback_flags = piggyback_flags
	
/datum/component/carbon_saddle/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(parent_equipped))

/datum/component/carbon_saddle/UnregisterFromParent()    
	var/obj/item/item_parent = parent
	UnregisterSignal(item_parent, COMSIG_ITEM_EQUIPPED)
	
/datum/component/carbon_saddle/proc/parent_equipped(datum/signal_source, mob/equipper, slot)
	SIGNAL_HANDLER

	RegisterSignal(equipper, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(mob_unequipped_item))

	if (isliving(equipper) && !(equipper.get_slot_by_item(parent) & (ITEM_SLOT_HANDS|ITEM_SLOT_POCKETS))) // ITEM_SLOT_BACK CHECK IS A PLACEHOLDER
		var/mob/living/living_mob = equipper
		living_mob.piggyback_flags = piggyback_flags

/datum/component/carbon_saddle/proc/mob_unequipped_item(mob/signal_source, obj/item/item, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	if (item == parent)
		mob_unequipped_parent(signal_source)
		UnregisterSignal(signal_source, COMSIG_MOB_UNEQUIPPED_ITEM)

/datum/component/carbon_saddle/proc/mob_unequipped_parent(mob/target)
	if (isliving(target))
		var/mob/living/living_mob = target
		living_mob.piggyback_flags = initial(living_mob.piggyback_flags)
