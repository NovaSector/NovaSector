/* Includes:
/datum/uplink_category/dangerous
/datum/uplink_item/dangerous
*/

// LOW COST
/datum/uplink_item/dangerous/foampistol
	cost = 1
//	cost = 6

/datum/uplink_item/dangerous/pistol
	cost = /datum/uplink_item/low_cost/weaponry::cost
//	cost = 7

/datum/uplink_item/dangerous/revolver
	cost = /datum/uplink_item/low_cost/weaponry::cost
//	cost = 13

/datum/uplink_item/dangerous/sword
	cost = /datum/uplink_item/low_cost/weaponry::cost
//	cost = 6

/datum/uplink_item/dangerous/powerfist
	cost = /datum/uplink_item/low_cost/weaponry::cost
//	cost = 6

/datum/uplink_item/dangerous/cat
	purchasable_from = NONE //low roleplay


// MEDIUM COST
/datum/uplink_item/dangerous/rapid
	cost = /datum/uplink_item/medium_cost/weaponry::cost
//	cost = 8

/datum/uplink_item/dangerous/guardian
	cost = /datum/uplink_item/medium_cost/weaponry::cost
//	cost = 18


// HIGH COST
/datum/uplink_item/dangerous/doublesword
	cost = /datum/uplink_item/high_cost/weaponry::cost
//	cost = 13
