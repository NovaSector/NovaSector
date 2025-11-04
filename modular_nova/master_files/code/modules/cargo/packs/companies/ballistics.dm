/datum/supply_pack/companies/ballistics
	access = ACCESS_WEAPONS
	group = "I - Ballistic Weapons"
	goody = TRUE
	express_lock = TRUE
	departamental_goody = FALSE
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

// NRI Weapons

/datum/supply_pack/companies/ballistics/nri_surplus
	cost = PAYCHECK_COMMAND * 6

/datum/supply_pack/companies/ballistics/nri_surplus/shotgun_revolver
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver)

/datum/supply_pack/companies/ballistics/nri_surplus/zashch
	contains = list(/obj/item/gun/ballistic/automatic/pistol/zashch)

/datum/supply_pack/companies/ballistics/nri_surplus/miecz
	contains = list(/obj/item/gun/ballistic/automatic/miecz)
	cost = PAYCHECK_COMMAND * 10

/datum/supply_pack/companies/ballistics/nri_surplus/napad
	contains = list(/obj/item/gun/ballistic/automatic/napad)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/nri_surplus/sakhno_rifle
	contains = list(/obj/item/gun/ballistic/rifle/boltaction)
	cost = PAYCHECK_COMMAND * 12

/datum/supply_pack/companies/ballistics/nri_surplus/lanca
	contains = list(/obj/item/gun/ballistic/automatic/lanca)
	cost = PAYCHECK_COMMAND * 14

/datum/supply_pack/companies/ballistics/nri_surplus/anti_materiel_rifle
	contains = list(/obj/item/gun/ballistic/automatic/wylom)
	cost = PAYCHECK_COMMAND * 16
