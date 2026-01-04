/datum/action/cooldown/spell/jaunt/space_crawl/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(grant_to, COMSIG_MOB_AFTER_EXIT_JAUNT, PROC_REF(apply_cooldown))

/datum/action/cooldown/spell/jaunt/space_crawl/Remove(mob/remove_from)
	. = ..()
	UnregisterSignal(remove_from, COMSIG_MOB_AFTER_EXIT_JAUNT)

/datum/action/cooldown/spell/jaunt/space_crawl/proc/apply_cooldown()
	addtimer(CALLBACK(src, PROC_REF(StartCooldown), 30 SECONDS), 0.1 SECONDS)

/obj/effect/dummy/phased_mob/spell_jaunt/space/phased_check(mob/living/user, direction)
	. = ..()
	if(. && !isspaceturf(.))
		to_chat(user, span_warning("You can't phase through anything but space."))
		return FALSE
