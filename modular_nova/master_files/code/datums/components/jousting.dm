/datum/component/jousting
	/// The proc to call when a joust is successfully accomplished.
	var/datum/callback/successful_joust_callback

/datum/component/jousting/Initialize(damage_boost_per_tile, knockdown_chance_per_tile, knockdown_time, max_tile_charge, min_tile_charge, datum/callback/successful_joust_callback)
	. = ..()
	if (!parent)
		return .

	src.successful_joust_callback = successful_joust_callback

	RegisterSignal(parent, COMSIG_PRE_BATON_FINALIZE_ATTACK, PROC_REF(on_successful_attack))
