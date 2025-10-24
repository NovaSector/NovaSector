// MODSUITS
/datum/uplink_item/suits/modsuit_civ
	name = "Nakamura Standard MODsuit"
	desc = "A third-generation, modular civilian class suit by Nakamura Engineering, this suit is a staple across the galaxy for civilian applications."
	item = /obj/item/mod/control/pre_equipped/empty
	cost = /datum/uplink_item/low_cost/modsuit::cost

/datum/uplink_item/suits/modsuit_contractor
	name = "Contractor MODsuit"
	desc = "A rare depart from the Syndicate's usual color scheme, this MODsuit is produced and manufactured for private mercenaries."
	item = /obj/item/mod/control/pre_equipped/contractor
	cost = /datum/uplink_item/low_cost/modsuit::cost

/datum/uplink_item/suits/modsuit_elite
	name = "Elite MODsuit"
	desc = "An evolution of the syndicate suit, featuring a bulkier build and a matte black color scheme, this suit is only produced for high ranking Syndicate officers and elite strike teams."
	item = /obj/item/mod/control/pre_equipped/elite/unrestricted
	cost = /datum/uplink_item/high_cost/modsuit::cost


// LOW COST
/datum/uplink_item/suits/recycler
	name = "MODsuit Donksoft Recycler"
	desc = "A mod module collects and repackages fired foam darts (and garbage) into half-sized boxes of riot foam darts. \
			Activate on a nearby turf or storage to unload stored ammo boxes."
	item = /obj/item/mod/module/recycler/donk
	cost = /datum/uplink_item/low_cost::cost

/datum/uplink_item/suits/flamethrower
	name = "MODsuit Flamethrower"
	desc = "A custom-manufactured flamethrower, used to burn through your path. Burn well."
	item = /obj/item/mod/module/flamethrower
	cost = /datum/uplink_item/low_cost::cost

/datum/uplink_item/suits/energy_shield
	name = "MODsuit Energy-Shield"
	desc = "A personal, protective forcefield typically seen in military applications. \
			This advanced deflector shield is essentially a scaled down version of those seen on starships, \
			and the power cost can be an easy indicator of this. However, it is capable of blocking nearly any incoming attack, \
			but only once every few seconds; a grim reminder of the users mortality."
	item = /obj/item/mod/module/energy_shield
	cost = /datum/uplink_item/low_cost::cost


// MEDIUM COST
/datum/uplink_item/suits/jump_jet
	name = "MODsuit Ionic Jump Jet"
	desc = "A specialised ionic thruster which provides a short but powerful boost capable of pushing against gravity, \
			after which time it needs to recharge."
	item = /obj/item/mod/module/jump_jet
	cost = /datum/uplink_item/medium_cost::cost


// HIGH COST
/datum/uplink_item/suits/shove_blocker
	name = "MODsuit Bulwark"
	desc = "Layers upon layers of shock dampening plates, just to stop you from getting shoved into a wall by an angry mob."
	item = /obj/item/mod/module/shove_blocker
	cost = /datum/uplink_item/high_cost::cost
