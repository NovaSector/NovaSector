/world/proc/update_status()
	var/hostedby
	var/list/features = list()
	var/players = GLOB.clients.len

	var/static/status_prefix
	if(isnull(status_prefix))
		var/prefix = ""
		if(config)
			var/server_name = CONFIG_GET(string/servername)
			if(server_name)
				prefix += "<b>[server_name]</b><br>"
			hostedby = CONFIG_GET(string/hostedby)
		prefix += " (<a href=\"[CONFIG_GET(string/discord_link)]\">Discord</a>) &#8212; "
		prefix += " (<a href=\"[CONFIG_GET(string/wikiurl)]\">Wiki</a>) &#8212; "
		prefix += " (<a href=\"[CONFIG_GET(string/githuburl)]\">Github</a>)"
		prefix += "<br>[CONFIG_GET(string/servertagline)]<br>"
		status_prefix = prefix

	if(SSmapping.current_map)
		features += "[SSmapping.current_map.map_name]"

	features += "~[players] player[players == 1 ? "": "s"]"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	status = status_prefix + (length(features) ? "\[[jointext(features, ", ")]\]" : "")

