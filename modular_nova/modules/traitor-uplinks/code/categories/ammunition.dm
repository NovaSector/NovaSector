/datum/uplink_item/ammo/revolver_emp
	name = ".357 Haywire+ (EMP) speedloader"
	desc = "A speed loader that contains seven additional .357 Magnum Haywire+ rounds; usable with the Syndicate revolver. \
		For when you really need a lot of things dead and batteries drained."
	item = /obj/item/ammo_box/speedloader/c357/haywire
	cost = 5
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/ammo/milspec_buck
	name = "Milspec Buckshot Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded buckshot shells; usable with \
		any shotgun, from conventional pump-actions to semi-automatics. For those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/buckshot/milspec
	cost = 4
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/ammo/milspec_slugs
	name = "Milspec Slugs Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded slug shells; usable with \
		any shotgun, from conventional pump-actions to semi-automatics. For those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/milspec
	cost = 4
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS | UPLINK_SPY)

/datum/uplink_item/ammo/enforcer
	name = "Enforcer 10mm Magazine Case"
	desc = "A case containing three additional 12-round 10mm magazines, compatible with the Enforcer-TEN combat handgun, as well as \
		a large box of loose 10mm ammunition."
	item = /obj/item/storage/toolbox/guncase/traitor/ammunition
	cost = 3

/datum/uplink_item/ammo/enforcerap
	name = "Enforcer 10mm Armour Piercing Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/enforcer/ap
	cost = 3

/datum/uplink_item/ammo/enforcerhp
	name = "Enforcer 10mm Hollow Point Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			These rounds are more damaging but ineffective against armour."
	item = /obj/item/ammo_box/magazine/enforcer/hp
	cost = 4

/datum/uplink_item/ammo/enforcerfire
	name = "Enforcer 10mm Incendiary Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			Loaded with incendiary rounds which inflict little damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/enforcer/fire
	cost = 3
