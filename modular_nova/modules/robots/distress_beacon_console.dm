/// How often the sensor data is updated
#define SENSORS_UPDATE_PERIOD (10 SECONDS) //How often the sensor data updates.
/// The job sorting ID associated with otherwise unknown jobs
#define UNKNOWN_JOB_ID 998

/obj/item/circuitboard/computer/crew_robot
	name = "Robot Distress Beacon Monitoring Console"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/computer/crew/robot

/datum/design/board/robotcrewconsole
	name = "Robot Distress Beacon Monitoring Computer Board"
	desc = "Allows for the construction of circuit boards used to build a Robot Distress Beacon monitoring computer."
	id = "robotcrewconsole"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/computer/crew_robot
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ROBOTICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE

GLOBAL_DATUM_INIT(crewmonitor_robot, /datum/crewmonitor/robot, new)

/obj/machinery/computer/crew/robot
	name = "Robot Distress Beacon monitoring console"
	desc = "A console for monitoring the health of robots on the station."
	icon_screen = "crew"
	icon_keyboard = "rd_key"
	circuit = /obj/item/circuitboard/computer/crew_robot
	light_color = LIGHT_COLOR_BLUE
	skip_existing_monitor = TRUE

/datum/area_spawn/distress_beacon_console
	target_areas = list(/area/station/science/robotics/lab, /area/station/science/robotics/mechbay)
	desired_atom = /obj/machinery/computer/crew/robot
	mode = AREA_SPAWN_MODE_HUG_WALL

/obj/machinery/computer/crew/robot/ui_interact(mob/user)
	. = ..()
	GLOB.crewmonitor_robot.show(user,src)

/datum/crewmonitor/robot/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CrewConsoleRobot")
		ui.open()

/datum/crewmonitor/robot/update_data(z)
	if(data_by_z["[z]"] && last_update["[z]"] && world.time <= last_update["[z]"] + SENSORS_UPDATE_PERIOD)
		return data_by_z["[z]"]

	var/list/results = list()
	for(var/tracked_mob in GLOB.human_list)
		if(!tracked_mob)
			stack_trace("Null entry in human list.")
			continue

		var/mob/living/tracked_living_mob = tracked_mob

		// Check if z-level is correct
		var/turf/pos = get_turf(tracked_living_mob)

		// Is our target in nullspace for some reason?
		if(!pos)
			continue

		var/mob/living/carbon/human/tracked_human = tracked_living_mob

		// Check their humanity.
		if(!ishuman(tracked_human))
			stack_trace("Non-human mob is in human_list: [tracked_living_mob] ([tracked_living_mob.type])")
			continue
		var/obj/item/clothing/under/uniform = tracked_human.w_uniform
		var/sensor_mode = 0
		// Check they have a uniform
		if(uniform && uniform.sensor_mode)
			sensor_mode = uniform.sensor_mode
		// The entry for this human
		var/list/entry = list(
			"ref" = REF(tracked_human),
			"name" = "Unknown Robot",
			"ijob" = UNKNOWN_JOB_ID,
		)
		var/not_a_robot = TRUE
		var/obj/item/organ/brain/robot_nova/robot_brain = tracked_human.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(robot_brain && istype(robot_brain))
			not_a_robot = FALSE
			if(robot_brain.distress_beacon_active)
				sensor_mode = SENSOR_COORDS
			// Damage
			if (sensor_mode >= SENSOR_VITALS)
				entry += list(
					"power" = round((robot_brain.power / robot_brain.max_power) * 100, 1),
					"oil" = round((tracked_living_mob.blood_volume / BLOOD_VOLUME_NORMAL) * 100, 1),
				)
		var/obj/item/organ/brain/synth/synth_brain = tracked_human.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(synth_brain && istype(synth_brain))
			not_a_robot = FALSE
			if(synth_brain.distress_beacon_active)
				sensor_mode = SENSOR_COORDS
			// Damage
			if (sensor_mode >= SENSOR_VITALS)
				entry += list(
					"power" = round((tracked_human.nutrition / NUTRITION_LEVEL_FULL) * 100, 1), // legacy synth power is nutrition for some reason
					"oil" = round((tracked_human.health / tracked_human.maxHealth) * 100, 1), // legacy symths don't have oil, use this to display health instead
				)
			entry["is_legacy_synth"] = TRUE
		if(not_a_robot)
			continue // get outta here
		// ID and id-related data
		var/obj/item/card/id/id_card = tracked_living_mob.get_idcard(hand_first = FALSE)
		if (id_card)
			entry["name"] = id_card.registered_name
			entry["assignment"] = id_card.assignment
			var/trim_assignment = id_card.get_trim_assignment()
			if (jobs[trim_assignment] != null)
				entry["ijob"] = jobs[trim_assignment]

		entry["is_robot"] = TRUE

		entry["life_status"] = tracked_living_mob.stat

		// Location
		if (sensor_mode >= SENSOR_COORDS)
			entry["area"] = get_area_name(tracked_living_mob, format_text = TRUE)

		// Trackability
		entry["can_track"] = tracked_living_mob.can_track()

		results[++results.len] = entry

	// Cache result
	data_by_z["[z]"] = results
	last_update["[z]"] = world.time

	return results

#undef SENSORS_UPDATE_PERIOD
#undef UNKNOWN_JOB_ID
