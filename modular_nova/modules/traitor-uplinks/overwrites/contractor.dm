/// How much TC should an operative have left after buying the contractor kit, factoring in the default TC granted below.
#define CONTRACTOR_KIT_REMAINING_TC (/datum/uplink_item/low_cost/modsuit::cost + /datum/uplink_item/medium_cost::cost)
/// Static define that will automatically update according to the traitor's default TC amount, factoring in the desired remaining TC defined above.
#define CONTRACTOR_KIT_PRICE (TELECRYSTALS_DEFAULT - CONTRACTOR_KIT_REMAINING_TC)

/datum/uplink_item/bundles_tc/contract_kit
//	cost = 20, TG default
	cost = CONTRACTOR_KIT_PRICE

#undef CONTRACTOR_KIT_REMAINING_TC
#undef CONTRACTOR_KIT_PRICE


// LOW COST
/datum/uplink_item/contractor/reroll

/datum/uplink_item/contractor/pinpointer

/datum/uplink_item/contractor/extraction_kit

/datum/uplink_item/contractor/partner


// MEDIUM COST


// HIGH COST
