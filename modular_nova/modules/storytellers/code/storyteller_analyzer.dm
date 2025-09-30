#define MOB_PLAYER "player"
#define MOB_ANTAGONIST "antagonist"
#define TOTAL_PLAYERS "total_players"
#define TOTAL_ANTAGS "total_antags"

// Analyzer
// and weights for crew and antagonists. These metrics influence event planning,
// global goal selection, and balancing in the storyteller.
// Station value is a rough estimate of the station's overall "worth" based on atoms.
// Crew/antag weights help balance player vs. threat dynamics.
/datum/storyteller_analyzer
	// Our storyteller instance
	var/datum/storyteller/owner
	/// Multiplier for the station value (can be adjusted by mood or other factors)
	var/multiplier = 1.0

	var/list/check_list = list ()

	var/analyzing = FALSE

	var/cache_duration = 1 MINUTES

	COOLDOWN_DECLARE(inputs_cahche_duration)

	COOLDOWN_DECLARE(station_integrity_duration)

	VAR_PRIVATE/datum/storyteller_inputs/actual_inputs

	VAR_PRIVATE/datum/station_state/actual_state

	VAR_PRIVATE/datum/station_state/cached_state

	/// Role multipliers overrides (higher for key roles like security/heads)
	var/list/role_multipliers = list(
		JOB_SECURITY_OFFICER = 1.3,
		JOB_HEAD_OF_SECURITY = 1.5,
		JOB_CAPTAIN = 1.6,
		JOB_HEAD_OF_PERSONNEL = 1.3,
	)


/datum/storyteller_analyzer/New(datum/storyteller/_owner)
	..()
	owner = _owner
	for(var/datum/storytellor_check/check in check_list)
		check = new
	compute_station_value()
	scan_station()

	cached_state = new
	actual_state = new

/datum/storyteller_analyzer/proc/get_inputs(scan_flags)
	SHOULD_NOT_OVERRIDE(TRUE)
	RETURN_TYPE(/datum/storyteller_inputs)

	if(COOLDOWN_FINISHED(src, inputs_cahche_duration))
		scan_station()

	return actual_inputs


/datum/storyteller_analyzer/proc/scan_station(scan_flags)
	ASYNC
	analyzing = TRUE
	COOLDOWN_START(src, inputs_cahche_duration, cache_duration)
	var/datum/storyteller_inputs/inputs = new
	inputs.station_state = get_station_integrity()
	inputs.station_value = SSstorytellers.station_value
	inputs.crew_weight = get_crew_weight()
	inputs.antag_weight = get_antag_weight()
	inputs.player_count = get_player_counts()[TOTAL_PLAYERS]
	inputs.antag_count = get_player_counts()[TOTAL_ANTAGS]
	inputs.antag_crew_ratio = get_antag_to_crew_ratio(inputs.antag_weight, inputs.crew_weight)

	for(var/datum/storytellor_check/check in check_list)
		if(!istype(check))
			continue
		if(!check.can_perform_now(src, owner, inputs, scan_flags))
			continue
		INVOKE_ASYNC(check, TYPE_PROC_REF(/datum/storytellor_check, perform), src, owner, inputs, scan_flags)

	UNTIL(analyzing)
	actual_inputs = inputs


/datum/storyteller_analyzer/proc/try_stop_analyzing(datum/storytellor_check/current)
	if(!can_finish_analyzing(current))
		return
	analyzing = FALSE


// Checks if the current scan stage is the last in the check_list
// Returns TRUE if it is the last stage (analysis can finish), FALSE otherwise
/datum/storyteller_analyzer/proc/can_finish_analyzing(datum/storytellor_check/current)
	if(!(current in check_list))
		return FALSE

	if(current == check_list[check_list.len])
		return TRUE

	return FALSE


/datum/storyteller_analyzer/proc/get_station_integrity()
	if(isnull(actual_state))
		actual_state = new
	if(isnull(cached_state))
		cached_state = new

	cached_state.floor = actual_state.floor
	cached_state.wall = actual_state.wall
	cached_state.r_wall = actual_state.r_wall
	cached_state.window = actual_state.window
	cached_state.door = actual_state.door
	cached_state.grille = actual_state.grille
	cached_state.mach = actual_state.mach

	if(COOLDOWN_FINISHED(src, station_integrity_duration))
		INVOKE_ASYNC(actual_state, TYPE_PROC_REF(/datum/station_state, count))
		COOLDOWN_START(src, station_integrity_duration, cache_duration * 10)
		return cached_state
	return actual_state


// Very rough: sum of atoms approximate value; can be refined later
// This is a full recalculation; use register_atom_for_storyteller for incremental updates
/datum/storyteller_analyzer/proc/compute_station_value()
	var/raw_total = 0
	for(var/atom/movable/A in SSmapping.levels_by_trait(ZTRAIT_STATION))
		raw_total += A.story_value()


	var/crew_weight = get_crew_weight()
	var/antag_weight = get_antag_weight()
	var/total_living_weight = crew_weight + antag_weight

	var/weighted_value = raw_total + total_living_weight
	var/mult = multiplier * owner.mood.get_value_multiplier()
	var/final_value = weighted_value * mult

	SSstorytellers.station_value = final_value


// Computes total weight for non-antagonist crew
// Factors: base weight by type, role multipliers, optional playtime scaling
// Playtime: Scales weight by player's living playtime (e.g., more experienced = higher weight)
/datum/storyteller_analyzer/proc/get_crew_weight(use_playtime = FALSE)
	var/crew_weight = 0

	for(var/mob/living/M in GLOB.alive_player_list)  // Use alive_player_list for living players
		if(isobserver(M) || M.stat == DEAD)  // Skip observers and dead
			continue
		if(M.mind?.has_antag_datum())  // Skip antagonists
			continue

		var/weight = STORY_LIVING_WEIGHT
		if(iscarbon(M))
			weight = STORY_CARBON_WEIGHT
		if(ishuman(M))
			weight = STORY_HUMAN_WEIGHT

			var/mob/living/carbon/human/H = M
			var/job = H.mind?.assigned_role?.title
			if(job in role_multipliers)
				weight *= role_multipliers[job]

			// Optional playtime scaling (e.g., 1.0 + (playtime_hours / 10))
			if(use_playtime && H.client)
				var/playtime_minutes = H.client.get_exp_living(TRUE)
				var/playtime_hours = playtime_minutes / 60
				var/playtime_modifier = 1.0 + (playtime_hours / 10)  // Caps influence at higher hours
				weight *= min(playtime_modifier, 2.0)
		crew_weight += weight
	return crew_weight


/datum/storyteller_analyzer/proc/get_crew_weight_normalized(use_playtime = FALSE)
	var/weight = get_crew_weight(use_playtime)
	return weight / get_player_counts()[TOTAL_PLAYERS]


// Computes total weight for antagonists, normalized to scale around 1
// Base: Similar to crew but scaled by antag multiplier
/datum/storyteller_analyzer/proc/get_antag_weight()
	var/antag_weight = 0

	for(var/mob/living/M in GLOB.alive_player_list)
		if(isobserver(M) || M.stat == DEAD)
			continue
		if(!M.mind?.has_antag_datum())  // Only antagonists
			continue

		var/weight = STORY_LIVING_WEIGHT
		if(iscarbon(M))
			weight = STORY_CARBON_WEIGHT
		if(ishuman(M))
			weight = STORY_HUMAN_WEIGHT

			// Apply job role multiplier if applicable (antags can have jobs)
			var/mob/living/carbon/human/H = M
			var/job = H.mind?.assigned_role?.title
			if(job in role_multipliers)
				weight *= role_multipliers[job]

		// Apply antag scaling placeholder wor antag weights
		antag_weight += weight * (STORY_DEFAULT_ANTAG_WEIGHT / STORY_DEFAULT_WEIGHT)

	return antag_weight



/datum/storyteller_analyzer/proc/get_antag_weight_normalized()
	var/weight = get_antag_weight()
	return weight / get_player_counts()[TOTAL_ANTAGS]


// Returns the ratio of antag_weight to crew_weight (0-1+ range)
// Use provided values or fall back to cached/current
/datum/storyteller_analyzer/proc/get_antag_to_crew_ratio(antag_weight = null, crew_weight = null)
	if(isnull(antag_weight))
		antag_weight = get_antag_weight()
	if(isnull(crew_weight))
		crew_weight = get_crew_weight()

	if(crew_weight == 0)
		return 1.0

	return antag_weight / crew_weight



/datum/storyteller_analyzer/proc/get_player_counts()
	// Helper to get total players and antag count (minimal loop for efficiency)
	var/total_players = 0
	var/antag_count = 0

	for(var/mob/living/M in GLOB.alive_player_list)
		if(isobserver(M) || M.stat == DEAD)
			continue
		total_players++
		if(M.mind?.has_antag_datum())
			antag_count++

	return list(
		TOTAL_PLAYERS = total_players,
		TOTAL_ANTAGS = antag_count
	)


/datum/storyteller_analyzer/proc/register_atom_for_storyteller(atom/A)
	// Incremental addition for new atoms (e.g., spawned during round)
	// Avoids full recompute every tick
	var/value = A.story_value() * multiplier
	if(value <= 0)
		return
	SSstorytellers.station_value += value


/datum/storyteller_analyzer/proc/calculate_threat_level(antag_weight, crew_weight)
	if(crew_weight == 0)
		return 100
	return min(100, (antag_weight / crew_weight) * 100)

/datum/storyteller_analyzer/proc/calculate_station_integrity()
	return 100

/datum/storyteller_analyzer/proc/calculate_crew_satisfaction()
	return 50

#undef MOB_PLAYER
#undef MOB_ANTAGONIST
#undef TOTAL_PLAYERS
#undef TOTAL_ANTAGS
