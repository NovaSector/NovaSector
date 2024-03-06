GLOBAL_LIST_INIT(nova_special_firearms, list(
	/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko,
	/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko/evil,
	/obj/item/gun/ballistic/automatic/sol_rifle,
	/obj/item/gun/ballistic/automatic/sol_rifle/evil,
	/obj/item/gun/ballistic/automatic/sol_rifle/marksman,
	/obj/item/gun/ballistic/automatic/sol_rifle/machinegun,
	/obj/item/gun/ballistic/shotgun/riot/sol/thunderdome,
	/obj/item/gun/ballistic/shotgun/riot/sol/evil/thunderdome,
	/obj/item/gun/ballistic/automatic/sol_smg,
	/obj/item/gun/ballistic/automatic/sol_smg/evil,
	/obj/item/gun/energy/modular_laser_rifle,
	/obj/item/gun/energy/modular_laser_rifle/carbine,
	/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
	/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
	/obj/item/gun/ballistic/revolver/shotgun_revolver,
	/obj/item/gun/ballistic/automatic/lanca,
	/obj/item/gun/ballistic/automatic/wylom,
	/obj/item/gun/ballistic/automatic/miecz,
	/obj/item/gun/ballistic/automatic/pistol/sol,
	/obj/item/gun/ballistic/automatic/pistol/sol/evil,
	/obj/item/gun/ballistic/automatic/pistol/trappiste,
	/obj/item/gun/ballistic/revolver/sol,
	/obj/item/gun/ballistic/revolver/takbok,
	/obj/item/gun/ballistic/rifle/boltaction/sporterized,
	/obj/item/gun/ballistic/automatic/xhihao_smg,
))

GLOBAL_LIST_INIT(nova_funny_mystery_box_items, list(
	/obj/item/storage/medkit/civil_defense/thunderdome,
	/obj/item/storage/medkit/frontier/stocked,
	/obj/item/storage/medkit/combat_surgeon/stocked,
	/obj/item/storage/backpack/duffelbag/deforest_medkit/stocked,
	/obj/item/storage/backpack/duffelbag/deforest_surgical/stocked,
	/obj/item/clothing/suit/armor/sf_sacrificial,
	/obj/item/clothing/head/helmet/sf_sacrificial/spawns_with_shield,
	/obj/item/clothing/suit/armor/sf_peacekeeper,
	/obj/item/clothing/suit/armor/sf_peacekeeper/debranded,
	/obj/item/clothing/head/helmet/sf_peacekeeper,
	/obj/item/clothing/head/helmet/sf_peacekeeper/debranded,
	/obj/item/clothing/suit/armor/sf_hardened,
	/obj/item/clothing/suit/armor/sf_hardened/emt,
	/obj/item/clothing/head/helmet/toggleable/sf_hardened,
	/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt,
	/obj/item/autosurgeon/syndicate/sandy,
	/obj/item/autosurgeon/syndicate/razorwire,
	/obj/item/shield/ballistic,
))

/obj/structure/mystery_box/guns/generate_valid_types()
	valid_types = GLOB.summoned_guns + GLOB.nova_special_firearms

/obj/structure/mystery_box/tdome/generate_valid_types()
	valid_types = GLOB.mystery_box_guns + GLOB.mystery_box_extended + GLOB.nova_special_firearms + GLOB.nova_funny_mystery_box_items
