/* Includes:
/datum/uplink_category/role_restricted
/datum/uplink_item/role_restricted
*/

// LOW COST
/datum/uplink_item/role_restricted/clownpin
	cost = 1
//	cost = 4

/datum/uplink_item/role_restricted/explosive_hot_potato
	purchasable_from = NONE //hilariously unfitting for the server

/datum/uplink_item/role_restricted/clownsuperpin
	cost = /datum/uplink_item/low_cost::cost
//	cost = 7

/datum/uplink_item/role_restricted/reverse_revolver
	cost = /datum/uplink_item/low_cost::cost
//	cost = 14

/datum/uplink_item/role_restricted/pressure_mod
	cost = /datum/uplink_item/low_cost::cost
	restricted_roles = list(JOB_SHAFT_MINER, JOB_CARGO_TECHNICIAN)
//	cost = 5

/datum/uplink_item/role_restricted/mail_counterfeit_kit
	purchasable_from = NONE //not sure what the story is

/datum/uplink_item/role_restricted/gorillacube
	cost = /datum/uplink_item/low_cost::cost
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)
//	cost = 6

/datum/uplink_item/role_restricted/springlock_module
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/concealed_weapon_bay
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)


// MEDIUM COST
/datum/uplink_item/role_restricted/bureaucratic_error
	cost = /datum/uplink_item/medium_cost::cost //this is much more expensive than TG's price, but we don't let QM's or HoPs be traitor so
//	cost = 2

/datum/uplink_item/role_restricted/ez_clean_bundle
	restricted_roles = list(JOB_JANITOR, JOB_BRIDGE_ASSISTANT)
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 6

/datum/uplink_item/role_restricted/brainwash_disk
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 5

/datum/uplink_item/role_restricted/modified_syringe_gun
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 14

/datum/uplink_item/role_restricted/turretbox
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)
	cost = 8 //grandfather value
//	cost = 11

/datum/uplink_item/role_restricted/rebarxbowsyndie
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/concussivedisk
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/meathook
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 11

/datum/uplink_item/role_restricted/chemical_gun
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 12

/datum/uplink_item/role_restricted/laser_arm
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)
	cost = 5 //grandfather value
//	cost = 10

/datum/uplink_item/role_restricted/pie_cannon
	cost = /datum/uplink_item/medium_cost::cost
//	cost = 10

/datum/uplink_item/role_restricted/spider_injector
	purchasable_from = NONE //not sure what the story is


// HIGH COST
/datum/uplink_item/role_restricted/magillitis_serum
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/reticence
	restricted_roles = list(JOB_MIME, JOB_ROBOTICIST)
	cost = /datum/uplink_item/high_cost::cost
//	cost = 20

/datum/uplink_item/role_restricted/clown_bomb
	cost = /datum/uplink_item/high_cost::cost
//	cost = 15

/datum/uplink_item/role_restricted/his_grace
	purchasable_from = NONE //low roleplay

/datum/uplink_item/role_restricted/blastcannon
	purchasable_from = NONE
