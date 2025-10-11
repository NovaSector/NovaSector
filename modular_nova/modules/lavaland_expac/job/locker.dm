/obj/structure/closet/secure_closet/armory_mining_station
	name = "fuana survival locker"
	req_access = list(ACCESS_MINING_STATION,ACCESS_ENGINEERING)
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/armory_kiboko/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/ammo_box/advanced/s12gauge/hunter = 2,
	), src)
