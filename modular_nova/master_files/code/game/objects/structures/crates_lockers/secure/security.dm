/obj/structure/closet/secure_closet/detective/PopulateContents()
	..()
	..() // Spawn the full set of gear, twice

/obj/structure/closet/secure_closet/captains/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget(src)

/obj/structure/closet/secure_closet/hop/PopulateContents()
	..()
	new /obj/item/card/id/departmental_budget/srv(src)
	new /obj/item/storage/box/visitor_ids(src)

/obj/structure/closet/secure_closet/hos/PopulateContents()
	..()
	new /obj/item/storage/bag/garment/hos/blue(src) // Bluesec alternative
	new /obj/item/card/id/departmental_budget/sec(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	..()
	new /obj/item/storage/bag/garment/warden/blue(src) // Bluesec alternative
	new /obj/item/stamp/warden(src)
