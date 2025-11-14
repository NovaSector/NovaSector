// All valid inputs to status display post_status
GLOBAL_LIST_INIT(status_display_approved_pictures, list(
	"blank",
	"shuttle",
	"default",
	"biohazard",
	"lockdown",
	"greenalert",
	"bluealert",
	"violetalert", // NOVA EDIT ADDITION - Alert Levels
	"orangealert", // NOVA EDIT ADDITION - Alert Levels
	"amberalert", // NOVA EDIT ADDITION - Alert Levels
	"redalert",
	"deltaalert",
	"gammaalert", // NOVA EDIT ADDITION - Alert Levels
	"epsilonalert", // NOVA EDIT ADDITION - Alert Levels
	"federalalert", // NOVA EDIT ADDITION - Alert Levels
	"redalert",
	"deltaalert",
	"radiation",
	"currentalert", //For automatic set of status display on current level
))

// Members of status_display_approved_pictures that are actually states and not alert values
GLOBAL_LIST_INIT(status_display_state_pictures, list(
	"blank",
	"shuttle",
))
