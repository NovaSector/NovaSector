/// Set to 0 in config to turn persistent player homes off entirely. The cafe terminal goes inert.
/datum/config_entry/flag/player_homes_enabled
	default = TRUE

/// Seconds a player must wait between filing home requisitions. Set to 0 to remove the wait.
/datum/config_entry/number/player_home_supply_cooldown
	config_entry_value = 300
	min_val = 0
