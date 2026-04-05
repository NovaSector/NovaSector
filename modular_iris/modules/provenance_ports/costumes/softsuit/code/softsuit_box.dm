/obj/item/storage/box/softsuit
	name = "replica softsuit box"
	desc = "A box containing a replica softsuit and matching helmet."

/obj/item/storage/box/softsuit/PopulateContents()
	new/obj/item/clothing/suit/softsuit(src)
	new/obj/item/clothing/head/softsuit(src)
