/obj/effect/spawner/random/xenoarch/tier1
	name = "Xenoarch Tier 1 Rewards"
	desc = "Rewards for Tier 1 xenoarch rocks"
	loot = list(
		/obj/item/coin/silver/ancient = 2, // always ensure coins are 20-25% of the total weight.
		/obj/item/coin/gold/ancient = 1,
		/obj/item/xenoarch/broken_item/plant = 2,
		/obj/item/xenoarch/broken_item/animal = 2,
		/obj/item/xenoarch/broken_item/t1 = 4,
	)

/obj/effect/spawner/random/xenoarch/tier2
	name = "Xenoarch Tier 2 Rewards"
	desc = "Rewards for Tier 2 xenoarch rocks"
	loot = list(
		/obj/item/coin/gold/ancient = 2, // always ensure coins are 20-25% of the total weight.
		/obj/item/coin/adamantine/ancient = 1,
		/obj/item/xenoarch/broken_item = 4,
		/obj/item/xenoarch/broken_item/weapon = 2,
		/obj/item/xenoarch/broken_item/clothing = 3,
		/obj/item/xenoarch/broken_item/illegal = 2,
		/obj/item/xenoarch/broken_item/alien = 2,
	)

/obj/effect/spawner/random/xenoarch/tier3
	name = "Xenoarch Tier 3 Rewards"
	desc = "Rewards for Tier 3 xenoarch rocks"
	loot = list(
		/obj/item/coin/adamantine/ancient = 2, // always ensure coins are 20-25% of the total weight.
		/obj/item/coin/mythril/ancient = 1,
		/obj/item/xenoarch/broken_item/weapon/t3 = 3,
		/obj/item/xenoarch/broken_item/illegal/t3 = 3,
		/obj/item/xenoarch/broken_item/alien/t3 = 3,
		/obj/item/xenoarch/broken_item/clothing/t3 = 3,
	)

/obj/effect/spawner/random/xenoarch/plant
	name = "Xenoarch Plant Rewards"
	desc = "Plant-related xenoarchaeology rewards."
	spawn_loot_count = 2
	loot = list(
		/obj/item/seeds/random = 2,
		/obj/item/seeds/gelthi = 1,
		/obj/item/seeds/amauri = 1,
		/obj/item/seeds/jurlmah = 1,
		/obj/item/seeds/nofruit = 1,
		/obj/item/seeds/shand = 1,
		/obj/item/seeds/surik = 1,
		/obj/item/seeds/telriis = 1,
		/obj/item/seeds/thaadra = 1,
		/obj/item/seeds/vale = 1,
		/obj/item/seeds/vaporsac = 1,
		/obj/item/seeds/honeysuckle = 1,
	)

/obj/effect/spawner/random/xenoarch/animal
	name = "Xenoarch Animal Rewards"
	desc = "Xenoarchaeology animal parts stuff."
	spawn_loot_count = 2
	loot = list(
		/obj/item/stack/sheet/sinew/five = 1,
		/obj/item/stack/sheet/bone/ten = 1,
		/obj/item/stack/sheet/animalhide/goliath_hide/three = 1,
		/obj/effect/spawner/random/animalhide = 1,
		/obj/item/organ/monster_core/regenerative_core/legion/preserved = 2,
		/obj/item/organ/monster_core/brimdust_sac/preserved = 1,
		/obj/item/organ/monster_core/rush_gland/preserved = 1,
		/obj/item/food/egg/watcher = 1,
		/obj/item/food/egg/watcher/raptor = 2,
	)

/obj/effect/spawner/random/xenoarch
	name = "Xenoarch Technological Rewards"
	desc = "Xenoarchaeology station mid tier."
	loot = list(
		/obj/item/stock_parts/power_store/cell/self_charge/exotic = 1,
		/obj/item/survivalcapsule/luxury = 1,
		/obj/item/clothing/glasses/hud/health/night/meson = 1,
		/obj/item/v8_engine = 1,
		/obj/item/gun/medbeam = 1,
		/obj/item/storage/box/shuttle_construction_kit = 1,
		/obj/item/flatpacked_machine = 1, // RCF
		/obj/item/hearthkin_ship_fragment_inactive/xenoarch = 1, // this turns into five /obj/item/stack/sheet/mineral/runite in lavaland maps
	)

/obj/effect/spawner/random/xenoarch/t1
	name = "Xenoarch Technological Rewards"
	desc = "Xenoarchaeology station low tier."
	loot = list(
		/obj/item/stock_parts/power_store/cell/self_charge = 1,
		/obj/item/bodybag/bluespace = 1,
		/obj/effect/spawner/random/exotic/languagebook = 1,
		/obj/item/storage/box/minerdeathrattle = 1,
		/obj/item/construction/plumbing = 1,
		/obj/item/storage/portable_chem_mixer = 1,
		/mob/living/basic/bot/medbot/xenoarch = 1,
		/obj/item/survivalcapsule = 1,
		/obj/item/gun/energy/plasmacutter = 1,
		/obj/item/grapple_gun = 1,
		/obj/item/flatpacked_machine = 1, // RCF - put it both on t1 and t2 lists, its on purpose.
		/obj/item/hearthkin_ship_fragment_inactive/xenoarch = 1, // this turns into five /obj/item/stack/sheet/mineral/runite in lavaland maps
	)

/obj/effect/spawner/random/xenoarch/clothing
	name = "Xenoarch Clothing Rewards"
	desc = "Xenoarchaeology clothing and armor related loot."
	loot = list(
		/obj/item/clothing/gloves/tackler/rocket = 1, 
		/obj/item/clothing/gloves/tackler/dolphin = 1,
		/obj/item/storage/box/fakesyndiesuit/voskhod = 1,
		/obj/item/clothing/suit/hooded/cloak/goliath = 1,
		/obj/item/gravity_harness = 1,
		/obj/item/clothing/shoes/bhop/rocket = 1,
		/obj/item/mod/control/pre_equipped/mining = 1,
	)

/obj/effect/spawner/random/xenoarch/clothing/t3
	name = "Xenoarch Clothing Rewards T3"
	desc = "Xenoarchaeology high tier clothing and armor related loot."
	loot = list(
		/obj/item/clothing/accessory/pandora_hope/faded = 1,
		/obj/item/shield/buckler/faded = 1,
		/obj/item/clothing/head/cowboy/bounty/deadman = 1,
	)

/obj/effect/spawner/random/xenoarch/weapon
	name = "Xenoarch Weapon Rewards"
	desc = "Xenoarchaeology weapons loot."
	loot = list(
		/obj/item/claymore/cutlass/old = 1,
		/obj/item/melee/energy/sword/surplus = 2,
		/obj/item/storage/belt/holster/energy/laser_pistol = 1,
		/obj/item/storage/backpack/duffelbag/mining_conscript = 1,
	)

/obj/effect/spawner/random/xenoarch/weapon/t3
	name = "Xenoarch Weapon Rewards T3"
	desc = "Xenoarchaeology high tier weapons loot."
	loot = list(
		/obj/item/claymore/cutlass = 1,
		/obj/item/nullrod/tribal_knife = 1,
		/obj/item/claymore/dragonslayer = 1,
	)

/obj/effect/spawner/random/xenoarch/illegal
	name = "Xenoarch Illegal Rewards"
	desc = "Xenoarchaeology contraband loot."
	loot = list(
		/obj/item/storage/box/incomplete_chameleon = 1,
		/obj/item/pen/edagger = 1,
		/obj/item/clothing/shoes/chameleon/noslip/xenoarch = 1,
		/obj/item/clothing/gloves/color/black/thief/xenoarch = 1,
	)

/obj/effect/spawner/random/xenoarch/illegal/t3
	name = "Xenoarch Illegal Rewards T3"
	desc = "Xenoarchaeology high tier contraband loot."
	loot = list(
		/obj/item/card/emag/doorjack = 1,
		/obj/item/melee/energy/sword/bananium = 1,
		/obj/item/construction/rcd/improved = 1,
	)

/obj/effect/spawner/random/xenoarch/alien
	name = "Xenoarch Alien Rewards"
	desc = "Xenoarchaeology alien origin loot."
	loot = list(
		/obj/item/multitool/abductor = 1,
		/obj/effect/spawner/random/engineering/tool_alien = 1,
		/obj/effect/spawner/random/medical/surgery_tool_alien = 1,
		/obj/item/slimecross/regenerative/grey = 1,
	)

/obj/effect/spawner/random/xenoarch/alien/t3
	name = "Xenoarch Alien Rewards T3"
	desc = "Xenoarchaeology high tier alien origin loot."
	loot = list(
		/obj/item/abductor/alien_omnitool = 1,
		/obj/item/storage/belt/military/abductor/full = 1,
		/obj/item/stock_parts/power_store/cell/self_charge/anomalous = 1,
	)
