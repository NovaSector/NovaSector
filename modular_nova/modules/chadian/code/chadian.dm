#define RESTING_STATE_NONE 0
#define RESTING_STATE_SIT 1
#define RESTING_STATE_REST 2

/mob/living/basic/pet/dog/corgi/ian
	icon = 'modular_nova/modules/chadian/icons/ian.dmi'
	ai_controller = /datum/ai_controller/basic_controller/dog/corgi/chadian

	var/resting_state = 0

/// AI controller that adds chad ian emotes
/datum/ai_controller/basic_controller/dog/corgi/chadian
	behavior_tree_json = "modular_nova/modules/chadian/code/chadian.bt.json"

/// Periodically emotes and sits/lies down/gets back up, chad ian style.
/datum/bt_node/ai_behavior/chadian_idle_pose
	time_between_perform = 1 SECONDS

/datum/bt_node/ai_behavior/chadian_idle_pose/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/basic/pet/dog/corgi/ian/ian_pawn = controller.pawn
	if(!istype(ian_pawn))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if(ian_pawn.buckled || ian_pawn.pulledby || ian_pawn.inventory_head || ian_pawn.inventory_back)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if(SPT_PROB(0.5, seconds_per_tick))
		ian_pawn.manual_emote(pick("flops forward laying flat.", "wags [ian_pawn.p_their()] tail.", "lies down."))
		ian_pawn.set_rest_state(RESTING_STATE_REST)
	else if(SPT_PROB(0.5, seconds_per_tick))
		ian_pawn.manual_emote(pick("sits down.", "crouches on [ian_pawn.p_their()] hind legs.", "looks alert."))
		ian_pawn.set_rest_state(RESTING_STATE_SIT)
	else if(SPT_PROB(0.5, seconds_per_tick))
		if(ian_pawn.resting_state)
			ian_pawn.manual_emote(pick("gets up and barks.", "walks around.", "stops resting."))
			ian_pawn.set_rest_state(RESTING_STATE_NONE)
		else
			ian_pawn.manual_emote(pick("grooms [ian_pawn.p_their()] fur.", "twitches [ian_pawn.p_their()] ears.", "shakes [ian_pawn.p_their()] fur."))

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/mob/living/basic/pet/dog/corgi/ian/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(resting_state)
		manual_emote(pick("gets up and barks.", "walks around.", "stops resting."))
		set_rest_state(RESTING_STATE_NONE)

/mob/living/basic/pet/dog/corgi/ian/proc/set_rest_state(state)
	resting_state = state
	update_icons()

/mob/living/basic/pet/dog/corgi/ian/update_icons()
	. = ..()

	// Dead
	if(stat)
		icon_state = "[initial(icon_state)][is_slow ? "_old" : ""][shaved ? "_shaved" : ""]_dead"
		return

	// Wheelchair
	if(is_slow)
		icon_state = "[initial(icon_state)]_old[shaved ? "_shaved" : ""]"
		return

	switch(resting_state)
		if(RESTING_STATE_NONE)
			icon_state = initial(icon_state)
		if(RESTING_STATE_SIT)
			icon_state = "[initial(icon_state)]_sit[shaved ? "_shaved" : ""]"
		if(RESTING_STATE_REST)
			icon_state = "[initial(icon_state)]_rest[shaved ? "_shaved" : ""]"

#undef RESTING_STATE_NONE
#undef RESTING_STATE_SIT
#undef RESTING_STATE_REST
