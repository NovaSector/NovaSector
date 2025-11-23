/datum/antagonist/obsessed/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("antagonist datum without owner")

	report += "<b>[printplayer(owner)]</b>"

	var/objectives_complete = TRUE
	if(objectives.len)
		report += printobjectives(objectives)

	if(trauma)
		if(trauma.total_time_creeping > 0)
			report += span_greentext("The [name] spent a total of [DisplayTimeText(trauma.total_time_creeping)] being near [trauma.obsession]!")
		else
			report += span_redtext("The [name] did not go near their obsession the entire round! That's extremely impressive!")
	else
		report += span_redtext("The [name] had no trauma attached to their antagonist ways! Either it bugged out or an admin incorrectly gave this good samaritan antag and it broke! You might as well show yourself!!")

	return report.Join("<br>")
