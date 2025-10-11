/* Includes:
/datum/uplink_category/explosives
/datum/uplink_item/explosives
*/

// LOW COST
/datum/uplink_item/explosives/soap_clusterbang
	purchasable_from = NONE //low rp and annoying


// MEDIUM COST
/datum/uplink_item/explosives/c4bag
	cost = /datum/uplink_item/medium_cost/explosive::cost
//	cost = 5

/datum/uplink_item/explosives/emp
	cost = /datum/uplink_item/medium_cost/explosive::cost //big step up from TG's pricing, but vastly more potent here
//	cost = 2

/datum/uplink_item/explosives/detomatix
	purchasable_from = NONE


// HIGH COST
/datum/uplink_item/explosives/syndicate_bomb
	cost = /datum/uplink_item/high_cost/explosive::cost
//	cost = 11

/datum/uplink_item/explosives/syndicate_bomb/emp
	cost = /datum/uplink_item/high_cost/explosive::cost
//	cost = 22 (parent type * 2)
