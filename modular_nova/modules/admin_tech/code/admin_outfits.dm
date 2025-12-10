//TODO:Bluespace Medical&Research/Security/ Operative (), Subspace Skinsuit, CC Intern / Sergeant / Commander / Official, Asset Protection,
//Bluespace Technician Outfit, used with the icspawning quick button
/datum/outfit/admin/bst
	name = "Bluespace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/misc/adminsuit//TODO:bst variant
	suit = /obj/item/clothing/suit/armor/vest/debug//TODO:bst variant
	suit_store = /obj/item/tank/internals/emergency_oxygen/double//TODO:bst variant, pluox instead of airmix
	ears = /obj/item/radio/headset/debug
	neck = null
	gloves = /obj/item/clothing/gloves/combat//TODO:bst variant
	belt = /obj/item/storage/belt/utility/debug/bst
	shoes = /obj/item/clothing/shoes/chameleon/noslip//TODO:bst variant
	mask = /obj/item/clothing/mask/gas/atmos
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debug/tools
	l_pocket = null
	r_pocket = /obj/item/storage/bag/construction/debug
	back = /obj/item/mod/control/pre_equipped/subspace
	backpack_contents = list(
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,
		/obj/item/boxcutter = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
	)
	belt_contents = list()

//Subspace Technician Outfit. This is the new debug outfit, tuned to provide lots of items
/datum/outfit/admin/sst
	name = "Subspace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/misc/adminsuit
	suit = /obj/item/clothing/suit/armor/vest/debug//TODO:Subspace variant
	suit_store = /obj/item/tank/internals/emergency_oxygen/double//TODO:Subspace variant, pluox+nitrium variant
	ears = /obj/item/radio/headset/debug
	neck = /obj/item/clothing/neck/necklace/memento_mori
	gloves = /obj/item/clothing/gloves/kaza_ruk/combatglovesplus//TODO:Subspace variant
	belt = /obj/item/storage/belt/utility/debug/sst
	shoes = /obj/item/clothing/shoes/magboots/advance/debug
	mask = /obj/item/clothing/mask/gas/atmos//TODO:Subspace variant
	id = /obj/item/card/id/advanced/debug/bst//TODO:Subspace variant
	box = /obj/item/storage/box/debug/tools
	l_pocket = /obj/item/door_remote/omni//TODO:Subspace variant
	r_pocket = /obj/item/storage/bag/construction/debug
	back = /obj/item/mod/control/pre_equipped/subspace
	backpack_contents = list(
		/obj/item/storage/box/debug/care_package = 1,
		/obj/item/storage/box/debug/power = 1,
		/obj/item/storage/box/debug/medical = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,//TODO:Subspace variant, modular rifle
		/obj/item/boxcutter = 1,//TODO:Subspace variant
		/obj/item/gun/energy/taser/debug = 1,
		/obj/item/gun/magic/hook/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
		/obj/item/storage/part_replacer/bluespace/tier4/bst = 1,
	)
	belt_contents = list()
