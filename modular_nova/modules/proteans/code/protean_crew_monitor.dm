/// How often the sensor data is updated
#define SENSORS_UPDATE_PERIOD (10 SECONDS)
/// The job sorting ID associated with otherwise unknown jobs
#define UNKNOWN_JOB_ID 998

/// Override to allow proteans to be tracked via their modsuit instead of uniform
/datum/crewmonitor/update_data(z)
	if(data_by_z["[z]"] && last_update["[z]"] && world.time <= last_update["[z]"] + SENSORS_UPDATE_PERIOD)
		return data_by_z["[z]"]

	var/list/results = list()
	for(var/tracked_mob in GLOB.suit_sensors_list)
		if(!tracked_mob)
			stack_trace("Null entry in suit sensors list.")
			continue

		var/mob/living/tracked_living_mob = tracked_mob

		// Check if z-level is correct
		var/turf/pos = get_turf(tracked_living_mob)

		// Is our target in nullspace for some reason?
		if(!pos)
			stack_trace("Tracked mob has no loc and is likely in nullspace: [tracked_living_mob] ([tracked_living_mob.type])")
			continue

		// Machinery and the target should be on the same level or different levels of the same station
		if(pos.z != z && (!is_station_level(pos.z) || !is_station_level(z)) && !HAS_TRAIT(tracked_living_mob, TRAIT_MULTIZ_SUIT_SENSORS))
			continue

		var/mob/living/carbon/human/tracked_human = tracked_living_mob

		// Check their humanity.
		if(!ishuman(tracked_human))
			stack_trace("Non-human mob is in suit_sensors_list: [tracked_living_mob] ([tracked_living_mob.type])")
			continue

		// Check if they're being deleted
		if(QDELETED(tracked_human))
			continue

		// Check if they're wearing a protean modsuit (or are a protean themselves)
		var/sensor_mode = SENSOR_OFF
		var/has_sensor = NO_SENSORS
		var/using_protean_sensors = FALSE

		// Check if they're wearing a protean suit on their back
		var/obj/item/mod/control/pre_equipped/protean/worn_protean_suit = tracked_human.back
		if(istype(worn_protean_suit))
			// They're wearing a protean suit - use its sensors
			for(var/obj/item/mod/module/crew_sensor/protean/sensor in worn_protean_suit.modules)
				sensor_mode = sensor.sensor_mode
				has_sensor = sensor.has_sensor
				using_protean_sensors = TRUE
				break
		else if(isprotean(tracked_human))
			// They ARE a protean - check their brain's linked modsuit
			var/obj/item/organ/brain/protean/brain = tracked_human.get_organ_slot(ORGAN_SLOT_BRAIN)
			if(istype(brain) && brain.linked_modsuit)
				var/obj/item/mod/control/pre_equipped/protean/suit = brain.linked_modsuit
				// Find the crew sensor module
				for(var/obj/item/mod/module/crew_sensor/protean/sensor in suit.modules)
					sensor_mode = sensor.sensor_mode
					has_sensor = sensor.has_sensor
					using_protean_sensors = TRUE
					break

		// If using protean sensors but they're not active, skip them
		if(using_protean_sensors)
			if(has_sensor == NO_SENSORS || !sensor_mode)
				continue
		else
			// Normal crew - check their uniform
			var/obj/item/clothing/under/uniform = tracked_human.w_uniform
			if (!istype(uniform))
				stack_trace("Human without a suit sensors compatible uniform is in suit_sensors_list: [tracked_human] ([tracked_human.type]) ([uniform?.type])")
				continue

			// Check if their uniform is in a compatible mode.
			if((uniform.has_sensor == NO_SENSORS) || !uniform.sensor_mode)
				stack_trace("Human without active suit sensors is in suit_sensors_list: [tracked_human] ([tracked_human.type]) ([uniform.type])")
				continue

			sensor_mode = uniform.sensor_mode
			has_sensor = uniform.has_sensor

		// The entry for this human
		var/list/entry = list(
			"ref" = REF(tracked_living_mob),
			"name" = "Unknown",
			"ijob" = UNKNOWN_JOB_ID,
		)

		// ID and id-related data
		var/obj/item/card/id/id_card = tracked_living_mob.get_idcard(hand_first = FALSE)
		if (id_card)
			entry["name"] = id_card.registered_name
			entry["assignment"] = id_card.assignment
			var/trim_assignment = id_card.get_trim_assignment()
			if (jobs[trim_assignment] != null)
				entry["ijob"] = jobs[trim_assignment]

		// Mark proteans as robotic for the UI
		if (using_protean_sensors || issynthetic(tracked_human))
			entry["is_robot"] = TRUE

		// Broken sensors show garbage data
		if (has_sensor == BROKEN_SENSORS)
			entry["life_status"] = rand(0,1)
			entry["area"] = pick_list (ION_FILE, "ionarea")
			entry["oxydam"] = rand(0,175)
			entry["toxdam"] = rand(0,175)
			entry["burndam"] = rand(0,175)
			entry["brutedam"] = rand(0,175)
			entry["health"] = -50
			results[++results.len] = entry
			continue

		// Current status
		if (sensor_mode >= SENSOR_LIVING)
			entry["life_status"] = tracked_living_mob.stat

		// Damage
		if (sensor_mode >= SENSOR_VITALS)
			entry += list(
				"oxydam" = round(tracked_living_mob.getOxyLoss(), 1),
				"toxdam" = round(tracked_living_mob.getToxLoss(), 1),
				"burndam" = round(tracked_living_mob.getFireLoss(), 1),
				"brutedam" = round(tracked_living_mob.getBruteLoss(), 1),
				"health" = round(tracked_living_mob.health, 1),
			)

		// Location
		if (sensor_mode >= SENSOR_COORDS)
			entry["area"] = get_area_name(tracked_living_mob, format_text = TRUE)

		results[++results.len] = entry

	// Cache result
	data_by_z["[z]"] = results
	last_update["[z]"] = world.time

	return results

#undef SENSORS_UPDATE_PERIOD
#undef UNKNOWN_JOB_ID

