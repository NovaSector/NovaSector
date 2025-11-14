/// Makes sure shuttle call times are correctly modified by security levels
/datum/unit_test/shuttle_call_times

/datum/unit_test/shuttle_call_times/Run()
	// Expected time: 15 minutes = 9000 deciseconds. Fucking thing doesnt like macros.
	var/expected_time = 9000

	for(var/datum/security_level/sec_level_path as anything in subtypesof(/datum/security_level))
		var/datum/security_level/sec_level = allocate(sec_level_path)

		// Request the shuttle with the coefficient from this sec level
		SSshuttle.emergency.request(null, set_coefficient = sec_level.shuttle_call_time_mod)

		// Grab the time left
		var/time_left = SSshuttle.emergency.timeLeft(1)

		// Check against expected
		TEST_ASSERT_EQUAL(time_left, expected_time, "[sec_level_path] shuttle call time didn't match expected [expected_time], got [time_left]")

		// Cancel for the next run
		SSshuttle.emergency.cancel()

		qdel(sec_level)
