/// Vote datum that allows players to vote on the dynamic threat tier before roundstart.
/// Results are kept secret — only admins see what was picked.
/datum/vote/dynamic_tier
	name = "Threat Level"
	override_question = "What threat level should this round have?"
	default_message = "Vote for the round's threat level!"
	count_method = VOTE_COUNT_METHOD_SINGLE
	winner_method = VOTE_WINNER_METHOD_SIMPLE
	display_statistics = FALSE

/datum/vote/dynamic_tier/New()
	. = ..()
	default_choices = list()
	for(var/datum/dynamic_tier/tier_type as anything in subtypesof(/datum/dynamic_tier))
		var/tier_name = initial(tier_type.name)
		if(!tier_name)
			continue
		default_choices += tier_name
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_pregame))
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, PROC_REF(on_setting_up))

/// Called when pregame starts. Schedules the vote after 60 seconds.
/datum/vote/dynamic_tier/proc/on_pregame(datum/source)
	SIGNAL_HANDLER

	if(!CONFIG_GET(flag/allow_vote_dynamic_tier))
		return
	INVOKE_ASYNC(src, PROC_REF(delayed_auto_start))

/// Waits 60 seconds then starts the vote if still in pregame.
/datum/vote/dynamic_tier/proc/delayed_auto_start()
	sleep(60 SECONDS)
	if(SSticker.current_state != GAME_STATE_PREGAME)
		return
	if(SSdynamic.current_tier || SSvote.current_vote)
		return
	SSvote.initiate_vote(src, "the server", forced = TRUE)

/// Force-end this vote if it's still running when setup begins.
/datum/vote/dynamic_tier/proc/on_setting_up(datum/source)
	SIGNAL_HANDLER

	if(!istype(SSvote.current_vote, /datum/vote/dynamic_tier))
		return
	SSvote.end_vote()

/datum/vote/dynamic_tier/create_vote(mob/vote_creator)
	// Filter tiers by current population before populating choices
	var/player_count = length(GLOB.clients)
	default_choices = list()
	for(var/datum/dynamic_tier/tier_type as anything in subtypesof(/datum/dynamic_tier))
		var/tier_name = initial(tier_type.name)
		if(!tier_name)
			continue
		var/tier_min_pop = SSdynamic.get_config_value(tier_type, "min_pop", initial(tier_type.min_pop))
		if(player_count < tier_min_pop)
			continue
		default_choices += tier_name
	return ..()

/datum/vote/dynamic_tier/is_config_enabled()
	return CONFIG_GET(flag/allow_vote_dynamic_tier)

/datum/vote/dynamic_tier/toggle_votable()
	CONFIG_SET(flag/allow_vote_dynamic_tier, !CONFIG_GET(flag/allow_vote_dynamic_tier))

/datum/vote/dynamic_tier/can_be_initiated(forced)
	. = ..()
	if(. != VOTE_AVAILABLE)
		return .
	if(SSdynamic.current_tier)
		return "The threat level has already been decided."
	if(SSticker.current_state >= GAME_STATE_PLAYING)
		return "The round has already started."
	return VOTE_AVAILABLE

/datum/vote/dynamic_tier/get_result_text(list/all_winners, real_winner, list/non_voters)
	// Keep the result secret from players
	return null

/datum/vote/dynamic_tier/finalize_vote(winning_option)
	if(!winning_option)
		return
	for(var/datum/dynamic_tier/tier_type as anything in subtypesof(/datum/dynamic_tier))
		if(initial(tier_type.name) != winning_option)
			continue
		var/player_count = length(GLOB.clients)
		SSdynamic.set_tier(tier_type, player_count)
		log_game("Dynamic tier vote: Players voted for [winning_option]. Tier set to [initial(tier_type.config_tag)].")
		message_admins(span_adminnotice("Dynamic tier vote: Players voted for [span_bold(winning_option)]. Tier has been set."))
		return
