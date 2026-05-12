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
		/obj/item/ammo_box/advanced/s12gauge/frangible = 2,
	)

/obj/machinery/vending/wardrobe/sec_wardrobe
	product_categories = list(
		list(
			"name" = "Main",
			"icon" = "shield",
			"products" = list(
				/obj/item/clothing/head/beret/sec = 4,
				/obj/item/clothing/mask/bandana/striped/security = 4,
				/obj/item/clothing/under/rank/security/officer = 4,
//				/obj/item/clothing/under/rank/security/nova/officer/black = 4,
				/obj/item/clothing/under/rank/security/nova/modskin = 4,
				/obj/item/clothing/under/rank/security/officer/skirt = 4,
				/obj/item/clothing/under/rank/security/nova/dress = 4,
				/obj/item/clothing/under/rank/security/officer/skirt = 4,
				/obj/item/clothing/suit/hooded/wintercoat/security/depgag/bomber = 4,
				/obj/item/clothing/under/rank/security/nova/dress = 4,
//				/obj/item/clothing/under/rank/security/nova/skirt/mini = 4,
				/obj/item/clothing/under/rank/security/nova/turtleneck = 4,
				/obj/item/clothing/under/rank/security/nova/formal = 4,
				/obj/item/clothing/under/rank/security/nova/utility = 4,
				/obj/item/clothing/under/rank/security/nova/trousers = 4,
//				/obj/item/clothing/under/rank/security/nova/trousers/shorts = 4,
				/obj/item/clothing/under/rank/security/officer/grey = 4,
				/obj/item/clothing/under/pants/slacks = 4,
				/obj/item/clothing/suit/armor/vest/secjacket = 4,
				/obj/item/clothing/suit/armor/vest = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec = 4,
				/obj/item/clothing/gloves/color/black/security = 4,
				/obj/item/clothing/shoes/jackboots/sec = 4,
				/obj/item/clothing/shoes/jackboots/gogo_boots = 4,
				/obj/item/storage/backpack/security = 4,
				/obj/item/storage/backpack/satchel/sec = 4,
				/obj/item/storage/backpack/duffelbag/sec = 4,
				/obj/item/storage/backpack/messenger/sec = 4,
				/obj/item/clothing/head/costume/ushanka/sec = 4,
				/obj/item/clothing/head/playbunnyears/security = 6,
				/obj/item/clothing/under/rank/security/security_bunnysuit = 6,
				/obj/item/clothing/suit/armor/security_tailcoat = 6,
				/obj/item/clothing/neck/tie/bunnytie/security = 6,
				/obj/item/clothing/head/playbunnyears/security/assistant = 6,
				/obj/item/clothing/under/rank/security/security_assistant_bunnysuit = 6,
				/obj/item/clothing/suit/armor/security_tailcoat/assistant = 6,
				/obj/item/clothing/neck/tie/bunnytie/security_assistant = 6,
				/obj/item/clothing/head/playbunnyears/prisoner = 6,
				/obj/item/clothing/under/rank/security/prisoner_bunnysuit = 6,
				/obj/item/clothing/neck/tie/bunnytie/prisoner = 6,
			),
		),

		list(
			"name" = "Alternate",
			"icon" = "shield-halved",
			"products" = list(
				/obj/item/clothing/glasses/hud/security/sunglasses/blue = 3,
				/obj/item/clothing/head/beret/sec/nova = 4,
//				/obj/item/clothing/head/security_cap = 4,
				/obj/item/clothing/head/helmet/sec/white = 3,
//				/obj/item/clothing/suit/hooded/wintercoat/security/blue = 4,
				/obj/item/clothing/suit/toggle/jacket/nova/colorable_bomber/sec/blue = 4,
				/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest = 3,
				/obj/item/clothing/suit/armor/vest/secjacket/depgag = 3,
				/obj/item/clothing/neck/security_cape/shoulder = 4,
				/obj/item/clothing/neck/security_cape/armplate = 4,
//				/obj/item/clothing/under/rank/security/nova/officer = 4,
				/obj/item/clothing/under/rank/security/nova/skirt = 4,
				/obj/item/clothing/under/rank/security/officer/blueshirt = 4,
//				/obj/item/clothing/under/rank/security/nova/dress/blue = 4,
//				/obj/item/clothing/under/rank/security/nova/skirt/plain = 4,
//				/obj/item/clothing/under/rank/security/nova/skirt/mini/blue = 4,
//				/obj/item/clothing/under/rank/security/nova/turtleneck/blue = 4,
//				/obj/item/clothing/under/rank/security/nova/formal/blue = 4,
//				/obj/item/clothing/under/rank/security/nova/utility/blue = 4,
				/obj/item/clothing/shoes/jackboots/sec/blue = 4,
				/obj/item/clothing/gloves/color/black/security/depgag/white = 4,
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
			"name" = "NEW!",
			"icon" = "shield-halved",
			"products" = list(
				/obj/item/clothing/under/rank/security/nova/uniform = 4,
				/obj/item/clothing/under/rank/security/nova/formal = 4,
				/obj/item/clothing/under/rank/security/nova/turtleneck = 4,
				/obj/item/clothing/under/rank/security/nova/skirt = 4,
				/obj/item/clothing/under/rank/security/nova/plainskirt = 4,
				/obj/item/clothing/under/rank/security/nova/miniskirt = 4,
				/obj/item/clothing/under/rank/security/nova/dress = 4,
				/obj/item/clothing/under/rank/security/nova/shorts = 4,
				/obj/item/clothing/under/rank/security/nova/trousers = 4,
				/obj/item/clothing/under/rank/security/nova/modskin = 4,
				/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest = 4,
				/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest_slim = 4,
				/obj/item/clothing/suit/armor/vest/depgag_hazard = 4,
				/obj/item/clothing/suit/armor/vest/secjacket/depgag = 4,
				/obj/item/clothing/suit/hooded/wintercoat/security/depgag/bomber = 4,
				/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket = 4,
				/obj/item/clothing/suit/hooded/wintercoat/security/depgag = 4,
				/obj/item/clothing/gloves/color/black/security/depgag = 4,
				/obj/item/clothing/head/security_garrison = 4,
				/obj/item/clothing/head/security_cap = 4,
				/obj/item/clothing/head/beret/sec/depgag = 4,
				/obj/item/clothing/head/hats/warden/police/patrol = 4,
			),
		),
	)

	premium = list(
		/obj/item/clothing/suit/armor/vest/depgag_hazard = 3,
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
/*
/obj/item/clothing/under/rank/security/nova/uniform								1
/obj/item/clothing/under/rank/security/nova/formal
/obj/item/clothing/under/rank/security/nova/turtleneck							2
/obj/item/clothing/under/rank/security/nova/skirt								3
/obj/item/clothing/under/rank/security/nova/plainskirt
/obj/item/clothing/under/rank/security/nova/miniskirt
/obj/item/clothing/under/rank/security/nova/dress								4
/obj/item/clothing/under/rank/security/nova/shorts								5
/obj/item/clothing/under/rank/security/nova/trousers
/obj/item/clothing/under/rank/security/nova/modskin
/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest							6
/obj/item/clothing/suit/armor/vest/alt/sec/depgag_vest_slim						7
/obj/item/clothing/suit/armor/vest/depgag_hazard								8
/obj/item/clothing/suit/armor/vest/secjacket/depgag								9
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/bomber				10
/obj/item/clothing/suit/hooded/wintercoat/security/depgag/depgag_vested_jacket	11
/obj/item/clothing/suit/hooded/wintercoat/security/depgag						12
/obj/item/clothing/gloves/color/black/security/depgag
/obj/item/clothing/head/security_garrison
/obj/item/clothing/head/security_cap											13
/obj/item/clothing/head/beret/sec/depgag
/obj/item/clothing/head/hats/warden/police/patrol














*/
