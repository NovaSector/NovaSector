
/datum/config_entry/flag/show_job_estimation
	default = TRUE

/datum/preference/toggle/ready_job
	savefile_key = "ready_job"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE

/datum/preference/toggle/ready_job/apply_to_human(mob/living/carbon/human/target, value, /datum/preferences/preferences)
	return FALSE

/datum/controller/subsystem/statpanels
	/// The assoc list of job estimations keyed to player ckey
	var/list/player_ready_data = list()
	/// The assoc list of job estimations keyed to player ckey (for command players only)
	var/list/command_player_ready_data = list()

/// Returns the list of job estimation strings that get output to the stat panel. First to ready up get listed first. Command roles get displayed before all the rest.
/datum/controller/subsystem/statpanels/proc/get_job_estimation()
	var/list/job_estimation = list(
		"",
		"------------------",
		"Job Estimation:",
		"",
	)

	for(var/player_ref in command_player_ready_data)
		job_estimation += command_player_ready_data[player_ref]

	for(var/player_ref in player_ready_data)
		job_estimation += player_ready_data[player_ref]

	return job_estimation

/// Adds a player to the ready estimation
/datum/controller/subsystem/statpanels/proc/add_job_estimation(mob/dead/new_player/player)
	if(isnull(player.client))
		return
	if(!CONFIG_GET(flag/show_job_estimation))
		return

	var/datum/preferences/prefs = player.client?.prefs
	var/datum/job/player_job = prefs?.get_highest_priority_job()

	// If a player does not have preferences (for some reason) or they don't want to be shown on the panel, don't add them
	if(!player_job || !(prefs.read_preference(/datum/preference/toggle/ready_job)))
		return

	var/title = player_job?.title
	// If the readied player has selected a miscellaneous job (Assistant, or Prisoner), they shouldn't be displayed
	if(title == JOB_ASSISTANT || title == JOB_PRISONER)
		return

	// If the job the player is selecting has a special name, that name should be displayed in the menu, otherwise it should use the normal name
	var/display
	switch(title)
		if(JOB_AI)
			display = prefs.read_preference(/datum/preference/name/ai)
		if(JOB_CLOWN)
			display = prefs.read_preference(/datum/preference/name/clown)
		if(JOB_CYBORG)
			display = prefs.read_preference(/datum/preference/name/cyborg)
		if(JOB_MIME)
			display = prefs.read_preference(/datum/preference/name/mime)
		else
			display = prefs.read_preference(/datum/preference/name/real_name)

	var/player_ref = REF(player)
	if(isnull(display) || isnull(player_ref))
		return

	/// The string as it appears in the stat panel
	var/job_estimation_text = "* [display] as [player.client?.prefs.alt_job_titles?[title] || title]"
	// If our player is a member of Command or a Silicon, we want to sort them to the top of the list. Otherwise, just add them to the end of the list.
	if(player_job.departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_SILICON))
		command_player_ready_data[player_ref] = job_estimation_text
	else
		player_ready_data[player_ref] = job_estimation_text

	RegisterSignal(player, COMSIG_JOB_PREF_UPDATED, PROC_REF(on_client_changes_job))

/// Removes a player from the job estimation.
/datum/controller/subsystem/statpanels/proc/remove_job_estimation(mob/dead/new_player/player)
	if(isnull(player))
		return

	var/player_ref = REF(player)
	player_ready_data -= player_ref

	if(length(command_player_ready_data))
		command_player_ready_data -= player_ref

	UnregisterSignal(player, list(COMSIG_JOB_PREF_UPDATED))

/mob/dead/new_player/become_uncliented()
	SSstatpanels.remove_job_estimation(src)

/// Updates the mob's job if they change it, either through the occupations tab or through switching their active character while still readied.
/datum/controller/subsystem/statpanels/proc/on_client_changes_job(mob/dead/new_player/source)
	SIGNAL_HANDLER
	remove_job_estimation(source)
	add_job_estimation(source)
