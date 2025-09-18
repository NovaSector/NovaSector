/// Makes sure shuttle call times are correctly modified by security levels
/datum/unit_test/shuttle_call_times

/datum/unit_test/shuttle_call_times/Run()
	// Expected time: 15 minutes = 9000 deciseconds. Fucking thing doesnt like macros.
	var/expected_time = 9000

	// List of security level datums to test
	var/list/sec_levels = list(
		/datum/security_level/green,
		/datum/security_level/blue,
		/datum/security_level/red,
		/datum/security_level/delta,
		/datum/security_level/violet,
		/datum/security_level/orange,
		/datum/security_level/amber,
		/datum/security_level/gamma,
		/datum/security_level/epsilon,
		/datum/security_level/federal,
	)

	for(var/type in sec_levels)
		var/datum/security_level/sec = allocate(type)

		// Request the shuttle with the coefficient from this sec level
		SSshuttle.emergency.request(null, set_coefficient = sec.shuttle_call_time_mod)

		// Grab the time left
		var/time_left = SSshuttle.emergency.timeLeft(1)

		// Check against expected
		TEST_ASSERT_EQUAL(time_left, expected_time, "[type] shuttle call time didn't match expected [expected_time], got [time_left]")

		// Cancel for the next run
		SSshuttle.emergency.cancel()

		qdel(sec)
