/obj/structure/closet/secure_closet/des_two/science_gear
	icon_state = "science"
	name = "scientist gear locker"

/obj/item/clothing/accessory/armband/science/syndicate
	name = "researcher armband"
	desc = "An armband, worn by the FOB's operatives to display which department they're assigned to."

/obj/item/storage/bag/garment/syndicate_scientist
	name = "scientist's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a scientist."

/obj/item/storage/bag/garment/syndicate_scientist/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/wintercoat/science,
		/obj/item/clothing/suit/toggle/labcoat/science,
		/obj/item/clothing/glasses/sunglasses/chemical,
		/obj/item/clothing/under/rank/rnd/scientist/nova/utility/syndicate,
		/obj/item/clothing/under/rank/rnd/scientist/nova/utility/syndicate,
		/obj/item/clothing/accessory/armband/science/syndicate,
		/obj/item/clothing/accessory/armband/science/syndicate,
	)

/obj/structure/closet/secure_closet/des_two/science_gear/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)

/obj/structure/closet/secure_closet/des_two/robotics
	icon_state = "science"
	name = "roboticist gear locker"

/obj/item/storage/bag/garment/syndicate_roboticist
	name = "roboticist's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a roboticist."

/obj/item/storage/bag/garment/syndicate_roboticist/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/techpriest,
		/obj/item/clothing/suit/toggle/labcoat/roboticist,
		/obj/item/clothing/under/syndicate/nova/overalls/skirt,
		/obj/item/clothing/under/syndicate/nova/overalls,
		/obj/item/clothing/glasses/hud/ar/aviator/diagnostic,
		/obj/item/clothing/glasses/hud/diagnostic,
		/obj/item/clothing/suit/hooded/wintercoat/science/robotics,
	)

/obj/structure/closet/secure_closet/des_two/robotics/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_scientist(src)
