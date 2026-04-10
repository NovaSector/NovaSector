/datum/feed_network/New()
	. = ..()
	create_feed_channel("AuriNet WeatherCast", "SS13", "Solar weather and radiative events monitoring.", locked = TRUE)
