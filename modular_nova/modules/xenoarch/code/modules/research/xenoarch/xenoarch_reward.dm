/obj/effect/spawner/random/xenoarch/tier1
	name = "Xenoarch Tier 1 Rewards"
	desc = "Rewards for Tier 1 xenoarch rocks"
	loot = list(
		/obj/item/coin/gold/ancient = 10,
		/obj/item/xenoarch/broken_item/plant = 10,
		/obj/item/xenoarch/broken_item/clothing = 5,
		/obj/item/xenoarch/broken_item/animal = 10,
		/obj/item/xenoarch/broken_item = 5,
		/obj/item/xenoarch/broken_item/weapon = 1,
		/obj/item/relic/lavaland/activated = 2,
	)

/obj/effect/spawner/random/xenoarch/tier3
	name = "Xenoarch Tier 2 Rewards"
	desc = "Rewards for Tier 2 xenoarch rocks"
	loot = list(
		/obj/item/coin/adamantine/ancient = 5,
		/obj/item/xenoarch/broken_item = 10,
		/obj/item/xenoarch/broken_item/weapon = 1,
		/obj/item/xenoarch/broken_item/clothing = 10,
		/obj/item/xenoarch/broken_item/illegal = 1,
		/obj/item/xenoarch/broken_item/alien = 1,
		/obj/item/relic/lavaland/activated = 1,
	)

/obj/effect/spawner/random/xenoarch/tier2
	name = "Xenoarch Tier 3 Rewards"
	desc = "Rewards for Tier 3 xenoarch rocks"
	loot = list(
		/obj/item/coin/mythril/ancient = 5,
		/obj/item/xenoarch/broken_item/weapon = 10,
		/obj/item/xenoarch/broken_item/illegal = 10,
		/obj/item/xenoarch/broken_item/alien = 10,
		/obj/item/xenoarch/broken_item = 5,
	)

/obj/effect/spawner/random/xenoarch/plant
	name = "Xenoarch Plant Rewards"
	desc = "Plant-related xenoarchaeology rewards."
	spawn_loot_count = 2
	loot = list(
		/obj/item/food/grown/gelthi = 1,
		/obj/item/seeds/random = 2,
		/obj/item/food/grown/amauri = 1,
		/obj/item/food/grown/jurlmah = 1,
		/obj/item/food/grown/nofruit = 1,
		/obj/item/food/grown/shand = 1,
		/obj/item/food/grown/surik = 1,
		/obj/item/food/grown/telriis = 1,
		/obj/item/food/grown/thaadra = 1,
		/obj/item/food/grown/vale = 1,
		/obj/item/food/grown/vaporsac = 1,
		/obj/item/food/grown/honeysuckle = 1,
	)

/obj/effect/spawner/random/xenoarch/animal
	name = "Xenoarch Animal Rewards"
	desc = "Xenoarchaeology animal parts stuff. It also spawns with random cytology cells and viruses."
	spawn_loot_count = 2
	loot = list(
		/obj/item/stack/sheet/sinew/five = 1,
		/obj/item/stack/sheet/animalhide/goliath_hide/three = 1,
		/obj/item/stack/sheet/bone/ten = 1,
		/obj/effect/spawner/random/animalhide = 2,
		/obj/item/organ/monster_core/regenerative_core/legion/preserved = 4,
		/obj/item/organ/monster_core/brimdust_sac/preserved = 2,
		/obj/item/organ/monster_core/rush_gland/preserved = 2,
	)

/obj/effect/spawner/random/xenoarch
	name = "Xenoarch Technological Rewards"
	desc = "Xenoarchaeology station tier but relative rare loot."
	loot = list(
		/obj/item/relic/lavaland/activated = 4,
		/obj/effect/spawner/random/exotic/technology = 5,
		/obj/item/grapple_gun = 3,
		/obj/item/stock_parts/power_store/cell/self_charge = 4,
		/obj/item/stock_parts/power_store/cell/self_charge/exotic = 2,
		/obj/item/flatpacked_machine = 4, // RCF
		/obj/item/construction/rcd = 4,
		/obj/item/bodybag/bluespace = 1,
		/obj/item/construction/plumbing = 1,
		/obj/item/storage/portable_chem_mixer = 1,
		/obj/item/pickaxe/drill/diamonddrill = 2,
		/obj/item/v8_engine = 1,
		/obj/item/hearthkin_ship_fragment_inactive/xenoarch = 3, // this turns into a /obj/item/relic/lavaland/activated in lavaland maps
	)

/obj/effect/spawner/random/xenoarch/clothing
	name = "Xenoarch Clothing Rewards"
	desc = "Xenoarchaeology clothing and armor related loot."
	loot = list(
		/obj/item/mod/control/pre_equipped/frontier_colonist = 6,
		/obj/item/mod/control/pre_equipped/mining = 4,
		/obj/item/clothing/gloves/tackler/rocket = 4, 
		/obj/item/clothing/gloves/tackler/dolphin = 4,
		/obj/item/storage/box/fakesyndiesuit/voskhod = 4,
		/obj/item/clothing/suit/hooded/cloak/goliath = 4,
		/obj/item/clothing/shoes/bhop/rocket = 2,
	)

/obj/effect/spawner/random/xenoarch/weapon
	name = "Xenoarch Weapon Rewards"
	desc = "Xenoarchaeology weapons loot."
	
	loot = list(
		/obj/item/claymore/weak = 3,
		/obj/item/claymore/cutlass/old = 3,
		/obj/item/claymore = 2,
		/obj/item/claymore/cutlass = 2,
		/obj/item/melee/energy/sword/surplus = 4, // This is the type 1, with 50% block.
		/obj/item/melee/baseball_bat/ablative = 4,
		/obj/item/nullrod/tribal_knife = 2,
		/obj/item/gun/energy/recharge/fisher = 2,
		/obj/item/claymore/dragonslayer = 1, // only way to get it. hopefully the list is big enough to make it rare.
	)

/obj/effect/spawner/random/xenoarch/illegal
	name = "Xenoarch Illegal Rewards"
	desc = "Xenoarchaeology contraband loot."
	loot = list(
		/obj/item/card/emag/doorjack = 3,
		/obj/item/clothing/shoes/chameleon/noslip = 2,
		/obj/item/storage/box/incomplete_chameleon = 3, // we use this modified box so it doesnt give illegal tech
		/obj/item/clothing/gloves/color/black/thief = 2,
		/obj/item/pen/edagger = 4,
		/obj/item/melee/energy/sword = 1,
	)

/obj/effect/spawner/random/xenoarch/alien
	name = "Xenoarch Alien Rewards"
	desc = "Xenoarchaeology alien origin loot."
	loot = list(
		/obj/item/multitool/abductor = 2,
		/obj/effect/spawner/random/engineering/tool_alien = 2,
		/obj/effect/spawner/random/medical/surgery_tool_alien = 2,
		/obj/item/abductor/alien_omnitool = 2,
		/obj/item/storage/belt/military/abductor/full = 2,
	)
