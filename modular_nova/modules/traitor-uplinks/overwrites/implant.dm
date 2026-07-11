/* Includes:
/datum/uplink_category/implants
/datum/uplink_item/implants
*/

// LOW COST
/datum/uplink_item/implants/radio
	cost = /datum/uplink_item/low_cost::cost
//	cost = 4


// MEDIUM COST
/datum/uplink_item/implants/freedom
	cost = /datum/uplink_item/medium_cost::cost //i dont want this in the top 5 most-bought, for what it does to security's mental
//	cost = 5


// HIGH COST
/datum/uplink_item/implants/stealthimplant
	cost = /datum/uplink_item/high_cost::cost
//	cost = 8

/datum/uplink_item/implants/storage
	cost = /datum/uplink_item/high_cost::cost
//	cost = 8
