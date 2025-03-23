/obj/item/storage/backpack/duffelbag/science/robo/surgery
	name = "robotics surgical duffelbag"
	desc = "A sleek, industrial-strength duffelbag issued to robotics personnel. This one has a tag implying it came stocked with surgical tools."

/obj/item/storage/backpack/duffelbag/science/robo/surgery/PopulateContents()
	return list(
		/obj/item/scalpel,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/circular_saw,
		/obj/item/surgicaldrill,
		/obj/item/cautery,
		/obj/item/bonesetter,
		/obj/item/surgical_drapes,
		/obj/item/clothing/suit/toggle/labcoat/nova/hospitalgown,
		/obj/item/clothing/mask/surgical,
		/obj/item/razor,
		/obj/item/blood_filter,
	)
