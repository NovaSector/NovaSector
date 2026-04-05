/obj/structure/ore_vent
	var/drone_vent_name = null

/mob/living/basic/node_drone/arrive(obj/structure/ore_vent/parent_vent)
	. = ..()
	if(isnull(attached_vent.drone_vent_name))
		generate_vent_name(parent_vent)

	aas_config_announce(/datum/aas_config_entry/node_start_excavation, list("VENT_NAME" = attached_vent.drone_vent_name), null, list(RADIO_CHANNEL_SUPPLY))

/mob/living/basic/node_drone/pre_escape(success)
	if(success)
		if(isnull(attached_vent.drone_vent_name))
			generate_vent_name(attached_vent)

		aas_config_announce(/datum/aas_config_entry/node_end_excavation, list("VENT_NAME" = attached_vent.drone_vent_name), null, list(RADIO_CHANNEL_SUPPLY))
	. = ..()

/mob/living/basic/node_drone/proc/generate_vent_name(obj/structure/ore_vent/vent)
	var/vent_name = ""
	for(var/datum/material/resource as anything in vent.mineral_breakdown)
		var/letters = html_decode(initial(resource.name))
		vent_name = "[vent_name][letters[1]]"

	vent.drone_vent_name = "[vent.boulder_size]-[uppertext(vent_name)]"

/datum/aas_config_entry/node_start_excavation
	name = "Cargo Notification: Node drone starting operation"
	general_tooltip = "Announces when a miner starts to excavate an ore vent."
	announcement_lines_map = list(
		"Message" = "Node drone network report: Starting excavation of ore vent %VENT_NAME."
	)
	vars_and_tooltips_map = list(
		"VENT_NAME" = "Will be replaced with the vent's ore information and size made up into a name",
	)

/datum/aas_config_entry/node_end_excavation
	name = "Cargo Notification: Node drone ending operation"
	general_tooltip = "Announces when a miner ends an ore vent excavation, be it a success or failure."
	announcement_lines_map = list(
		"Message" = "Node drone network report: Successfully excavated ore vent %VENT_NAME."
	)
	vars_and_tooltips_map = list(
		"VENT_NAME" = "Will be replaced with the vent's ore information and size made up into a name",
	)
