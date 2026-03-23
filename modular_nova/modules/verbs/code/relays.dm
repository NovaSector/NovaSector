/datum/config_entry/flag/enable_relays

/datum/config_entry/keyed_list/relay_option
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_TEXT
	lowercase_key = FALSE
	splitter = ","

/client/proc/connect_to_relay()
	set name = "Connect to Relay"
	set category = "OOC"
	if(!CONFIG_GET(flag/enable_relays))
		to_chat(src, span_danger("Relays are currently disabled!"))
		return

	var/static/list/available_relays
	if(isnull(available_relays))
		available_relays = CONFIG_GET(keyed_list/relay_option)

	if(!length(available_relays))
		to_chat(src, span_danger("No relays are available to connect to!"))
		return

	var/choice = tgui_input_list(usr, "Which relay do you wish to use?", "Relay choice", available_relays)
	if(isnull(choice))
		return
	var/address = available_relays[choice]
	if(isnull(address))
		return

	usr << link(address)
	sleep(1 SECONDS)
	winset(usr, null, "command=.quit")
