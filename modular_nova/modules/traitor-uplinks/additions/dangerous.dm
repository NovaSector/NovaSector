// LOW COST
/datum/uplink_item/dangerous/foamsmg
	name = "Donksoft Riot SMG Case"
	desc = "A case containing an innocent-looking toy SMG designed to fire foam darts at higher than normal velocity. \
			Comes loaded with riot-grade darts effective at incapacitating a target and two spare magazines.  \
			Perfect for nonlethal takedowns at range, as well as deniability. While not included in the kit, the \
			SMG is compatible with suppressors, which can be purchased separately."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/foamforce_smg
	cost = 1
	purchasable_from = UPLINK_TRAITORS | UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/dangerous/enforcer
	name = "Enforcer-TEN Handgun Case"
	desc = "A weapon case containing the Enforcer-TEN combat handgun, along with two spare magazines and a large box of loose 10mm ammunition. \
			Chambered in 10mm. Incompatible with suppressors, and very loud, making it a poor choice for subtlety. \
			The raw power of 10mm, however, makes it a fine choice for high-impact skirmishing."
	item = /obj/item/storage/toolbox/guncase/traitor/enforcer
	cost = /datum/uplink_item/low_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/ansem
	name = "Ansem Pistol Case"
	desc = "A small, easily concealable handgun that uses 10mm auto rounds in 8-round magazines and is compatible \
			with suppressors. Comes with two spare magazines."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/ansem
	cost = /datum/uplink_item/low_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/dangerous/ocelot
	name = "Modified Revolver Case"
	desc = "A .357 Magnum revolver firing ricochet bullets, in case you care about style-points."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/ocelot
	cost = /datum/uplink_item/low_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/nunchaku
	name = "Syndie Fitness Nunchuks"
	desc = "Heavyweight titanium nunchucks that can be used to knock out and harm your opponent quickly and easily. \
			In close combat, it allows you to block all melee attacks and throws, punishing the offender."
	item = /obj/item/melee/baton/nunchaku
	cost = /datum/uplink_item/low_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// MEDIUM COST
/datum/uplink_item/dangerous/laser_carbine
	name = "Allstar Laser-Carbine Case"
	desc = "A modified laser gun which can shoot far faster, but each shot is far less damaging. \
			Comes with a recharge kit."
	item = /obj/item/storage/toolbox/guncase/nova/opfor/carbine
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/sindano
	name = "Carwo-Cawil Sindano Case"
	desc = "A Sindano SMG, with spare lethal-and-non-lethal ammo, and three various magazines."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/sindano
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/nukeop_smg
	name = "Scarborough C-20r Case"
	desc = "A fully-loaded Scarborough Arms bullpup submachine gun. The C-20r fires .45 rounds with a \
			24-round magazine and is compatible with suppressors. Comes with spare two magazines."
	item = /obj/item/storage/toolbox/guncase/nova/pistol/opfor/c20r
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/dangerous/eshield
	name = "Energy Shield"
	desc = "A highly deflective energy shield, pairs well with the energy sword."
	item = /obj/item/shield/energy
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/dangerous/katana
	name = "Katana"
	desc = "An extremely sharp and robust sword folded over nine thousand times until perfection. Highly lethal and illegal."
	item = /obj/item/katana
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/combat_shotgun
	name = "Carwo-Cawil M64 Shotgun Case"
	desc = "A twelve guage shotgun with an eight shell capacity underneath."
	item = /obj/item/storage/toolbox/guncase/nova/opfor/riot_sol
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/boarder980
	name = "Boarder-980 Grenade Launcher Case"
	desc = "A weapon case featuring the Boarder-980 grenade launcher, chambered for .980 Tydhouer with on-the-fly airburst configuration. \
			Maximum capacity of 5+1 grenades, and comes pre-loaded with shrapnel grenades, with the case coming with two more boxes of shrapnel \
			grenades and one box of phosphor grenades. The Syndicate reminds you that it is not responsible for user error."
	item = /obj/item/storage/toolbox/guncase/traitor/boarder
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// HIGH COST
/datum/uplink_item/dangerous/shitzu
	name = "Shitzu Magfed Shotgun Case"
	desc = "Everyone says a dog is a man's best friend, lets change that and make man's best friend a 12 gauge magfed shotgun! Thanks to the beloved contributions from the Gorlex Marauders."
	item = /obj/item/storage/toolbox/guncase/nova/syndicate/shitzu
	cost = /datum/uplink_item/high_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/sol_rifle
	name = "Carwo-Cawil MMR-2543E Assault Rifle"
	desc = "A heavy battle rifle, this one seems to be painted tacticool black. Accepts any standard SolFed rifle magazine."
	item = /obj/item/storage/toolbox/guncase/nova/opfor/sol_rifle
	cost = /datum/uplink_item/high_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/wylom
	name = "Szot Dynamica 'Wyłom' AMR Case"
	desc = "A massive, outdated beast of an anti materiel rifle that was once in use by CIN military forces. Fires the devastating .60 Strela caseless round, the massively overperforming penetration of which being the reason this weapon was discontinued."
	item = /obj/item/storage/toolbox/guncase/nova/opfor/amr
	cost = /datum/uplink_item/high_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/dangerous/hook_shotgun
	name = "Modified Sawn-off Shotgun Case"
	desc = "Range isn't an issue when you can bring your victim to you."
	item = /obj/item/storage/toolbox/guncase/nova/opfor/hook_shotgun
	cost = /datum/uplink_item/high_cost/weaponry::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS
