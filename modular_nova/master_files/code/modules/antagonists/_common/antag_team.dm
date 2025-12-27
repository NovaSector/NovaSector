/datum/team/roundend_report()
	var/list/report = list()

	report += span_header("\The [name]:")
	report += "The [member_name]s were:"
	report += printplayerlist(members)

	if(objectives.len)
		report += span_header("Team had following objectives:")
		var/objective_count = 1
		for(var/datum/objective/objective as anything in objectives)
			report += "<B>Objective #[objective_count]</B>: [objective.explanation_text] [objective.get_roundend_success_suffix()]"
			objective_count++

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"
