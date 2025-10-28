/datum/supply_pack/companies/ballistics
	access = ACCESS_WEAPONS
	group = "I - Ballistic Weapons"
	goody = TRUE
	express_lock = TRUE
	crate_type = null
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE

// Sol Fed Weapons
/datum/supply_pack/companies/ballistics/solfed

/datum/supply_pack/companies/ballistics/solfed/sidearm
	cost = PAYCHECK_COMMAND * 4

/datum/supply_pack/companies/ballistics/solfed/sidearm/eland
	contains =list(/obj/item/gun/ballistic/revolver/sol)

/datum/supply_pack/companies/ballistics/solfed/sidearm/wespe
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol)

/datum/supply_pack/companies/ballistics/solfed/sidearm/type207
	contains = list(/obj/item/gun/ballistic/automatic/pistol/type207)

/datum/supply_pack/companies/ballistics/solfed/sidearm/skild
	contains = list(/obj/item/gun/ballistic/automatic/pistol/trappiste)
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/ballistics/solfed/sidearm/takbok
	contains = list(/obj/item/gun/ballistic/revolver/takbok)
	cost = PAYCHECK_COMMAND * 6

// Lethal anything that's not a pistol, requires high company interest

/datum/supply_pack/companies/ballistics/solfed/longarm
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/ballistics/solfed/longarm/renoster
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol)

/datum/supply_pack/companies/ballistics/solfed/longarm/sindano
	contains = list(/obj/item/gun/ballistic/automatic/sol_smg)

/datum/supply_pack/companies/ballistics/solfed/longarm/type213
	contains = list(/obj/item/gun/ballistic/automatic/type213)

/datum/supply_pack/companies/ballistics/solfed/longarm/br38
	contains = list(/obj/item/gun/ballistic/automatic/battle_rifle)
	cost = PAYCHECK_COMMAND * 8

/datum/supply_pack/companies/ballistics/solfed/longarm/elite
	contains = list(/obj/item/gun/ballistic/automatic/sol_classic/marksman)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/solfed/longarm/bogseo
	contains = list(/obj/item/gun/ballistic/automatic/xhihao_smg)
	cost = PAYCHECK_COMMAND * 10

/datum/supply_pack/companies/ballistics/solfed/longarm/jager
	contains = list(/obj/item/gun/ballistic/shotgun/katyusha/jager)
	cost = PAYCHECK_COMMAND * 16

/datum/supply_pack/companies/ballistics/solfed/longarm/infanterie
	contains = list(/obj/item/gun/ballistic/automatic/sol_classic)
	cost = PAYCHECK_COMMAND * 14

/* //
/datum/supply_pack/companies/ballistics/solfed/longarm/outomaties
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/machinegun)
	cost = PAYCHECK_COMMAND * 23
*/ //Commented out due to a severe lack of balance regarding it.

/datum/supply_pack/companies/ballistics/solfed/longarm/kiboko
	contains = list(/obj/item/gun/ballistic/automatic/sol_grenade_launcher)
	cost = PAYCHECK_COMMAND * 46

/datum/supply_pack/companies/ballistics/solfed/magazines
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/ballistics/solfed/magazines/c35_mag
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/c35_extended
	contains = list(/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/c585_mag
	contains = list(/obj/item/ammo_box/magazine/c585trappiste_pistol/spawns_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/sol_rifle_short
	contains = list(/obj/item/ammo_box/magazine/c40sol_rifle/starts_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/br38
	contains = list(/obj/item/ammo_box/magazine/m38/empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/kineticballs
	contains = list(/obj/item/ammo_box/magazine/kineticballs/starts_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/kineticballsbig
	contains = list(/obj/item/ammo_box/magazine/kineticballsbig/starts_empty)

/datum/supply_pack/companies/ballistics/solfed/magazines/sol_rifle_standard
	contains = list(/obj/item/ammo_box/magazine/c40sol_rifle/standard/starts_empty)
	cost = PAYCHECK_COMMAND

/datum/supply_pack/companies/ballistics/solfed/magazines/sol_grenade_standard
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/starts_empty)
	cost = PAYCHECK_COMMAND * 2

/datum/supply_pack/companies/ballistics/solfed/magazines/sol_grenade_drum
	contains = list(/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty)
	cost = PAYCHECK_CREW * 3

/datum/supply_pack/companies/ballistics/solfed/magazines/jager_shotgun_regular
	contains = list(/obj/item/ammo_box/magazine/jager/empty)
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/ballistics/solfed/magazines/jager_shotgun_Large
	contains = list(/obj/item/ammo_box/magazine/jager/large/empty)
	cost = PAYCHECK_CREW * 3

// NRI Weapons

/datum/supply_pack/companies/ballistics/nri_surplus/firearm
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/shotgun_revolver
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/zashch
	contains = list(/obj/item/gun/ballistic/automatic/pistol/zashch)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/miecz
	contains = list(/obj/item/gun/ballistic/automatic/miecz)
	cost = PAYCHECK_COMMAND * 10

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/zaibas
	contains = list(/obj/item/gun/ballistic/automatic/pulse_rifle)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/napad
	contains = list(/obj/item/gun/ballistic/automatic/napad)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/sakhno_rifle
	contains = list(/obj/item/gun/ballistic/rifle/boltaction)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/lanca
	contains = list(/obj/item/gun/ballistic/automatic/lanca)
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/zaibas_a
	contains = list(/obj/item/gun/ballistic/rifle/pulse_sniper)
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/companies/ballistics/nri_surplus/firearm/anti_materiel_rifle
	contains = list(/obj/item/gun/ballistic/automatic/wylom)
	cost = PAYCHECK_COMMAND * 16

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo
	cost = PAYCHECK_CREW

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/zashch
	contains = list(/obj/item/ammo_box/magazine/zashch/spawns_empty)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/miecz
	contains = list(/obj/item/ammo_box/magazine/miecz/spawns_empty)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/zaibas
	contains = list(/obj/item/ammo_box/magazine/pulse/spawns_empty)
	cost = PAYCHECK_CREW * 2

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/napad
	contains = list(/obj/item/ammo_box/magazine/napad/spawns_empty)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/sakhno
	contains = list(/obj/item/ammo_box/speedloader/strilka310)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/lanca
	contains = list(/obj/item/ammo_box/magazine/lanca/spawns_empty)

/datum/supply_pack/companies/ballistics/nri_surplus/firearm_ammo/amr_magazine
	contains = list(/obj/item/ammo_box/magazine/wylom)
	cost = PAYCHECK_CREW * 3
