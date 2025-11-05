/datum/supply_pack/companies/ballistics
	group = "I - Ballistic Weapons"
	access = ACCESS_WEAPONS
	access_view = ACCESS_WEAPONS
	express_lock = TRUE
	departamental_goody = FALSE
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

// Sol Fed Weapons
/datum/supply_pack/companies/ballistics/sol_fed

/datum/supply_pack/companies/ballistics/sol_fed/sidearm
	cost = CARGO_CRATE_VALUE * 2
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	departamental_goody = TRUE

/datum/supply_pack/companies/ballistics/sol_fed/sidearm/eland
	contains =list(/obj/item/gun/ballistic/revolver/sol)

/datum/supply_pack/companies/ballistics/sol_fed/sidearm/wespe
	contains = list(/obj/item/gun/ballistic/automatic/pistol/sol)

/datum/supply_pack/companies/ballistics/sol_fed/sidearm/type207
	contains = list(/obj/item/gun/ballistic/automatic/pistol/type207)

/datum/supply_pack/companies/ballistics/sol_fed/sidearm/skild
	contains = list(/obj/item/gun/ballistic/automatic/pistol/trappiste)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/ballistics/sol_fed/sidearm/takbok
	contains = list(/obj/item/gun/ballistic/revolver/takbok)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/ballistics/sol_fed/longarm
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/ballistics/sol_fed/longarm/renoster
	contains = list(/obj/item/gun/ballistic/shotgun/riot/sol)

/datum/supply_pack/companies/ballistics/sol_fed/longarm/sindano
	contains = list(/obj/item/gun/ballistic/automatic/sol_smg)

/datum/supply_pack/companies/ballistics/sol_fed/longarm/type213
	contains = list(/obj/item/gun/ballistic/automatic/type213)

/datum/supply_pack/companies/ballistics/sol_fed/longarm/br38
	contains = list(/obj/item/gun/ballistic/automatic/battle_rifle)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/ballistics/sol_fed/longarm/elite
	contains = list(/obj/item/gun/ballistic/automatic/sol_classic/marksman)
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/companies/ballistics/sol_fed/longarm/bogseo
	contains = list(/obj/item/gun/ballistic/automatic/xhihao_smg)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/ballistics/sol_fed/longarm/jager
	contains = list(/obj/item/gun/ballistic/shotgun/katyusha/jager)
	cost = CARGO_CRATE_VALUE *8

/datum/supply_pack/companies/ballistics/sol_fed/longarm/infanterie
	contains = list(/obj/item/gun/ballistic/automatic/sol_classic)
	cost = CARGO_CRATE_VALUE * 7

/* //
/datum/supply_pack/companies/ballistics/sol_fed/longarm/outomaties
	contains = list(/obj/item/gun/ballistic/automatic/sol_rifle/machinegun)
	cost = CARGO_CRATE_VALUE * 11.5
*/ //Commented out due to a severe lack of balance regarding it.

/datum/supply_pack/companies/ballistics/sol_fed/longarm/kiboko
	contains = list(/obj/item/gun/ballistic/automatic/sol_grenade_launcher)
	cost = CARGO_CRATE_VALUE * 23

// NRI Surplus

/datum/supply_pack/companies/ballistics/nri_surplus
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/ballistics/nri_surplus/shotgun_revolver
	contains = list(/obj/item/gun/ballistic/revolver/shotgun_revolver)
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	departamental_goody = TRUE

/datum/supply_pack/companies/ballistics/nri_surplus/zashch
	contains = list(/obj/item/gun/ballistic/automatic/pistol/zashch)
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	departamental_goody = TRUE

/datum/supply_pack/companies/ballistics/nri_surplus/miecz
	contains = list(/obj/item/gun/ballistic/automatic/miecz)
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/companies/ballistics/nri_surplus/napad
	contains = list(/obj/item/gun/ballistic/automatic/napad)
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/companies/ballistics/nri_surplus/sakhno_rifle
	contains = list(/obj/item/gun/ballistic/rifle/boltaction)
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/companies/ballistics/nri_surplus/lanca
	contains = list(/obj/item/gun/ballistic/automatic/lanca)
	cost = CARGO_CRATE_VALUE * 7

/datum/supply_pack/companies/ballistics/nri_surplus/anti_materiel_rifle
	contains = list(/obj/item/gun/ballistic/automatic/wylom)
	cost = CARGO_CRATE_VALUE * 8

// Donk

datum/supply_pack/companies/ballistics/donk
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	departamental_goody = TRUE
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

datum/supply_pack/companies/ballistics/donk/foam_pistol
	contains = list(/obj/item/gun/ballistic/automatic/pistol/toy)
	cost = CARGO_CRATE_VALUE * 0.5

datum/supply_pack/companies/ballistics/donk/foam_shotgun
	contains = list(/obj/item/gun/ballistic/shotgun/toy/riot)
	cost = CARGO_CRATE_VALUE * 0.5

datum/supply_pack/companies/ballistics/donk/foam_smg
	contains = list(/obj/item/gun/ballistic/automatic/toy)
	cost = CARGO_CRATE_VALUE * 1.5

datum/supply_pack/companies/ballistics/donk/foam_c20
	contains = list(/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted)
	cost = CARGO_CRATE_VALUE * 1.5

datum/supply_pack/companies/ballistics/donk/foam_turret
	contains = list(/obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled)
	cost = CARGO_CRATE_VALUE * 2

datum/supply_pack/companies/ballistics/donk/foam_lmg
	contains = list(/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted)
	cost = CARGO_CRATE_VALUE * 2.5
