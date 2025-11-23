/datum/antagonist/space_dragon/roundend_report()
	var/list/parts = list()
	parts += printplayer(owner)

	if(length(carp))
		parts += span_header("<br>The [name] was assisted by:")
		parts += "<ul class='playerlist'>"
		var/list/players_to_carp_taken = list()
		for(var/datum/mind/carpy as anything in carp)
			players_to_carp_taken[carpy.key] += 1
		var/list = ""
		for(var/carp_user in players_to_carp_taken)
			list += "<li><b>[carp_user]</b>, who played <b>[players_to_carp_taken[carp_user]]</b> space carps.</li>"
		parts += list
		parts += "</ul>"

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
