/* Includes:
/datum/uplink_category/bundle
/datum/uplink_item/bundles_tc
*/

// LOW COST


// MEDIUM COST
/datum/uplink_item/bundles_tc/bundle_a
	cost = /datum/uplink_item/medium_cost/bundle::cost
//	cost = 20

/datum/uplink_item/bundles_tc/bundle_b
	cost = /datum/uplink_item/medium_cost/bundle::cost
//	cost = 20

/datum/uplink_item/bundles_tc/surplus
	cost = /datum/uplink_item/medium_cost/bundle::cost
	crate_tc_value = 50
	desc = "A dusty crate from the back of the Syndicate warehouse delivered directly to you via Supply Pod. \
			Contents are sorted to always be worth 50 TC. The Syndicate will only provide one surplus item per agent."
//	cost = 20

/datum/uplink_item/bundles_tc/surplus/united
	cost = /datum/uplink_item/medium_cost/bundle::cost
	crate_tc_value = 125
	desc = "A shiny and large crate to be delivered directly to you via Supply Pod. It has an advanced locking mechanism with an anti-tampering protocol. \
			It is recommended that you only attempt to open it by having another agent purchase a Surplus Crate Key. Unite and fight. \
			Contents are sorted to always be worth 125 TC. The Syndicate will only provide one surplus item per agent."

/datum/uplink_item/bundles_tc/surplus_key
	cost = /datum/uplink_item/medium_cost/bundle::cost
//	cost = 20


// HIGH COST
