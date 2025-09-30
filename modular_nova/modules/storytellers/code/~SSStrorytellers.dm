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
