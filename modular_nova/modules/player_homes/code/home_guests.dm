/*
 * Visiting somebody else's home.
 *
 * Entirely by knocking, and entirely one-time. You pick a host at the terminal, they are asked, and
 * if they say yes you are shown straight in. Nothing is remembered: step back out for any reason
 * and you knock again. There is no guest list, no standing permission, and nothing written to disk.
 *
 * That is deliberate. A permanent list is a thing owners have to police, and it means somebody can
 * wander your rooms on the strength of a yes you gave three rounds ago. A knock costs the host one
 * click and is always about right now.
 *
 * A guest needs no special handling once inside. The closed economy already stops them carrying a
 * host's furnishings out, and is_owner() already gates the console, so they cannot save the house,
 * relight it, unbolt anything, or file requisitions against it.
 */

/// How long a visitor must wait before knocking at the same door again.
#define HOME_KNOCK_COOLDOWN (30 SECONDS)

/// Everyone whose door there is any point knocking at: online, and currently in their own home.
///
/// You cannot knock at an empty house. Admission is one-time and granted in the moment, so a host
/// answering from the far side of the station would be letting somebody into rooms they are not in -
/// which is the standing-access model we deliberately did not build.
///
/// Hosts are identified to the client by a mob ref, never by ckey. A player should not learn who is
/// behind a character from a door list, and the ref is enough to resolve back to an account here.
/datum/controller/subsystem/homes/proc/visitable_hosts(mob/visitor)
	var/list/hosts = list()
	for(var/client/online as anything in GLOB.clients)
		if(!online.ckey || (online.ckey == visitor?.ckey))
			continue
		var/mob/host_mob = online.mob
		if(isnull(host_mob) || isnull(active_homes[online.ckey]))
			continue
		hosts += list(list(
			"ref" = REF(host_mob),
			"name" = host_mob.real_name || "Unknown",
		))
	return hosts

/// Resolves what the client sent back into an account we are willing to knock at. Re-checks that
/// they are in, because a window open on somebody's screen can easily outlast them going home.
/datum/controller/subsystem/homes/proc/host_ckey_from_ref(host_ref)
	var/mob/host_mob = locate(host_ref)
	if(!ismob(host_mob) || !host_mob.ckey)
		return null
	return isnull(active_homes[host_mob.ckey]) ? null : host_mob.ckey

/**
 * Knocks at somebody's door. The answer is asked for asynchronously, so the visitor is not left
 * staring at a frozen terminal while the host makes up their mind.
 *
 * The host has to be online to answer and in their own home to answer for - see visitable_hosts().
 */
/datum/controller/subsystem/homes/proc/knock(mob/visitor, owner_ckey, obj/machinery/home_terminal/terminal)
	var/client/host = GLOB.directory[owner_ckey]
	if(isnull(host) || isnull(host.mob) || isnull(active_homes[owner_ckey]))
		to_chat(visitor, span_warning("Nobody is answering."))
		return FALSE

	var/cooldown_key = "[visitor.ckey]-[owner_ckey]"
	if(world.time < knock_cooldowns[cooldown_key])
		to_chat(visitor, span_warning("You have only just knocked. Give them a moment."))
		return FALSE
	knock_cooldowns[cooldown_key] = world.time + HOME_KNOCK_COOLDOWN

	to_chat(visitor, span_notice("You knock, and wait to see if anybody answers."))
	INVOKE_ASYNC(src, PROC_REF(ask_host), visitor, host, owner_ckey, terminal)
	return TRUE

/// Puts the question to the host and acts on the answer. Runs detached from the knocker.
/datum/controller/subsystem/homes/proc/ask_host(mob/visitor, client/host, owner_ckey, obj/machinery/home_terminal/terminal)
	var/visitor_name = visitor.real_name || visitor.ckey
	var/answer = tgui_alert(
		host,
		"[visitor_name] is knocking at your door. Letting them in admits them this once - if they leave, they will have to knock again.",
		"Somebody at the Door",
		list("Let them in", "Refuse"),
		timeout = 1 MINUTES,
	)
	if(answer != "Let them in")
		to_chat(visitor, span_warning("Nobody answers the door."))
		return

	// The yes was for the person stood at the pad a moment ago. If they have wandered off, died, or
	// the registry has gone down since, it lapses rather than following them around.
	if(QDELETED(terminal) || !terminal.ready_for(visitor))
		to_chat(host, span_warning("You open the door, but [visitor_name] is no longer waiting."))
		return

	log_game("Player homes: [owner_ckey] let [visitor.ckey] into their home.")
	to_chat(host, span_notice("You let [visitor_name] in."))
	to_chat(visitor, span_notice("The door opens."))
	terminal.admit_visitor(visitor, owner_ckey)

#undef HOME_KNOCK_COOLDOWN
