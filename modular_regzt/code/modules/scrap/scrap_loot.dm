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
	GLOB.trash_loot = 1,
	/obj/effect/spawner/random/engineering/material_rare = 1,
	/obj/item/stack/sheet/plastic = 1,
	/obj/item/stack/sheet/iron = 1,
	/obj/item/stack/sheet/glass = 1,
	/obj/item/stack/sheet/plasteel = 1,
	/obj/item/stack/sheet/mineral/wood = 1,
	/obj/item/shard = 1,
	/obj/item/stack/rods = 1,
	))

GLOBAL_LIST_INIT(scrap_medical, list(
	/obj/effect/spawner/random/medical/minor_healing = 4,
	/obj/effect/spawner/random/medical/injector = 1,
	/obj/effect/spawner/random/medical/organs = 1,
	/obj/effect/spawner/random/medical/memeorgans = 1,
	/obj/effect/spawner/random/medical/two_percent_xeno_egg_spawner = 1,
	/obj/effect/spawner/random/medical/surgery_tool = 1,
	/obj/effect/spawner/random/medical/medkit_rare = 1,
	/obj/effect/spawner/random/medical/medkit = 1,
	/obj/effect/spawner/random/medical/patient_stretcher = 1,
	/obj/effect/spawner/random/medical/supplies = 1,
	GLOB.trash_loot = 4,
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
/*
//бля лан похуй потом
//ПОЗЖЕ ДОБАВИТЬ В НИЖНИЙ СПИСОК
GLOBAL_LIST_INIT(techscience, list(
	/obj/effect/spawner/random/techstorage/data_disk = 1,
	/obj/effect/spawner/random/techstorage/arcade_boards = 1,
	/obj/effect/spawner/random/techstorage/service_all = 1,
	/obj/effect/spawner/random/techstorage/rnd_all = 1,
	/obj/effect/spawner/random/techstorage/tcomms_all = 1,
	))
*/
GLOBAL_LIST_INIT(scrap_science, list(
	GLOB.trash_loot = 2,
	/obj/item/shard = 1,
	/obj/item/stack/rods = 1,
	GLOB.tier1_reward = 1,
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
	GLOB.trash_loot = 10,
	))

GLOBAL_LIST_INIT(scrap_industrial, list(
	GLOB.trash_loot = 2,
	/obj/effect/spawner/random/engineering/tool = 2,
	/obj/effect/spawner/random/trash/garbage = 4,
	/obj/effect/spawner/random/trash/deluxe_garbage = 2,
	/obj/item/shard = 1,
	/obj/item/stack/rods = 1,
	/obj/item/storage/toolbox = 1,
	/obj/item/storage/toolbox/electrical = 1,
	/obj/item/storage/toolbox/mechanical = 1,
	/obj/item/storage/toolbox/emergency = 1,
	/obj/item/storage/toolbox/artistic = 1,
	/obj/item/storage/toolbox/syndicate = 1,
	))

//комбо из всего
GLOBAL_LIST_INIT(scrap_poor, list(
	GLOB.scrap_maintenance = 1,
	GLOB.scrap_trash = 1,
	GLOB.scrap_material = 1,
	GLOB.scrap_medical = 1,
	GLOB.scrap_food = 1,
	GLOB.scrap_cloth = 1,
	GLOB.scrap_industrial = 1,
	))
