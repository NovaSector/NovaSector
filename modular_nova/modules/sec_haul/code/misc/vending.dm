/obj/machinery/vending/security
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 12,
		/obj/item/grenade/flashbang = 6,
		/obj/item/assembly/flash/handheld = 8,
		/obj/item/food/donut/plain = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 6,
		/obj/item/restraints/legcuffs/bola/energy = 10,
		/obj/item/clothing/gloves/tackler/security = 5,
		/obj/item/holosign_creator/security = 2,
		/obj/item/gun_maintenance_supplies = 2,
		/obj/item/gun/energy/e_gun/advtaser = 3,
	)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/fancy/donut_box = 2,
		/obj/item/melee/baton/security/stun_gun/stun_knife = 3,
	)
	premium = list(
		/obj/item/ammo_workbench_module/lethal = 1,
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 3,
		/obj/item/clothing/suit/armor/vest/blueshirt = 3,
		/obj/item/grenade/stingbang = 5,
		/obj/item/watertank/pepperspray = 2,
		/obj/item/storage/belt/holster/energy = 4,
		/obj/item/storage/box/holobadge = 1,
	)

/obj/machinery/vending/wardrobe/sec_wardrobe
	product_categories = list(
		list(
			"name" = "Main",
			"icon" = "shield",
			"products" = list(
				/obj/item/clothing/head/beret/sec = 4,
				/obj/item/clothing/head/soft/sec = 4,
				/obj/item/clothing/mask/bandana/striped/security = 4,
				/obj/item/clothing/under/rank/security/nova/secjumpsuit = 4,	//1
				/obj/item/clothing/under/rank/security/nova/officer/black = 4,  //2
				/obj/item/clothing/under/rank/security/officer/skirt = 4,		//3
				/obj/item/clothing/under/rank/security/nova/dress = 4,			//4
//				/obj/item/clothing/under/rank/security/nova/skirt/mini = 4,		//5
				/obj/item/clothing/under/rank/security/nova/turtleneck = 4,
				/obj/item/clothing/under/rank/security/nova/formal = 4,
				/obj/item/clothing/under/rank/security/nova/utility = 4,		//7
				/obj/item/clothing/under/rank/security/nova/trousers = 4,
				/obj/item/clothing/under/rank/security/nova/secshorts = 4,
				/obj/item/clothing/under/rank/security/officer/grey = 4,
				/obj/item/clothing/under/pants/slacks = 4,
				/obj/item/clothing/suit/armor/vest/secjacket = 4,
				/obj/item/clothing/suit/hooded/wintercoat/security = 4,
				/obj/item/clothing/suit/armor/vest = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec = 4,
				/obj/item/clothing/gloves/color/black/security = 4,
				/obj/item/clothing/shoes/jackboots/sec = 4,
				/obj/item/storage/backpack/security = 4,
				/obj/item/storage/backpack/satchel/sec = 4,
				/obj/item/storage/backpack/duffelbag/sec = 4,
				/obj/item/storage/backpack/messenger/sec = 4,
				/obj/item/clothing/head/costume/ushanka/sec = 4
			),
		),

		list(
			"name" = "Blue",
			"icon" = "shield-halved",
			"products" = list(
				/obj/item/clothing/glasses/hud/security/sunglasses/blue = 3,
				/obj/item/clothing/head/beret/sec/nova = 4,
				/obj/item/clothing/head/security_cap = 4,
				/obj/item/clothing/head/helmet/sec/white = 3,
				/obj/item/clothing/suit/hooded/wintercoat/security/blue = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec/blue = 4,
				/obj/item/clothing/suit/armor/vest/alt/sec/white = 3,
				/obj/item/clothing/suit/armor/vest/brit = 3,
				/obj/item/clothing/neck/security_cape = 4,
				/obj/item/clothing/neck/security_cape/armplate = 4,
				/obj/item/clothing/under/rank/security/nova/officer = 4,
				/obj/item/clothing/under/rank/security/nova/skirt = 4,
				/obj/item/clothing/under/rank/security/officer/blueshirt = 4,
				/obj/item/clothing/under/rank/security/nova/dress/blue = 4,
				/obj/item/clothing/under/rank/security/nova/skirt/plain = 4,
//				/obj/item/clothing/under/rank/security/nova/skirt/mini/blue = 4,
				/obj/item/clothing/under/rank/security/nova/turtleneck/blue = 4,
				/obj/item/clothing/under/rank/security/nova/formal/blue = 4,
				/obj/item/clothing/under/rank/security/nova/utility/blue = 4,
				/obj/item/clothing/under/rank/security/nova/trousers/blue = 4,
				/obj/item/clothing/under/rank/security/nova/secshorts/blue = 4,
				/obj/item/clothing/shoes/jackboots/sec/blue = 4,
				/obj/item/clothing/gloves/color/black/security/white = 4,
				/obj/item/clothing/gloves/color/black/security/blu = 4,
				/obj/item/clothing/head/security_garrison = 4,
				/obj/item/clothing/head/hats/warden/police/patrol = 4,
				/obj/item/clothing/head/costume/ushanka/sec/blue = 4,
				/obj/item/storage/backpack/security/blue = 4,
				/obj/item/storage/backpack/satchel/sec/blue = 4,
				/obj/item/storage/backpack/duffelbag/sec/blue = 4,
				/obj/item/storage/backpack/messenger/sec/blue = 4,
			),
		),

		list(
			"name" = "White",
			"icon" = "shield-halved",
			"products" = list(
/*				/obj/item/clothing/glasses/hud/security/sunglasses/blue = 3,
				/obj/item/clothing/head/beret/sec/nova = 4,
				/obj/item/clothing/head/security_cap = 4,
				/obj/item/clothing/head/helmet/sec/white = 3,
				/obj/item/clothing/suit/hooded/wintercoat/security/blue = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec/blue = 4, */
				/obj/item/clothing/suit/armor/vest/alt/sec/white = 3,
/*				/obj/item/clothing/suit/armor/vest/brit = 3,
				/obj/item/clothing/neck/security_cape = 4,
				/obj/item/clothing/neck/security_cape/armplate = 4,
				/obj/item/clothing/under/rank/security/nova/officer = 4,
				/obj/item/clothing/under/rank/security/nova/skirt = 4,
				/obj/item/clothing/under/rank/security/officer/blueshirt = 4,*/
				/obj/item/clothing/under/rank/security/nova/dress/white = 4,
/*				/obj/item/clothing/under/rank/security/nova/skirt/plain = 4,
				/obj/item/clothing/under/rank/security/nova/skirt/mini/blue = 4, */
				/obj/item/clothing/under/rank/security/nova/turtleneck/white = 4,
				/obj/item/clothing/under/rank/security/nova/formal/white = 4,
//				/obj/item/clothing/under/rank/security/nova/utility/blue = 4,
				/obj/item/clothing/under/rank/security/nova/trousers/white = 4,
				/obj/item/clothing/under/rank/security/nova/secshorts/white = 4,
/*				/obj/item/clothing/shoes/jackboots/sec/blue = 4,
				/obj/item/clothing/gloves/color/black/security/white = 4,
				/obj/item/clothing/gloves/color/black/security/blu = 4,
				/obj/item/clothing/head/security_garrison = 4,
				/obj/item/clothing/head/hats/warden/police/patrol = 4,
				/obj/item/clothing/head/costume/ushanka/sec/blue = 4,
				/obj/item/storage/backpack/security/blue = 4,
				/obj/item/storage/backpack/satchel/sec/blue = 4,
				/obj/item/storage/backpack/duffelbag/sec/blue = 4,
				/obj/item/storage/backpack/messenger/sec/blue = 4, */
			),
		),

		list(
			"name" = "Black",
			"icon" = "shield-halved",
			"products" = list(
/*				/obj/item/clothing/glasses/hud/security/sunglasses/blue = 3,
				/obj/item/clothing/head/beret/sec/nova = 4,
				/obj/item/clothing/head/security_cap = 4,
				/obj/item/clothing/head/helmet/sec/white = 3,
				/obj/item/clothing/suit/hooded/wintercoat/security/blue = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec/blue = 4,
				/obj/item/clothing/suit/armor/vest/alt/sec/white = 3,
				/obj/item/clothing/suit/armor/vest/brit = 3,
				/obj/item/clothing/neck/security_cape = 4,
				/obj/item/clothing/neck/security_cape/armplate = 4,
				/obj/item/clothing/under/rank/security/nova/officer = 4,
				/obj/item/clothing/under/rank/security/nova/skirt = 4,
				/obj/item/clothing/under/rank/security/officer/blueshirt = 4, */
				/obj/item/clothing/under/rank/security/nova/dress/black = 4,
/*				/obj/item/clothing/under/rank/security/nova/skirt/plain = 4,
				/obj/item/clothing/under/rank/security/nova/skirt/mini/blue = 4, */
				/obj/item/clothing/under/rank/security/nova/turtleneck/black = 4,
				/obj/item/clothing/under/rank/security/nova/formal/black = 4,
//				/obj/item/clothing/under/rank/security/nova/utility/blue = 4,
				/obj/item/clothing/under/rank/security/nova/trousers/black = 4,
				/obj/item/clothing/under/rank/security/nova/secshorts/black = 4,
/*				/obj/item/clothing/shoes/jackboots/sec/blue = 4,
				/obj/item/clothing/gloves/color/black/security/white = 4,
				/obj/item/clothing/gloves/color/black/security/blu = 4,
				/obj/item/clothing/head/security_garrison = 4,
				/obj/item/clothing/head/hats/warden/police/patrol = 4,
				/obj/item/clothing/head/costume/ushanka/sec/blue = 4,
				/obj/item/storage/backpack/security/blue = 4,
				/obj/item/storage/backpack/satchel/sec/blue = 4,
				/obj/item/storage/backpack/duffelbag/sec/blue = 4,
				/obj/item/storage/backpack/messenger/sec/blue = 4, */
			),
		),
	)

	premium = list(
		/obj/item/clothing/under/rank/security/officer/formal = 3,
		/obj/item/clothing/suit/jacket/officer/blue = 3,
		/obj/item/clothing/head/beret/sec/navyofficer = 3,
		/obj/item/riding_saddle/leather = 3,
		/obj/item/riding_saddle/leather/blue = 2,
		/obj/item/clothing/head/helmet/hc_police = 3,
		/obj/item/clothing/head/soft/hc_police = 3,
		/obj/item/clothing/mask/gas/hc_police = 3,
		/obj/item/clothing/head/hats/colonial/hc_police = 3,
		/obj/item/clothing/neck/cloak/colonial/hc_police = 3,
		/obj/item/clothing/under/colonial/hc_police = 3,
		/obj/item/clothing/under/colonial/hc_police/skirt = 3,
		/obj/item/clothing/suit/armor/vest/hc_police_jacket/suit = 3,
		/obj/item/clothing/suit/armor/vest/hc_police = 3,
		/obj/item/clothing/suit/armor/vest/hc_police_jacket = 3,
		)
	payment_department = ACCOUNT_SEC
