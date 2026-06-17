/// Shared base for components that suppress or block psionics while an item is equipped.
/// Subclasses set [interference_signal] and [signal_handler] to choose which psionic signal to intercept.
/datum/component/psionic_interference
	dupe_mode = COMPONENT_DUPE_ALLOWED

	/// Inventory slot the parent item must occupy before it affects its wearer.
	var/inventory_flags = ALL
	/// Mob currently affected by this component.
	var/mob/living/affected_mob
	/// Signal registered on [affected_mob] to intercept psionics.
	var/interference_signal
	/// Proc ref registered against [interference_signal].
	var/signal_handler
	/// TRUE when the parent is an item, so equip/unequip feedback should fire.
	var/parent_is_item = FALSE

/datum/component/psionic_interference/Initialize(inventory_flags = ALL)
	var/atom/movable/movable_parent = parent
	if(!istype(movable_parent))
		return COMPONENT_INCOMPATIBLE

	src.inventory_flags = inventory_flags
	parent_is_item = isitem(movable_parent)

	if(parent_is_item)
		RegisterSignal(movable_parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
		RegisterSignal(movable_parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		return

	if(isliving(movable_parent))
		var/mob/living/living_parent = movable_parent
		apply_to_mob(living_parent)
		return

	return COMPONENT_INCOMPATIBLE

/datum/component/psionic_interference/Destroy(force)
	clear_affected_mob()
	return ..()

/datum/component/psionic_interference/proc/apply_to_mob(mob/living/target)
	if(affected_mob == target)
		return

	clear_affected_mob()
	affected_mob = target
	if(interference_signal && signal_handler)
		RegisterSignal(target, interference_signal, signal_handler)
	on_applied(target)

/datum/component/psionic_interference/proc/clear_affected_mob()
	if(!affected_mob)
		return

	if(interference_signal && signal_handler)
		UnregisterSignal(affected_mob, interference_signal)
	on_cleared(affected_mob)
	affected_mob = null

/// Called after [affected_mob] is set. Override in subclasses for side effects (e.g. button updates).
/// Only fires for item parents — direct-mob applications skip this to avoid double feedback.
/datum/component/psionic_interference/proc/on_applied(mob/living/target)
	return

/// Called before [affected_mob] is cleared. Override in subclasses for side effects (e.g. button updates).
/// Only fires for item parents — direct-mob applications skip this to avoid double feedback.
/datum/component/psionic_interference/proc/on_cleared(mob/living/target)
	return

/datum/component/psionic_interference/proc/on_equip(atom/movable/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(inventory_flags & slot))
		if(affected_mob == equipper)
			clear_affected_mob()
		return
	if(!isliving(equipper))
		return

	apply_to_mob(equipper)

/datum/component/psionic_interference/proc/on_drop(atom/movable/source, mob/user)
	SIGNAL_HANDLER

	if(affected_mob == user)
		clear_affected_mob()


/// Blocks incoming psionic effects directed at the wearer. Attached to items or mobs directly.
/datum/component/psionic_protection
	parent_type = /datum/component/psionic_interference
	dupe_mode = COMPONENT_DUPE_ALLOWED
	interference_signal = COMSIG_MOB_RECEIVE_PSIONICS
	signal_handler = PROC_REF(on_receive_psionics)

	/// How much psionic protection remains before this component is spent.
	var/charges = INFINITY
	/// Called after this component blocks a psionic effect.
	var/datum/callback/on_block

/datum/component/psionic_protection/Initialize(charges = INFINITY, inventory_flags = ALL, datum/callback/on_block)
	. = ..(inventory_flags)
	src.charges = charges
	src.on_block = on_block
	if(parent_is_item)
		RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/psionic_protection/Destroy(force)
	if(parent_is_item)
		UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	on_block = null
	return ..()

/datum/component/psionic_protection/on_applied(mob/living/target)
	if(parent_is_item && (charges == INFINITY || charges > 0))
		to_chat(target, span_notice("You feel a layer of psionic protection settle over your thoughts."))

/datum/component/psionic_protection/on_cleared(mob/living/target)
	if(parent_is_item && charges > 0)
		to_chat(target, span_notice("Your psionic protection fades."))

/datum/component/psionic_protection/proc/on_receive_psionics(mob/living/target, psionic_flags, charge_cost, list/psionic_sources)
	SIGNAL_HANDLER

	if(parent in psionic_sources)
		return NONE
	if(charges != INFINITY && charges <= 0)
		return NONE

	psionic_sources += parent
	on_block?.Invoke(target, parent)
	if(charges == INFINITY)
		to_chat(target, span_notice("Your psionic protection absorbs the effect."))
	else
		charges = max(charges - max(charge_cost, 1), 0)
		if(charges > 0)
			to_chat(target, span_notice("Your psionic protection absorbs the effect ([charges] charge\s remaining)."))
		else
			to_chat(target, span_warning("Your psionic protection collapses!"))
	return COMPONENT_PSIONIC_BLOCKED

/datum/component/psionic_protection/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(charges == INFINITY)
		examine_list += span_purple("Its psionic lattice hums with inexhaustible charge.")
	else if(charges > 0)
		examine_list += span_purple("Its psionic lattice has [charges] charge\s remaining.")
	else
		examine_list += span_purple("Its psionic lattice is spent.")


/// Suppresses the wearer's own psionic projection entirely. Attached to items or mobs directly.
/datum/component/block_host_psionics
	parent_type = /datum/component/psionic_interference
	dupe_mode = COMPONENT_DUPE_ALLOWED
	interference_signal = COMSIG_MOB_RESTRICT_PSIONICS
	signal_handler = PROC_REF(on_restrict_psionics)

/datum/component/block_host_psionics/on_applied(mob/living/target)
	update_psionic_action_buttons(target)
	if(parent_is_item)
		to_chat(target, span_warning("Your psionic focus is suppressed."))

/datum/component/block_host_psionics/on_cleared(mob/living/target)
	update_psionic_action_buttons(target)
	if(parent_is_item)
		to_chat(target, span_notice("Your psionic focus returns."))

/datum/component/block_host_psionics/proc/update_psionic_action_buttons(mob/living/target)
	var/datum/component/psionic_profile/profile = target?.get_psionic_profile()
	if(profile)
		profile.update_psionic_action_buttons()

/datum/component/block_host_psionics/proc/on_restrict_psionics(mob/user, psionic_flags)
	SIGNAL_HANDLER

	return COMPONENT_PSIONIC_BLOCKED
