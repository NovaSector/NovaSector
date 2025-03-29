/obj/item/storage/bag/garment/blueshield
	name = "blueshield's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the blueshield."

/obj/item/storage/bag/garment/blueshield/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/wintercoat/nova/blueshield,
		/obj/item/clothing/head/beret/blueshield,
		/obj/item/clothing/head/beret/blueshield/navy,
		/obj/item/clothing/under/rank/blueshield,
		/obj/item/clothing/under/rank/blueshield/skirt,
		/obj/item/clothing/under/rank/blueshield/turtleneck,
		/obj/item/clothing/under/rank/blueshield/turtleneck/skirt,
		/obj/item/clothing/suit/armor/vest/blueshield,
		/obj/item/clothing/suit/armor/vest/blueshield/jacket,
		/obj/item/clothing/neck/mantle/bsmantle,
	)

/obj/structure/closet/secure_closet/blueshield
	name = "blueshield's locker"
	icon_state = "bs"
	icon = 'modular_nova/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/briefcase/secure(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/storage/medkit/frontier/stocked(src)
	new /obj/item/storage/bag/garment/blueshield(src)
	new /obj/item/mod/control/pre_equipped/blueshield(src)
	new /obj/item/sensor_device/blueshield(src)
