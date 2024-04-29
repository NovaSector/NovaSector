/datum/map_template/shuttle/pirate/sapper
	prefix = "_maps/shuttles/nova/"
	suffix = "sapper"
	name = "Sapper ship (Default)"

/area/shuttle/pirate/sapper
	name = "Sapper Shuttle"

/obj/machinery/computer/shuttle/pirate/sapper
	possible_destinations = "pirate_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/sapper
	name = "shuttle navigation computer"
	desc = "Used to designate a precise transit location for the shuttle."

/obj/machinery/porta_turret/syndicate/energy/sapper
	max_integrity = 250
	faction = list(FACTION_SAPPER)
