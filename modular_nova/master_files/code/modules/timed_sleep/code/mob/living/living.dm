// Voluntary sleeping / Timed sleeping
/mob/living/mob_sleep()
	if(IsSleeping())
		to_chat(src, span_warning("You are already sleeping!"))
		return
	var/duration = tgui_input_number(
		src,
		"How many minutes do you want to sleep for? Enter 0 to sleep indefinitely. Resist to wake up.",
		"Sleep: Duration",
		max_value = INFINITY,
		min_value = 0,
		default = 1
	)
	if(duration == 0)
		PermaSleeping(is_voluntary = TRUE)
	else
		SetSleeping(duration MINUTES, is_voluntary = TRUE)
