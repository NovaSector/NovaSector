// IRIS MODULE
//heavily cribbed off /datum/element/prevent_attacking_of_types

/datum/element/prevent_attacking_of_player_types
    element_flags = ELEMENT_BESPOKE
    argument_hash_start_idx = 2

    var/list/typecache

    var/alert_message

/datum/element/prevent_attacking_of_player_types/Attach(datum/target, list/typecache, alert_message)
    . = ..()
    if (!isanimal_or_basicmob(target))
        return ELEMENT_INCOMPATIBLE

    src.typecache = typecache
    src.alert_message = alert_message

    RegisterSignal(target, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_pre_attacking_player_target))

/datum/element/prevent_attacking_of_player_types/Detach(datum/source, ...)
    UnregisterSignal(source, COMSIG_HOSTILE_PRE_ATTACKINGTARGET)
    return ..()

/datum/element/prevent_attacking_of_player_types/proc/on_pre_attacking_player_target(mob/source, atom/target)
    SIGNAL_HANDLER

    if (!typecache[target.type])
        return

    // only proceed if both source and target are living mobs
    var/mob/living/l_source = istype(source, /mob/living) ? source : null
    var/mob/living/l_target = istype(target, /mob/living) ? target : null
    if (!l_source || !l_target)
        return

	// only block if both are player-controlled
    if (!l_source.client || !l_target.client)
        return

    l_target.balloon_alert(l_source, alert_message)
    return COMPONENT_HOSTILE_NO_ATTACK
