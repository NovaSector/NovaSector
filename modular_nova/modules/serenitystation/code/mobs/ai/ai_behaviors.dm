/// Shared logic for actually flipping a mob's hidden state. Used by both the
/// explicit toggle_hiding leaf and the random_hiding decision leaf.
/proc/ai_toggle_hiding(datum/ai_controller/controller, now_hiding, cooldown_before_hiding_key = BB_HIDING_COOLDOWN_BEFORE_HIDING)
	var/mob/living/basic/hiding_pawn = controller.pawn
	if(!istype(hiding_pawn))
		return FALSE

	if(now_hiding)
		// We can't hide if we can't move properly, or if we don't have any valid hiding locations.
		if(!(hiding_pawn.mobility_flags & MOBILITY_MOVE) || !isturf(hiding_pawn.loc) || hiding_pawn.pulledby || !islist(controller.blackboard[BB_HIDING_CAN_HIDE_ON]))
			return FALSE
		// We can't hide if we don't match the proper turf type we need to hide onto.
		if(!controller.blackboard[BB_HIDING_CAN_HIDE_ON][hiding_pawn.loc.type])
			return FALSE

	if(!controller.blackboard[BB_HIDING_AGGRO_RANGE_NOT_HIDING])
		controller.set_blackboard_key(BB_HIDING_AGGRO_RANGE_NOT_HIDING, controller.blackboard[BB_AGGRO_RANGE])

	var/hiding_status_changed = controller.blackboard[BB_HIDING_HIDDEN] != now_hiding
	if(!hiding_status_changed)
		return TRUE

	controller.set_blackboard_key(BB_HIDING_HIDDEN, now_hiding)
	SEND_SIGNAL(hiding_pawn, COMSIG_MOVABLE_TOGGLE_HIDING, now_hiding, TRUE)

	var/new_vision_range = now_hiding ? (controller.blackboard[BB_HIDING_AGGRO_RANGE] || DEFAULT_HIDING_AGGRO_RANGE) : controller.blackboard[BB_HIDING_AGGRO_RANGE_NOT_HIDING]

	if(!now_hiding)
		var/cooldown_minimum = controller.blackboard[BB_HIDING_COOLDOWN_MINIMUM] || 1 MINUTES
		var/cooldown_maximum = controller.blackboard[BB_HIDING_COOLDOWN_MAXIMUM] || 3 MINUTES
		controller.set_blackboard_key(cooldown_before_hiding_key, world.time + rand(cooldown_minimum, cooldown_maximum))

	controller.set_blackboard_key(BB_AGGRO_RANGE, new_vision_range)
	return TRUE

/// This behavior is to run any code that needs to be ran when the mob is going
/// into hiding, or coming out from hiding.
/datum/bt_node/ai_behavior/toggle_hiding
	/// The blackboard cooldown key to check before we can hide. Only here
	/// to avoid copy-paste in other subtrees/behaviors, should only be SET,
	/// not READ here.
	var/cooldown_before_hiding_key = BB_HIDING_COOLDOWN_BEFORE_HIDING
	/// Whether this instance hides (TRUE) or unhides (FALSE) the pawn.
	var/now_hiding = FALSE

/datum/bt_node/ai_behavior/toggle_hiding/perform(seconds_per_tick, datum/ai_controller/controller)
	if(!ai_toggle_hiding(controller, now_hiding, cooldown_before_hiding_key))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/bt_node/ai_behavior/toggle_hiding/start
	now_hiding = TRUE

/// Stops hiding if the given blackboard key is currently set. Used to break
/// hiding when a combat/flee target or a retaliation target shows up.
/datum/bt_node/ai_behavior/stop_hiding_if_key_set
	var/target_key

/datum/bt_node/ai_behavior/stop_hiding_if_key_set/perform(seconds_per_tick, datum/ai_controller/controller)
	if(!controller.blackboard[target_key] || !controller.blackboard[BB_HIDING_HIDDEN])
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	ai_toggle_hiding(controller, FALSE)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
