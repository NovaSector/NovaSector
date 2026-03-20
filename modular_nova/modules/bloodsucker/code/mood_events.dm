/datum/mood_event/drankblood
	description = "<span class='nicegreen'>The symbiont is sated. Fresh blood flows through me.</span>\n"
	mood_change = 10
	timeout = 8 MINUTES

/datum/mood_event/drankblood_bad
	description = "<span class='boldwarning'>I drank blood from a lesser organism. The symbiont rejects it.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/drankblood_dead
	description = "<span class='boldwarning'>I drank dead blood. The symbiont finds it insufficient.</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankblood_synth
	description = "<span class='boldwarning'>I drank synthetic blood. What is wrong with me?</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankkilled
	description = "<span class='boldwarning'>I fed off of a dead person. The symbiont is eroding something inside me.</span>\n"
	mood_change = -15
	timeout = 10 MINUTES

/datum/mood_event/madevamp
	description = "<span class='boldwarning'>I have transmitted the full strain to another host. The symbiont surges with satisfaction.</span>\n"
	mood_change = 15
	timeout = 20 MINUTES

/datum/mood_event/coffinsleep
	description = "<span class='nicegreen'>I slept in my den during the day. I feel whole again.</span>\n"
	mood_change = 10
	timeout = 6 MINUTES

/datum/mood_event/coffinsleep/quirk
	mood_change = 4

/datum/mood_event/daylight_bad_sleep
	description = "<span class='boldwarning'>I slept poorly in a makeshift shelter during the day.</span>\n"
	mood_change = -3
	timeout = 6 MINUTES

/datum/mood_event/daylight_sun_scorched
	description = "<span class='boldwarning'>I have been scorched by the unforgiving rays of the sun.</span>\n"
	mood_change = -6
	timeout = 6 MINUTES

///Candelabrum's mood event to non Bloodsucker/Thralls
/datum/mood_event/vampcandle
	description = "<span class='boldwarning'>Something is making your mind feel... loose.</span>\n"
	mood_change = -15
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined
	mood_change = -10
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined/add_effects(target, level = 0)
	description = span_danger("You feel a deep sense of revulsion at the sight of [target].")
	mood_change = level * -5
