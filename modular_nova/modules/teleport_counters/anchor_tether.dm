/obj/item/mod/module/tether
	/// What kind of tether projectile do we fire? This should probably be a subtype of /obj/projectile/tether.
	var/obj/projectile/tether/tether_type = /obj/projectile/tether

/obj/item/mod/module/tether/anti_teleport
	name = "MOD grounding apprehension module"
	desc = "A custom-built grappling-hook powered by a winch capable of hauling the user. \
		The serrated edges on this variant's anchors, and the flashforged bluespace grounding circuit, \
		mean that each tether drains much more charge when fired. It remains functional as a tether, though."
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	tether_type = /obj/projectile/tether/anti_teleport

/obj/projectile/tether/anti_teleport
	name = "grounding tether"
	embed_type = /datum/embedding/tether_projectile/anti_teleport
	shrapnel_type = /obj/item/tether_anchor/anti_teleport

/obj/item/tether_anchor/anti_teleport
	name = "grounding tether anchor"
	desc = "A reinforced anchor with a tether attachment point and an integrated bluespace grounding circuit. \
		Still usable as an emergency tether, though how useful that would be is questionable."

/datum/embedding/tether_projectile/anti_teleport
	embed_chance = 90
	rip_time = 3 SECONDS

/datum/embedding/tether_projectile/anti_teleport/on_successful_embed(mob/living/carbon/victim, obj/item/bodypart/target_limb)
	RegisterSignal(victim, COMSIG_MOVABLE_TELEPORTING, PROC_REF(on_teleport))
	RegisterSignal(victim, COMSIG_MOB_PRE_JAUNT, PROC_REF(on_jaunt))

/datum/embedding/tether_projectile/anti_teleport/remove_embedding(mob/living/to_hands)
	UnregisterSignal(owner, list(COMSIG_MOVABLE_TELEPORTING, COMSIG_MOB_PRE_JAUNT))
	return ..()

/// Signal for COMSIG_MOVABLE_TELEPORTING that blocks teleports and stuns the would-be-teleportee, adapted from implant_noteleport.dm
/datum/embedding/tether_projectile/anti_teleport/proc/on_teleport(mob/living/teleportee, atom/destination, channel)
	SIGNAL_HANDLER

	to_chat(teleportee, span_holoparasite("You feel yourself teleporting, but are suddenly flung back to where you just were!"))
	penalize(teleportee)

	return TRUE

/// Signal for COMSIG_MOB_PRE_JAUNT that prevents a user from entering a jaunt.
/datum/embedding/tether_projectile/anti_teleport/proc/on_jaunt(mob/living/jaunter)
	SIGNAL_HANDLER

	to_chat(jaunter, span_holoparasite("As you attempt to jaunt, you slam directly into the barrier between realities and are sent crashing back into corporeality!"))
	penalize(jaunter)

	return COMPONENT_BLOCK_JAUNT

/// Stuns a target, presumably the offending party/embed target/whoever was about to try teleporting.
/datum/embedding/tether_projectile/anti_teleport/proc/penalize(mob/living/target)
	target.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * 2, 10 SECONDS)
	target.Knockdown(0.2 SECONDS)
	target.drop_all_held_items()
	target.apply_damage(55, STAMINA)
	var/datum/effect_system/spark_spread/quantum/spark_system = new()
	spark_system.set_up(5, TRUE, target)
	spark_system.start()
