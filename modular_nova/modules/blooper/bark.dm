GLOBAL_VAR_INIT(blooper_allowed, TRUE) // For administrators

// Mechanics for Changelings
/datum/changeling_profile
	/// Blooper ID of copied target
	var/blooper_id
	/// Blooper Pitch of copied target
	var/blooper_pitch
	/// Blooper Pitch Range of copied target
	var/blooper_pitch_range
	/// Blooper Speed of copied target
	var/blooper_speed

/datum/smite/normalblooper
	name = "Normal blooper"

/datum/smite/normalblooper/effect(client/user, mob/living/carbon/human/target)
	. = ..()
	target.blooper = null
	target.blooper_id = pick(GLOB.blooper_random_list)
	target.blooper_speed = round((BLOOPER_DEFAULT_MINSPEED + BLOOPER_DEFAULT_MAXSPEED) / 2)
	target.blooper_pitch = round((BLOOPER_DEFAULT_MINPITCH + BLOOPER_DEFAULT_MAXPITCH) / 2)
	target.blooper_pitch_range = 0.2

/// Admin verb to globally toggle vocal barks
/datum/admins/proc/toggleblooper()
	set category = "Server"
	set desc = "Toggle the annoying voices."
	set name = "Toggle Vocal Barks"
	toggle_blooper()
	log_admin("[key_name(usr)] toggled Voice Barks.")
	message_admins("[key_name_admin(usr)] toggled Voice Barks.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Voice Bark", "[GLOB.blooper_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/// Globally toggles bloopers on/off
/proc/toggle_blooper(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.blooper_allowed)
			GLOB.blooper_allowed = toggle
		else
			return
	else
		GLOB.blooper_allowed = !GLOB.blooper_allowed
	to_chat(world, span_oocplain("<B>Vocal barks have been globally [GLOB.blooper_allowed ? "enabled" : "disabled"].</B>"))

/// It's was stoolen from Splurt build >:3 and from fluffySTG!! nyeehehehheee!~
/datum/blooper
	var/name = "None"
	var/id = "No Voice"
	var/soundpath

	var/minpitch = BLOOPER_DEFAULT_MINPITCH
	var/maxpitch = BLOOPER_DEFAULT_MAXPITCH
	var/minvariance = BLOOPER_DEFAULT_MINVARY
	var/maxvariance = BLOOPER_DEFAULT_MAXVARY

	// Speed vars. Speed determines the number of characters required for each blooper, with lower speeds being faster with higher blooper density
	var/minspeed = BLOOPER_DEFAULT_MINSPEED
	var/maxspeed = BLOOPER_DEFAULT_MAXSPEED

	// Visibility vars. Regardless of what's set below, these can still be obtained via adminbus and genetics. Rule of fun.

	///If set to FALSE, this will prevent it from showing up in the voice selection dropdown in char prefs.
	var/allow_random = FALSE
