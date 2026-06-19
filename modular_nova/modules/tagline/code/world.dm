/world/proc/update_status()
	var/hostedby
	var/list/features = list()
	var/players = GLOB.clients.len

	var/static/cached_prefix
	var/prefix = cached_prefix || ""

	if(isnull(cached_prefix))
		if(config)
			var/server_name = CONFIG_GET(string/servername)
			if(server_name)
				prefix += "<b>[server_name]</b><br>"
				var/discord = CONFIG_GET(string/discord_link)
				if(discord)
					prefix += " &#8212; (<a href=\"[discord]\">Discord</a>)<br>"
			hostedby = CONFIG_GET(string/hostedby)
		prefix += "[CONFIG_GET(string/servertagline)]<br>"
		// If we at least have loaded the config system, we don't have to keep doing all this
		if(global.config?.loaded)
			cached_prefix = prefix

	if(SSmapping.current_map)
		features += "[SSmapping.current_map.map_name]"

	features += "~[players] player[players == 1 ? "": "s"]"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	status = prefix + (length(features) ? "\[[jointext(features, ", ")]" : "")

