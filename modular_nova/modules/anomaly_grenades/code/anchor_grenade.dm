/obj/item/grenade/anchor
	name = "fastball bluespace grounder"
	desc = "A quantity of charged dimensional stability, siphoned from a dimensional core, barely contained within a shape vaguely reminiscent of a grenade. \
		Upon detonation, all targets within a two-pace radius of the detonation are temporarily bluespace grounded, preventing teleportation."
	icon = 'modular_nova/modules/anomaly_grenades/icons/anchornade.dmi'
	icon_state = "anchornade"
	inhand_icon_state = "flashbang"

/obj/item/grenade/anchor/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return
	for(var/mob/living/affected in view(2, get_turf(src)))
		affected.apply_status_effect(/datum/status_effect/bluespace_grounded)
	qdel(src)

/atom/movable/screen/alert/status_effect/bluespace_grounded
	name = "Bluespace Grounded"
	desc = "Your bluespace signature has been grounded! Conventional teleportation and/or jaunting may end poorly."
	use_user_hud_icon = TRUE
	overlay_state = "stun"

/datum/status_effect/bluespace_grounded
	id = "bluespace_grounded"
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/bluespace_grounded
	status_type = STATUS_EFFECT_REFRESH
	show_duration = TRUE
	var/datum/effect_system/spark_spread/quantum/spark_system

/datum/status_effect/bluespace_grounded/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_TELEPORTING, PROC_REF(on_teleport))
	RegisterSignal(owner, COMSIG_MOB_PRE_JAUNT, PROC_REF(on_jaunt))
	spark_system = new /datum/effect_system/spark_spread/quantum
	spark_system.set_up(3, TRUE, owner)
	spark_system.start()
	to_chat(owner, span_warning("Your surroundings shimmer slightly. Teleportation, somehow, seems like it would not be a good idea."))
	return TRUE

/datum/status_effect/bluespace_grounded/on_remove()
	qdel(spark_system)
	UnregisterSignal(owner, COMSIG_MOVABLE_TELEPORTING)
	UnregisterSignal(owner, COMSIG_MOB_PRE_JAUNT)
	to_chat(owner, span_notice("Your surroundings shimmer slightly. Teleportation might be possible again."))

/// Signal for COMSIG_MOVABLE_TELEPORTING that blocks teleports and stuns the would-be-teleportee.
/datum/status_effect/bluespace_grounded/proc/on_teleport(mob/living/teleportee, atom/destination, channel)
	SIGNAL_HANDLER

	to_chat(owner, span_holoparasite("You feel yourself teleporting, but are suddenly flung back to where you just were!"))
	penalize()

	return TRUE

/// Signal for COMSIG_MOB_PRE_JAUNT that prevents a user from entering a jaunt.
/datum/status_effect/bluespace_grounded/proc/on_jaunt(mob/living/jaunter)
	SIGNAL_HANDLER

	to_chat(owner, span_holoparasite("As you attempt to jaunt, you slam directly into the barrier between realities and crash back into corporeality!"))
	penalize()

	return COMPONENT_BLOCK_JAUNT

/// Stuns a target, presumably the offending party/embed target/whoever was about to try teleporting.
/datum/status_effect/bluespace_grounded/proc/penalize()
	owner.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * 2, 10 SECONDS)
	owner.Knockdown(0.2 SECONDS)
	owner.drop_all_held_items()
	owner.apply_damage(55, STAMINA)
	spark_system.set_up(5, TRUE, owner)
	spark_system.start()
