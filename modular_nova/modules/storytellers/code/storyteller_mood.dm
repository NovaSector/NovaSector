// Mood profile for storytellers to influence decisions and pacing

/datum/storyteller_mood
	var/name = "Neutral"
	var/desc = ""
	/// 0.0 - 2.0; higher means more aggressive challenges
	var/aggression = 1.0
	/// 0.1 - 3.0; higher means events/goals happen more frequently
	var/pace = 1.0
	/// 0.0 - 2.0; higher means more variability/chaos in choices
	var/volatility = 1.0

/datum/storyteller_mood/proc/get_event_frequency_multiplier()
	return clamp(pace, 0.1, 3.0)

/datum/storyteller_mood/proc/get_threat_multiplier()
	return clamp(aggression, 0.0, 2.0)

/datum/storyteller_mood/proc/get_variance_multiplier()
	return clamp(volatility, 0.0, 2.0)

/datum/storyteller_mood/proc/get_value_multiplier()
	return 1


/datum/storyteller_mood/slow_builder
	name = "Slow Builder"
	aggression = 0.7
	pace = 0.6
	volatility = 0.8

/datum/storyteller_mood/spicy
	name = "Spicy"
	aggression = 1.4
	pace = 1.3
	volatility = 1.2

// Additional mood profiles adapted to RimWorld-inspired styles
/datum/storyteller_mood/cassandra_classic
	name = "Cassandra Classic"
	desc = "Escalating challenges with cycles of tension and relief, inspired by RimWorld's classic storyteller."
	aggression = 1.2
	pace = 1.0
	volatility = 0.9

/datum/storyteller_mood/phoebe_chillax
	name = "Phoebe Chillax"
	desc = "Relaxed pace with longer breaks between events, allowing recovery, like RimWorld's chill storyteller."
	aggression = 0.8
	pace = 0.5
	volatility = 0.7

/datum/storyteller_mood/randy_random
	name = "Randy Random"
	desc = "Highly unpredictable with random bursts of events, mimicking RimWorld's chaotic storyteller."
	aggression = 1.5
	pace = 1.2
	volatility = 1.8
