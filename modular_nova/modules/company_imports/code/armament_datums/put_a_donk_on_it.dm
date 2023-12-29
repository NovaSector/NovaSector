/datum/armament_entry/company_import/donk
	category = DONK_CO_NAME
	company_bitflag = CARGO_COMPANY_DONK

///Donk Co food - EAT DONK
/datum/armament_entry/company_import/donk/food
	subcategory = "Microwave Foods"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/donk/food/pockets
	item_type = /obj/item/storage/box/donkpockets

/datum/armament_entry/company_import/donk/food/dank_pockets
	item_type = /obj/item/storage/box/donkpockets/nova/donkpocketdank
	contraband = TRUE

/datum/armament_entry/company_import/donk/food/caffe_pockets
	item_type = /obj/item/storage/box/donkpockets/nova/donkpocketcaffe

/datum/armament_entry/company_import/donk/food/berry_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketberry

/datum/armament_entry/company_import/donk/food/honk_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpockethonk

/datum/armament_entry/company_import/donk/food/pizza_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketpizza

/datum/armament_entry/company_import/donk/food/spicy_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketspicy

/datum/armament_entry/company_import/donk/food/teriyaki_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketteriyaki

/datum/armament_entry/company_import/donk/food/ready_donk
	item_type = /obj/item/food/ready_donk

/datum/armament_entry/company_import/donk/food/ready_donkhiladas
	item_type = /obj/item/food/ready_donk/donkhiladas

/datum/armament_entry/company_import/donk/food/ready_donk_n_cheese
	item_type = /obj/item/food/ready_donk/mac_n_cheese

///Donksoft
/datum/armament_entry/company_import/donk/foamforce
	subcategory = "Foam Force (TM) Blasters"

/datum/armament_entry/company_import/donk/foamforce/foam_pistol
	item_type = /obj/item/gun/ballistic/automatic/pistol/toy
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/donk/foamforce/foam_shotgun
	item_type = /obj/item/gun/ballistic/shotgun/toy/unrestricted
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/donk/foamforce/foam_smg
	item_type = /obj/item/gun/ballistic/automatic/toy/unrestricted
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/donk/foamforce/foam_c20
	item_type = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted
	cost = PAYCHECK_COMMAND * 3

/datum/armament_entry/company_import/donk/foamforce/foam_lmg
	item_type = /obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted
	cost = PAYCHECK_COMMAND * 5

///Donksoft Ammunition
/datum/armament_entry/company_import/donk/foamforce_ammo
	subcategory = "Foam Force (TM) Dart Accessories"
	cost = PAYCHECK_CREW

/datum/armament_entry/company_import/donk/foamforce_ammo/darts
	item_type = /obj/item/ammo_box/foambox
	cost = PAYCHECK_LOWER

/datum/armament_entry/company_import/donk/foamforce_ammo/riot_darts
	item_type = /obj/item/ammo_box/foambox/riot
	cost = PAYCHECK_COMMAND * 1.5

/datum/armament_entry/company_import/donk/foamforce_ammo/pistol_mag
	item_type = /obj/item/ammo_box/magazine/toy/pistol

/datum/armament_entry/company_import/donk/foamforce_ammo/smg_mag
	item_type = /obj/item/ammo_box/magazine/toy/smg

/datum/armament_entry/company_import/donk/foamforce_ammo/smgm45_mag
	item_type = /obj/item/ammo_box/magazine/toy/smgm45

/datum/armament_entry/company_import/donk/foamforce_ammo/m762_mag
	item_type = /obj/item/ammo_box/magazine/toy/m762

///Donksoft MOD modules
/datum/armament_entry/company_import/donk/mod_modules
	subcategory = "Donk Co. MOD modules"
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/donk/mod_modules/dart_collector_safe
	item_type = /obj/item/mod/module/recycler/donk/safe
	cost = PAYCHECK_COMMAND

/datum/armament_entry/company_import/donk/mod_modules/dart_collector
	item_type = /obj/item/mod/module/recycler/donk
	cost = PAYCHECK_COMMAND * 4
