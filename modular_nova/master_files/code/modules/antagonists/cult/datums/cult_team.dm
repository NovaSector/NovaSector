/datum/team/cult/roundend_report()
	var/list/parts = list()

	if(objectives.len)
		parts += "<b>The cultists' objectives were:</b>"
		var/count = 1
		for(var/datum/objective/objective in objectives)
			parts += "<b>Objective #[count]</b>: [objective.explanation_text]"
			count++

	if(members.len)
		parts += span_header("The cultists were:")
		if(length(true_cultists))
			parts += printplayerlist(true_cultists)
		else
			parts += printplayerlist(members)

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
