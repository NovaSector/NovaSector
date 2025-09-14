/datum/uplink_category/explosives

/datum/uplink_item/explosives


// LOW COST
/datum/uplink_item/explosives/soap_clusterbang
	purchasable_from = NONE //low rp and annoying

/datum/uplink_item/explosives/frag

/datum/uplink_item/explosives/smoke

/datum/uplink_item/explosives/syndicate_minibomb

/datum/uplink_item/explosives/c4

/datum/uplink_item/explosives/x4

/datum/uplink_item/explosives/pizza_bomb


// MEDIUM COST
/datum/uplink_item/explosives/c4bag
	cost = /datum/uplink_item/medium_cost/explosive::cost

/datum/uplink_item/explosives/emp
	cost = /datum/uplink_item/medium_cost/explosive::cost //big step up from TG's pricing, but vastly more potent here

/datum/uplink_item/explosives/detomatix
	purchasable_from = NONE


// HIGH COST
/datum/uplink_item/explosives/syndicate_bomb
	cost = /datum/uplink_item/high_cost/explosive::cost

/datum/uplink_item/explosives/syndicate_bomb/emp
	cost = /datum/uplink_item/high_cost/explosive::cost
