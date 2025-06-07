/datum/armament_entry/company_import/syndicate
	category = SYNDICATE_NAME
	offstation = TRUE

/// This is a list of the syndicate items that are permitted for DS-2

// Syndicate attire (Suspicious wears)
/datum/armament_entry/company_import/syndicate/clothing
	subcategory = "Clothing"
	cost = PAYCHECK_CREW * 3

/datum/armament_entry/company_import/syndicate/clothing/noslips
	item_type = /obj/item/clothing/shoes/chameleon/noslip
	cost = PAYCHECK_CREW * 5

// Syndicate Weapons (conspicuous and non conspicuous)
/datum/armament_entry/company_import/syndicate/kits
	subcategory = "Kits"
	cost = PAYCHECK_COMMAND * 20

/datum/armament_entry/company_import/syndicate/kits/donksoft
	item_type = /obj/item/storage/toolbox/guncase/traitor/donksoft

/datum/armament_entry/company_import/syndicate/kits/shotgun
	item_type = /obj/item/storage/toolbox/guncase/bulldog

/datum/armament_entry/company_import/syndicate/kits/clandestine
	item_type = /obj/item/storage/toolbox/guncase/clandestine

/datum/armament_entry/company_import/syndicate/kits/cr20
	item_type = /obj/item/storage/toolbox/guncase/c20r

/datum/armament_entry/company_import/syndicate/kits/melee
	item_type = /obj/item/storage/toolbox/guncase/sword_and_board

/datum/armament_entry/company_import/syndicate/kits/revolver
	item_type = /obj/item/storage/toolbox/guncase/revolver

/datum/armament_entry/company_import/syndicate/kits/cyberimplants
	item_type = /obj/item/storage/box/cyber_implants

/datum/armament_entry/company_import/syndicate/kits/cowboy
	item_type = /obj/item/storage/box/syndie_kit/cowboy

/datum/armament_entry/company_import/syndicate/kits/sleepy
	item_type = /obj/item/storage/box/syndie_kit/sleepytime

/datum/armament_entry/company_import/syndicate/kits/games
	item_type = /obj/item/storage/backpack/duffelbag/syndie/des_two/gameskit

/datum/armament_entry/company_import/syndicate/kits/camo
	item_type = /obj/item/storage/box/syndie_kit/chameleon
/datum/armament_entry/company_import/syndicate/Weapons
	subcategory = "Weapons"
	cost = PAYCHECK_COMMAND * 5

/datum/armament_entry/company_import/syndicate/Weapons/esword
	item_type = /obj/item/melee/energy/sword

/datum/armament_entry/company_import/syndicate/Weapons/eshield
	item_type = /obj/item/shield/energy

/datum/armament_entry/company_import/syndicate/Weapons/shotgun
	item_type = /obj/item/gun/ballistic/shotgun/bulldog

/datum/armament_entry/company_import/syndicate/Weapons/flukie
	item_type = /obj/item/gun/ballistic/automatic/smartgun

/datum/armament_entry/company_import/syndicate/ammo
	subcategory = "Ammunition"
	cost = PAYCHECK_COMMAND * 2.5

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

/datum/armament_entry/company_import/syndicate/ammo/a357
	item_type = /obj/item/ammo_box/a357

/datum/armament_entry/company_import/syndicate/ammo/a357p
	item_type = /obj/item/ammo_box/a357/phasic

/datum/armament_entry/company_import/syndicate/ammo/a357h
	item_type = /obj/item/ammo_box/a357/heartseeker

/datum/armament_entry/company_import/syndicate/ammo/flukie
	item_type = /obj/item/ammo_box/magazine/smartgun

/datum/armament_entry/company_import/syndicate/implants
	subcategory = "Implants"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/implants/reviver
	item_type = /obj/item/autosurgeon/syndicate/reviver/des_two

/datum/armament_entry/company_import/syndicate/implants/thermal
	item_type = /obj/item/autosurgeon/syndicate/thermal_eyes/des_two

/datum/armament_entry/company_import/syndicate/implants/xray
	item_type = /obj/item/autosurgeon/syndicate/xray_eyes/des_two
	cost = PAYCHECK_COMMAND * 65

/datum/armament_entry/company_import/syndicate/implants/nostun
	item_type = /obj/item/autosurgeon/syndicate/anti_stun/des_two

/datum/armament_entry/company_import/syndicate/misc
	subcategory = "Miscellaneous"
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

/datum/armament_entry/company_import/syndicate/misc/jaws
	item_type = /obj/item/crowbar/power/syndicate

/datum/armament_entry/company_import/syndicate/misc/slime
	item_type = /obj/item/slimepotion/slime/sentience/nuclear

/datum/armament_entry/company_import/syndicate/misc/agentid
	item_type = /obj/item/card/id/advanced/chameleon

// Syndicate spacetide gear
/datum/armament_entry/company_import/syndicate/space
	subcategory = "Space Gear"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/space/modsuit
	item_type = /obj/item/mod/control/pre_equipped/traitor
	cost = PAYCHECK_COMMAND * 50

/datum/armament_entry/company_import/syndicate/space/spacesuit
	item_type = /obj/item/storage/box/syndie_kit/space
	cost = PAYCHECK_COMMAND * 10

// Modsuit mods that CAN be found in the uplinks
/datum/armament_entry/company_import/syndicate/mods
	subcategory = "Modsuit Mods"
	cost = PAYCHECK_COMMAND * 15

/datum/armament_entry/company_import/syndicate/mods/energyshield
	item_type = /obj/item/mod/module/energy_shield
	cost = PAYCHECK_COMMAND * 25

/datum/armament_entry/company_import/syndicate/mods/empshield
	item_type = /obj/item/mod/module/emp_shield/advanced

/datum/armament_entry/company_import/syndicate/mods/injector
	item_type = /obj/item/mod/module/injector

/datum/armament_entry/company_import/syndicate/mods/camo
	item_type = /obj/item/mod/module/chameleon

/datum/armament_entry/company_import/syndicate/mods/compress
	item_type = /obj/item/mod/module/plate_compression

/datum/armament_entry/company_import/syndicate/mods/slipbgone
	item_type = /obj/item/mod/module/noslip
	cost = PAYCHECK_COMMAND * 20

/datum/armament_entry/company_import/syndicate/mods/shockabsorb
	item_type = /obj/item/mod/module/shock_absorber

/datum/armament_entry/company_import/syndicate/mods/byebyelight
	item_type = /obj/item/mod/module/stealth/wraith

/datum/armament_entry/company_import/syndicate/ai
	subcategory = "Artificial Intelligence"
	cost = PAYCHECK_COMMAND * 10

/datum/armament_entry/company_import/syndicate/ai/mmi
	item_type = /obj/item/mmi/syndie/ds2

/datum/armament_entry/company_import/syndicate/ai/modsuit
	item_type = /obj/item/mmi/posibrain/syndie/ds2

