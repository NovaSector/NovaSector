#define VERY_HIGH_EVENT_FREQ 64
#define HIGH_EVENT_FREQ 32
#define MED_EVENT_FREQ 16
#define LOW_EVENT_FREQ 8
#define VERY_LOW_EVENT_FREQ 4
#define MIN_EVENT_FREQ 2

/**
 * ICES - Intensity Credit Events System
 *
 * This file is used to denote weight and frequency
 * for events to be spawned by the system.
 */

/**
 * Event subsystem
 *
 * Overriden min and max start times
 * to accomodate for much longer rounds
 */
/datum/controller/subsystem/events
	/// Rate at which we add intensity credits
	var/intensity_credit_rate = 27000
	/// Last world time we added an intensity credit
	var/intensity_credit_last_time = 8400
	/// Current active ICES multiplier
	var/active_intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
	/// LOWPOP player threshold
	var/intensity_low_players = EVENT_LOWPOP_THRESHOLD
	/// LOWPOP multiplier (lower = more events)
	var/intensity_low_multiplier = EVENT_LOWPOP_TIMER_MULTIPLIER
	/// MIDPOP player threshold
	var/intensity_mid_players = EVENT_MIDPOP_THRESHOLD
	/// MIDPOP multiplier (lower = more events)
	var/intensity_mid_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
	/// HIGHPOP player threshold
	var/intensity_high_players = EVENT_HIGHPOP_THRESHOLD
	/// HIGHPOP multiplier (lower = more events)
	var/intensity_high_multiplier = EVENT_HIGHPOP_TIMER_MULTIPLIER

/datum/controller/subsystem/events/Initialize()
	. = ..()
	frequency_lower = CONFIG_GET(number/event_frequency_lower)
	frequency_upper = CONFIG_GET(number/event_frequency_upper)
	intensity_credit_rate = CONFIG_GET(number/intensity_credit_rate)

/**
 * Abductors
 */
/datum/round_event_control/abductor
	max_occurrences = 0
	weight = VERY_LOW_EVENT_FREQ

/**
 * Alien Infestation
 *
 * Enabled: Disable from config.
 */
/datum/round_event_control/alien_infestation
	max_occurrences = 1
	intensity_restriction = TRUE
	weight = MED_EVENT_FREQ
	min_players = 85
	intensity_restriction = TRUE


/**
 * Anomalies
 */
/datum/round_event_control/anomaly/anomaly_bioscrambler
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_bluespace
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_dimensional
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_ectoplasm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_flux
	max_occurrences = 1
	weight = MED_EVENT_FREQ

// We have other intensities
/datum/round_event_control/anomaly/anomaly_grav
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_grav/high
	max_occurrences = 1
	min_players = 45
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_hallucination
	max_occurrences = 2
	weight = HIGH_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_pyro
	max_occurrences = 1
	min_players = 40
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_vortex
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Aurora Caelus
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/aurora_caelus
	max_occurrences = 3
	weight = HIGH_EVENT_FREQ

/**
 * Brain Trauma
 *
 * Disabled: Interrupting scenes and preventing roleplay by interaction with medbay
 */
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/**
 * Brand Intelligence
 */
/datum/round_event_control/brand_intelligence
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Bureaucratic Error
 *
 * Disabled: Too intrusive and should be staff-only
 */
/datum/round_event_control/bureaucratic_error
	max_occurrences = 0

/**
 * Camera Failure
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/camera_failure
	max_occurrences = 5
	weight = LOW_EVENT_FREQ

/**
 * Carp Migration
 */
/datum/round_event_control/carp_migration
	max_occurrences = 2
	weight = HIGH_EVENT_FREQ

/**
 * Communications
 *
 * Combined weight: 16
 */
/datum/round_event_control/communications_blackout
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/datum/round_event_control/processor_overload
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE


/**
 * Medical
 *
 */
/datum/round_event_control/disease_outbreak
	max_occurrences = 2
	min_players = 45
	weight = HIGH_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/disease_outbreak/advanced
	max_occurrences = 1
	min_players = 45
	weight = MED_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/fake_virus
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/heart_attack
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Earthquakes
 *
 * Disabled: Yeah lol as if we'd run an event with the sole purpose of griefing the station
 * with no way to prevent it. Nice try.
 */
/datum/round_event_control/earthquake
	max_occurrences = 0


/**
 * Electricity Events
 *
 */
/datum/round_event_control/electrical_storm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/grid_check
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * False Alarm
 */
/datum/round_event_control/falsealarm
	max_occurrences = 4
	weight = LOW_EVENT_FREQ

/**
 * Gravity Generator Blackout
 */
/datum/round_event_control/gravity_generator_blackout
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Grey Tide
 */
/datum/round_event_control/grey_tide
	max_occurrences = 2
	weight = LOW_EVENT_FREQ

/**
 * Ion Storm
 */
/datum/round_event_control/ion_storm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Immovable Rod
 */
/datum/round_event_control/immovable_rod
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Market Crash
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/market_crash
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Mass Hallucination
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/mass_hallucination
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Meteors / Space Dust
 *
 */
/datum/round_event_control/meteor_wave
	max_occurrences = 0
	weight = MIN_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/meteor_wave/ices
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

// No preset ones, we have our own custom preset above
/datum/round_event_control/meteor_wave/threatening
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/meteor_wave/catastrophic
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/meteor_wave/meaty
	max_occurrences = 0
	weight = MIN_EVENT_FREQ

/datum/round_event_control/stray_meteor
	max_occurrences = 0
	weight = MIN_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/space_dust
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/space_dust/major_dust
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/datum/round_event_control/sandstorm
	max_occurrences = 1
	min_players = 45
	weight = MED_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Mice Migration
 */
/datum/round_event_control/mice_migration
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Moldies
 */
/datum/round_event_control/mold
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	intensity_restriction = TRUE

/**
 * Lone op
 *
 * Disabled: Does not have policy. Will re-add if/when policy is added
 */
/datum/round_event_control/operative
	max_occurrences = 0

/**
 * Syndicate Portal Storm
 */
/datum/round_event_control/portal_storm_syndicate
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/portal_storm_narsie
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Radiation
 *
 * Disabled: Unintutivie design and incompatibility with this server
 */
/datum/round_event_control/radiation_leak
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/radiation_storm
	max_occurrences = 0
	intensity_restriction = TRUE

/**
 * Scrubber Clogs
 *
 */
/datum/round_event_control/vent_clog
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/vent_clog/major
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/vent_clog/critical
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/vent_clog/strange
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Scrubber Overflow
 *
 */

/datum/round_event_control/scrubber_overflow
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_overflow/threatening
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/scrubber_overflow/catastrophic
	max_occurrences = 0

/datum/round_event_control/scrubber_overflow/ices
	weight = MED_EVENT_FREQ

/**
 * Human-level Intelligence
 */
/datum/round_event_control/sentience
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Shuttle Events
 *
 */
/datum/round_event_control/shuttle_catastrophe
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/shuttle_insurance
	max_occurrences = 1
	weight = HIGH_EVENT_FREQ

/datum/round_event_control/shuttle_loan
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Spess Vines
 *
 *
 */
/datum/round_event_control/spacevine
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Stray Cargo Pods
 *
 * Combined weight: 24
 */
/datum/round_event_control/stray_cargo
	max_occurrences = 3
	weight = LOW_EVENT_FREQ

/datum/round_event_control/stray_cargo/syndicate
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/**
 * Supermatter Surge
 */
/datum/round_event_control/supermatter_surge
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Tram Malfunction
 *
 * Only runs on Tramstation, otherwise rolls a different event.
 */
/datum/round_event_control/tram_malfunction
	weight = HIGH_EVENT_FREQ

/**
 * Wisdom Cow
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/wisdomcow
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Wormholes
 */
/datum/round_event_control/wormholes
	max_occurrences = 2
	weight = MED_EVENT_FREQ



#undef VERY_HIGH_EVENT_FREQ
#undef HIGH_EVENT_FREQ
#undef MED_EVENT_FREQ
#undef LOW_EVENT_FREQ
#undef VERY_LOW_EVENT_FREQ
#undef MIN_EVENT_FREQ
