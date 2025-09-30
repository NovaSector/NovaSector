// Story Values for Base Atoms
// These define the baseline "story value" for different types of atoms in the game.
// Story value represents how significant an atom is to the narrative, influencing
// event planning, analysis, and balancing in the storyteller system.
// Higher values indicate greater importance (e.g., humans are more valuable than basic atoms).

// Basic atom (generic, low narrative impact)
#define STORY_VALUE_BASE_ATOM 1
// Turfs (floors, walls, etc., foundational but replaceable)
#define STORY_VALUE_BASE_TURF 10
// Items (tools, objects, moderate utility)
#define STORY_VALUE_BASE_ITEM 10
// Machines (complex systems like engines or fabricators)
#define STORY_VALUE_BASE_MACHINE 100
// Structures (simple builds, low impact)
#define STORY_VALUE_BASE_STRUCTURE 1
// Mobs (living entities, high narrative potential)
#define STORY_VALUE_BASE_MOB 100
// Carbon-based life (organic mobs, similar to mobs)
#define STORY_VALUE_BASE_CARBON 100
// Humans (key players, highest base value for crew)
#define STORY_VALUE_BASE_HUMAN 150

// Registration Macro for Storyteller
// This macro registers an atom with the storyteller subsystem (SSstorytellers).
// Used to track atoms for analysis, event targeting, and value computation.
// Call this when spawning or initializing relevant atoms.

#define REGISTER_ATOM_FOR_STORYTELLER(A) do { \
	SSstorytellers.register_atom_for_storyteller(A); \
} while(FALSE)  // Wrapped in do-while for safe multi-line usage




// Storyteller Memory Defines
// These are keys for storing data in the storyteller's memory system.
// Used for caching event candidates, progress tracking, or temporary states.

// Key for potential event candidates during planning
#define STORY_MEMORY_EVENT_CANDIDATE "memory_event_candidate"



// Weights for Entities in Balancing
// These weights are used in the balancer subsystem to compute relative importance
// of entities (e.g., players vs. antagonists) when updating plans or adjusting difficulty.
// They scale based on STORY_DEFAULT_WEIGHT and influence global goal progress,
// event intensity, and antagonist spawning.


// Baseline weight for generic entities
#define STORY_DEFAULT_WEIGHT 1
// Weight for living mobs (e.g., animals)
#define STORY_LIVING_WEIGHT (STORY_DEFAULT_WEIGHT * 2)
// Weight for carbon-based life (organic complexity)
#define STORY_CARBON_WEIGHT (STORY_DEFAULT_WEIGHT * 5)
// Weight for humans (core crew members)
#define STORY_HUMAN_WEIGHT (STORY_DEFAULT_WEIGHT * 10)
// Weight for antagonists (high threat/disruption)
#define STORY_DEFAULT_ANTAG_WEIGHT (STORY_DEFAULT_WEIGHT * 10)

// Job Roles Weights
// These modifiers adjust weights based on job roles, affecting how the storyteller
// prioritizes events or subgoals involving specific crew members.
// For example, engineers might have higher weight in infrastructure-related goals.

#define STORY_DEFAULT_JOB_WEIGHT_MODIFIER 1.0  // Default multiplier for job-based weight adjustments
// Higher for tech-focused roles
#define STORY_ENGINEER_JOB_WEIGHT_MODIFIER (STORY_DEFAULT_JOB_WEIGHT_MODIFIER * 1.5)
// Higher for conflict roles
#define STORY_SECURITY_JOB_WEIGHT_MODIFIER (STORY_DEFAULT_JOB_WEIGHT_MODIFIER * 2.0)


// Scan Flags for Storyteller Analyzer
// These bitflags define what aspects of the station to scan during analysis.
// Used in analyzer procs like sample_station() to selectively compute metrics.
// For example, pass STORY_SCAN_STATION_INTEGRITY | STORY_SCAN_CREW_HEALTH to focus on those.
// This allows efficient, targeted scans without always computing everything.

 // Scan hull, structures, and overall physical integrity
#define STORY_SCAN_STATION_INTEGRITY (1<<0)
// Scan average crew health, injuries, and vitality
#define STORY_SCAN_CREW_HEALTH (1<<1)
// Scan morale, hunger, sanity, and satisfaction levels
#define STORY_SCAN_CREW_SATISFACTION (1<<2)
// Scan active threats like antagonists, mobs, or events
#define STORY_SCAN_THREAT_LEVEL (1<<3)
// Scan supplies like power, materials, food, and ammo
#define STORY_SCAN_RESOURCE_LEVELS (1<<4)
// Scan department-specific metrics (using DEPARTMENT_BITFLAG_*)
#define STORY_SCAN_DEPARTMENT_STATUS    (1<<5)
// Scan recent events for patterns or repetitions
#define STORY_SCAN_EVENT_HISTORY (1<<6)
// Scan player counts, activity, and engagement
#define STORY_SCAN_PLAYER_ACTIVITY (1<<7)
// Scan antagonist vs. crew ratios and weights
#define STORY_SCAN_ANTAG_BALANCE (1<<8)
// Scan atmos, temperature, pressure, and hazards
#define STORY_SCAN_ENVIRONMENT (1<<9)
// Scan alert levels, weapons, and security presence
#define STORY_SCAN_SECURITY_LEVEL (1<<10)
// Scan R&D levels, tech unlocks, and experiments
#define STORY_SCAN_RESEARCH_PROGRESS (1<<11)
// Scan cargo, economy, and resource flow
#define STORY_SCAN_ECONOMY (1<<12)
// Scan diseases, clones, and medical bay state
#define STORY_SCAN_MEDICAL_STATUS (1<<13)
// Scan power generation, distribution, and outages
#define STORY_SCAN_POWER_GRID (1<<14)
// Scan communications, AI, and network integrity
#define STORY_SCAN_COMMS_STATUS (1<<15)

DEFINE_BITFIELD(story_scan_flags, list(
	"STATION_INTEGRITY" = STORY_SCAN_STATION_INTEGRITY,
	"CREW_HEALTH" = STORY_SCAN_CREW_HEALTH,
	"CREW_SATISFACTION" = STORY_SCAN_CREW_SATISFACTION,
	"THREAT_LEVEL" = STORY_SCAN_THREAT_LEVEL,
	"RESOURCE_LEVELS" = STORY_SCAN_RESOURCE_LEVELS,
	"DEPARTMENT_STATUS" = STORY_SCAN_DEPARTMENT_STATUS,
	"EVENT_HISTORY" = STORY_SCAN_EVENT_HISTORY,
	"PLAYER_ACTIVITY" = STORY_SCAN_PLAYER_ACTIVITY,
	"ANTAG_BALANCE" = STORY_SCAN_ANTAG_BALANCE,
	"ENVIRONMENT" = STORY_SCAN_ENVIRONMENT,
	"SECURITY_LEVEL" = STORY_SCAN_SECURITY_LEVEL,
	"RESEARCH_PROGRESS" = STORY_SCAN_RESEARCH_PROGRESS,
	"ECONOMY" = STORY_SCAN_ECONOMY,
	"MEDICAL_STATUS" = STORY_SCAN_MEDICAL_STATUS,
	"POWER_GRID" = STORY_SCAN_POWER_GRID,
	"COMMS_STATUS" = STORY_SCAN_COMMS_STATUS,
))




// Station State Flags (Tendencies)
// Bitflags representing extracted states or tendencies of the station.
// Set by analyzer based on thresholds (e.g., if resources < 30%, set STATION_LOW_RESOURCES).
// Used in planner for goal branching and event selection.

#define STATION_HIGH_INTEGRITY      (1<<0)   // Station is mostly intact (>80% integrity)
#define STATION_LOW_INTEGRITY       (1<<1)   // Station is damaged (<50% integrity)
#define STATION_CREW_HEALTHY        (1<<2)   // Crew is mostly healthy (>70% avg health)
#define STATION_CREW_INJURED        (1<<3)   // Many crew members are hurt (<50% avg health)
#define STATION_CREW_DEAD           (1<<4)   // Significant crew deaths (>30% dead)
#define STATION_HIGH_SATISFACTION   (1<<5)   // Crew morale is high (>70%)
#define STATION_LOW_SATISFACTION    (1<<6)   // Crew morale is low (<40%, risk of mutiny)
#define STATION_HIGH_THREAT         (1<<7)   // Active threats like antags or mobs (>50 threat level)
#define STATION_LOW_THREAT          (1<<8)   // Station is peaceful (<20 threat level)
#define STATION_HIGH_RESOURCES      (1<<9)   // Abundant supplies (>80% stocked)
#define STATION_LOW_RESOURCES       (1<<10)  // Shortages in food, materials, etc. (<30%)
#define STATION_HIGH_POWER          (1<<11)  // Power grid stable (>90% uptime)
#define STATION_LOW_POWER           (1<<12)  // Power outages or failures (<50% uptime)
#define STATION_ATMOS_STABLE        (1<<13)  // Atmosphere is safe (no fires, toxins)
#define STATION_ATMOS_HAZARD        (1<<14)  // Fires, plasma leaks, or pressure issues
#define STATION_HIGH_SECURITY       (1<<15)  // Strong security presence (armed guards, low crime)
#define STATION_LOW_SECURITY        (1<<16)  // Weak security (brig empty, high crime)
#define STATION_HIGH_RESEARCH       (1<<17)  // Advanced tech unlocked (>70% R&D progress)
#define STATION_LOW_RESEARCH        (1<<18)  // Minimal tech advancements (<30%)
#define STATION_ECONOMY_BOOMING     (1<<19)  // Cargo flowing, high credits
#define STATION_ECONOMY_CRASHING    (1<<20)  // No shipments, low funds
#define STATION_DISEASE_OUTBREAK    (1<<21)  // Active viruses or infections
#define STATION_MEDICAL_OVERLOAD    (1<<22)  // Medbay full, many patients
#define STATION_COMMS_UP            (1<<23)  // Communications functional
#define STATION_COMMS_DOWN          (1<<24)  // Blackout or sabotage
#define STATION_HIGH_ANTAGS         (1<<25)  // Many antagonists active (>10% of crew)
#define STATION_LOW_ANTAGS          (1<<26)  // Few or no antagonists
#define STATION_CREW_OVERWORKED     (1<<27)  // High activity, low rest based on playtime
#define STATION_CREW_IDLE           (1<<28)  // Low activity, boredom risk
#define STATION_INVASION_ACTIVE     (1<<29)  // External threats like xenos or pirates
#define STATION_EVACUATION_READY    (1<<30)  // Shuttle prepped or conditions for evac met
#define STATION_HIGH_WEAPONS        (1<<31)  // Lots of armory access or weapons distributed
#define STATION_LOW_WEAPONS         (1<<32)  // Minimal armament, vulnerable
#define STATION_FOOD_SHORTAGE       (1<<33)  // Kitchen empty, hunger rising
#define STATION_XENO_INFESTATION    (1<<34)  // Xenomorphs or biohazards spreading
#define STATION_AI_MALFUNCTION      (1<<35)  // AI rogue or subverted
#define STATION_SYNDICATE_PRESENCE  (1<<36)  // Syndicate agents detected
#define STATION_MUTINY_IN_PROGRESS  (1<<37)  // Crew vs. command conflict
#define STATION_ENGINE_FAILURE      (1<<38)  // SM delam or engine issues
#define STATION_HIGH_MATERIALS      (1<<39)  // Abundant ores and fabrics
#define STATION_LOW_MATERIALS       (1<<40)  // Depleted stockpiles
#define STATION_BOTANY_OVERGROWN    (1<<41)  // Plants mutating or overgrown
#define STATION_VIROLOGY_ACTIVE     (1<<42)  // Virus research ongoing
#define STATION_PRISON_BREAK        (1<<43)  // Brig escapees
#define STATION_CENTCOM_ALERT       (1<<44)  // High alert from CentCom
#define STATION_LOW_OXYGEN          (1<<45)  // Oxygen shortages
#define STATION_HIGH_RADIATION      (1<<46)  // Radiation leaks
#define STATION_CREW_CLONED         (1<<47)  // Many clones active
#define STATION_GHOST_TOWN          (1<<48)  // Low player count, empty halls


DEFINE_BITFIELD(station_states, list(
	"HIGH_INTEGRITY" = STATION_HIGH_INTEGRITY,
	"LOW_INTEGRITY" = STATION_LOW_INTEGRITY,
	"CREW_HEALTHY" = STATION_CREW_HEALTHY,
	"CREW_INJURED" = STATION_CREW_INJURED,
	"CREW_DEAD" = STATION_CREW_DEAD,
	"HIGH_SATISFACTION" = STATION_HIGH_SATISFACTION,
	"LOW_SATISFACTION" = STATION_LOW_SATISFACTION,
	"HIGH_THREAT" = STATION_HIGH_THREAT,
	"LOW_THREAT" = STATION_LOW_THREAT,
	"HIGH_RESOURCES" = STATION_HIGH_RESOURCES,
	"LOW_RESOURCES" = STATION_LOW_RESOURCES,
	"HIGH_POWER" = STATION_HIGH_POWER,
	"LOW_POWER" = STATION_LOW_POWER,
	"ATMOS_STABLE" = STATION_ATMOS_STABLE,
	"ATMOS_HAZARD" = STATION_ATMOS_HAZARD,
	"HIGH_SECURITY" = STATION_HIGH_SECURITY,
	"LOW_SECURITY" = STATION_LOW_SECURITY,
	"HIGH_RESEARCH" = STATION_HIGH_RESEARCH,
	"LOW_RESEARCH" = STATION_LOW_RESEARCH,
	"ECONOMY_BOOMING" = STATION_ECONOMY_BOOMING,
	"ECONOMY_CRASHING" = STATION_ECONOMY_CRASHING,
	"DISEASE_OUTBREAK" = STATION_DISEASE_OUTBREAK,
	"MEDICAL_OVERLOAD" = STATION_MEDICAL_OVERLOAD,
	"COMMS_UP" = STATION_COMMS_UP,
	"COMMS_DOWN" = STATION_COMMS_DOWN,
	"HIGH_ANTAGS" = STATION_HIGH_ANTAGS,
	"LOW_ANTAGS" = STATION_LOW_ANTAGS,
	"CREW_OVERWORKED" = STATION_CREW_OVERWORKED,
	"CREW_IDLE" = STATION_CREW_IDLE,
	"INVASION_ACTIVE" = STATION_INVASION_ACTIVE,
	"EVACUATION_READY" = STATION_EVACUATION_READY,
	"HIGH_WEAPONS" = STATION_HIGH_WEAPONS,
	"LOW_WEAPONS" = STATION_LOW_WEAPONS,
	"FOOD_SHORTAGE" = STATION_FOOD_SHORTAGE,
	"XENO_INFESTATION" = STATION_XENO_INFESTATION,
	"AI_MALFUNCTION" = STATION_AI_MALFUNCTION,
	"SYNDICATE_PRESENCE" = STATION_SYNDICATE_PRESENCE,
	"MUTINY_IN_PROGRESS" = STATION_MUTINY_IN_PROGRESS,
	"ENGINE_FAILURE" = STATION_ENGINE_FAILURE,
	"HIGH_MATERIALS" = STATION_HIGH_MATERIALS,
	"LOW_MATERIALS" = STATION_LOW_MATERIALS,
	"BOTANY_OVERGROWN" = STATION_BOTANY_OVERGROWN,
	"VIROLOGY_ACTIVE" = STATION_VIROLOGY_ACTIVE,
	"PRISON_BREAK" = STATION_PRISON_BREAK,
	"CENTCOM_ALERT" = STATION_CENTCOM_ALERT,
	"LOW_OXYGEN" = STATION_LOW_OXYGEN,
	"HIGH_RADIATION" = STATION_HIGH_RADIATION,
	"CREW_CLONED" = STATION_CREW_CLONED,
	"GHOST_TOWN" = STATION_GHOST_TOWN,
))



