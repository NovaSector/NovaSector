/mob/living
	/// Flags passed into piggyback()'s buckle_mob() call in the buckle_mob_flags arg.
	var/piggyback_flags = RIDER_NEEDS_ARMS

/// Allows the attached item to enable saddle mechanics on the mob wearing it.
/datum/component/carbon_saddle
	/// The piggyback flags to apply to any mob that wears parent.
	var/piggyback_flags = RIDER_NEEDS_ARM|RIDING_TAUR
	/// If our parent does not have this organ, we cannot be equipped by them.
	var/obj/item/organ/required_organ = /obj/item/organ/external/taur_body

/datum/component/carbon_saddle/Initialize(piggyback_flags)
	if (!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if (!isnull(piggyback_flags))
		src.piggyback_flags = piggyback_flags

/datum/component/carbon_saddle/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(parent_equipped))
	RegisterSignal(parent, COMSIG_ITEM_MOB_CAN_EQUIP, PROC_REF(parent_can_equip))

/datum/component/carbon_saddle/UnregisterFromParent()
	var/obj/item/item_parent = parent
	UnregisterSignal(item_parent, COMSIG_ITEM_EQUIPPED)

/datum/component/carbon_saddle/proc/parent_can_equip(obj/item/signal_source, mob/living/target, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if (!(slot & (ITEM_SLOT_HANDS|ITEM_SLOT_POCKETS)))
		return

	if (required_organ && !wearer_has_requisite_organ(target))
		return COMPONENT_ITEM_CANT_EQUIP

/datum/component/carbon_saddle/proc/parent_equipped(datum/signal_source, mob/equipper, slot)
	SIGNAL_HANDLER

	if (!isliving(equipper))
		return
	var/mob/living/living_equipper = equipper

	RegisterSignal(living_equipper, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(mob_unequipped_item))
	RegisterSignal(living_equipper, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(wearer_lost_organ))

	living_equipper.piggyback_flags = piggyback_flags

/datum/component/carbon_saddle/proc/mob_unequipped_item(mob/signal_source, obj/item/item, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	if (item == parent)
		mob_unequipped_parent(signal_source)
		UnregisterSignal(signal_source, list(COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_CARBON_LOSE_ORGAN))

/datum/component/carbon_saddle/proc/mob_unequipped_parent(mob/target)
	if (isliving(target))
		var/mob/living/living_mob = target
		living_mob.piggyback_flags = initial(living_mob.piggyback_flags)

/datum/component/carbon_saddle/proc/wearer_lost_organ(mob/living/carbon/signal_source, /obj/item/organ/lost)
	SIGNAL_HANDLER

	if (!wearer_has_requisite_organ(signal_source))
		var/obj/item/item_parent = parent
		item_parent.forceMove(get_turf(item_parent)) // force unequip

/datum/component/carbon_saddle/proc/wearer_has_requisite_organ(mob/target)
	if (!iscarbon(target))
		return TRUE

	var/mob/living/carbon/carbon_target = target
	for (var/obj/item/organ/iter_organ as anything in carbon_target.organs)
		if (istype(iter_organ, required_organ))
			return TRUE

	return FALSE
