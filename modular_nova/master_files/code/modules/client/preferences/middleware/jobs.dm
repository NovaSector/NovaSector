/datum/preference_middleware/jobs/proc/set_job_title(list/params, mob/user)
	var/job_title = params["job"]
	var/new_job_title = params["new_title"]

	var/datum/job/job = SSjob.get_job(job_title)

	if (isnull(job))
		return FALSE

	if (!(new_job_title in job.alt_titles))
		return FALSE

	preferences.alt_job_titles[job_title] = new_job_title
	if(!SSticker.HasRoundStarted())
		SEND_SIGNAL(user, COMSIG_JOB_PREF_UPDATED)

	return TRUE
