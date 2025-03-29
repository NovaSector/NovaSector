/obj/structure/closet/secure_closet/des_two/welding_supplies
	icon_door = "eng_weld"
	icon_state = "eng"
	name = "welding supplies locker"

/obj/structure/closet/secure_closet/des_two/welding_supplies/PopulateContents()
	..()

	new /obj/item/weldingtool/largetank(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/clothing/glasses/welding(src)

/obj/structure/closet/secure_closet/des_two/electrical_supplies
	icon_door = "eng_elec"
	icon_state = "eng"
	name = "electrical supplies locker"

/obj/structure/closet/secure_closet/des_two/electrical_supplies/PopulateContents()
	..()

	new /obj/item/electronics/airlock(src)
	new /obj/item/electronics/airlock(src)
	new /obj/item/storage/toolbox/electrical(src)
	new /obj/item/electronics/apc(src)
	new /obj/item/electronics/firelock(src)
	new /obj/item/electronics/airalarm(src)
	new /obj/item/stock_parts/power_store/cell/high(src)
	new /obj/item/stock_parts/power_store/cell/high(src)
	new /obj/item/stock_parts/power_store/battery/high(src)
	new /obj/item/stock_parts/power_store/battery/high(src)
	new /obj/item/clothing/glasses/meson/engine(src)

/obj/structure/closet/secure_closet/des_two/engie_locker
	icon_door = "eng_secure"
	icon_state = "eng_secure"
	name = "engine technician gear locker"

/obj/item/storage/bag/garment/syndicate_engie
	name = "engine tech's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to an engine tech."

/obj/item/storage/bag/garment/syndicate_engie/PopulateContents()
	return list(
		/obj/item/clothing/suit/hooded/wintercoat/engineering,
		/obj/item/clothing/head/soft/sec/syndicate,
		/obj/item/clothing/under/syndicate/nova/overalls,
		/obj/item/clothing/under/syndicate/nova/overalls/skirt,
		/obj/item/clothing/under/rank/engineering/engineer/nova/utility/syndicate,
		/obj/item/clothing/suit/jacket/gorlex_harness,
		/obj/item/clothing/suit/hazardvest,
		/obj/item/clothing/accessory/armband/engine/syndicate,
		/obj/item/clothing/accessory/armband/engine/syndicate,
		/obj/item/clothing/glasses/hud/ar/aviator/meson,
	)

/obj/item/clothing/accessory/armband/engine/syndicate
	name = "engine technician armband"
	desc = "An armband, worn by the FOB's operatives to display which department they're assigned to."

/obj/structure/closet/secure_closet/des_two/engie_locker/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/syndicate_engie(src)
	new /obj/item/holosign_creator/atmos(src)
