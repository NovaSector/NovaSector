/datum/team/abductor_team/roundend_report()
	var/list/result = list()

	result += span_header("The abductors of [name] were:")
	for(var/datum/mind/abductor_mind in members)
		result += printplayer(abductor_mind)
	result += printobjectives(objectives)

	return "<div class='panel redborder'>[result.Join("<br>")]</div>"
