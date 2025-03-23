/obj/structure/closet/secure_closet/des_two/medical
	icon_state = "med_secure"
	name = "medical gear locker"

/obj/item/storage/bag/garment/syndicate_medical
	name = "medical garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to medical."

/obj/item/storage/bag/garment/syndicate_medical/PopulateContents()
	return list(
		/obj/item/clothing/gloves/latex/nitrile/ntrauma,
		/obj/item/clothing/suit/toggle/labcoat/interdyne,
		/obj/item/clothing/suit/toggle/labcoat/interdyne,
		/obj/item/clothing/glasses/hud/ar/aviator/health,
		/obj/item/clothing/glasses/hud/ar/aviator/health,
	)

/obj/structure/closet/secure_closet/des_two/medical/PopulateContents()
	..()

	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/storage/bag/garment/syndicate_medical(src)
