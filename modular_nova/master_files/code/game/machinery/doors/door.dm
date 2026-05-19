#define LINK_DENY "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=deny'> (Deny)</a>"
#define LINK_OPEN "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=open'> (Open)</a>"
#define LINK_BOLT "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=bolt'> (Bolt)</a>"
#define LINK_SHOCK "<a href='byond://?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=shock'> (Shock)</a>"

/// How long the same player must wait between AI-open requests on the same door.
#define DOOR_AI_REQUEST_COOLDOWN (30 SECONDS)

/obj/machinery/door/airlock
	//so the AI doesn't get spammed
	COOLDOWN_DECLARE(answer_cd)
	/// Tracks per-(player, door) AI-open-request cooldowns. Keyed by "[ckey]_[REF(door)]".
	var/static/list/requesters = list()

/obj/machinery/door/airlock/attack_hand_secondary(mob/living/user, list/modifiers)
	var/request_key = "[user.ckey]_[REF(src)]"
	var/last_request = requesters[request_key]
	if(last_request && world.time < last_request + DOOR_AI_REQUEST_COOLDOWN)
		to_chat(user, span_warning("You've already asked the AI about this door recently."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	. = ..()

	if(!hasPower())
		to_chat(user, span_warning("This door isn't powered."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	src.balloon_alert(user, "ai requested!")

	for(var/mob/living/silicon/ai/AI as anything in GLOB.ai_list)
		if(AI.stat == DEAD)
			continue
		if(AI.control_disabled)
			continue
		if(AI.deployed_shell)
			if(!is_station_level(AI.deployed_shell.registered_z))
				continue
			to_chat(AI.deployed_shell, "<b><a href='byond://?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open the [src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK].")
			continue
		if(!is_station_level(AI.registered_z))
			continue
		to_chat(AI, "<b><a href='byond://?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open the [src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK].")
	requesters[request_key] = world.time
	addtimer(CALLBACK(src, PROC_REF(clear_stale_requester), request_key, world.time), DOOR_AI_REQUEST_COOLDOWN)

/// Clears a `requesters` entry only if its timestamp still matches `set_at`, so a renewed
/// cooldown (same player re-requests the same door, or the sibling early-clear on open) isn't
/// wiped by a stale timer.
/obj/machinery/door/airlock/proc/clear_stale_requester(key, set_at)
	if(requesters[key] == set_at)
		requesters -= key

#undef LINK_DENY
#undef LINK_OPEN
#undef LINK_BOLT
#undef LINK_SHOCK
#undef DOOR_AI_REQUEST_COOLDOWN
