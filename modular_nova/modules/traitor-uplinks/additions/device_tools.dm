// LOW COST
/datum/uplink_item/device_tools/syndie_jaws
	name = "Syndicate Jaws of Life"
	desc = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
			In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."
	item = /obj/item/crowbar/power/syndicate
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/device_tools/syndicateborg
	name = "Syndicate Cyborg Upgrade"
	desc = "A marvel of modern syndicate technology; a syndicate borg hijacker. Allowing for the use of extremely powerful repair nanites, building equipment and otherwise useful upgrades to the standard saboteur modules."
	item = /obj/item/borg/upgrade/transform/syndicatejack
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/device_tools/syndikush
	name = "Syndikush Green Crack cart"
	desc = "A cheap Chinese vape cart that contains a potent combination of THC and \
			stimulants. Not made with real crack."
	item = /obj/item/reagent_containers/vapecart/syndicate
	cost = /datum/uplink_item/low_cost::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SPY


// MEDIUM COST
/datum/uplink_item/device_tools/syndie_glue
	name = "Glue"
	desc = "A cheap bottle of one use syndicate brand super glue. \
			Use on any item to make it undroppable. \
			Be careful not to glue an item you're already holding!"
	item = /obj/item/syndie_glue
	cost = /datum/uplink_item/medium_cost::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SPY

/datum/uplink_item/ammo/evil_module
	name = "Ammo Fabricator Advanced Lethal Authentication Module"
	desc = "A Gorlex Marauders-modified ammunition fabricator module, loaded with the authentication keys for causing lots and lots of problems."
	item = /obj/item/ammo_workbench_module/lethal_super/evil
	cost = /datum/uplink_item/medium_cost::cost
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// HIGH COST
