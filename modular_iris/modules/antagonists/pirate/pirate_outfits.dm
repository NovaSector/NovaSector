/datum/outfit/pirate/tider
	name = "Tider Trooper"

	id = /obj/item/card/id/advanced
	uniform = /obj/item/clothing/under/greyscale/turtleneck
	suit = /obj/item/clothing/suit/armor/vest/cin_surplus_vest
	belt = /obj/item/storage/belt/security/webbing/peacekeeper
	ears = /obj/item/radio/headset/syndicate
	glasses = /obj/item/clothing/glasses/sunglasses/solfed
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/alt
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	head = /obj/item/clothing/head/helmet/cin_surplus_helmet
	shoes = /obj/item/clothing/shoes/jackboots/frontier_colonist
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio = 1,
		/obj/item/storage/box/handcuffs = 1,
	)

/datum/outfit/pirate/tider/captain
	name = "Tider Maximus"

	gloves = /obj/item/clothing/gloves/color/yellow
	neck = /obj/item/bedsheet/yellow
	head = /obj/item/clothing/head/beret/sec/engineering
	belt = /obj/item/storage/belt/holster
	belt_contents = list(
		/obj/item/gun/ballistic/revolver/c38/super = 1,
		/obj/item/ammo_box/speedloader/c38 = 2,
	)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio = 1,
		/obj/item/storage/box/handcuffs = 1,
	)

/datum/outfit/pirate/tider/medic
	name = "Tider Corpsman"

	head = /obj/item/clothing/head/beret/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile
	back = /obj/item/storage/backpack/satchel/med
	glasses = /obj/item/clothing/glasses/science
	belt = /obj/item/storage/belt/holster
	belt_contents = list(
		/obj/item/gun/ballistic/revolver/c38/super = 1,
		/obj/item/ammo_box/speedloader/c38 = 2,
	)
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio = 1,
		/obj/item/storage/box/evilmeds = 1,
		/obj/item/storage/box/medipens/utility = 1,
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
	)
	suit = /obj/item/clothing/suit/toggle/labcoat/medical
