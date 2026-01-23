/obj/structure/closet/crate/secure/bitrunning/encrypted/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_CAN_BE_PULLED, PROC_REF(on_try_pull))
	RegisterSignal(src, COMSIG_MOVABLE_BUMP_PUSHED, PROC_REF(on_try_push))

/obj/structure/closet/crate/secure/bitrunning/encrypted/wrench_act_secondary(mob/living/user, obj/item/tool)
	var/datum/mind/user_mind = user?.mind

	if(isnull(user_mind))
		return ..()

	if(user_mind.has_antag_datum(/datum/antagonist/domain_ghost_actor, TRUE) || user_mind.has_antag_datum(/datum/antagonist/bitrunning_glitch, TRUE))
		balloon_alert(user, "read-only!")
		return ITEM_INTERACT_BLOCKING

	return ..()

/// Do not allow hostile/neutral ghost roles to pull the crate
/obj/structure/closet/crate/secure/bitrunning/encrypted/proc/on_try_pull(datum/source, mob/living/puller)
	SIGNAL_HANDLER
	var/datum/mind/puller_mind = puller?.mind

	if(puller_mind.has_antag_datum(/datum/antagonist/domain_ghost_actor, TRUE) || puller_mind.has_antag_datum(/datum/antagonist/bitrunning_glitch, TRUE))
		balloon_alert(puller, "read-only!")
		return COMSIG_ATOM_CANT_PULL

/// Do not allow hostile/neutral ghost roles to push the crate
/obj/structure/closet/crate/secure/bitrunning/encrypted/proc/on_try_push(datum/source, mob/living/pusher)
	SIGNAL_HANDLER
	var/datum/mind/pusher_mind = pusher?.mind

	if(pusher_mind.has_antag_datum(/datum/antagonist/domain_ghost_actor, TRUE) || pusher_mind.has_antag_datum(/datum/antagonist/bitrunning_glitch, TRUE))
		balloon_alert(pusher, "read-only!")
		return COMPONENT_NO_PUSH
