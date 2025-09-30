// Balance
/datum/storyteller_balance
	/// Base weight per player
	var/player_weight = 1.0
	/// Base weight per antagonist
	var/antag_weight = 2.0

/datum/storyteller_balance/proc/compute(datum/storyteller_inputs/inputs)


/datum/storyteller_balance_snapshot
	var/total_player_weight = 0
	var/total_antag_weight = 0
	var/ratio = 1.0
