/obj/item/motiondetector
	name = "motion detector"
	desc = "A device that detects nearby movement, displaying them as visible blips. Does not differentiate between "
	icon_state = "scanner"
	icon = 'modular_np_lethal/lethalguns/icons/detector.dmi'
	///The range of this motion detector
	var/scan_range = 9
	/// Used for the cooldown below, how long do we wait between uses
	var/scan_cooldown_time = 15 SECONDS
	/// Time between using the big ping scan
	COOLDOWN_DECLARE(motion_detector_cooldown)

/obj/item/motiondetector/attack_self(mob/user, modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, motion_detector_cooldown))
		balloon_alert(user, "recharging")
		return
	balloon_alert(user, "readying sonar...")
	playsound(user, 'sound/mecha/skyfall_power_up.ogg', vol = 20, vary = TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)
	if(!do_after(user, 1.1 SECONDS))
		return
	playsound(user, 'sound/effects/ping_hit.ogg', vol = 75, vary = TRUE) // Should be audible for the radius of the sonar
	var/detected_count = 0
	for(var/mob/living/nearby_living_thing in range(scan_range, user))
		if(nearby_living_thing == user)
			continue
		if(nearby_living_thing.stat == DEAD)
			continue
		new /obj/effect/temp_visual/sonar_ping(user.loc, user, nearby_living_thing)
		detected_count += 1
	to_chat(user, span_notice("The sensor pings, detecting [detected_count] living beings nearby!"))
	flick("scanner_ping", src)
	COOLDOWN_START(src, motion_detector_cooldown, scan_cooldown_time)
