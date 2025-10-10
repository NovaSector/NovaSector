/* Includes:
/datum/uplink_category/stealthy
/datum/uplink_item/stealthy_weapons
*/

// LOW COST
/datum/uplink_item/stealthy_weapons/slipstick
	cost = /datum/uplink_item/low_cost::cost
//	cost = 6

/datum/uplink_item/stealthy_weapons/crossbow
	cost = /datum/uplink_item/low_cost/weaponry::cost
//	cost = 10


// MEDIUM COST
/datum/uplink_item/stealthy_weapons/martialarts
	cost = /datum/uplink_item/medium_cost/martial_arts::cost
//	cost = 17

/datum/uplink_item/stealthy_weapons/contrabaton
	cost = /datum/uplink_item/medium_cost/weaponry::cost
//	cost = 7


// HIGH COST
/datum/uplink_item/stealthy_weapons/romerol_kit
	purchasable_from = NONE
