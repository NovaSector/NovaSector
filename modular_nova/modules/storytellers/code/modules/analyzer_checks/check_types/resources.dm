// Specialized check for station resources: ore silos and other resource-related objects
// This checks all ore_silo instances for total mineral counts and can be expanded for other resources like cargo budget
/datum/storytellor_check/resource_check
	name = "Resource Check"

/datum/storytellor_check/resource_check/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	// Check ore silos for total minerals
	var/total_minerals = 0
	for(var/obj/machinery/ore_silo/silo in GLOB.machines)
		if(!istype(silo) || !silo.holds)
			continue
		for(var/mat_type in silo.holds)
			var/datum/material/mat = mat_type
			total_minerals += silo.holds[mat]

	inputs.vault[STORY_RESOURCE_MINERALS] = total_minerals

	// Placeholder for other resources (expand as needed, e.g., cargo points from SSshuttle)
	var/other_resources = 0
	// Example: Add cargo budget if available
	if(SSshuttle && SSshuttle.points)
		other_resources += SSshuttle.points
	inputs.vault[STORY_RESOURCE_OTHER] = other_resources
	..()
