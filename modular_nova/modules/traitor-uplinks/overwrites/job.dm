/datum/uplink_category/role_restricted

/datum/uplink_item/role_restricted


// LOW COST
/datum/uplink_item/role_restricted/advanced_plastic_surgery

/datum/uplink_item/role_restricted/haunted_magic_eightball

/datum/uplink_item/role_restricted/oldtoolboxclean

/datum/uplink_item/role_restricted/clumsinessinjector

/datum/uplink_item/role_restricted/clownpin
	cost = 1

/datum/uplink_item/role_restricted/reverse_bear_trap

/datum/uplink_item/role_restricted/reverse_bear_trap

/datum/uplink_item/role_restricted/syndimmi

/datum/uplink_item/role_restricted/explosive_hot_potato

/datum/uplink_item/role_restricted/clownsuperpin
	cost = /datum/uplink_item/low_cost::cost

/datum/uplink_item/role_restricted/reverse_revolver
	cost = /datum/uplink_item/low_cost::cost

/datum/uplink_item/role_restricted/pressure_mod
	cost = /datum/uplink_item/low_cost::cost
	restricted_roles = list(JOB_SHAFT_MINER, JOB_CARGO_TECHNICIAN)

/datum/uplink_item/role_restricted/mail_counterfeit_kit
	purchasable_from = NONE //not sure what the story is

/datum/uplink_item/role_restricted/moltobeso

/datum/uplink_item/role_restricted/gorillacube
	cost = /datum/uplink_item/low_cost::cost
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/springlock_module
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/concealed_weapon_bay
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/bee_smoker

/datum/uplink_item/role_restricted/monkey_supplies


// MEDIUM COST
/datum/uplink_item/role_restricted/bureaucratic_error
	cost = /datum/uplink_item/medium_cost::cost //this is much more expensive than TG's price, but we don't let QM's or HoPs be traitor so

/datum/uplink_item/role_restricted/combat_baking

/datum/uplink_item/role_restricted/ez_clean_bundle
	cost = /datum/uplink_item/medium_cost::cost
	restricted_roles = list(JOB_JANITOR, JOB_BRIDGE_ASSISTANT)

/datum/uplink_item/role_restricted/brainwash_disk
	cost = /datum/uplink_item/medium_cost::cost

/datum/uplink_item/role_restricted/modified_syringe_gun
	cost = /datum/uplink_item/medium_cost::cost
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/turretbox
	cost = 8 //grandfather value
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/rebarxbowsyndie
//	cost = 6   grandfather value, but this item is strong. i think TG's price is fine
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/concussivedisk
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/meathook
	cost = /datum/uplink_item/medium_cost::cost

/datum/uplink_item/role_restricted/chemical_gun
	cost = /datum/uplink_item/medium_cost::cost

/datum/uplink_item/role_restricted/laser_arm
	cost = 5 //grandfather value
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/pie_cannon
	cost = /datum/uplink_item/medium_cost::cost

/datum/uplink_item/role_restricted/spider_injector
	purchasable_from = NONE //not sure what the story is

/datum/uplink_item/role_restricted/evil_seedling

/datum/uplink_item/role_restricted/monkey_agent


// HIGH COST
/datum/uplink_item/role_restricted/ancient_jumpsuit

/datum/uplink_item/role_restricted/mimery

/datum/uplink_item/role_restricted/magillitis_serum
	restricted_roles = list(JOB_GENETICIST, JOB_SCIENTIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/reticence
	cost = /datum/uplink_item/high_cost::cost
	restricted_roles = list(JOB_MIME, JOB_ROBOTICIST)

/datum/uplink_item/role_restricted/clown_bomb
	cost = /datum/uplink_item/high_cost::cost

/datum/uplink_item/role_restricted/clowncar

/datum/uplink_item/role_restricted/his_grace
	purchasable_from = NONE //low roleplay

/datum/uplink_item/role_restricted/blastcannon
	purchasable_from = NONE
