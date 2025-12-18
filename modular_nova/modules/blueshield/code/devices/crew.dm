/*
*	Trimmed and modified copy of ".../machinery/computer/crew.dm"
*	for the sake of modularity. (Blueshield Monitor Console soon?)
*/

#define SENSORS_UPDATE_PERIOD (10 SECONDS)

GLOBAL_DATUM_INIT(blueshield_crewmonitor, /datum/crewmonitor/blueshield, new)

/datum/crewmonitor
	/// For blueshield - only show command jobs
	var/show_command_only
	var/static/list/jobs_command

/datum/crewmonitor/blueshield
	show_command_only = TRUE

/datum/crewmonitor/blueshield/New()
	// Build the list of command + centcom jobs
	var/list/command_jobs = list(
		JOB_CAPTAIN = 1,
		JOB_HEAD_OF_PERSONNEL = 2,
		JOB_RESEARCH_DIRECTOR = 3,
		JOB_CHIEF_ENGINEER = 4,
		JOB_CHIEF_MEDICAL_OFFICER = 5,
		JOB_HEAD_OF_SECURITY = 6,
		JOB_QUARTERMASTER = 7,
	)
	if(isnull(jobs_command))
		jobs_command = list()
		for (var/job, id in jobs)
			// Filter out any job not present in command_jobs or that is not a centcom job
			if (isnull(command_jobs[job]) && (id < 200 || id >= 300))
				continue
			jobs_command[job] = id
	return ..()

#undef SENSORS_UPDATE_PERIOD
