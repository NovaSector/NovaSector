/// How much TC should an operative have left after buying the contractor kit, factoring in the default TC granted below.
#define CONTRACTOR_KIT_REMAINING_TC (/datum/uplink_item/low_cost/modsuit::cost + /datum/uplink_item/low_cost::cost)
/// Static define that will automatically update according to the traitor's default TC amount, factoring in the desired remaining TC defined above.
#define CONTRACTOR_KIT_PRICE (TELECRYSTALS_DEFAULT - CONTRACTOR_KIT_REMAINING_TC)

/datum/uplink_item/bundles_tc/contract_kit
	cost = CONTRACTOR_KIT_PRICE
//	cost = 20

#undef CONTRACTOR_KIT_REMAINING_TC
#undef CONTRACTOR_KIT_PRICE


// LOW COST


// MEDIUM COST


// HIGH COST
