/// Provides resistance to psionic effects without interacting with antimagic.
/datum/component/anti_psionic
	dupe_mode = COMPONENT_DUPE_ALLOWED

	/// A bitflag of psionic effect categories blocked by this component.
	var/psionic_flags
	/// The amount of times this protection can block psionics.
	var/charges
	/// The inventory slot the item must be in to activate.
	var/inventory_flags
	/// Called when this component blocks psionics.
	var/datum/callback/block_psionic
	/// Called when charges run out.
	var/datum/callback/expiration
	/// Called before blocking, allowing dynamic vetoes.
	var/datum/callback/check_blocking
	/// If TRUE, the wearer is also prevented from using matching psionic categories.
	var/restrict_user

/datum/component/anti_psionic/Initialize(
		psionic_flags = PSIONIC_ALL,
		charges = INFINITY,
		inventory_flags = ALL,
		datum/callback/block_psionic,
		datum/callback/expiration,
		datum/callback/check_blocking,
		restrict_user = FALSE,
	)
	var/atom/movable/movable = parent
	if(!istype(movable))
		return COMPONENT_INCOMPATIBLE

	var/compatible = FALSE
	if(isitem(movable))
		RegisterSignal(movable, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
		RegisterSignal(movable, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		RegisterSignal(movable, COMSIG_ATOM_EXAMINE_TAGS, PROC_REF(get_examine_tags))
		compatible = TRUE
	else if(ismob(movable))
		register_psionic_signals(movable)
		compatible = TRUE

	if(movable.can_buckle)
		RegisterSignal(movable, COMSIG_MOVABLE_BUCKLE, PROC_REF(on_buckle))
		RegisterSignal(movable, COMSIG_MOVABLE_UNBUCKLE, PROC_REF(on_unbuckle))
		compatible = TRUE

	if(!compatible)
		return COMPONENT_INCOMPATIBLE

	src.psionic_flags = psionic_flags
	src.charges = charges
	src.inventory_flags = inventory_flags
	src.block_psionic = block_psionic
	src.expiration = expiration
	src.check_blocking = check_blocking
	src.restrict_user = restrict_user

/datum/component/anti_psionic/Destroy(force)
	block_psionic = null
	expiration = null
	check_blocking = null
	return ..()

/datum/component/anti_psionic/proc/register_psionic_signals(datum/on_what)
	RegisterSignal(on_what, COMSIG_MOB_RECEIVE_PSIONICS, PROC_REF(block_receiving_psionics), override = TRUE)
	if(restrict_user)
		RegisterSignal(on_what, COMSIG_MOB_RESTRICT_PSIONICS, PROC_REF(restrict_using_psionics), override = TRUE)

/datum/component/anti_psionic/proc/unregister_psionic_signals(datum/on_what)
	UnregisterSignal(on_what, list(COMSIG_MOB_RECEIVE_PSIONICS, COMSIG_MOB_RESTRICT_PSIONICS))

/datum/component/anti_psionic/proc/on_buckle(atom/movable/source, mob/living/bucklee)
	SIGNAL_HANDLER
	register_psionic_signals(bucklee)

/datum/component/anti_psionic/proc/on_unbuckle(atom/movable/source, mob/living/bucklee)
	SIGNAL_HANDLER
	unregister_psionic_signals(bucklee)

/datum/component/anti_psionic/proc/get_examine_tags(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(psionic_flags == PSIONIC_ALL)
		examine_list["psi-shielded"] = "It is shielded against psionic intrusion and projection."
		return

	if(psionic_flags & PSIONIC_INTRUSIVE)
		examine_list["thought-shielded"] = "It is insulated against intrusive psionic contact."
	if(psionic_flags & PSIONIC_KINETIC)
		examine_list["kinetic-dampened"] = "It resists psionic kinetic force."
	if(psionic_flags & PSIONIC_SENSORY)
		examine_list["sense-dampened"] = "It blurs psionic perception."
	if(psionic_flags & PSIONIC_PROTECTIVE)
		examine_list["guard-dampened"] = "It disrupts protective psionic shaping."
	if(psionic_flags & PSIONIC_SPATIAL)
		examine_list["spatial-dampened"] = "It disrupts psionic spatial folding."
	if(psionic_flags & PSIONIC_THERMAL)
		examine_list["thermal-dampened"] = "It disperses psionic thermal shaping."

/datum/component/anti_psionic/proc/on_equip(atom/movable/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(inventory_flags & slot))
		unregister_psionic_signals(equipper)
		return

	register_psionic_signals(equipper)

/datum/component/anti_psionic/proc/on_drop(atom/movable/source, mob/user)
	SIGNAL_HANDLER
	unregister_psionic_signals(user)

/datum/component/anti_psionic/proc/block_receiving_psionics(mob/living/source, incoming_psionic_flags, charge_cost, list/psionic_sources)
	SIGNAL_HANDLER

	if(check_blocking && !check_blocking.Invoke())
		return NONE
	if(!(incoming_psionic_flags & psionic_flags))
		return NONE
	if(parent in psionic_sources)
		return NONE

	psionic_sources += parent
	block_psionic?.Invoke(source, parent)

	if((charges != INFINITY) && charge_cost > 0)
		charges -= charge_cost
		if(charges <= 0)
			expiration?.Invoke(source, parent)
			qdel(src)

	return COMPONENT_PSIONIC_BLOCKED

/datum/component/anti_psionic/proc/restrict_using_psionics(mob/user, incoming_psionic_flags)
	SIGNAL_HANDLER

	if(incoming_psionic_flags & psionic_flags)
		return COMPONENT_PSIONIC_BLOCKED

	return NONE
