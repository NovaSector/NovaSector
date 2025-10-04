// Specialized check for station resources: ore silos and other resource-related objects
/datum/storyteller_metric/resource_check
	name = "Resource Check"

/datum/storyteller_metric/resource_check/perform(datum/storyteller_analyzer/anl, datum/storyteller/ctl, datum/storyteller_inputs/inputs, scan_flags)
	var/total_minerals = 0
	for(var/obj/machinery/ore_silo/silo in SSmachines.get_all_machines())
		if(!istype(silo) || !silo.holds)
			continue
		for(var/mat_type in silo.holds)
			var/datum/material/mat = mat_type
			total_minerals += silo.holds[mat]

	inputs.vault[STORY_VAULT_RESOURCE_MINERALS] = total_minerals

	// Other resources, like cargo points
	var/other_resources = 0
	if(SSshuttle && SSshuttle.points)
		other_resources += SSshuttle.points
	inputs.vault[STORY_VAULT_RESOURCE_OTHER] = other_resources
	..()
