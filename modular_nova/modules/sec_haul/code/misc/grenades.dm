// Security members are not supposed to use flashbangs during green alert, as per company policy.
// Disobeying this policy will result in IC consequences.
/obj/item/grenade/flashbang/attack_self(mob/user, modifiers, breaking_policy = FALSE)
	if (!CONFIG_GET(flag/flashbangs_forbidden_during_green) || SSsecurity_level.get_current_level_as_number() != SEC_LEVEL_GREEN)
		return ..()

	var/is_sec_or_command = user.mind?.assigned_role.departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY|DEPARTMENT_BITFLAG_COMMAND)
	if(active || HAS_TRAIT(src, TRAIT_NODROP) || !is_sec_or_command)
		return ..()

	if(breaking_policy)
		var/crew_to_alert = list(
			JOB_CAPTAIN,
			JOB_WARDEN,
			JOB_DETECTIVE,
			JOB_HEAD_OF_SECURITY,
		)
		var/message = "[user], [user.mind?.assigned_role.title] has armed a flashbang during security level green! This is a blatant violation of company policy and must be investigated."
		silent_alert(user, src, crew_to_alert, message)
		return ..()
	else
		to_chat(user, span_doyourjobidiot("The use of flashbangs when the security level is green is a violation of company policy!"))
		to_chat(user, span_doyourjobidiot("To bypass this restriction and arm the flashbang anyway, CTRL + Click it (be prepared to have a good reason for doing this!)."))
		return

// CTRL + Click to willingly bypass the green alert restriction
/obj/item/grenade/flashbang/CtrlClick(mob/user)
	return attack_self(user, breaking_policy = TRUE)

/// Sends a silent alert message to certain crew members' PDAs
/proc/silent_alert(mob/sender, atom/source, crew_to_alert, message)
	// build list of alt titles + base titles
	var/list/base_title_by_alt_title = list()
	for(var/job_title in crew_to_alert)
		var/datum/job/job_datum = SSjob.GetJob(job_title)
		for(var/alt_job_title in job_datum.alt_titles)
			base_title_by_alt_title[alt_job_title] = job_title

	for(var/messenger_ref in GLOB.pda_messengers)
		var/datum/computer_file/program/messenger/messenger = GLOB.pda_messengers[messenger_ref]
		if(!length(crew_to_alert))
			break
		if(sender.name == messenger.computer.saved_identification) // don't alert yourself
			continue
		// Alt titles exist, so we need to check all of the possible titles
		if(!(base_title_by_alt_title[messenger.computer.saved_job] in crew_to_alert))
			continue

		var/datum/signal/subspace/messaging/tablet_message/signal = new(source, list(
			"fakename" = "NanoTrasen Corp Alerts",
			"fakejob" = "Flashbang Watchdog",
			"message" = message,
			"targets" = list(messenger),
			"automated" = TRUE
		))
		signal.send_to_receivers()
		sender.log_message("(PDA: Flashbang Alerts) sent \"[message]\" to [signal.format_target()]", LOG_PDA)

	return TRUE
