/datum/antagonist/heretic/roundend_report()
	var/list/parts = list()

	parts += printplayer(owner)
	parts += "<b>Sacrifices Made:</b> [total_sacrifices]"
	parts += "The heretic's sacrifice targets were: [english_list(all_sac_targets, nothing_text = "No one")]."
	if(length(objectives))
		var/count = 1
		for(var/datum/objective/objective as anything in objectives)
			parts += "<b>Objective #[count]</b>: [objective.explanation_text]"
			count++

	parts += "<b>Knowledge Researched:</b> "

	var/list/string_of_knowledge = list()

	for(var/knowledge_path in researched_knowledge)
		var/list/knowledge_info = researched_knowledge[knowledge_path]
		var/datum/heretic_knowledge/knowledge = knowledge_info[HKT_INSTANCE]
		string_of_knowledge += knowledge.name

	parts += english_list(string_of_knowledge)

	return parts.Join("<br>")
