/datum/emote/living/roll_dice
	key = "dice"
	key_third_person = "rolldice"
	message = null

	cooldown = 1 SECONDS // this really doesnt need a massive cooldown. if people spam it just. mute them
	stat_allowed = UNCONSCIOUS

/datum/emote/living/roll_dice/can_run_emote(mob/user, status_check, intentional)
	. = ..() && intentional

/datum/emote/living/roll_dice/run_emote(mob/user, params, type_override, intentional)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE

	if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, span_boldwarning("You cannot send IC messages (muted)."))
		return FALSE

	user.display_random_roll(params, intentional)

	return TRUE

