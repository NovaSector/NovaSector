///This component is a specialized version of the /datum/component/squashable component for undersized
/datum/component/squashable_carbons
	///Chance on crossed to be squashed
	var/squash_chance = 50
	///this is the base value we reset to after squishing, but it's modified by several factors
	var/squash_damage_base = 20
	///Squash flags, for extra checks etcetera, you can use the same ones as normal squashable
	var/squash_flags = NONE
	///Special callback to call on squash instead, for things like hauberoach
	var/datum/callback/on_squash_callback

	///signal list given to connect_loc
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)


/datum/component/squashable_carbons/Initialize(squash_chance, squash_damage, squash_flags, squash_callback)
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	if(squash_chance)
		src.squash_chance = squash_chance
	if(squash_damage)
		src.squash_damage_base = squash_damage
	if(squash_flags)
		src.squash_flags = squash_flags
	if(!src.on_squash_callback && squash_callback)
		on_squash_callback = CALLBACK(parent, squash_callback)

	AddComponent(/datum/component/connect_loc_behalf, parent, loc_connections)

/datum/component/squashable_carbons/Destroy(force)
	on_squash_callback = null
	return ..()

///Handles the squashing of the mob
/datum/component/squashable_carbons/proc/on_entered(turf/source_turf, atom/movable/crossing_movable)
	SIGNAL_HANDLER

	if(parent == crossing_movable)
		return

	var/mob/living/parent_as_living = parent
	if((squash_flags & SQUASHED_DONT_SQUASH_IN_CONTENTS) && !isturf(parent_as_living.loc))
		return

	if((squash_flags & SQUASHED_SHOULD_BE_DOWN) && parent_as_living.body_position != LYING_DOWN)
		return

	var/should_squash = ((squash_flags & SQUASHED_ALWAYS_IF_DEAD) && parent_as_living.stat == DEAD) || prob(squash_chance)

	if(should_squash && on_squash_callback)
		if(on_squash_callback.Invoke(parent_as_living, crossing_movable))
			return //Everything worked, we're done!

	if(isliving(crossing_movable))
		living_entered(crossing_movable, should_squash)
	else if(isstructure(crossing_movable))
		structure_entered(crossing_movable, should_squash)

/datum/component/squashable_carbons/proc/living_entered(mob/living/crossing_living, should_squash)
	var/mob/living/parent_as_living = parent
	// If they're too small, can't squash us.
	if(crossing_living.mob_size <= MOB_SIZE_SMALL)
		return
	// If they're not touching the ground, they're not stepping on us either
	if(crossing_living.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
		return

	// If they're a pacifist, they won't harm us.
	if(HAS_TRAIT(crossing_living, TRAIT_PACIFISM))
		crossing_living.visible_message(span_notice("[crossing_living] carefully steps over [parent_as_living]."), span_notice("You carefully step over [parent_as_living] to avoid hurting it."))
		return
	// If you're on Combat intent, you will always squash. If you walk, you will avoid squashing.
	if(crossing_living.move_intent == MOVE_INTENT_WALK && crossing_living.combat_mode == FALSE)
		crossing_living.visible_message(span_notice("[crossing_living] carefully walks around [parent_as_living]."), span_notice("You carefully walk around [parent_as_living] to avoid hurting it."))
		return
	// Tiny flying creatures are only squashed if the squasher is explicitly on combat mode.
	if(parent_as_living.movement_type & MOVETYPES_NOT_TOUCHING_GROUND && crossing_living.combat_mode == FALSE)
		return

	if(!should_squash)
		parent_as_living.visible_message(span_notice("[parent_as_living] avoids getting crushed."))
		return
	if(parent_as_living.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
		crossing_living.visible_message(span_notice("[crossing_living] slaps [parent_as_living] out of the air!"), span_notice("You slapped [parent_as_living] down."))
	else
		crossing_living.visible_message(span_notice("[crossing_living] squashed [parent_as_living]."), span_notice("You squashed [parent_as_living]."))
	var/damage_modifier = (crossing_living.mob_size >= MOB_SIZE_LARGE) ? 2 : 1 // If something big is stepping on you, it's gonna hurt more.
	squash_us(parent_as_living, damage_modifier)

/datum/component/squashable_carbons/proc/structure_entered(obj/structure/crossing_structure, should_squash)
	var/mob/living/parent_as_living = parent
	// If they're not dense, don't squash us.
	if(!crossing_structure.density)
		return

	if(!should_squash)
		parent_as_living.visible_message(span_notice("[parent_as_living] avoids getting crushed."))
		return
	crossing_structure.visible_message(span_notice("[parent_as_living] is crushed under [crossing_structure]."))
	squash_us(parent_as_living)

/datum/component/squashable_carbons/proc/squash_us(mob/living/carbon/target, damage_modifier = 1)
	var/squash_damage_final = squash_damage_base * damage_modifier

	if(target.movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
		//uh oh, we just got smacked out of the air, this is gonna suck
		target.apply_effect(6 SECONDS, EFFECT_KNOCKDOWN)
		target.apply_effect(2 SECONDS, EFFECT_PARALYZE)
		playsound(parent, 'sound/effects/emotes/assslap.ogg', 100)
		squash_damage_final *= 1.5

	if(squash_flags & SQUASHED_SHOULD_BE_GIBBED)
		target.gib(DROP_ALL_REMAINS)
		return

	target.apply_damage(squash_damage_final, BRUTE, spread_damage = TRUE)
	var/obj/item/bodypart/chest/chest_reference = target.get_bodypart(BODY_ZONE_CHEST)
	if(istype(chest_reference, /obj/item/bodypart/chest/robot))
		playsound(parent,'sound/effects/wounds/crack2.ogg',90)
	else if(istype(chest_reference, /obj/item/bodypart/chest/jelly))
		playsound(parent,'sound/effects/desecration/desecration-01.ogg',90)
	else
		playsound(parent,'sound/effects/wounds/crackandbleed.ogg',90)

/datum/component/squashable_carbons/UnregisterFromParent()
	. = ..()
	qdel(GetComponent(/datum/component/connect_loc_behalf))
