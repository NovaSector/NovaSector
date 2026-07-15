/// Prevents an atom from being directly interacted with by bitrunning threats,
/// and tries to prevent methods of indirectly moving it (such as throwing)
/datum/element/bitrunning_objective
	var/static/list/restricted_from = list(/datum/antagonist/domain_ghost_actor, /datum/antagonist/bitrunning_glitch)

/datum/element/bitrunning_objective/Attach(atom/movable/objective)
	. = ..()

	if(!ismovable(objective))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(objective, COMSIG_ATOM_CAN_BE_PULLED, PROC_REF(on_try_pull))
	RegisterSignal(objective, COMSIG_MOVABLE_BUMP_PUSHED, PROC_REF(on_try_push))
	RegisterSignals(objective, list(COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_ATTACK_HAND_SECONDARY), PROC_REF(on_attack_hand))
	RegisterSignal(objective, COMSIG_TRY_USE_MACHINE, PROC_REF(on_try_use_machine))
	RegisterSignals(objective, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_ITEM_INTERACTION_SECONDARY), PROC_REF(on_item_interaction))
	RegisterSignal(objective, COMSIG_MOVABLE_PRE_THROW, PROC_REF(on_pre_throw))

/datum/element/bitrunning_objective/Detach(atom/movable/objective, ...)
	. = ..()
	UnregisterSignal(objective, list(
		COMSIG_ATOM_CAN_BE_PULLED,
		COMSIG_MOVABLE_BUMP_PUSHED,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_ATOM_ATTACK_HAND_SECONDARY,
		COMSIG_TRY_USE_MACHINE,
		COMSIG_ATOM_ITEM_INTERACTION,
		COMSIG_ATOM_ITEM_INTERACTION_SECONDARY,
		COMSIG_MOVABLE_PRE_THROW,
	))

/// When you try to pull it
/datum/element/bitrunning_objective/proc/on_try_pull(atom/movable/source, mob/living/user)
	SIGNAL_HANDLER
	return should_interaction_fail(source, user) ? COMSIG_ATOM_CANT_PULL : NONE

/// When it's dense, and you try to push it
/datum/element/bitrunning_objective/proc/on_try_push(atom/movable/source, mob/living/user, force)
	SIGNAL_HANDLER
	return should_interaction_fail(source, user) ? COMPONENT_NO_PUSH : NONE

/// When you click it with an empty hand
/datum/element/bitrunning_objective/proc/on_attack_hand(atom/movable/source, mob/living/user, list/modifiers)
	SIGNAL_HANDLER
	return should_interaction_fail(source, user) ? COMPONENT_CANCEL_ATTACK_CHAIN : NONE

/// When it's a machine, and you try to interact with it
/datum/element/bitrunning_objective/proc/on_try_use_machine(atom/movable/source, mob/living/user)
	SIGNAL_HANDLER
	return should_interaction_fail(source, user) ? COMPONENT_CANT_USE_MACHINE_INTERACT : NONE

/// When you click it with any item
/datum/element/bitrunning_objective/proc/on_item_interaction(atom/movable/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER
	return should_interaction_fail(source, user) ? ITEM_INTERACT_BLOCKING : NONE

/// When something tries to throw it
/datum/element/bitrunning_objective/proc/on_pre_throw(atom/movable/source, list/throw_args)
	SIGNAL_HANDLER
	var/mob/living/thrower = throw_args[4]
	if(istype(thrower))
		// If they somehow have a datum. I won't judge
		return should_interaction_fail(source, thrower) ? COMPONENT_CANCEL_THROW : NONE
	// If the thrower isn't a mob, just block it. It could be anything, but it's probably an explosion
	source.visible_message(span_warning("\The [source] resists being thrown!"))
	return COMPONENT_CANCEL_THROW

/// Returns FALSE if we don't have a bitrunning threat antag datum, TRUE + balloon alert otherwise
/datum/element/bitrunning_objective/proc/should_interaction_fail(atom/movable/objective, mob/user)
	var/datum/mind/user_mind = user?.mind
	if(isnull(user_mind))
		return FALSE
	if(!user_mind.has_antag_datum_in_list(restricted_from))
		return FALSE

	objective.balloon_alert(user, "can't interact with objectives!")
	return TRUE
