/datum/export/gas_canister/New()
	if(CONFIG_GET(flag/override_gas_prices))
		k_hit_percentile = 0 // Originally inherits k_hit_percentile = 0.05
	return ..()
