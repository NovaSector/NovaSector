GLOBAL_LIST(storyteller_vote_uis)
#define FIRE_PRIORITY_STORYTELLERS 101


SUBSYSTEM_DEF(storytellers)
	name = "AI Storytellers"
	runlevels = RUNLEVEL_GAME
	wait = 1 SECONDS
	priority = FIRE_PRIORITY_STORYTELLERS

	// Stortyteller selected on vote
	var/selected_path
	// Difficult selected on vote
	var/selected_difficult

	var/current_vote_duration = 60 SECONDS

	var/vote_active = FALSE
	/// Active storyteller instance
	var/datum/storyteller/active

	// The current station value
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

	RegisterSignal(src, COMSIG_CLIENT_MOB_LOGIN, PROC_REF(on_login))
	return SS_INIT_SUCCESS


/datum/controller/subsystem/storytellers/fire(resumed)
	if(active)
		active.think()


/datum/controller/subsystem/storytellers/proc/setup_game(start_now = FALSE)
	disable_dynamic()
	disable_ICES()

	if(vote_active)
		end_vote()

/datum/controller/subsystem/storytellers/proc/disable_dynamic()
	SSdynamic.flags = SS_NO_FIRE
	SSdynamic.antag_events_enabled = FALSE
	// TODO: add ability to completely disable dynamic by adading all rullsets to admin-disabled


/datum/controller/subsystem/storytellers/proc/disable_ICES()
	SSevents.flags = SS_NO_FIRE
	SSevents.intensity_credit_rate = 0
	SSevents.intensity_credit_last_time = 0
	SSevents.active_intensity_multiplier = 0


/datum/controller/subsystem/storytellers/proc/initialize_storyteller()
	if(!ispath(selected_path, /datum/storyteller))
		log_storyteller("Failed to Initialize storyteller: invalid path [selected_path]")
		message_admins(span_bolditalic("Failed to Initialize storyteller! Default storyteller selected"))
		if (active)
			qdel(active)
		active = new /datum/storyteller
		active.difficulty_multiplier = 1.0
		active.initialize_round()
		return

	active = new selected_path
	active.difficulty_multiplier = clamp(selected_difficult, 0.3, 5.0)
	active.initialize_round()

/datum/controller/subsystem/storytellers/proc/on_login(mob/new_client)
	if(vote_active)
		var/datum/storyteller_vote_ui/ui = new(new_client, current_vote_duration)
		ui.ui_interact(new_client)

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

		if(!goal.tags)
			log_storyteller("Storyteller goal [goal_type] has signed with no category.")
			goal.tags = STORY_GOAL_UNCATEGORIZED

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



/datum/controller/subsystem/storytellers/proc/filter_goals(category = null, required_tags = null, subtype = null, all_tags_required = FALSE, include_children = TRUE)
	var/list/result = list()


	var/list/goals_to_check = list()
	var/category_str
	if(category & STORY_GOAL_RANDOM)
		category_str = "GOAL_RANDOM"
	else if(category & STORY_GOAL_GOOD)
		category_str = "GOAL_GOOD"
	else if(category & STORY_GOAL_BAD)
		category_str = "GOAL_BAD"
	else if(category & STORY_GOAL_NEUTRAL)
		category_str = "GOAL_NEUTRAL"
	else
		category_str = "GOAL_UNCATEGORIZED"

	var/is_global = category & STORY_GOAL_GLOBAL | FALSE
	if(category)
		if(!goals_by_category[category_str])
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

		if(is_global & !goal.category & STORY_GOAL_GLOBAL)
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


/datum/controller/subsystem/storytellers/proc/start_vote(duration = 60 SECONDS)
	GLOB.storyteller_vote_uis = list()
	to_chat(world, span_boldnotice("Storyteller voting has begun!"))
	current_vote_duration = duration
	for (var/client/C in GLOB.clients)
		var/datum/storyteller_vote_ui/ui = new(C, duration)
		ui.ui_interact(C.mob)
	addtimer(CALLBACK(src, PROC_REF(check_vote_end)), duration)
	log_storyteller("Storyteller vote started: duration=[duration/10]s")
	vote_active = TRUE

/datum/controller/subsystem/storytellers/proc/check_vote_end()
	if(length(GLOB.storyteller_vote_uis) > 0)
		end_vote()

/datum/controller/subsystem/storytellers/proc/end_vote()
	if(!length(GLOB.storyteller_vote_uis))
		return

	vote_active = FALSE
	var/list/tallies = list()
	var/list/all_diffs = list()
	var/total_votes = 0
	for(var/client/client in GLOB.storyteller_vote_uis)
		var/datum/storyteller_vote_ui/ui = GLOB.storyteller_vote_uis[client]
		for(var/ckey in ui.votes)
			var/list/v = ui.votes[ckey]
			var/path_str = v["storyteller"]
			if (!path_str)
				continue
			tallies[path_str] = (tallies[path_str] || 0) + 1
			if (v["difficulty"])
				all_diffs += v["difficulty"]
			total_votes++
		SStgui.close_uis(ui.owner.mob, ui)
		qdel(ui)

	GLOB.storyteller_vote_uis = list()
	var/list/best_storytellers = list()
	var/max_votes = 0
	for (var/path_str in tallies)
		var/count = tallies[path_str]
		if (count > max_votes)
			max_votes = count
			best_storytellers = list(path_str)
		else if (count == max_votes)
			best_storytellers += path_str

	var/selected_path_str
	if (best_storytellers.len == 1)
		selected_path_str = best_storytellers[1]
	else
		selected_path_str = pick(best_storytellers)
		to_chat(world, span_announce("Tie broken randomly!"))

	selected_path = text2path(selected_path_str)
	var/avg_diff = length(all_diffs) ? get_avg(all_diffs) : 1.0
	selected_difficult = avg_diff

	var/selected_name = find_candidate_name_global(selected_path_str)
	to_chat(world, span_boldnotice("Storyteller selected: [selected_name] at difficulty [round(avg_diff, 0.1)]."))
	log_storyteller("Storyteller vote ended: [selected_path_str] (votes=[max_votes], diff=[avg_diff]), total votes=[total_votes]")
	if(!SSticker.state == GAME_STATE_PLAYING)
		return

	if(!ispath(selected_path, /datum/storyteller))
		log_storyteller("Vote failed: invalid path [selected_path_str]")
		to_chat(world, span_boldnotice("Vote failed! Default storyteller selected."))
		if (active)
			qdel(active)
		active = new /datum/storyteller
		active.difficulty_multiplier = 1.0
		active.initialize_round()
		return

	if(active)
		qdel(active)
	active = new selected_path
	active.difficulty_multiplier = clamp(avg_diff, 0.3, 5.0)
	active.initialize_round()

/datum/storyteller_vote_ui/proc/find_candidate_name(path_str)
	for (var/list/cand in candidates)
		if (cand["id"] == path_str)
			return cand["name"]
	return "Unknown"

/proc/get_avg(list/nums)
	if (!length(nums))
		return 1.0
	var/sum = 0
	for (var/n in nums)
		sum += n
	return sum / length(nums)

/proc/find_candidate_name_global(path_str)
	for (var/datum/storyteller_vote_ui/ui in GLOB.storyteller_vote_uis)
		for (var/list/cand in ui.candidates)
			if (cand["id"] == path_str)
				return cand["name"]
	var/datum/storyteller/ST = text2path(path_str)
	return initial(ST:name) || "Unknown"




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
		for(var/datum/storyteller_goal/subgoal in ctl.get_closest_subgoals())
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
	data["difficulty_multiplier"] = ctl.difficulty_multiplier
	data["event_difficulty_modifier"] = ctl.difficulty_multiplier
	data["can_force_event"] = TRUE
	data["current_world_time"] = world.time
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
			ctl.next_think_time = world.time + 1
			return TRUE
		if("trigger_event")
			// fafa
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
				// Promote immediately
				ctl.current_global_goal = G
				ctl.global_goal_weight = G.get_weight(ctl.inputs.vault, ctl.inputs, ctl)
				ctl.global_goal_progress = 0
			return TRUE
		if("reroll_goal")
			ctl.current_global_goal = null
			ctl.global_goal_progress = 0
			return TRUE
		if("promote_subgoal")
			if(ctl.subgoals)
				var/datum/storyteller_goal/G2 = pick(ctl.subgoals)
				ctl.current_global_goal = G2
				ctl.global_goal_weight = G2.get_weight(ctl.inputs.vault, ctl.inputs, ctl)
				ctl.global_goal_progress = 0
				ctl.subgoals = null
			return TRUE
		if("next_subgoal")
			// Ask planner to regenerate timeline which will pick next subgoal
			ctl.planner.recalculate_plan(ctl, ctl.inputs, ctl.balancer.make_snapshot(ctl.inputs))
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
			ctl.planner.update_plan(ctl, ctl.inputs, ctl.balancer.make_snapshot(ctl.inputs))
			return TRUE
		// Advanced setters
		if("set_difficulty")
			var/value = clamp(text2num(params["value"]), 0.1, 5.0)
			ctl.difficulty_multiplier = value
			return TRUE
		if("set_target_tension")
			var/value = clamp(text2num(params["value"]), 0, 100)
			ctl.target_tension = value
			return TRUE
		if("set_think_delay")
			var/value = max(0, round(text2num(params["value"])) )
			ctl.base_think_delay = value
			ctl.schedule_next_think()
			return TRUE
		if("set_event_intervals")
			var/minv = max(0, round(text2num(params["min"])) )
			var/maxv = max(minv, round(text2num(params["max"])) )
			ctl.min_event_interval = minv
			ctl.max_event_interval = maxv
			return TRUE
		if("set_grace_period")
			var/value = max(0, round(text2num(params["value"])) )
			ctl.grace_period = value
			return TRUE
		if("set_repetition_penalty")
			var/value = clamp(text2num(params["value"]), 0, 2)
			ctl.repetition_penalty = value
			return TRUE
	return FALSE

ADMIN_VERB(storyteller_admin, R_ADMIN, "Storyteller", "Open the storyteller admin panel.", ADMIN_CATEGORY_EVENTS)
	var/datum/storyteller_admin_ui/ui = new
	ui.ui_interact(usr)


/datum/storyteller_vote_ui
	var/list/candidates
	var/list/votes = list() // ckey -> list("storyteller" = path_string, "difficulty" = num)
	var/vote_end_time = 0
	var/vote_duration = 60 SECONDS
	var/client/owner

/datum/storyteller_vote_ui/New(client/C, duration = 60 SECONDS)
	. = ..()
	if (!C)
		qdel(src)
		return
	owner = C
	vote_duration = duration
	vote_end_time = world.time + duration
	candidates = list()
	for (var/typepath in subtypesof(/datum/storyteller))
		if (typepath == /datum/storyteller)
			continue
		var/datum/storyteller/ST = typepath
		var/name = initial(ST:name)
		var/desc = initial(ST:desc)
		candidates += list(list(
			"id" = "[typepath]",
			"name" = name,
			"desc" = desc,
			"portrait" = null,
		))
	GLOB.storyteller_vote_uis += list(
		owner = src
	)

/datum/storyteller_vote_ui/Destroy()
	GLOB.storyteller_vote_uis -= owner
	return ..()

/datum/storyteller_vote_ui/ui_state(mob/user)
	return GLOB.always_state

/datum/storyteller_vote_ui/ui_static_data(mob/user)
	var/list/data = list()
	data["storytellers"] = candidates
	data["min_difficulty"] = 0.3
	data["max_difficulty"] = 5.0
	return data

/datum/storyteller_vote_ui/ui_data(mob/user)
	var/ckey = owner.ckey
	var/list/personal_vote = votes[ckey] || list("storyteller" = null, "difficulty" = 1.0)

	var/list/tallies = list()
	var/list/difficulties = list()
	for (var/datum/storyteller_vote_ui/ui in GLOB.storyteller_vote_uis)
		for (var/vote_ckey in ui.votes)
			var/list/v = ui.votes[vote_ckey]
			var/path_str = v["storyteller"]
			if (!path_str)
				continue
			tallies[path_str] = (tallies[path_str] || 0) + 1
			LAZYADD(difficulties[path_str], v["difficulty"])

	var/list/top_tallies = list()
	var/list/sorted_tallies = sortTim(tallies, /proc/cmp_numeric_dsc, TRUE)
	for (var/i = 1 to min(3, length(sorted_tallies)))
		var/path_str = sorted_tallies[i]
		top_tallies += list(list(
			"name" = find_candidate_name(path_str),
			"count" = tallies[path_str],
			"avg_diff" = length(difficulties[path_str]) ? get_avg(difficulties[path_str]) : 1.0
		))

	var/list/data = list()
	data["personal_selection"] = personal_vote["storyteller"]
	data["personal_difficulty"] = personal_vote["difficulty"]
	data["total_voters"] = length(GLOB.clients)
	data["voted_count"] = length(tallies)
	data["time_left"] = max(0, (vote_end_time - world.time))
	data["top_tallies"] = top_tallies
	data["is_open"] = world.time < vote_end_time
	return data

/datum/storyteller_vote_ui/ui_interact(mob/user, datum/tgui/ui)
	if (!owner)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "StorytellerVote", "Storyteller Vote")
		ui.open()

/datum/storyteller_vote_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return
	var/ckey = owner.ckey
	switch (action)
		if ("select_storyteller")
			var/id = params["id"]
			var/list/personal = votes[ckey] || list()
			personal["storyteller"] = id
			votes[ckey] = personal
			return TRUE
		if ("set_difficulty")
			var/value = text2num(params["value"])
			value = clamp(value, 0.3, 5.0)
			var/list/personal = votes[ckey] || list()
			personal["difficulty"] = value
			votes[ckey] = personal
			return TRUE
	return FALSE


/client/verb/reopen_storyteller_vote()
	set name = "Reopen Storyteller Vote"
	set category = "OOC"
	var/datum/storyteller_vote_ui/ui = GLOB.storyteller_vote_uis[usr.client]
	if(!SSstorytellers.vote_active)
		to_chat(src, span_warning("Voting has ended."))
		return
	if (!ui)
		to_chat(src, span_warning("No active storyteller vote"))
		return
	if (world.time >= ui.vote_end_time)
		to_chat(src, span_warning("Voting has ended."))
		return
	ui.ui_interact(mob)



ADMIN_VERB(storyteller_vote, R_ADMIN | R_DEBUG, "Storyteller - Start Vote", "Start a global storyteller vote.", ADMIN_CATEGORY_EVENTS)
	if (tg_alert(usr, "Start global vote?", "Storyteller Vote", "Yes", "No") == "No")
		return
	var/duration = tgui_input_number(usr, "Duration in seconds:", "Vote Duration", 60, 240, 60)
	SSstorytellers.start_vote(duration SECONDS)

ADMIN_VERB(storyteller_end_vote, R_ADMIN | R_DEBUG, "Storyteller - End Vote", "End vote early.", ADMIN_CATEGORY_EVENTS)
	SSstorytellers.end_vote()

#undef FIRE_PRIORITY_STORYTELLERS
