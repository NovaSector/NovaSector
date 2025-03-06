/datum/armament_entry/company_import/syndicate
	category = SYNDICATE_CONGLOMERATE_NAME
	company_bitflag = INDEPENDENT_SYNDICATE_CONGLOMERATE

/// This is a list of the syndicate items that are permitted for DS-2

// Syndicate attire (Suspicious wears)
/datum/armament_entry/company_import/syndicate/clothing
	subcategory = "Clothing"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/syndicate/clothing/peacekeeper
	item_type = /obj/item/clothing/under/sol_peacekeeper

/datum/armament_entry/company_import/syndicate/clothing/noslips
	item_type = /obj/item/clothing/shoes/chameleon/noslip

// Syndicate Weapons (conspicuous and non conspicuous)
/datum/armament_entry/company_import/syndicate/guns
	subcategory = "Guns"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/syndicate/guns/donksoft
	item_type = /obj/item/storage/toolbox/guncase/traitor/donksoft

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/guns/clandestine
	item_type = /obj/item/storage/toolbox/guncase/clandestine

/datum/armament_entry/company_import/syndicate/guns/cr20
	item_type = /datum/uplink_item/weapon_kits/medium_cost/smg

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/guns/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/ammo
	subcategory = "Ammunition"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/syndicate/ammo/m12gregular
	item_type = /obj/item/ammo_box/magazine/m12g

/datum/armament_entry/company_import/syndicate/ammo/m12slug
	item_type = /obj/item/ammo_box/magazine/m12g/slug

/datum/armament_entry/company_import/syndicate/ammo/m12dragon
	item_type = /obj/item/ammo_box/magazine/m12g/dragon

/datum/armament_entry/company_import/syndicate/ammo/m12meteor
	item_type = /obj/item/ammo_box/magazine/m12g/meteor

/datum/armament_entry/company_import/syndicate/ammo/m10regular
	item_type = /obj/item/ammo_box/magazine/m10mm

/datum/armament_entry/company_import/syndicate/ammo/m10armor
	item_type = /obj/item/ammo_box/magazine/m10mm/ap

/datum/armament_entry/company_import/syndicate/ammo/m10hollow
	item_type = /obj/item/ammo_box/magazine/m10mm/hp

/datum/armament_entry/company_import/syndicate/ammo/m10fire
	item_type = /obj/item/ammo_box/magazine/m10mm/fire

/datum/armament_entry/company_import/syndicate/ammo/smg45
	item_type = /obj/item/ammo_box/magazine/smgm45

/datum/armament_entry/company_import/syndicate/ammo/smg45ap
	item_type = /obj/item/ammo_box/magazine/smgm45/ap

/datum/armament_entry/company_import/syndicate/ammo/smg45hp
	item_type = /obj/item/ammo_box/magazine/smgm45/hp

/datum/armament_entry/company_import/syndicate/ammo/smg45fire
	item_type = /obj/item/ammo_box/magazine/smgm45/incen

/datum/armament_entry/company_import/syndicate/misc
	subcategory = "miscellanieous"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/misc/soap
	item_type = /obj/item/soap/syndie

/datum/armament_entry/company_import/syndicate/misc/surgery
	item_type = /obj/item/storage/backpack/duffelbag/syndie/surgery

/datum/armament_entry/company_import/syndicate/misc/tome
	item_type = /obj/item/book/bible/syndicate

/datum/armament_entry/company_import/syndicate/misc/goggles
	item_type = /obj/item/clothing/glasses/thermal/syndi

/datum/armament_entry/company_import/syndicate/misc/cutout
	item_type = /obj/item/storage/box/syndie_kit/cutouts

/datum/armament_entry/company_import/syndicate/misc/teleporter
	item_type = /obj/item/storage/box/syndie_kit/syndicate_teleporter

/datum/armament_entry/company_import/syndicate/misc/doorjack
	item_type = /obj/item/card/emag/doorjack

/datum/armament_entry/company_import/syndicate/misc/dafuckindisk
	item_type = /obj/item/disk/nuclear/fake

/datum/armament_entry/company_import/syndicate/misc/toolbox
	item_type = /obj/item/storage/toolbox/syndicate

/datum/armament_entry/company_import/syndicate/misc/emag
	item_type = /obj/item/card/emag

/datum/armament_entry/company_import/syndicate/misc/tape
	item_type = /obj/item/stack/sticky_tape/pointy/super

/datum/armament_entry/company_import/syndicate/misc/rope
	item_type = /obj/item/climbing_hook/syndicate






// Syndicate spacetide gear
/datum/armament_entry/company_import/syndicate/space
	subcategory = "Space Gear"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/space/modsuit
	item_type = /obj/item/mod/control/pre_equipped/traitor
	cost = PAYCHECK_COMMAND * 50

/datum/armament_entry/company_import/syndicate/space/spacesuit
	item_type = /obj/item/storage/box/syndie_kit/space
	cost = PAYCHECK_COMMAND * 20


// Modsuit mods that CAN be found in the uplinks
/datum/armament_entry/company_import/syndicate/mods
	subcategory = "Modsuit Mods"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/mods/energyshield
	item_type = /obj/item/mod/module/energy_shield

/datum/armament_entry/company_import/syndicate/mods/empshield
	item_type = /obj/item/mod/module/emp_shield/advanced

/datum/armament_entry/company_import/syndicate/mods/injector
	item_type = /obj/item/mod/module/injector

/datum/armament_entry/company_import/syndicate/mods/medbeam
	item_type = /obj/item/mod/module/medbeam

