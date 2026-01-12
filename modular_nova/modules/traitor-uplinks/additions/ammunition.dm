// LOW COST
/datum/uplink_item/ammo/enforcer
	name = "Enforcer 10mm Magazine Case"
	desc = "A case containing three additional 12-round 10mm magazines, compatible with the Enforcer-TEN combat handgun, as well as \
			a large box of loose 10mm ammunition."
	item = /obj/item/ammo_box/magazine/enforcer
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/enforcerap
	name = "Enforcer 10mm Armour Piercing Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/enforcer/ap
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/enforcerhp
	name = "Enforcer 10mm Hollow Point Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			These rounds are more damaging but ineffective against armour."
	item = /obj/item/ammo_box/magazine/enforcer/hp
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/enforcerfire
	name = "Enforcer 10mm Incendiary Magazine"
	desc = "An additional 12-round 10mm magazine, compatible with the Enforcer-TEN handgun. \
			Loaded with incendiary rounds which inflict little damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/enforcer/fire
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/slug_shells
	name = "Slug Twelve-Gauge Box"
	desc = "A standard-sized box of slug shells."
	item = /obj/item/ammo_box/advanced/s12gauge
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/buckshot_shells
	name = "Buckshot Twelve-Gauge Box"
	desc = "A standard-sized box of buckshot shells."
	item = /obj/item/ammo_box/advanced/s12gauge/buckshot
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/flechette_shells
	name = "Flechette Twelve-Gauge Box"
	desc = "A standard-sized box of flechette shells."
	item = /obj/item/ammo_box/advanced/s12gauge/flechette
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/incendiary_shells
	name = "Incendiary Twelve-Gauge Box"
	desc = "A standard-sized box of incendiary shells."
	item = /obj/item/ammo_box/advanced/s12gauge/incendiary
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/m10mm
	name = "10mm Handgun Magazine (Ansem)"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol."
	item = /obj/item/ammo_box/magazine/m10mm
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/m10mm_app
	name = "10mm Armour Piercing Magazine (Ansem)"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
		These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/m10mm/ap
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/m10mm_hp
	name = "10mm Hollow Point Magazine (Ansem)"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
		These rounds are more damaging but ineffective against armour."
	item = /obj/item/ammo_box/magazine/m10mm/hp
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/m10mm_incendiary
	name = "10mm Incendiary Magazine (Ansem)"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
		Loaded with incendiary rounds which inflict less damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/m10mm/fire
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/ammo_pouch
	name = "Ammo Pouch"
	desc = "A small yet large enough pouch that can fit in your pocket, and has room for three magazines."
	item = /obj/item/storage/pouch/ammo
	cost = 1
	uplink_item_flags = NONE
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// MEDIUM COST
/datum/uplink_item/ammo/smg
	name = ".45 SMG Magazine (C-20r)"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun."
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS
	item = /obj/item/ammo_box/magazine/smgm45

/datum/uplink_item/ammo/smg_ap
	name = ".45 Armor Piercing SMG Magazine (C-20r)"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			These rounds are less effective at injuring the target but penetrate protective gear."
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS
	item = /obj/item/ammo_box/magazine/smgm45/ap

/datum/uplink_item/ammo/smg_hp
	name = ".45 Hollow Point SMG Magazine (C-20r)"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			These rounds are more damaging but ineffective against armour."
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS
	item = /obj/item/ammo_box/magazine/smgm45/hp

/datum/uplink_item/ammo/smg_incen
	name = ".45 Incendiary SMG Magazine (C-20r)"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			Loaded with incendiary rounds which inflict little damage, but ignite the target."
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS
	item = /obj/item/ammo_box/magazine/smgm45/incen

/datum/uplink_item/ammo/milspec_buck
	name = "Milspec Buckshot Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded buckshot shells; usable with \
			any shotgun, from conventional pump-actions to semi-automatics. For those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/buckshot/milspec
	cost = /datum/uplink_item/medium_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/milspec_slugs
	name = "Milspec Slugs Box"
	desc = "A standard-sized box of 15 Scarborough-manufactured, hot-loaded slug shells; usable with \
			any shotgun, from conventional pump-actions to semi-automatics. For those with a penchant for grievous bodily harm."
	item = /obj/item/ammo_box/advanced/s12gauge/milspec
	cost = /datum/uplink_item/medium_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS


// HIGH COST
/datum/uplink_item/ammo/breacher_shells
	name = "Breacher Twelve-Gauge Box"
	desc = "A stack of twelve of breacher shells, superb at destroying any structures in your way."
	item = /obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/breacher
	cost = /datum/uplink_item/low_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS

/datum/uplink_item/ammo/revolver_emp
	name = ".357 Haywire+ (EMP) speedloader"
	desc = "A speed loader that contains seven additional .357 Magnum Haywire+ rounds; usable with the Syndicate revolver. \
			For when you really need a lot of things dead and batteries drained."
	item = /obj/item/ammo_box/speedloader/c357/haywire
	cost = /datum/uplink_item/high_cost/ammunition::cost
	purchasable_from = UPLINK_TRAITORS | UPLINK_SERIOUS_OPS
