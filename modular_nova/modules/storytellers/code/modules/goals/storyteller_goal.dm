// Storyteller Goals
/datum/storyteller_goal
	/// Unique identifier for the goal
	var/id
	/// Display name
	var/name
	/// Description
	var/desc
	/// Optional tags for filtering/grouping
	var/list/tags
	/// Optional parent goal id
	var/parent_id
	/// Children goal ids as declared by data (used to link after load)
	var/list/path_ids
	/// Linked child goal datums after resolution
	var/list/children
	/// Requirement expression; if null, goal is available
	var/datum/story_expr/requirement
	/// Weight/score expression; if null, defaults to 1.0
	var/datum/story_expr/weight
	/// Optional priority expression to break ties
	var/datum/story_expr/priority
	/// Optional event path to trigger on achievement (e.g., /datum/event/meteor)
	var/event_path
	/// Optional arguments to set on the event vars (list("varname" = value))
	var/list/event_args


/// Construct empty; call load_from_spec to populate
/datum/storyteller_goal/New()
	..()
	tags = list()
	path_ids = list()
	children = list()
	event_args = list()

/// Populate from a decoded JSON object spec
/datum/storyteller_goal/proc/load_from_spec(list/spec)
	if(!islist(spec))
		return FALSE
	id = spec["id"]
	name = spec["name"]
	desc = spec["desc"]
	tags = islist(spec["tags"]) ? spec["tags"] : list()
	parent_id = spec["parent_id"]
	path_ids = islist(spec["paths"]) ? spec["paths"] : list()

	var/req_node = spec["requirement"]
	if(islist(req_node) || istext(req_node))
		requirement = new /datum/story_expr(req_node)

	var/w_node = spec["weight"]
	if(islist(w_node) || istext(w_node))
		weight = new /datum/story_expr(w_node)

	var/p_node = spec["priority"]
	if(islist(p_node) || istext(p_node))
		priority = new /datum/story_expr(p_node)

	var/event_spec = spec["event"]
	if(islist(event_spec))
		var/path_text = event_spec["path"]
		if(istext(path_text))
			event_path = text2path(path_text)
		event_args = islist(event_spec["args"]) ? event_spec["args"] : list()

	return TRUE

/// Is goal available for selection under the given context?
/// Context should at least include: inputs, owner, vault
/datum/storyteller_goal/proc/is_available(list/context)
	if(isnull(requirement))
		return TRUE
	var/res = requirement.evaluate(context)
	return !!res

/// Compute selection weight; defaults to 1.0 if no expression
/datum/storyteller_goal/proc/get_weight(list/context)
	if(isnull(weight))
		return 1.0
	var/w = weight.evaluate(context)
	if(isnull(w))
		return 0
	return w

/// Compute tie-breaker priority; defaults to 0
/datum/storyteller_goal/proc/get_priority(list/context)
	if(isnull(priority))
		return 0
	var/p = priority.evaluate(context)
	return isnull(p) ? 0 : p

/// Return linked children
/datum/storyteller_goal/proc/get_children()
	return children

/// Link this goal's children by id using a registry
/datum/storyteller_goal/proc/link_children(list/goals_by_id)
	children = list()
	for(var/i in 1 to path_ids.len)
		var/child_id = path_ids[i]
		var/datum/storyteller_goal/G = goals_by_id[child_id]
		if(G)
			children += G
	return children

/// Trigger the associated event if defined (called when goal is achieved)
/datum/storyteller_goal/proc/trigger_event()
	if(!event_path)
		return
	var/datum/round_event/E = new event_path()
	if(E && event_args.len)
		for(var/key in event_args)
			if(key in E.vars)
				E.vars[key] = event_args[key]
	// Assuming integration with SSevents or similar; adjust as needed
	E.setup()
	E.announce()


// Helpers to build goals from JSON content

/// Build goals from a JSON file path. Returns a list with keys:
/// - "goals_by_id": map id -> goal
/// - "roots": list of top-level goals without a parent
/proc/storyteller_goals_from_json(path)
	if(!fexists(path))
		return list("goals_by_id" = list(), "roots" = list())
	var/text = file2text(path)
	if(isnull(text) || !length(text))
		return list("goals_by_id" = list(), "roots" = list())
	var/list/spec = safe_json_decode(text)
	if(!islist(spec))
		return list("goals_by_id" = list(), "roots" = list())
	return storyteller_goals_from_list(spec)

/// Build goals from a decoded list of goal specs
/proc/storyteller_goals_from_list(list/spec)
	var/list/goals_by_id = list()
	var/list/roots = list()

	// First pass: instantiate
	for(var/i in 1 to spec.len)
		var/list/entry = spec[i]
		if(!islist(entry))
			continue
		var/datum/storyteller_goal/G = new
		if(!G.load_from_spec(entry))
			qdel(G)
			continue
		if(isnull(G.id))
			qdel(G)
			continue
		goals_by_id[G.id] = G

	// Second pass: link children and build roots
	for(var/id_key in goals_by_id)
		var/datum/storyteller_goal/G = goals_by_id[id_key]
		G.link_children(goals_by_id)
		if(isnull(G.parent_id) || !(G.parent_id in goals_by_id))
			roots += G

	return list("goals_by_id" = goals_by_id, "roots" = roots)
