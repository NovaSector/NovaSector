SUBSYSTEM_DEF(storytellers)
	name = "Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_PING

	/// Active storyteller instance
	var/datum/storyteller/active

	var/station_value = 0

	/// Goal registry built from JSON
	var/list/goals_by_id = list()
	/// Root goals without a valid parent
	var/list/goal_roots = list()
	/// Base directory for expressions/config
	var/goal_base_dir = "config/storyteller/expressions"
	/// Current active goal (for tracking progress)
	var/datum/storyteller_goal/active_goal


/datum/controller/subsystem/storytellers/Initialize()
	. = ..()
	// Load goals registry from all configured paths
	load_all_goals()
	// Create default storyteller
	active = new /datum/storyteller
	active.initialize_round()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		active.think()
		// Check if active goal is still valid or achieved
		if(active_goal)
			var/list/context = active.get_context()
			if(!active_goal.is_available(context))
				// Goal no longer valid; clear and select new
				active_goal = select_weighted_goal(context)
			else if(active_goal_is_achieved(context))
				// Trigger event and move to next goal
				active_goal.trigger_event()
				log_storyteller("Goal [active_goal.id] achieved, triggered event: [active_goal.event_path]")
				var/list/children = active_goal.get_children()
				active_goal = children.len ? select_weighted_goal_from_list(children, context) : null
			// If no active goal, select a new one
			if(!active_goal)
				active_goal = select_weighted_goal(context)
				if(active_goal)
					log_storyteller("Selected new goal: [active_goal.id]")

/datum/controller/subsystem/storytellers/proc/register_atom_for_storyteller(atom/A)
	if(!active)
		return
	if(isnull(A) || QDELETED(A))
		return
	var/value = A.story_value()
	if(isnull(value) || value <= 0)
		return
	active.analyzer.register_atom_for_storyteller(A)
	station_value += value

/// Check if the active goal is achieved (e.g., requirement still true and event conditions met)
/datum/controller/subsystem/storytellers/proc/active_goal_is_achieved(list/context)
	if(!active_goal)
		return FALSE
	// Example: assume goal is achieved if requirement is true and event_path is defined
	return active_goal.is_available(context) && active_goal.event_path

/// Select a goal from a specific list (e.g., children of a parent goal)
/datum/controller/subsystem/storytellers/proc/select_weighted_goal_from_list(list/candidates, list/context)
	if(!length(candidates))
		return null
	var/total = 0
	var/list/weights = list()
	for(var/datum/storyteller_goal/G in candidates)
		var/w = max(0, G.get_weight(context))
		weights[G] = w
		total += w
	if(total <= 0)
		var/datum/storyteller_goal/best = null
		var/best_p = -INFINITY
		for(var/datum/storyteller_goal/G in candidates)
			var/p = G.get_priority(context)
			if(isnull(best) || p > best_p)
				best = G
				best_p = p
		return best
	var/roll = rand() * total
	for(var/datum/storyteller_goal/G in candidates)
		roll -= weights[G]
		if(roll <= 0)
			return G
	return candidates[1]

/// Recursively enumerate all JSON files in goal_base_dir and subfolders
/datum/controller/subsystem/storytellers/proc/enumerate_goal_files(path = goal_base_dir)
	var/list/files = list()
	if(!fexists(path))
		return files
	for(var/entry in flist(path))
		var/full_path = "[path]/[entry]"
		if(findtext(entry, "/"))
			// Directory; recurse
			files += enumerate_goal_files(full_path)
		else if(copytext(entry, -4) == ".json")
			// JSON file
			files += full_path
	return files

/// Load all goal specs from discovered JSON files
/datum/controller/subsystem/storytellers/proc/load_all_goals()
	goals_by_id = list()
	goal_roots = list()
	var/list/files = enumerate_goal_files()
	for(var/path in files)
		var/list/result = storyteller_goals_from_json(path)
		if(!islist(result))
			log_storyteller("Failed to load goals from [path]")
			continue
		var/list/map_in = result["goals_by_id"]
		if(islist(map_in))
			for(var/id_key in map_in)
				goals_by_id[id_key] = map_in[id_key]
		var/list/roots_in = result["roots"]
		if(islist(roots_in))
			for(var/datum/storyteller_goal/G in roots_in)
				if(!(G in goal_roots))
					goal_roots += G
	// Relink children
	for(var/id_key in goals_by_id)
		var/datum/storyteller_goal/G = goals_by_id[id_key]
		G.link_children(goals_by_id)
	log_storyteller("Loaded [goals_by_id.len] goals and [goal_roots.len] root goals")

/// Return all goals available under a context
/datum/controller/subsystem/storytellers/proc/get_available_goals(list/context)
	var/list/available = list()
	for(var/id_key in goals_by_id)
		var/datum/storyteller_goal/G = goals_by_id[id_key]
		if(G.is_available(context))
			available += G
	return available

/// Select a goal given context, using weight, then priority as tie-breaker
/datum/controller/subsystem/storytellers/proc/select_weighted_goal(list/context)
	var/list/candidates = get_available_goals(context)
	return select_weighted_goal_from_list(candidates, context)



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
		var/list/context = ctl.get_context()
		for(var/id_key in SSstorytellers.goals_by_id)
			var/datum/storyteller_goal/G = SSstorytellers.goals_by_id[id_key]
			if(G.is_available(context))
				goals += list(list(
					"id" = G.id,
					"name" = G.name || G.id,
					"weight" = G.get_weight(context),
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
			"weight" = ctl.current_global_goal.get_weight(ctl.get_context()),
		)
	if(ctl.subgoals)
		data["current_subgoal"] = list(
			"id" = ctl.subgoals.id,
			"name" = ctl.subgoals.name || ctl.subgoals.id,
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
			ctl.trigger_random_event(ctl.get_context())
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
				ctl.current_global_goal = G
				ctl.global_goal_weight = G.get_weight(ctl.get_context())
				ctl.global_goal_progress = 0
				var/list/children = G.get_children()
				ctl.subgoals = children.len ? SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context()) : null
			return TRUE
		if("reroll_goal")
			ctl.current_global_goal = SSstorytellers.select_weighted_goal(ctl.get_context())
			if(ctl.current_global_goal)
				ctl.global_goal_weight = ctl.current_global_goal.get_weight(ctl.get_context())
				var/list/children = ctl.current_global_goal.get_children()
				ctl.subgoals = children.len ? SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context()) : null
			return TRUE
		if("promote_subgoal")
			if(ctl.subgoals)
				ctl.current_global_goal = ctl.subgoals
				ctl.global_goal_weight = ctl.current_global_goal.get_weight(ctl.get_context())
				ctl.global_goal_progress = 0
				ctl.subgoals = null
			return TRUE
		if("next_subgoal")
			if(ctl.current_global_goal)
				var/list/children = ctl.current_global_goal.get_children()
				if(children.len)
					ctl.subgoals = SSstorytellers.select_weighted_goal_from_list(children, ctl.get_context())
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
