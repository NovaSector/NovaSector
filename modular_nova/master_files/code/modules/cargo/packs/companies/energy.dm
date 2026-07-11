/datum/supply_pack/companies/energy
	group = "★ Energy Weapons"
	access = ACCESS_WEAPONS
	access_view = ACCESS_WEAPONS
	express_lock = TRUE
	order_flags = ORDER_GOODY
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

//Microstar weapons
/datum/supply_pack/companies/energy/microstar

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons
	cost = CARGO_CRATE_VALUE * 1.25
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/disabler
	contains = list(/obj/item/gun/energy/disabler)

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/advtaser
	contains = list(/obj/item/gun/energy/e_gun/advtaser)
	cost = CARGO_CRATE_VALUE * 1.75

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/disabler_smg
	contains = list(/obj/item/gun/energy/disabler/smg)
	cost = CARGO_CRATE_VALUE * 1.75
	access = ACCESS_WEAPONS
	access_view = ACCESS_WEAPONS
	express_lock = TRUE
	order_flags = ORDER_GOODY

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/mini_egun
	contains = list(/obj/item/gun/energy/e_gun/mini)

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/laser_pistol
	contains = list(/obj/item/gun/energy/laser/pistol)

/datum/supply_pack/companies/energy/microstar/basic_energy_weapons/energy_holster
	contains = list(/obj/item/storage/belt/holster/energy/thermal)
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/laser
	contains = list(/obj/item/gun/energy/laser)
	cost = CARGO_CRATE_VALUE * 1.25
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/laser/soul
	contains = list(/obj/item/gun/energy/laser/soul)

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/laser_carbine
	contains = list(/obj/item/gun/energy/laser/carbine)
	cost = CARGO_CRATE_VALUE * 1.75

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/laser_assault
	contains = list(/obj/item/gun/energy/laser/assault)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/egun
	contains = list(/obj/item/gun/energy/e_gun)
	cost = CARGO_CRATE_VALUE * 2
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/mod_laser_small
	contains = list(/obj/item/gun/energy/modular_laser_rifle/carbine)
	cost = CARGO_CRATE_VALUE * 2.5
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/microstar/basic_energy_long_weapons/mod_laser_large
	contains = list(/obj/item/gun/energy/modular_laser_rifle)
	cost = CARGO_CRATE_VALUE * 4

/datum/supply_pack/companies/energy/microstar/experimental_energy
	cost = CARGO_CRATE_VALUE * 3

/datum/supply_pack/companies/energy/microstar/experimental_energy/ion_carbine
	contains = list(/obj/item/gun/energy/ionrifle/carbine)

// HC Weapons
/datum/supply_pack/companies/energy/hc_surplus

/datum/supply_pack/companies/energy/hc_surplus/plasma_thrower
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_thrower)

/datum/supply_pack/companies/energy/hc_surplus/plasma_marksman
	contains = list(/obj/item/gun/ballistic/automatic/pistol/plasma_marksman)
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/hc_surplus/crank_taser
	contains = list(/obj/item/gun/energy/taser/crank)
	cost = CARGO_CRATE_VALUE * 2
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/hc_surplus/stun_gun //Not a gun but it's only fair to place similar items close to each other
	contains = list(/obj/item/melee/baton/security/stun_gun/loaded)
	cost = CARGO_CRATE_VALUE * 1.5 //Similarly live action roleplay'iy stun baton lite
	access = FALSE
	access_view = FALSE
	express_lock = FALSE
	order_flags = ORDER_COMPANY

/datum/supply_pack/companies/energy/hc_surplus/zaibas
	contains = list(/obj/item/gun/ballistic/automatic/pulse_rifle)
	cost = CARGO_CRATE_VALUE * 6

/datum/supply_pack/companies/energy/hc_surplus/zaibas_a
	contains = list(/obj/item/gun/ballistic/rifle/pulse_sniper)
	cost = CARGO_CRATE_VALUE * 7
