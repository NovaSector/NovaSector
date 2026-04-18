#define MODE_VOTE_DYNAMIC "Dynamic"
#define MODE_VOTE_GREENSHIFT "Greenshift"

GLOBAL_VAR_INIT(chosen_round_mode, null)

/datum/vote/round_mode
	name = "Round Mode"
	override_question = "How should this round run?"
	default_message = "Vote for the round mode!"
	count_method = VOTE_COUNT_METHOD_SINGLE
	winner_method = VOTE_WINNER_METHOD_SIMPLE
	display_statistics = TRUE
	default_choices = list(MODE_VOTE_DYNAMIC, MODE_VOTE_GREENSHIFT)

/datum/vote/round_mode/New()
	. = ..()
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_pregame))
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, PROC_REF(on_setting_up))
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_mob_login))

/datum/vote/round_mode/proc/on_pregame(datum/source)
	SIGNAL_HANDLER

	GLOB.chosen_round_mode = null
	if(!CONFIG_GET(flag/allow_vote_mode))
		return
	INVOKE_ASYNC(src, PROC_REF(delayed_auto_start))

/datum/vote/round_mode/proc/delayed_auto_start()
	sleep(60 SECONDS)
	if(SSticker.current_state != GAME_STATE_PREGAME)
		return
	if(SSdynamic.current_tier || SSvote.current_vote)
		return
	if(GLOB.chosen_round_mode)
		return
	SSvote.initiate_vote(src, "the server", forced = TRUE)

/datum/vote/round_mode/proc/on_setting_up(datum/source)
	SIGNAL_HANDLER

	if(!istype(SSvote.current_vote, /datum/vote/round_mode))
		return
	SSvote.end_vote()

/datum/vote/round_mode/is_config_enabled()
	return CONFIG_GET(flag/allow_vote_mode)

/datum/vote/round_mode/toggle_votable()
	CONFIG_SET(flag/allow_vote_mode, !CONFIG_GET(flag/allow_vote_mode))

/datum/vote/round_mode/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .
	if(GLOB.chosen_round_mode)
		return "The round mode has already been decided."
	if(SSdynamic.current_tier)
		return "The dynamic tier has already been decided."
	if(SSticker.current_state >= GAME_STATE_PLAYING)
		return "The round has already started."
	return VOTE_AVAILABLE

/datum/vote/round_mode/finalize_vote(winning_option)
	if(!winning_option)
		winning_option = MODE_VOTE_DYNAMIC

	GLOB.chosen_round_mode = winning_option

	switch(winning_option)
		if(MODE_VOTE_GREENSHIFT)
			var/player_count = length(GLOB.clients)
			SSdynamic.set_tier(/datum/dynamic_tier/greenshift, player_count)
			log_game("Round mode vote: Players voted for [winning_option]. Dynamic tier forced to Greenshift (incidental events only).")
			message_admins(span_adminnotice("Round mode vote: Players voted for [span_bold(winning_option)]. Tier forced to Greenshift."))
		if(MODE_VOTE_DYNAMIC)
			log_game("Round mode vote: Players voted for [winning_option]. Dynamic will roll normally.")
			message_admins(span_adminnotice("Round mode vote: Players voted for [span_bold(winning_option)]. Dynamic will roll normally."))

	for(var/mob/player as anything in GLOB.player_list)
		RegisterSignal(player, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(add_stat_entry), override = TRUE)

/datum/vote/round_mode/proc/on_mob_login(datum/source, mob/new_mob)
	SIGNAL_HANDLER

	if(!GLOB.chosen_round_mode)
		return
	RegisterSignal(new_mob, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(add_stat_entry), override = TRUE)

/datum/vote/round_mode/proc/add_stat_entry(mob/source, list/items)
	SIGNAL_HANDLER

	if(!GLOB.chosen_round_mode)
		return
	items += "Round Mode: [GLOB.chosen_round_mode]"

#undef MODE_VOTE_DYNAMIC
#undef MODE_VOTE_GREENSHIFT
