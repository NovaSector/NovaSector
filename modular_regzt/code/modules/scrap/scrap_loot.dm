//доп листы
GLOBAL_LIST_INIT(xenoarch_random, list(
	/obj/effect/spawner/random/xenoarch/tier1 = 400,
	/obj/effect/spawner/random/xenoarch/t1 = 300,
	/obj/effect/spawner/random/xenoarch = 150,
	/obj/effect/spawner/random/xenoarch/plant = 80,
	/obj/effect/spawner/random/xenoarch/tier2 = 40,
	/obj/effect/spawner/random/xenoarch/animal = 20,
	/obj/effect/spawner/random/xenoarch/clothing = 15,
	/obj/effect/spawner/random/xenoarch/tier3 = 8,
	/obj/effect/spawner/random/xenoarch/clothing/t3 = 5,
	/obj/effect/spawner/random/xenoarch/weapon = 3,
	/obj/effect/spawner/random/xenoarch/illegal = 2,
	/obj/effect/spawner/random/xenoarch/alien = 2,
	/obj/effect/spawner/random/xenoarch/weapon/t3 = 1,
	/obj/effect/spawner/random/xenoarch/illegal/t3 = 1,
	/obj/effect/spawner/random/xenoarch/alien/t3 = 1,
))

GLOBAL_LIST_INIT(robot_random, list(
	/obj/item/bodypart/arm/left/robot/surplus = 20,
	/obj/item/bodypart/arm/right/robot/surplus = 20,
	/obj/item/bodypart/leg/left/robot/surplus = 20,
	/obj/item/bodypart/leg/right/robot/surplus = 20,
	/obj/item/bodypart/head/robot = 4,
	/obj/item/bodypart/chest/robot = 4,
	/obj/item/assembly/flash/handheld = 8,
	/obj/item/stack/cable_coil = 8,
	/obj/item/mmi/posibrain/circuit = 1,
))

//листы мусора
GLOBAL_LIST_INIT(scrap_maintenance, list(
	GLOB.maintenance_loot = 6,
	GLOB.trash_loot = 2,
	/obj/item/shard = 1,
	/obj/item/stack/rods = 1,
	/obj/effect/spawner/random/trash/garbage = 1,
))

GLOBAL_LIST_INIT(scrap_trash, list(
	GLOB.trash_loot = 8,
	/obj/item/shard = 1,
	/obj/item/stack/rods = 1,
))

GLOBAL_LIST_INIT(scrap_material, list(
	GLOB.trash_loot = 200,

	// --- ОБЫЧНЫЕ МАТЕРИАЛЫ ---
	/obj/item/stack/rods = 80,
	/obj/item/shard = 70,
	/obj/item/stack/sheet/iron = 80,
	/obj/item/stack/sheet/glass = 60,
	/obj/item/stack/sheet/mineral/wood = 30,
	/obj/item/stack/sheet/plastic = 20,

	// --- РЕДКИЕ МАТЕРИАЛЫ ---
	/obj/item/stack/sheet/plasteel = 2,
	/obj/effect/spawner/random/engineering/material_rare = 1,
))

GLOBAL_LIST_INIT(scrap_medical, list(
	// --- САМОЕ ЧАСТОЕ ---
	/obj/effect/spawner/random/medical/minor_healing = 40,
	GLOB.trash_loot = 20,
	/obj/effect/spawner/random/medical/supplies = 20,

	// --- СРЕДНЯЯ РЕДКОСТЬ ---
	/obj/effect/spawner/random/medical/medkit = 7,
	/obj/effect/spawner/random/medical/injector = 5,
	/obj/effect/spawner/random/medical/surgery_tool = 3,
	/obj/effect/spawner/random/medical/patient_stretcher = 2,

	// --- ОЧЕНЬ РЕДКОЕ ---
	/obj/effect/spawner/random/medical/organs = 1,
	/obj/effect/spawner/random/medical/medkit_rare = 1,
	/obj/effect/spawner/random/medical/memeorgans = 0.8,
	/obj/effect/spawner/random/medical/two_percent_xeno_egg_spawner = 0.2,
))

GLOBAL_LIST_INIT(scrap_food, list(
	/obj/effect/spawner/random/food_or_drink = 1,
	/obj/item/reagent_containers/cup/glass/bottle/beer = 1,
	/obj/item/reagent_containers/cup/glass/coffee = 1,
	/obj/item/reagent_containers/cup/glass/bottle/beer = 1,
	/obj/item/reagent_containers/cup/glass/coffee = 1,
	/obj/item/storage/box/donkpockets/donkpocketberry = 1,
	/obj/item/storage/box/donkpockets/donkpockethonk = 1,
	/obj/item/storage/box/donkpockets/donkpocketpizza = 1,
	/obj/item/storage/box/donkpockets/donkpocketspicy = 1,
	/obj/item/storage/box/donkpockets/donkpocketteriyaki = 1,
	/obj/item/food/ready_donk = 1,
	/obj/item/food/ready_donk/donkhiladas = 1,
	/obj/item/food/ready_donk/mac_n_cheese = 1,
	/obj/item/food/monkeycube = 1,
	GLOB.trash_loot = 1,
))

GLOBAL_LIST_INIT(scrap_science, list(
	GLOB.trash_loot = 200,
	/obj/item/shard = 150,
	/obj/item/stack/rods = 150,
	GLOB.xenoarch_random = 50,
	GLOB.robot_random = 50,
	GLOB.slime_extract_random = 50,
))

GLOBAL_LIST_INIT(scrap_cloth, list(
	/obj/effect/spawner/random/clothing/costume = 1,
	/obj/effect/spawner/random/clothing/beret_or_rabbitears = 1,
	/obj/effect/spawner/random/clothing/bowler_or_that = 1,
	/obj/effect/spawner/random/clothing/kittyears_or_rabbitears = 1,
	/obj/effect/spawner/random/clothing/pirate_or_bandana = 1,
	/obj/effect/spawner/random/clothing/twentyfive_percent_cyborg_mask = 1,
	/obj/effect/spawner/random/clothing/mafia_outfit = 1,
	/obj/effect/spawner/random/clothing/syndie = 1,
	/obj/effect/spawner/random/clothing/gloves = 1,
	/obj/effect/spawner/random/clothing/lizardboots = 1,
	/obj/effect/spawner/random/clothing/wardrobe_closet = 1,
	/obj/effect/spawner/random/clothing/wardrobe_closet_colored = 1,
	/obj/effect/spawner/random/clothing/backpack = 1,
	/obj/effect/spawner/random/clothing/funny_hats = 1,
	GLOB.trash_loot = 5,
))

GLOBAL_LIST_INIT(scrap_industrial, list(
	// --- МУСОР И Т.Д---
	/obj/effect/spawner/random/trash/garbage = 300,
	GLOB.trash_loot = 200,
	/obj/effect/spawner/random/trash/deluxe_garbage = 150,
	/obj/item/shard = 40,
	/obj/effect/spawner/random/engineering/tool = 50,
	/obj/item/stack/rods = 40,

	// --- ТУЛБОКСЫ ---
	/obj/item/storage/toolbox = 5,
	/obj/item/storage/toolbox/mechanical = 5,
	/obj/item/storage/toolbox/electrical = 5,
	/obj/item/storage/toolbox/emergency = 5,
	/obj/item/storage/toolbox/artistic = 2, // Чуть реже
	/obj/item/storage/toolbox/mechanical/old/clean = 15,
	/obj/item/storage/toolbox/mechanical/old = 10,
	/obj/item/storage/toolbox/emergency/old = 10,

	// --- СИНДИКАТ ---
	/obj/item/storage/toolbox/syndicate = 1,
))

//комбо из всего
GLOBAL_LIST_INIT(scrap_poor, list(
	GLOB.scrap_trash = 20,
	GLOB.scrap_food = 10,
	GLOB.scrap_cloth = 10,
	GLOB.scrap_maintenance = 20,
	GLOB.scrap_material = 5,
	GLOB.scrap_industrial = 5,
	GLOB.scrap_medical = 5,
))
