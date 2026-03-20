///Uncomment this to enable testing of Bloodsucker features (such as thralling people with a mind instead of a client).
// #define BLOODSUCKER_TESTING // if this isn't commented out, someone is a dumbfuck

/// Span helper for centered text
#define span_center(str) ("<span class='center'>[str]</span>")

/// You have special interactions with Bloodsuckers
#define TRAIT_BLOODSUCKER_HUNTER "bloodsucker_hunter"

// how much to multiply the den size by mob_size
#define DEN_ENLARGE_MULT 0.5

/// At what health to burn damage ratio you reach Termination
#define TERMINATION_HEALTH_TO_BURN 2.5
/**
 * Blood-level defines
 */
/// Determines Bloodsucker regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// Cost to torture someone halfway, in blood. Called twice for full cost
#define TORTURE_BLOOD_HALF_COST 4
/// Cost to convert someone after successful torture, in blood
#define TORTURE_CONVERSION_COST 10
/// How much blood it costs you to make a thrall into a special thrall
#define SPECIAL_THRALL_COST 150
/// Minimum and maximum feral episode blood thresholds
/// Once blood is this low, will enter a Feral Episode
#define FERAL_THRESHOLD_ENTER 25
/// Once blood is this high, will exit Feral Episode
#define FERAL_THRESHOLD_EXIT 250

/// A bloodsucker can't accumulate more neural erosion than this, and loses the Mimic ability when reaching it
#define NEURAL_EROSION_MAXIMUM 50

/// Level up blood cost define, max_blood * this = blood cost
#define BLOODSUCKER_LEVELUP_PERCENTAGE 0.40
#define BLOODSUCKER_LEVELUP_PERCENTAGE_TYRANT BLOODSUCKER_LEVELUP_PERCENTAGE - 0.1

///The level when a bloodsucker becomes selective about who they drain and gains their mature reputation
#define BLOODSUCKER_HIGH_LEVEL 4

/**
 * Sol defines
 */
///How long Sol will last until it's night again.
#define TIME_BLOODSUCKER_DAY 60
///Base time nighttime should be in for, until Sol rises.
// Can't put defines in defines, so we have to use deciseconds.
#define TIME_BLOODSUCKER_NIGHT_MAX 1320 // 22 minutes
#define TIME_BLOODSUCKER_NIGHT_MIN 1020 // 17 minutes

///Time left to send an alert to Bloodsuckers about an incoming Sol.
#define TIME_BLOODSUCKER_DAY_WARN 90
///Time left to send an urgent alert to Bloodsuckers about an incoming Sol.
#define TIME_BLOODSUCKER_DAY_FINAL_WARN 30
///Time left to alert that Sol is rising.
#define TIME_BLOODSUCKER_BURN_INTERVAL 5

///How much time Sol can be 'off' by, keeping the time inconsistent.
#define TIME_BLOODSUCKER_SOL_DELAY 90

/**
 * Thrall defines
 */
///If someone passes all checks and can be thralled
#define THRALLING_ALLOWED 0
///If someone has to accept thralling
#define THRALLING_DISLOYAL 1
///If someone is not allowed under any circumstances to become a Thrall
#define THRALLING_BANNED 2

/**
 * Cooldown defines
 * Used in Cooldowns Bloodsuckers use to prevent spamming
 */
///Spam prevention for healing messages.
#define BLOODSUCKER_SPAM_HEALING (15 SECONDS)
///Spam prevention for Sol Mimic messages.
#define BLOODSUCKER_SPAM_MIMIC (60 SECONDS)

///Spam prevention for Sol messages.
#define BLOODSUCKER_SPAM_SOL (30 SECONDS)


/**
 * Clade defines
 */
#define CLADE_NONE "Unaligned"
#define CLADE_FERAL "Clade Feral"
#define CLADE_HEMOKINETIC "Clade Hemokinetic"
#define CLADE_TYRANT "Clade Tyrant"
#define CLADE_MIMIC "Clade Mimic"

#define HEMOKINETIC_THRALL "hemokinetic_thrall"
#define BONDED_THRALL "bonded_thrall"
#define FERAL_THRALL "feral_thrall"

/**
 * Power defines
 */
/// This Power can't be used in Dormancy
#define BP_CANT_USE_IN_DORMANCY (1<<0)
/// This Power can't be used in a Feral Episode.
#define BP_CANT_USE_IN_FERAL (1<<1)
/// This Power can be used while transformed, for example by the shapeshift spell
#define BP_CAN_USE_TRANSFORMED (1<<2)
/// This Power can be used with a stake in you
#define BP_CAN_USE_WHILE_STAKED (1<<4)
/// This Power can be used while heartless
#define BP_CAN_USE_HEARTLESS (1<<5)

/// This Power can be purchased by Bloodsuckers
#define BLOODSUCKER_CAN_BUY (1<<0)
/// This is a Default Power that all Bloodsuckers get.
#define BLOODSUCKER_DEFAULT_POWER (1<<1)
/// This Power can be purchased by Hemokinetic Bloodsuckers
#define HEMOKINETIC_CAN_BUY (1<<2)

/// This Power can be purchased by Thralls
#define THRALL_CAN_BUY (1<<3)

/// If this Power can be bought if you already own it
#define CAN_BUY_OWNED (1<<4)


/// This Power is a Continuous Effect, processing every tick
#define BP_CONTINUOUS_EFFECT (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost blood to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)

#define DEACTIVATE_POWER_DO_NOT_REMOVE (1<<0)
#define DEACTIVATE_POWER_NO_COOLDOWN (1<<1)

// ability levels that are used cross-file
#define NEURAL_OVERRIDE_THRALLIZE_LEVEL 2
#define HEMOKINETIC_OBJECTIVE_POWER_LEVEL 4

#define DEN_HEAL_COST_MULT 0.5


/**
 * Dormancy check bitflags
 */
#define DORMANCY_SKIP_CHECK_ALL (1<<0)
#define DORMANCY_SKIP_CHECK_FERAL (1<<1)
#define DORMANCY_SKIP_CHECK_DAMAGE (1<<2)

/**
 * Bloodsucker Signals
 */
///Called when a Bloodsucker ranks up: (datum/bloodsucker_datum, mob/owner, mob/target)
#define COMSIG_BLOODSUCKER_RANK_UP "bloodsucker_rank_up"
///Called when a Bloodsucker interacts with a Thrall on their indoctrination rack.
#define COMSIG_BLOODSUCKER_INTERACT_WITH_THRALL "bloodsucker_interact_with_thrall"
///Called when a Bloodsucker makes a Thrall into their Bonded: (datum/thrall_datum, mob/master)
#define COMSIG_BLOODSUCKER_MAKE_BONDED "bloodsucker_make_bonded"
// called when a bloodsucker loses their bonded thrall, cleaning up whatever they gained
#define COMSIG_BLOODSUCKER_LOOSE_BONDED "bloodsucker_loose_bonded"
///Called when a new Thrall is successfully made: (datum/bloodsucker_datum)
#define COMSIG_BLOODSUCKER_MADE_THRALL "bloodsucker_made_thrall"
///Called when a Bloodsucker exits Dormancy.
#define COMSIG_BLOODSUCKER_EXIT_DORMANCY "bloodsucker_exit_dormancy"
///Called when a Bloodsucker reaches Termination.
#define COMSIG_BLOODSUCKER_TERMINATION "bloodsucker_termination"
	///Whether the Bloodsucker should not be dusted when reaching Termination
	#define DONT_DUST (1<<0)
///Called when a Bloodsucker becomes Exposed
#define COMSIG_BLOODSUCKER_EXPOSED "comsig_bloodsucker_exposed"
///Called when a Bloodsucker enters a Feral Episode
#define COMSIG_BLOODSUCKER_ENTERS_FERAL "bloodsucker_enters_feral"
///Called when a Bloodsucker exits a Feral Episode
#define COMSIG_BLOODSUCKER_EXITS_FERAL "bloodsucker_exits_feral"
/// COMSIG_ATOM_EXAMINE that correctly updates when the bloodsucker datum is moved
#define COMSIG_BLOODSUCKER_EXAMINE "bloodsucker_examine"
// Called when anyone enters a claimed den
#define COMSIG_ENTER_DEN "enter_den"
#define COMSIG_MOB_STAKED "staked"
#define COMSIG_BODYPART_STAKED "staked"
// called when a targeted ability is cast
#define COMSIG_FIRE_TARGETED_POWER "comsig_fire_targeted_power"

/**
 * Sol signals & Defines
 */
#define COMSIG_SOL_RANKUP_BLOODSUCKERS "comsig_sol_rankup_bloodsuckers"
#define COMSIG_SOL_RISE_TICK "comsig_sol_rise_tick"
#define COMSIG_SOL_NEAR_START "comsig_sol_near_start"
#define COMSIG_SOL_END "comsig_sol_end"
///Sent when a warning for Sol is meant to go out: (danger_level, bloodsucker_warning_message, thrall_warning_message)
#define COMSIG_SOL_WARNING_GIVEN "comsig_sol_warning_given"
///Called on a Bloodsucker's Lifetick.
#define COMSIG_BLOODSUCKER_ON_LIFETICK "comsig_bloodsucker_on_lifetick"
/// Called when a Bloodsucker's blood is updated
#define BLOODSUCKER_UPDATE_BLOOD "bloodsucker_update_blood"
	#define BLOODSUCKER_UPDATE_BLOOD_DISABLED (1<<0)

#define DANGER_LEVEL_FIRST_WARNING 1
#define DANGER_LEVEL_SECOND_WARNING 2
#define DANGER_LEVEL_THIRD_WARNING 3
#define DANGER_LEVEL_SOL_ROSE 4
#define DANGER_LEVEL_SOL_ENDED 5

/**
 * Clade defines
 *
 * This is stuff that is used solely by Clades for clade-related activity.
 */
///Drinks blood the normal Bloodsucker way.
#define BLOODSUCKER_DRINK_NORMAL "bloodsucker_drink_normal"
///Drinks blood but is selective, refusing to drain the mindless
#define BLOODSUCKER_DRINK_SELECTIVE "bloodsucker_drink_selective"
///Drinks blood from any creature without Sapience consequences.
#define BLOODSUCKER_DRINK_INDISCRIMINATE "bloodsucker_drink_indiscriminate"

/**
 * Traits
 */
/// Falsifies Health analyzer blood levels
#define TRAIT_MIMIC "bloodsucker_mimic"
/// Your body is literal room temperature. Does not make you immune to the temp
#define TRAIT_COLDBLOODED "coldblooded"
/// In dormancy (regenerative hibernation)
#define TRAIT_DORMANCY "bloodsucker_dormancy"

/**
 * Sources
 */
/// Source trait for Bloodsuckers-related traits
#define BLOODSUCKER_TRAIT "bloodsucker_trait"

#define THRALL_TRAIT "thrall_trait"

/// Source trait for neural suppression related traits
#define NEURAL_SUPPRESSION_TRAIT "neural_suppression_trait"
#define NEURAL_OVERRIDE_TRAIT "neural_override_trait"

/// Source trait for Monster Hunter-related traits
#define HUNTER_TRAIT "monsterhunter_trait"
/// Source trait while Feeding
#define FEED_TRAIT "feed_trait"
/// Source trait during a Feral Episode
#define FERAL_TRAIT "feral_trait"

///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Thrall
#define IS_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/ghoul))
///Whether a mob is a Bonded Thrall
#define IS_BONDED_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/ghoul/favorite))
///Whether a mob is a Feral Thrall
#define IS_FERAL_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/ghoul/revenge))
#define IS_EX_THRALL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/ex_ghoul))

///Whether a mob is a Monster Hunter-NOT NEEDED RIGHT NOW
// #define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))
///For future use
#define IS_MONSTERHUNTER(mob) (FALSE)

#define BLOODSUCKER_SIGHT_COLOR_CUTOFF list(25, 8, 5)
#define POLL_IGNORE_THRALL "thrall"

// Why waste memory on a dynamic global list if we can just bake it in on compile time?
#define BLOODSUCKER_BLACKLISTED_ROLES list( \
	JOB_CAPTAIN, \
	JOB_HEAD_OF_PERSONNEL, \
	JOB_HEAD_OF_SECURITY, \
	JOB_WARDEN, \
	JOB_SECURITY_OFFICER, \
	JOB_DETECTIVE, \
)

#define BLOODSUCKER_RESTRICTED_SPECIES list( \
	/datum/species/synthetic, \
	/datum/species/plasmaman, \
	/datum/species/shadow/nightmare, \
	/datum/species/abductor, \
	/datum/species/android, \
	/datum/species/golem, \
	/datum/species/shadow, \
	/datum/species/skeleton, \
	/datum/species/zombie, \
	/datum/species/mutant, \
	/datum/species/dullahan \
)

/**
 * Missing biotypes/traits/signals
 * These are custom to the bloodsucker module
 */
/// Custom biotype for vampiric mobs
#define MOB_VAMPIRIC (1<<15)

/// Trait for when a den has been enlarged to fit a larger mob
#define TRAIT_DEN_ENLARGED "den_enlarged"
/// Trait for being shaded/protected from Sol
#define TRAIT_SHADED "shaded"
/// Trait applied when garlic reagent is in your system
#define TRAIT_GARLIC_REAGENT "garlic_reagent"

/// Thrall pinpointer defines
#define THRALL_SCAN_MIN_DISTANCE 1
#define THRALL_SCAN_PING_TIME 2 SECONDS

/// Signal sent when a mob drinks blood via Drain
#define COMSIG_MOB_FEED_DRINK "mob_feed_drink"
	/// Return flag to cancel blood transfer during feeding
	#define FEED_CANCEL_BLOOD_TRANSFER (1<<0)
/// Signal sent when a mob reaches max blood during feeding
#define COMSIG_MOB_REACHED_MAX_BLOOD "mob_reached_max_blood"
	/// Return flag to indicate max blood was reached
	#define REACHED_MAX_BLOOD (1<<0)

/// Signal sent when an organ is removed from a bodypart (for talking head cleanup)
#define COMSIG_ORGAN_BODYPART_REMOVED "organ_bodypart_removed"

/// Signal for hemophage blood regen tick
#define COMSIG_MOB_HEMO_BLOOD_REGEN_TICK "mob_hemo_blood_regen_tick"
	/// Return flag to cancel hemophage blood regen
	#define COMSIG_CANCEL_MOB_HEMO_BLOOD_REGEN (1<<0)

/**
 * Ventcrawl signals - used by Clade Feral
 */
#define COMSIG_CAN_VENTCRAWL "can_ventcrawl"
#define COMISG_VENTCRAWL_PRE_ENTER "ventcrawl_pre_enter"
#define COMSIG_VENTCRAWL_PRE_EXIT "ventcrawl_pre_exit"
#define COMSIG_VENTCRAWL_EXIT "ventcrawl_exit"
#define COMSIG_VENTCRAWL_PRE_CANCEL "ventcrawl_pre_cancel"

/// Role defines for preferences
#define ROLE_BLOODSUCKER "Bloodsucker"
#define ROLE_BLOODSUCKER_BREAKOUT "Bloodsucker Breakout"
#define ROLE_BLOODSUCKERBREAKOUT "Bloodsucker (Latejoin)"
#define ROLE_VAMPIRICACCIDENT "Bloodsucker (Midround)"
#define ROLE_THRALL "Thrall"
