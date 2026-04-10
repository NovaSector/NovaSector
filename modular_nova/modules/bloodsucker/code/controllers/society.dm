/// A global list of vampire antag datums that have broken the Masquerade
GLOBAL_LIST_EMPTY(masquerade_breakers)

/// A global list of vampire antag datums in general
GLOBAL_LIST_EMPTY(all_vampires)

SUBSYSTEM_DEF(vsociety)
	name = "Vampire Society"
	wait = 5 MINUTES
	ss_flags = SS_NO_INIT | SS_BACKGROUND
	can_fire = FALSE

	// Are we currently polling?
	var/currently_polling = FALSE

	// Ref to the prince datum
	var/datum/weakref/princedatum

	var/start_time = 0

/datum/controller/subsystem/vsociety/fire(resumed = FALSE)
	var/time_elapsed = world.time - start_time

	// Give them some breathing room
	if(time_elapsed < 9 MINUTES)
		return

	if(!princedatum && !currently_polling)
		for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
			to_chat(vampire.owner.current, span_announce("* Vampire Tip: A vote for Prince will occur soon. If you are interested in leading your fellow kindred, read up on princes in your info panel now!"))
		addtimer(CALLBACK(src, PROC_REF(poll_for_prince)), 2 MINUTES)
		message_admins("Vampire society has fired, and a prince poll will occur in 2 minutes.")
		log_game("Vampire society has fired, and a prince poll will occur soon.")

/datum/controller/subsystem/vsociety/proc/poll_for_prince()
	message_admins("Vampire society is now polling for a new prince.")
	log_game("Vampire society is now polling for a new prince.")

	//Build a list of mobs in GLOB.all_vampires
	var/list/vampire_living_candidates = list()

	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		var/currentmob = vampire.owner?.current

		if(!isliving(currentmob)) //Are we mob/living?
			continue

		var/mob/living/livingmob = currentmob
		if(livingmob.health <= HEALTH_THRESHOLD_DEAD) // we check health instead of stat to avoid skipping out on vamps that are in torpor or something
			continue

		vampire_living_candidates += currentmob

	currently_polling = TRUE
	var/icon/prince_icon = icon('modular_nova/modules/bloodsucker/icons/vampiric.dmi', "prince")
	prince_icon.Scale(24, 24)
	var/list/pollers = SSpolling.poll_candidates(
		"You are eligible for princedom.",
		poll_time = 3 MINUTES,
		flash_window = TRUE,
		group = vampire_living_candidates,
		alert_pic = image(prince_icon),
		role_name_text = "Prince",
		custom_response_messages = list(
			POLL_RESPONSE_SIGNUP = "You have made your bid for princedom. <br>* Note: Princedom has certain expectations placed upon you. If you are not in a position to enforce the masquerade, consider letting someone else take this burden.",
			POLL_RESPONSE_UNREGISTERED = "You have removed your bid to princedom.",
		),
		amount_to_pick = length(GLOB.all_vampires),
		announce_chosen = FALSE,
	)
	currently_polling = FALSE

	var/datum/antagonist/vampire/chosen_datum
	var/mob/living/chosen_candidate

	// We have to do this shit because the polling proc doesn't always return a list. Sometimes it just returns a mob.
	var/list/candidates = list()
	candidates += pollers

	for(var/mob/living/current_candidate in candidates) // Pick the ideal one from the list.
		var/datum/antagonist/vampire/current_datum = IS_VAMPIRE(current_candidate)

		if(!chosen_candidate)	// If we are the first in line, just be the prince by default
			chosen_candidate = current_candidate
			chosen_datum = IS_VAMPIRE(current_candidate)
			continue

		if(current_datum.get_princely_score() >= chosen_datum.get_princely_score())
			chosen_candidate = current_candidate
			chosen_datum = IS_VAMPIRE(current_candidate)

	if(chosen_datum)
		chosen_datum.princify()


//////////////////////////////////////////////////
//////////// ON THE VAMP ANTAG DATUM /////////////
//////////////////////////////////////////////////
/**
 * Resumes society, called when someone is assigned Vampire
**/
/datum/antagonist/vampire/proc/check_start_society()

	if(SSvsociety.can_fire)
		return

	if(length(GLOB.all_vampires) >= 3)
		SSvsociety.start_time = world.time
		SSvsociety.can_fire = TRUE
		message_admins("Vampire Society has started, as there are [length(GLOB.all_vampires)] vampires active.")
		log_game("Vampire Society has started, as there are [length(GLOB.all_vampires)] vampires active.")

/**
 * Pauses society, called when someone is unassigned Vampire
**/
/datum/antagonist/vampire/proc/check_cancel_society()

	if(!SSvsociety.can_fire)
		return

	if(length(GLOB.all_vampires) < 3)
		SSvsociety.can_fire = FALSE
		message_admins("Vampire Society has paused, as there are only [length(GLOB.all_vampires)] vampires active.")
		log_game("Vampire Society has paused, as there are only [length(GLOB.all_vampires)] vampires active.")

/**
 * Turns the player into a prince.
**/
/datum/antagonist/vampire/proc/princify()
	SSvsociety.princedatum = WEAKREF(src)

	rank_up(8, TRUE) // Rank up a lot.
	to_chat(owner.current, span_cult_bold("As a true prince, you find some of your old power returning to you!"))
	owner.current.playsound_local(null, 'modular_nova/modules/bloodsucker/sound/prince.ogg', 100, FALSE, pressure_affected = FALSE)
	prince = TRUE
	add_team_hud(owner.current)

	var/full_name = return_full_name()
	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		to_chat(vampire.owner.current, span_narsiesmall("[full_name], also known as [owner.name || owner.current.real_name || owner.current.name], has claimed the role of Prince!"))

	grant_power(new /datum/action/cooldown/vampire/targeted/scourgify)

	var/datum/objective/vampire/prince/prince_objective = new()
	objectives += prince_objective
	owner.announce_objectives()

	message_admins("[ADMIN_LOOKUP(owner.current)] has received the role of Vampire Prince. ([get_princely_score()] princely score, with [my_clan?.princely_score_bonus]/[min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10] clan/hour bonus.)")
	log_game("[key_name(owner.current)] has become the Vampire Prince. ([get_princely_score()] princely score, with [my_clan?.princely_score_bonus]/[min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10] clan/hour bonus.)")

	notify_ghosts(
		"[owner.name] has become the Vampire Prince!",
		source = owner.current,
		header = "bloodclan confirmed???",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

	update_static_data_for_all_viewers()
	tgui_alert(owner.current, "Congratulations, you have been chosen for Princedom.\nPlease note that this entails a certain responsibility. Your job, now, is to keep order, and to enforce the masquerade.", "Welcome, my Prince.", list("I understand"), 30 SECONDS, TRUE)

/**
 * Turns the player into a scourge.
**/
/datum/antagonist/vampire/proc/scourgify()
	ASSERT(!prince, "Somehow a prince was going to be turned into a scourge") // Literally how would this happen. Still, just in case.

	rank_up(4, TRUE) // Rank up less.
	to_chat(owner.current, span_cult_bold("As a Camarilla scourge, your newfound purpose empowers you!"))
	owner.current.playsound_local(null, 'modular_nova/modules/bloodsucker/sound/scourge_recruit.ogg', 100, FALSE, pressure_affected = FALSE)
	scourge = TRUE
	add_team_hud(owner.current)

	var/datum/objective/vampire/scourge/scourge_objective = new()
	objectives += scourge_objective
	owner.announce_objectives()

	for(var/datum/antagonist/vampire as anything in GLOB.all_vampires)
		to_chat(vampire.owner.current, span_cult_bold(span_big("Under authority of the Prince, [owner.name || owner.current.real_name || owner.current.name] has been raised to the duty of the Scourge!")))

	message_admins("[ADMIN_LOOKUPFLW(owner.current)] has been made a Scourge of the Vampires!")
	log_game("[key_name(owner.current)] has become a Scourge of the Vampires.")

	notify_ghosts(
		"[owner.name] has been raised to the duty Scourge of the Vampires!",
		source = owner.current,
		header = "bloodclan confirmed???",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

	update_static_data_for_all_viewers()

/**
 * Returns the princyness of this vampire.
 * get the players hours, convert it into a 10 point scale, 0-100 hours.
 * get their clans default princely score. 0-10(mostly).
 * Add those together.
**/
/datum/antagonist/vampire/proc/get_princely_score()
	var/calculated_hour_score = min(50, owner.current?.client?.get_exp_living(TRUE) / 60) / 10

	var/clan_bonus = my_clan?.princely_score_bonus || -10

	return clan_bonus + calculated_hour_score

// We could put this in objectives but like, it's just two tiny hardcoded things. It's fine here.
/datum/objective/vampire/scourge
	name = "Camarilla Scourge"
	explanation_text = "Obey your prince! Ensure order! Safeguard the Masquerade!"
	completed = TRUE

/datum/objective/vampire/prince
	name = "Camarilla Prince"
	explanation_text = "Rule your fellow kindred with an iron fist! Ensure the sanctity of the Masquerade, at ALL costs!"
	completed = TRUE
