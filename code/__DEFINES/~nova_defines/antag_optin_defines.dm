//defines for antag opt in objective checking
//objectives check for all players with a value equal or greater than the 'threat' level of an objective then pick from that list
//command + sec roles are always opted in regardless of opt in status

// Config-styled defines. Me no likey
/// The minimum opt-in level for people playing sec.
#define SECURITY_ANTAG_OPT_IN_LEVEL ANTAG_OPT_IN_YES_KILL
/// The minimum opt-in level for people playing command.
#define COMMAND_ANTAG_OPT_IN_LEVEL ANTAG_OPT_IN_YES_KILL
/// The default opt in level for preferences and mindless mobs.
#define ANTAG_OPT_IN_DEFAULT_LEVEL ANTAG_OPT_OUT
/// If the player has any non-ghost role antags enabled, they are forced to use a minimum of this.
#define ANTAG_OPT_IN_ANTAG_ENABLED_LEVEL ANTAG_OPT_IN_YES_PARTIAL

// Each level decides how the dyanmic system can select a player as a target for antagonist objectives. The higher the level, the more severe the objectives they are consenting to be a target of.
// These are used in preferences and in objective targeting checks.
/// Prefers not to be a target. Will still be a potential target if playing sec or command.
#define ANTAG_OPT_OUT 0
/// For temporary or otherwise 'inconvenient' objectives like kidnapping or theft
#define ANTAG_OPT_IN_YES_PARTIAL 1
/// Cool with being killed or otherwise occupied but not removed from the round
#define ANTAG_OPT_IN_YES_KILL 2
/// Fine with being round removed.
#define ANTAG_OPT_IN_YES_ROUND_REMOVE 3

// The string representations of the opt in levels for the front-end.
#define ANTAG_OPT_OUT_STRING "No"
#define ANTAG_OPT_IN_YES_PARTIAL_STRING "Yes - Inconvenience"
#define ANTAG_OPT_IN_YES_KILL_STRING "Yes - Kill"
#define ANTAG_OPT_IN_YES_ROUND_REMOVE_STRING "Yes - Round Remove"

/// Assoc list of stringified opt_in_## define to the front-end string to show users as a representation of the setting.
GLOBAL_LIST_INIT(antag_opt_in_strings, list(
	"0" = ANTAG_OPT_OUT_STRING,
	"1" = ANTAG_OPT_IN_YES_PARTIAL_STRING,
	"2" = ANTAG_OPT_IN_YES_KILL_STRING,
	"3" = ANTAG_OPT_IN_YES_ROUND_REMOVE_STRING,
))

/// Assoc list of stringified opt_in_## define to the color associated with it.
GLOBAL_LIST_INIT(antag_opt_in_colors, list(
	ANTAG_OPT_OUT_STRING = COLOR_GRAY,
	ANTAG_OPT_IN_YES_PARTIAL_STRING = COLOR_EMERALD,
	ANTAG_OPT_IN_YES_KILL_STRING = COLOR_ORANGE,
	ANTAG_OPT_IN_YES_ROUND_REMOVE_STRING = COLOR_RED,
))
