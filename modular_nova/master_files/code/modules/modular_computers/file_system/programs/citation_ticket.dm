#define CITATION_DEFAULT_DEADLINE_MINUTES 15
#define CITATION_MAX_DEADLINE_MINUTES 60
#define CITATION_TICKET_NAME_LEN 24

/**
 * A citation that records a deadline for the offender to pay.
 *
 * Used by the Security Citation PDA app. Behaves identically to a
 * regular [/datum/crime/citation] aside from carrying [pay_deadline]
 * (an absolute world.time) so the deadline survives in the offender's
 * record and is visible in the security records console.
 */
/datum/crime/citation/timed_ticket
	/// world.time at which the fine is considered overdue.
	var/pay_deadline = 0

/datum/computer_file/program/citation_ticket
	filename = "secticket"
	filedesc = "Security Citation Issuer"
	downloader_category = PROGRAM_CATEGORY_SECURITY
	program_open_overlay = "citation"
	extended_desc = "Issue citations against crew records and print carbon-copy enforcement tickets. Restricted to security personnel."
	program_flags = PROGRAM_ON_NTNET_STORE
	can_run_on_flags = PROGRAM_ALL
	download_access = list(ACCESS_SECURITY)
	run_access = list(ACCESS_SECURITY)
	size = 4
	tgui_id = "NtosCitation"
	program_icon = "gavel"
	program_open_overlay_icon = 'modular_nova/master_files/icons/obj/devices/modular_pda_overlays.dmi'
	alert_able = TRUE

/datum/computer_file/program/citation_ticket/ui_data(mob/user)
	var/list/data = list()

	var/list/crew = list()
	for(var/datum/record/crew/entry as anything in GLOB.manifest.general)
		if(entry.name == "Unknown")
			continue
		crew += list(list(
			"name" = entry.name,
			"rank" = entry.rank,
		))
	data["crew"] = crew

	data["max_fine"] = CONFIG_GET(number/maxfine)
	data["money_symbol"] = MONEY_SYMBOL
	data["max_crime_name_len"] = CITATION_TICKET_NAME_LEN
	data["max_details_len"] = MAX_MESSAGE_LEN
	data["default_deadline_minutes"] = CITATION_DEFAULT_DEADLINE_MINUTES
	data["max_deadline_minutes"] = CITATION_MAX_DEADLINE_MINUTES
	data["paper_left"] = computer?.stored_paper
	return data

/datum/computer_file/program/citation_ticket/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("issue_citation")
			return issue_citation(ui.user, params)

/// Validates the form, creates the citation, prints the carbon ticket.
/datum/computer_file/program/citation_ticket/proc/issue_citation(mob/user, list/params)
	if(!computer)
		return FALSE

	var/input_name = strip_html_full(params["crime_name"], CITATION_TICKET_NAME_LEN)
	if(!input_name)
		balloon_alert_to_user(user, "no crime name!")
		return FALSE

	var/input_details
	if(params["details"])
		input_details = strip_html_full(params["details"], MAX_MESSAGE_LEN)

	var/fine = round(text2num(params["fine"]))
	if(!isnum(fine) || fine <= 0)
		balloon_alert_to_user(user, "fine must be > 0!")
		return FALSE

	var/max_fine = CONFIG_GET(number/maxfine)
	if(fine > max_fine)
		balloon_alert_to_user(user, "max fine is [max_fine]!")
		return FALSE

	var/deadline_minutes = round(text2num(params["deadline_minutes"]))
	if(!isnum(deadline_minutes) || deadline_minutes <= 0)
		deadline_minutes = CITATION_DEFAULT_DEADLINE_MINUTES
	if(deadline_minutes > CITATION_MAX_DEADLINE_MINUTES)
		deadline_minutes = CITATION_MAX_DEADLINE_MINUTES

	var/target_name = params["target_name"]
	if(!target_name)
		balloon_alert_to_user(user, "no target selected!")
		return FALSE

	var/datum/record/crew/target = find_record(target_name)
	if(!target)
		balloon_alert_to_user(user, "target not found in records!")
		return FALSE

	if(computer.stored_paper <= 0)
		balloon_alert_to_user(user, "out of paper!")
		return FALSE

	var/datum/crime/citation/timed_ticket/new_citation = new(
		name = input_name,
		details = input_details,
		author = user,
		fine = fine,
	)
	new_citation.pay_deadline = world.time + (deadline_minutes MINUTES)
	target.citations += new_citation

	var/issuer_name = computer.stored_id?.GetID()?.registered_name || user.real_name
	var/deadline_stamp = station_time_timestamp("hh:mm", new_citation.pay_deadline)

	new_citation.alert_owner(
		user,
		computer,
		target.name,
		"You have been issued a [fine][MONEY_SYMBOL] citation for [input_name] by [issuer_name]. Payable at Security before [deadline_stamp] ([deadline_minutes] min).",
	)

	computer.investigate_log("New PDA Citation: <strong>[input_name]</strong> Fine: [fine] Deadline: [deadline_minutes]m | Added to [target.name] by [key_name(user)]", INVESTIGATE_RECORDS)
	SSblackbox.ReportCitation(REF(new_citation), user.ckey, user.real_name, target.name, input_name, input_details, fine)

	print_ticket(user, target.name, target.rank, issuer_name, input_name, input_details, fine, deadline_stamp, deadline_minutes)
	playsound(computer, 'sound/items/poster/poster_being_created.ogg', 30, TRUE)
	computer.visible_message(span_notice("\The [computer] prints a citation ticket."))
	balloon_alert_to_user(user, "ticket issued")
	return TRUE

/// Prints a single sheet of carbon paper containing the citation. Tries to place it in the issuing officer's free hand; falls back to the computer's drop location.
/datum/computer_file/program/citation_ticket/proc/print_ticket(mob/user, target_name, target_rank, issuer_name, crime_name, details, fine, deadline_stamp, deadline_minutes)
	var/details_block = details ? "<p><b>Details:</b><br>[details]</p>" : ""
	var/contents = {"<h3>Nanotrasen Security Citation</h3>
<hr>
<p><b>Issued to:</b> [target_name] ([target_rank])</p>
<p><b>Issued by:</b> [issuer_name]</p>
<p><b>Issued at:</b> [station_time_timestamp()]</p>
<hr>
<p><b>Offense:</b> [crime_name]</p>
[details_block]
<hr>
<p><b>Fine:</b> [fine][MONEY_SYMBOL]</p>
<p><b>Pay before:</b> [deadline_stamp] (within [deadline_minutes] minute\s of issue)</p>
<hr>
<p><i>Fines are payable at the Security Office. Failure to pay before the listed deadline may escalate enforcement.</i></p>
<p><i>Right-click this paper to detach the carbon copy.</i></p>"}

	var/obj/item/paper/carbon/ticket = new(computer.drop_location())
	ticket.name = "citation - [target_name]"
	ticket.add_raw_text(contents)
	ticket.update_appearance()
	computer.stored_paper--
	if(!isnull(user))
		user.put_in_hands(ticket)
	return ticket

/// Wraps balloon_alert when called from a PDA, since the alert needs an atom not a datum.
/datum/computer_file/program/citation_ticket/proc/balloon_alert_to_user(mob/user, message)
	if(computer)
		computer.balloon_alert(user, message)

#undef CITATION_DEFAULT_DEADLINE_MINUTES
#undef CITATION_MAX_DEADLINE_MINUTES
#undef CITATION_TICKET_NAME_LEN
