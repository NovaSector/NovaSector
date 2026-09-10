//defines for conflict opt in, which is separate from antag opt in and is for OOC consent to engage in conflict, not just antagonist objectives.
//This is for things like policy and other conflict based systems that aren't necessarily antagonist objectives but still involve conflict between players.

// Config-styled defines. Me no likey
/// The default opt in level for preferences and mindless mobs.
#define CONFLICT_OPT_IN_DEFAULT_LEVEL CONFLICT_OPT_OUT
/// The minimum opt-in level for people playing sec.
#define SECURITY_CONFLICT_OPT_IN_LEVEL CONFLICT_OPT_OUT
/// The minimum opt-in level for people playing command.
#define COMMAND_CONFLICT_OPT_IN_LEVEL CONFLICT_OPT_OUT
/// If the player has any non-ghost role antags enabled, they are forced to use a minimum of this.
#define CONFLICT_OPT_IN_ANTAG_ENABLED_LEVEL CONFLICT_OPT_IN_PARTIAL

// The levels of opt in. The higher the level, the more severe the conflict they are consenting to.
/// Prefers not to be a target. Will still be a potential target if playing sec or command.
#define CONFLICT_OPT_OUT 0
/// For temporary or otherwise 'inconvenient' objectives like kidnapping or theft
#define CONFLICT_OPT_IN_PARTIAL 1
/// Cool with being killed or otherwise occupied but not removed from the round
#define CONFLICT_OPT_IN_YES_KILL 2
/// Fine with being round removed.
#define CONFLICT_OPT_IN_YES_ROUND_REMOVE 3

// The string representations of the opt in levels for the front-end.
#define CONFLICT_OPT_OUT_STRING "Passive"
#define CONFLICT_OPT_IN_YES_PARTIAL_STRING "Involved"
#define CONFLICT_OPT_IN_YES_KILL_STRING "Vulnerable"
#define CONFLICT_OPT_IN_YES_ROUND_REMOVE_STRING "Expendable"

/// Assoc list of stringified opt_in_## define to the front-end string to show users as a representation of the setting.
GLOBAL_LIST_INIT(conflict_opt_in_strings, list(
	"0" = CONFLICT_OPT_OUT_STRING,
	"1" = CONFLICT_OPT_IN_YES_PARTIAL_STRING,
	"2" = CONFLICT_OPT_IN_YES_KILL_STRING,
	"3" = CONFLICT_OPT_IN_YES_ROUND_REMOVE_STRING,
))

/// Assoc list of stringified opt_in_## define to the color associated with it.
GLOBAL_LIST_INIT(conflict_opt_in_colors, list(
	CONFLICT_OPT_OUT_STRING = COLOR_GRAY,
	CONFLICT_OPT_IN_YES_PARTIAL_STRING = COLOR_EMERALD,
	CONFLICT_OPT_IN_YES_KILL_STRING = COLOR_ORANGE,
	CONFLICT_OPT_IN_YES_ROUND_REMOVE_STRING = COLOR_RED,
))
