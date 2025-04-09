/datum/uplink_item/ammo/revolver_emp
	name = ".357 Haywire+ (EMP) speedloader"
	desc = "A speed loader that contains seven additional .357 Magnum Haywire+ rounds; usable with the Syndicate revolver. \
		For when you really need a lot of things dead and batteries drained."
	item = /obj/item/ammo_box/a357/haywire
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
