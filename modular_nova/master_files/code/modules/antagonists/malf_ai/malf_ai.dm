/datum/antagonist/malf_ai/roundend_report()
	var/list/result = list()

	result += printplayer(owner)

	var/objectives_text = ""
	if(objectives.len)
		var/count = 1
		for(var/datum/objective/objective in objectives)
			objectives_text += "<br><B>Objective #[count]</B>: [objective.explanation_text]"
			count++

	result += objectives_text

	return result.Join("<br>")
