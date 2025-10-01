SUBSYSTEM_DEF(storytellers)
	name = "Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_PING

	/// Active storyteller instance
	var/datum/storyteller/active

	var/station_value = 0

	var/list/goals_by_category = list()
	/// Goal registry built from JSON
	var/list/goals_by_id = list()
	/// Root goals without a valid parent
	var/list/goal_roots = list()
	/// Current active goal (for tracking progress)
	var/datum/storyteller_goal/active_goal


/datum/controller/subsystem/storytellers/Initialize()
	. = ..()
	goals_by_id = list()
	goal_roots = list()
	goals_by_category = list()
	collect_avaible_goals()


	// Create default storyteller
	active = new /datum/storyteller
	active.initialize_round()
	return SS_INIT_SUCCESS


/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		active.think()


/datum/controller/subsystem/storytellers/proc/register_atom_for_storyteller(atom/A)
	if(!active)
		return
	if(isnull(A) || QDELETED(A))
		return
	var/value = A.story_value()
	if(isnull(value) || value <= 0)
		return
	active.analyzer.register_atom_for_storyteller(A)


/datum/controller/subsystem/storytellers/proc/active_goal_is_achieved(list/context)
	if(!active_goal)
		return FALSE
	return active_goal.is_available(context) && active_goal.event_path



/datum/controller/subsystem/storytellers/proc/collect_avaible_goals()
	goals_by_id = list()
	goals_by_category = list()
	goal_roots = list()

	goals_by_category["GOAL_RANDOM"] = list()
	goals_by_category["GOAL_GOOD"] = list()
	goals_by_category["GOAL_BAD"] = list()
	goals_by_category["GOAL_NEUTRAL"] = list()
	goals_by_category["GOAL_UNCATEGORIZED"] = list()

	var/list/goal_types = subtypesof(/datum/storyteller_goal)
	for(var/goal_type in goal_types)
		var/datum/storyteller_goal/goal = new goal_type()

		if(goal.id)
			goals_by_id[goal.id] = goal
		else
			log_storyteller("Storyteller goal [goal_type] has no ID and was skipped.")
			continue

		if(goal.category & STORY_GOAL_RANDOM)
			goals_by_category["GOAL_RANDOM"] += goal
		if(goal.category & STORY_GOAL_GOOD)
			goals_by_category["GOAL_GOOD"] += goal
		if(goal.category & STORY_GOAL_BAD)
			goals_by_category["GOAL_BAD"] += goal
		if(goal.category & STORY_GOAL_NEUTRAL)
			goals_by_category["GOAL_NEUTRAL"] += goal
		if(goal.category & STORY_GOAL_UNCATEGORIZED)
			goals_by_category["GOAL_UNCATEGORIZED"] += goal

	for(var/id in goals_by_id)
		var/datum/storyteller_goal/goal = goals_by_id[id]
		goal.link_children(goals_by_id)

	for(var/id in goals_by_id)
		var/datum/storyteller_goal/goal = goals_by_id[id]
		if(!goal.parent_id || !goals_by_id[goal.parent_id])
			goal_roots += goal


	log_storyteller("Collected [goals_by_id.len] storyteller goals. Root goals: [goal_roots.len].")

/datum/controller/subsystem/storytellers/proc/filter_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE, include_children = TRUE)
	var/list/result = list()


	var/list/goals_to_check = list()
	if(category)
		if(!goals_by_category[category])
			log_storyteller("Invalid category [category] in filter_goals.")
			return result
		goals_to_check = goals_by_category[category]
	else
		var/list/seen_ids = list()
		for(var/cat in goals_by_category)
			for(var/datum/storyteller_goal/goal in goals_by_category[cat])
				if(!seen_ids[goal.id])
					goals_to_check += goal
					seen_ids[goal.id] = TRUE

	for(var/datum/storyteller_goal/goal in goals_to_check)
		// Check subtype
		if(subtype && !istype(goal, subtype))
			continue

		if(required_tags)
			if(!goal.tags)
				continue
			if(all_tags_required)
				if((goal.tags & required_tags) != required_tags)
					continue
			else
				if(!(goal.tags & required_tags))
					continue

		if(!include_children && goal.parent_id && goals_by_id[goal.parent_id])
			continue
		result += goal
	return result


/// Convenience method to get root goals by category, tags, and subtype
/datum/controller/subsystem/storytellers/proc/get_root_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE)
	return filter_goals(category, required_tags, subtype, all_tags_required, FALSE)

/// Convenience method to get goals by category and subtype
/datum/controller/subsystem/storytellers/proc/get_goals_by_category_and_subtype(category, subtype)
	return filter_goals(category, null, subtype, FALSE, TRUE)

/// Convenience method to get goals by tags
/datum/controller/subsystem/storytellers/proc/get_goals_by_tags(required_tags, all_tags_required = FALSE)
	return filter_goals(null, required_tags, null, all_tags_required, TRUE)




/datum/storyteller_admin_ui
	/// cached reference to storyteller
	var/datum/storyteller/ctl

/datum/storyteller_admin_ui/New()
	. = ..()
	ctl = SSstorytellers?.active

/datum/storyteller_admin_ui/ui_state(mob/user)
	return ADMIN_STATE(R_ADMIN)

/datum/storyteller_admin_ui/ui_interact(mob/user, datum/tgui/ui)
	ctl = SSstorytellers?.active
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Storyteller")
		ui.open()

/datum/storyteller_admin_ui/ui_static_data(mob/user)
	var/list/data = list()
	var/list/moods = list()
	for(var/mood_type as anything in subtypesof(/datum/storyteller_mood))
		if(mood_type == /datum/storyteller_mood)
			continue
		var/datum/storyteller_mood/mood = mood_type
		moods += list(list(
			"id" = "[mood_type]",
			"name" = initial(mood.name),
			"pace" = initial(mood.pace),
			"threat" = initial(mood.aggression),
		))
	data["available_moods"] = moods

	// Available goals from the subsystem registry, filtered by availability
	var/list/goals = list()
	if(ctl)
		for(var/id_key in SSstorytellers.goals_by_id)
			var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id_key]
			if(G.is_available(ctl.inputs.vault, ctl.inputs, ctl))
				goals += list(list(
					"id" = G.id,
					"name" = G.name || G.id,
					"weight" = G.get_weight(ctl.inputs.vault, ctl.inputs, ctl),
				))
	data["available_goals"] = goals
	return data

/datum/storyteller_admin_ui/ui_data(mob/user)
	var/list/data = list()
	ctl = SSstorytellers?.active
	if(!ctl)
		data["name"] = "No storyteller"
		return data

	data["name"] = ctl.name
	data["desc"] = ctl.desc
	if(ctl.mood)
		data["mood"] = list(
			"id" = "[ctl.mood.type]",
			"name" = ctl.mood.name,
			"pace" = ctl.mood.pace,
			"threat" = ctl.mood.get_threat_multiplier(),
		)
	if(ctl.current_global_goal)
		data["current_global_goal"] = list(
			"id" = ctl.current_global_goal.id,
			"name" = ctl.current_global_goal.name || ctl.current_global_goal.id,
			"weight" = ctl.current_global_goal.get_weight(ctl.inputs.vault, ctl.inputs, ctl),
		)
	if(length(ctl.subgoals))
		for(var/datum/storyteller_goal/subgoal in ctl.subgoals)
			data["current_subgoal"] += list(
				list(
					"id" = subgoal.id,
					"name" = subgoal.name || subgoal.id
				),
			)
	data["global_goal_progress"] = ctl.global_goal_progress
	data["global_goal_weight"] = ctl.global_goal_weight
	data["next_think_time"] = ctl.next_think_time
	data["base_think_delay"] = ctl.base_think_delay
	data["min_event_interval"] = ctl.min_event_interval
	data["max_event_interval"] = ctl.max_event_interval
	data["player_count"] = ctl.get_active_player_count()
	data["antag_count"] = ctl.get_active_antagonist_count()
	data["player_antag_balance"] = ctl.player_antag_balance
	data["event_difficulty_modifier"] = ctl.event_difficulty_modifier
	data["can_force_event"] = TRUE

	// Recent events log formatting
	var/list/events = list()
	for(var/i in 1 to length(ctl.recent_events))
		var/tick = ctl.recent_events[i]
		events += list(list(
			"time" = tick,
			"desc" = "Event at [tick]",
		))
	data["recent_events"] = events
	return data

/datum/storyteller_admin_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!check_rights(R_ADMIN))
		return TRUE
	ctl = SSstorytellers?.active
	if(!ctl)
		return TRUE

	switch(action)
		if("force_think")
			ctl.think()
			return TRUE
		if("trigger_event")
//			ctl.trigger_random_event(ctl.get_context())
			return TRUE
		if("clear_goal")
			ctl.current_global_goal = null
			ctl.subgoals = null
			ctl.global_goal_progress = 0
			return TRUE
		if("complete_goal")
			ctl.on_goal_completed()
			return TRUE
		if("set_global_goal")
			var/id = params["id"]
			if(!id)
				return TRUE
			var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id]
			if(istype(G))
/*
				ctl.current_global_goal = G
				ctl.global_goal_weight = G.get_weight(ctl.get_context())
				ctl.global_goal_progress = 0
				var/list/children = G.get_children()
				ctl.subgoals = children.len ? SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context()) : null
*/
			return TRUE
		if("reroll_goal")
/*
			ctl.current_global_goal = SSstorytellers.select_weighted_goal(ctl.get_context())
			if(ctl.current_global_goal)
				ctl.global_goal_weight = ctl.current_global_goal.get_weight(ctl.get_context())
				var/list/children = ctl.current_global_goal.get_children()
				ctl.subgoals = children.len ? SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context()) : null
*/
			return TRUE
		if("promote_subgoal")
/*
			if(ctl.subgoals)
				ctl.current_global_goal = ctl.subgoals
				ctl.global_goal_weight = ctl.current_global_goal.get_weight(ctl.get_context())
				ctl.global_goal_progress = 0
				ctl.subgoals = null
*/
			return TRUE
		if("next_subgoal")
/*
			if(ctl.current_global_goal)
				var/list/children = ctl.current_global_goal.get_children()
				if(children.len)
					ctl.subgoals = SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context())
*/
			return TRUE
		if("set_mood")
			var/mood_id = params["id"]
			if(mood_id)
				var/path = text2path(mood_id)
				if(ispath(path, /datum/storyteller_mood))
					ctl.mood = new path
					ctl.schedule_next_think()
			return TRUE
		if("set_pace")
			var/pace = clamp(text2num(params["pace"]), 0.1, 3.0)
			if(ctl.mood)
				ctl.mood.pace = pace
				ctl.schedule_next_think()
			return TRUE
		if("reanalyse")
			ctl.analyzer.scan_station()
			ctl.inputs = ctl.analyzer.get_inputs()
			return TRUE
		if("replan")
			ctl.planner.update_plan(ctl, ctl.inputs, null)
			return TRUE
	return FALSE

ADMIN_VERB(storyteller_admin, R_ADMIN, "Storyteller", "Open the storyteller admin panel.", ADMIN_CATEGORY_EVENTS)
	var/datum/storyteller_admin_ui/ui = new
	ui.ui_interact(usr)
