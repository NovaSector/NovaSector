/datum/component/psionic_protection
	dupe_mode = COMPONENT_DUPE_ALLOWED

	/// How much psionic protection remains before this component is spent.
	var/charges = INFINITY
	/// Inventory slot the parent item must occupy before it protects its wearer.
	var/inventory_flags = ALL
	/// Called after this component blocks a psionic effect.
	var/datum/callback/on_block
	/// Mob currently protected by this component.
	var/mob/living/protected_mob

/datum/component/psionic_protection/Initialize(charges = INFINITY, inventory_flags = ALL, datum/callback/on_block)
	var/atom/movable/movable_parent = parent
	if(!istype(movable_parent))
		return COMPONENT_INCOMPATIBLE

	src.charges = charges
	src.inventory_flags = inventory_flags
	src.on_block = on_block

	if(isitem(movable_parent))
		RegisterSignal(movable_parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
		RegisterSignal(movable_parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		return

	if(isliving(movable_parent))
		var/mob/living/living_parent = movable_parent
		protect_mob(living_parent)
		return

	return COMPONENT_INCOMPATIBLE

/datum/component/psionic_protection/Destroy(force)
	clear_protected_mob()
	on_block = null
	return ..()

/datum/component/psionic_protection/proc/protect_mob(mob/living/target)
	if(protected_mob == target)
		return

	clear_protected_mob()
	protected_mob = target
	RegisterSignal(target, COMSIG_MOB_RECEIVE_PSIONICS, PROC_REF(on_receive_psionics))

/datum/component/psionic_protection/proc/clear_protected_mob()
	if(!protected_mob)
		return

	UnregisterSignal(protected_mob, COMSIG_MOB_RECEIVE_PSIONICS)
	protected_mob = null

/datum/component/psionic_protection/proc/on_equip(atom/movable/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(inventory_flags & slot))
		if(protected_mob == equipper)
			clear_protected_mob()
		return
	if(!isliving(equipper))
		return

	var/mob/living/living_equipper = equipper
	protect_mob(living_equipper)

/datum/component/psionic_protection/proc/on_drop(atom/movable/source, mob/user)
	SIGNAL_HANDLER

	if(protected_mob == user)
		clear_protected_mob()

/datum/component/psionic_protection/proc/on_receive_psionics(mob/living/target, psionic_flags, charge_cost, list/psionic_sources)
	SIGNAL_HANDLER

	if(parent in psionic_sources)
		return NONE

	psionic_sources += parent
	on_block?.Invoke(target, parent)
	if(charges != INFINITY)
		charges -= max(charge_cost, 1)
		if(charges <= 0)
			qdel(src)
	return COMPONENT_PSIONIC_BLOCKED

/datum/component/block_host_psionics
	dupe_mode = COMPONENT_DUPE_ALLOWED

	/// Inventory slot the parent item must occupy before it suppresses its wearer.
	var/inventory_flags = ALL
	/// Mob currently suppressed by this component.
	var/mob/living/blocked_mob

/datum/component/block_host_psionics/Initialize(inventory_flags = ALL)
	var/atom/movable/movable_parent = parent
	if(!istype(movable_parent))
		return COMPONENT_INCOMPATIBLE

	src.inventory_flags = inventory_flags

	if(isitem(movable_parent))
		RegisterSignal(movable_parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
		RegisterSignal(movable_parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		return

	if(isliving(movable_parent))
		var/mob/living/living_parent = movable_parent
		block_mob(living_parent)
		return

	return COMPONENT_INCOMPATIBLE

/datum/component/block_host_psionics/Destroy(force)
	clear_blocked_mob()
	return ..()

/datum/component/block_host_psionics/proc/block_mob(mob/living/target)
	if(blocked_mob == target)
		return

	clear_blocked_mob()
	blocked_mob = target
	RegisterSignal(target, COMSIG_MOB_RESTRICT_PSIONICS, PROC_REF(on_restrict_psionics))
	update_psionic_action_buttons(target)

/datum/component/block_host_psionics/proc/clear_blocked_mob()
	if(!blocked_mob)
		return

	UnregisterSignal(blocked_mob, COMSIG_MOB_RESTRICT_PSIONICS)
	update_psionic_action_buttons(blocked_mob)
	blocked_mob = null

/datum/component/block_host_psionics/proc/update_psionic_action_buttons(mob/living/target)
	var/datum/component/psionic_profile/profile = target?.get_psionic_profile()
	if(profile)
		profile.update_psionic_action_buttons()

/datum/component/block_host_psionics/proc/on_equip(atom/movable/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(inventory_flags & slot))
		if(blocked_mob == equipper)
			clear_blocked_mob()
		return
	if(!isliving(equipper))
		return

	var/mob/living/living_equipper = equipper
	block_mob(living_equipper)

/datum/component/block_host_psionics/proc/on_drop(atom/movable/source, mob/user)
	SIGNAL_HANDLER

	if(blocked_mob == user)
		clear_blocked_mob()

/datum/component/block_host_psionics/proc/on_restrict_psionics(mob/user, psionic_flags)
	SIGNAL_HANDLER

	return COMPONENT_PSIONIC_BLOCKED
