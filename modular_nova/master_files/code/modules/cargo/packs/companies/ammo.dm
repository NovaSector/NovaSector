/datum/supply_pack/companies/mags_and_ammo
	group = "I - Magazines and Ammo"
	goody = TRUE
	express_lock = TRUE
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

//SolFed Mags

/datum/supply_pack/companies/mags_and_ammo
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/mags_and_ammo/c35_mag
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty)

/datum/supply_pack/companies/mags_and_ammo/c35_extended
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty)

/datum/supply_pack/companies/mags_and_ammo/c585_mag
	contains = list(/obj/item/ammo_box/magazine/c585trappiste_pistol/spawns_empty)

/datum/supply_pack/companies/mags_and_ammo/sol_rifle_short
	contains = list(/obj/item/ammo_box/magazine/c40sol_rifle/starts_empty)

/datum/supply_pack/companies/mags_and_ammo/br38
	contains = list(/obj/item/ammo_box/magazine/m38/empty)

/datum/supply_pack/companies/mags_and_ammo/kineticballs
	contains = list(/obj/item/ammo_box/magazine/kineticballs/starts_empty)

/datum/supply_pack/companies/mags_and_ammo/kineticballsbig
	contains = list(/obj/item/ammo_box/magazine/kineticballsbig/starts_empty)

/datum/supply_pack/companies/mags_and_ammo/sol_rifle_standard
	contains = list(/obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/companies/mags_and_ammo/sol_grenade_standard
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/starts_empty)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/companies/mags_and_ammo/sol_grenade_drum
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/companies/mags_and_ammo/jager_shotgun_regular
	contains = list(/obj/item/ammo_box/magazine/jager/empty)

/datum/supply_pack/companies/mags_and_ammo/jager_shotgun_Large
	contains = list(/obj/item/ammo_box/magazine/jager/large/empty)
	cost = PAYCHECK_CREW * 3

//NRI Mags
/datum/supply_pack/companies/mags_and_ammo/nri_surplus/
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/plasma_battery
	contains = list(/obj/item/ammo_box/magazine/recharge/plasma_battery)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/zaibas
	contains = list(/obj/item/ammo_box/magazine/pulse/spawns_empty)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/zashch
	contains = list(/obj/item/ammo_box/magazine/zashch/spawns_empty)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/miecz
	contains = list(/obj/item/ammo_box/magazine/miecz/spawns_empty)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/napad
	contains = list(/obj/item/ammo_box/magazine/napad/spawns_empty)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/sakhno
	contains = list(/obj/item/ammo_box/speedloader/strilka310)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/lanca
	contains = list(/obj/item/ammo_box/magazine/lanca/spawns_empty)

/datum/supply_pack/companies/mags_and_ammo/nri_surplus/amr_magazine
	contains = list(/obj/item/ammo_box/magazine/wylom)
	cost = PAYCHECK_CREW * 3

// Ammo bench and the lethals disk

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench/bench_itself
	contains = list(/obj/item/flatpack/ammo_workbench)
	cost = PAYCHECK_COMMAND * 2

// basic disk
/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench/ammo_disk
	contains = list(/obj/item/ammo_workbench_module/lethal)
	cost = PAYCHECK_COMMAND * 3

// disk but with the bits needed for EMP/fire bullets
/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench/ammo_disk/lethal_gimmick
	contains = list(/obj/item/ammo_workbench_module/lethal_gimmick)
	cost = PAYCHECK_COMMAND * 5

// disk but it's got HP/AP
/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench/ammo_disk/variant
	contains = list(/obj/item/ammo_workbench_module/lethal_variant)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_bench/bullet_drive
	contains = list(/obj/item/flatpack/bullet_drive)
	cost = PAYCHECK_COMMAND * 2

// Boxes of non-shotgun ammo

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/peacekeeper_lethal
	contains = list(/obj/item/ammo_box/c9mm)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/peacekeeper_hp
	contains = list(/obj/item/ammo_box/c9mm/hp)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/peacekeeper_ap
	contains = list(/obj/item/ammo_box/c9mm/ap)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/peacekeeper_rubber
	contains = list(/obj/item/ammo_box/c9mm/rubber)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/auto10mm_lethal
	contains = list(/obj/item/ammo_box/c10mm)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/auto10mm_hp
	contains = list(/obj/item/ammo_box/c10mm/hp)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/auto10mm_ap
	contains = list(/obj/item/ammo_box/c10mm/ap)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/auto10mm_rubber
	contains = list(/obj/item/ammo_box/c10mm/rubber)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/zaibas_ammo
	contains = list(/obj/item/ammo_box/pulse_cargo_box)
	//It's like, a lot of ammo compared to other packages; high-capacity universal ammo for all pulse plasma guns.
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/strilka_lethal
	contains = list(/obj/item/ammo_box/c310_cargo_box)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/strilka_rubber
	contains = list(/obj/item/ammo_box/c310_cargo_box/rubber)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/strilka_ap
	contains = list(/obj/item/ammo_box/c310_cargo_box/piercing)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/cesarzowa_lethal
	contains = list(/obj/item/ammo_box/c27_54cesarzowa)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/cesarzowa_rubber
	contains = list(/obj/item/ammo_box/c27_54cesarzowa/rubber)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol35
	contains = list(/obj/item/ammo_box/c35sol)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol35_disabler
	contains = list(/obj/item/ammo_box/c35sol/incapacitator)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol35_ripper
	contains = list(/obj/item/ammo_box/c35sol/ripper)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol40
	contains = list(/obj/item/ammo_box/c40sol)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol40_disabler
	contains = list(/obj/item/ammo_box/c40sol/fragmentation)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol40_flame
	contains = list(/obj/item/ammo_box/c40sol/incendiary)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/sol40_pierce
	contains = list(/obj/item/ammo_box/c40sol/pierce)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/trappiste585
	contains = list(/obj/item/ammo_box/c585trappiste)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/trappiste585_disabler
	contains = list(/obj/item/ammo_box/c585trappiste/incapacitator)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/trappiste585_incendiary
	contains = list(/obj/item/ammo_box/c585trappiste/incendiary)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/ammo_boxes/kineticballs
	contains = list(/obj/item/ammo_box/advanced/kineticballs)

// Revolver speedloaders

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader/detective_lethal
	contains = list(/obj/item/ammo_box/speedloader/c38)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader/detective_dumdum
	contains = list(/obj/item/ammo_box/speedloader/c38/dumdum)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader/detective_bouncy
	contains = list(/obj/item/ammo_box/speedloader/c38/match)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader/c35sol
	contains = list(/obj/item/ammo_box/speedloader/c35sol)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/speedloader/c585trappiste
	contains = list(/obj/item/ammo_box/speedloader/c585trappiste)

// Shotgun boxes

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/slugs
	contains = list(/obj/item/ammo_box/advanced/s12gauge)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/buckshot
	contains = list(/obj/item/ammo_box/advanced/s12gauge/buckshot)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/beanbag_slugs
	contains = list(/obj/item/ammo_box/advanced/s12gauge/bean)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/rubbershot
	contains = list(/obj/item/ammo_box/advanced/s12gauge/rubber)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/magnum_buckshot
	contains = list(/obj/item/ammo_box/advanced/s12gauge/magnum)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/express_buckshot
	contains = list(/obj/item/ammo_box/advanced/s12gauge/express)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/hunter_slug
	contains = list(/obj/item/ammo_box/advanced/s12gauge/hunter)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/flechettes
	contains = list(/obj/item/ammo_box/advanced/s12gauge/flechette)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/hornet_nest
	contains = list(/obj/item/ammo_box/advanced/s12gauge/beehive)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/lighting
	contains = list(/obj/item/ammo_box/advanced/s12gauge/antitide)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/shot_shells/confetti
	contains = list(/obj/item/ammo_box/advanced/s12gauge/honkshot)

// Boxes of kiboko launcher ammo

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells
	cost = PAYCHECK_COMMAND

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/practice
	contains = list(/obj/item/ammo_box/c980grenade)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/smoke
	contains = list(/obj/item/ammo_box/c980grenade/smoke)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/riot
	contains = list(/obj/item/ammo_box/c980grenade/riot)

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/shrapnel
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel)
	access = ACCESS_WEAPONS

/datum/supply_pack/companies/mags_and_ammo/vitezstvi/grenade_shells/phosphor
	contains = list(/obj/item/ammo_box/c980grenade/shrapnel/phosphor)
	access = ACCESS_WEAPONS
