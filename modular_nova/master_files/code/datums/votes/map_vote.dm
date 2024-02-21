//Map votes shouldn't be using weighted random
/datum/vote/map_vote
	count_method = VOTE_COUNT_METHOD_MULTI
	winner_method = VOTE_WINNER_METHOD_SIMPLE
