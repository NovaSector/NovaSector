//TODO:Bluespace Medical&Research/Security/ Operative (), Subspace Skinsuit, CC Intern / Sergeant / Commander / Official, Asset Protection,
//Bluespace Technician Outfit, used with the icspawning quick button
/datum/outfit/admin/bluespace
	name = "Bluespace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/admin
	suit = /obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/admin
	suit_store = /obj/item/tank/internals/admin/pluoxium
	head = /obj/item/clothing/head/helmet/perceptomatrix/admin
	ears = /obj/item/radio/headset/admin
	glasses = /obj/item/clothing/glasses/meson/engine/admin/debug
	neck = null
	gloves = /obj/item/clothing/gloves/tackler/admin
	belt = /obj/item/storage/belt/utility/admin/bluespace
	shoes = /obj/item/clothing/shoes/magboots/advance/admin
	mask = /obj/item/clothing/mask/gas/atmos/admin
	id = /obj/item/card/id/advanced/debug/bst
	box = /obj/item/storage/box/debug/tools
	l_pocket = null
	r_pocket = null
	back = /obj/item/mod/control/pre_equipped/bluespace
	backpack_contents = list(
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,
		/obj/item/boxcutter = 1,
	)
	belt_contents = list()

//Subspace Technician Outfit. This is the new debug outfit, tuned to provide lots of items
/datum/outfit/admin/subspace
	name = "Subspace Tech (MODsuit)"
	uniform = /obj/item/clothing/under/admin/subspace
	suit = /obj/item/clothing/suit/toggle/jacket/nova/flannel/gags/admin
	suit_store = /obj/item/tank/internals/admin/pluoxium
	head = /obj/item/clothing/head/helmet/perceptomatrix/admin/subspace
	ears = /obj/item/radio/headset/admin/subspace
	glasses = /obj/item/clothing/glasses/meson/engine/admin/debug
	neck = null
	gloves = /obj/item/clothing/gloves/tackler/admin/subspace
	belt = /obj/item/storage/belt/utility/admin/subspace
	shoes = /obj/item/clothing/shoes/magboots/advance/admin/subspace
	mask = /obj/item/clothing/mask/gas/atmos/admin
	id = /obj/item/card/id/advanced/debug/sst
	box = /obj/item/storage/box/debug/tools
	l_pocket = null
	r_pocket = null
	back = /obj/item/mod/control/pre_equipped/subspace
	backpack_contents = list(
		/obj/item/storage/box/debug/care_package = 1,
		/obj/item/storage/box/debug/power = 1,
		/obj/item/storage/box/debug/medical = 1,
		/obj/item/melee/energy/axe = 1,
		/obj/item/gun/energy/pulse/destroyer = 1,
		/obj/item/boxcutter = 1,//TODO:Subspace variant
		/obj/item/gun/energy/taser/debug = 1,
		/obj/item/gun/magic/hook/debug = 1,
		/obj/item/debug/human_spawner = 1,
		/obj/item/gun/magic/wand/resurrection/debug = 1,
		/obj/item/gun/magic/wand/death/debug = 1,
		/obj/item/gun/magic/wand/safety/debug = 1,
	)
	belt_contents = list()
