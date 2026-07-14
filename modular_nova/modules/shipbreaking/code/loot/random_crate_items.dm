/// Create subtypes for the different sizes of crate for loot spawners
#define SALVAGE_CRATE_LOOT_SPAWNER(path) ##path/small {\
	spawn_loot_count = 3; \
} \
##path/medium {\
	spawn_loot_count = 5; \
} \
##path/large {\
	spawn_loot_count = 7; \
} \
##path/shipping {\
	spawn_loot_count = 10; \
}

// Crates

/obj/structure/closet/shipping_container/secured/random_loot
	/// List of spawners we can choose from
	var/list/loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/money/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/shipping,
	)
	/// The chance this crate has to spawn with nothing in it
	var/empty_chance = 25

/obj/structure/closet/shipping_container/secured/random_loot/PopulateContents()
	if(prob(empty_chance))
		return
	var/obj/effect/spawner/random/loot_spawner = pick(loot_spawners)
	new loot_spawner(src)

/obj/structure/closet/shipping_container/secured/random_loot/medical_or_research
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/shipping,
	)

/obj/structure/closet/shipping_container/secured/random_loot/construction
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/shipping,
	)

/obj/structure/closet/shipping_container/secured/random_loot/civilian_supply
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/shipping,
	)

/obj/structure/closet/shipping_container/secured/random_loot/military
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/shipping,
	)

/obj/structure/closet/shipping_container/secured/random_loot/salvage
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/shipping,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/shipping,
	)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot
	/// List of spawners we can choose from
	var/list/loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/money/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/large,
	)
	/// The chance this crate has to spawn with nothing in it
	var/empty_chance = 30

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/PopulateContents()
	if(prob(empty_chance))
		return
	var/obj/effect/spawner/random/loot_spawner = pick(loot_spawners)
	new loot_spawner(src)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/medical_or_research
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/large,
	)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/construction
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/large,
	)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/civilian_supply
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/large,
	)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/military
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/large,
	)

/obj/structure/closet/crate/shuttle_hard/secured/random_loot/salvage
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/large,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/large,
	)

/obj/structure/closet/crate/shuttle/secured/random_loot
	/// List of spawners we can choose from
	var/list/loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/money/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/medium,
	)
	/// The chance this crate has to spawn with nothing in it
	var/empty_chance = 40

/obj/structure/closet/crate/shuttle/secured/random_loot/PopulateContents()
	if(prob(empty_chance))
		return
	var/obj/effect/spawner/random/loot_spawner = pick(loot_spawners)
	new loot_spawner(src)

/obj/structure/closet/crate/shuttle/secured/random_loot/medical_or_research
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/medium,
	)

/obj/structure/closet/crate/shuttle/secured/random_loot/construction
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/medium,
	)

/obj/structure/closet/crate/shuttle/secured/random_loot/civilian_supply
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/medium,
	)

/obj/structure/closet/crate/shuttle/secured/random_loot/military
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/medium,
	)

/obj/structure/closet/crate/shuttle/secured/random_loot/salvage
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/medium,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/medium,
	)

/obj/structure/closet/crate/shuttle/small/secured/random_loot
	/// List of spawners we can choose from
	var/list/loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/money/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/small,
	)
	/// The chance this crate has to spawn with nothing in it
	var/empty_chance = 40

/obj/structure/closet/crate/shuttle/small/secured/random_loot/PopulateContents()
	if(prob(empty_chance))
		return
	var/obj/effect/spawner/random/loot_spawner = pick(loot_spawners)
	new loot_spawner(src)

/obj/structure/closet/crate/shuttle/small/secured/random_loot/medical_or_research
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk/small,
	)

/obj/structure/closet/crate/shuttle/small/secured/random_loot/construction
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/small,
	)

/obj/structure/closet/crate/shuttle/small/secured/random_loot/civilian_supply
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/produce/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/booze/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes/small,
	)

/obj/structure/closet/crate/shuttle/small/secured/random_loot/military
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/food/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/military/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything/small,
	)

/obj/structure/closet/crate/shuttle/small/secured/random_loot/salvage
	loot_spawners = list(
		/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/components/small,
		/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering/small,
	)

// Spawners

/obj/effect/spawner/random/salvage/crate_loot_spawner
	abstract_type = /obj/effect/spawner/random/salvage/crate_loot_spawner
	name = "crate contents spawner"

/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding
	name = "crate contents spawner (bedding)"
	loot = list(
		/obj/effect/spawner/random/bedsheet = 2,
		/obj/effect/spawner/random/bedsheet/double = 1,
		/obj/item/pillow/random = 2,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/bedding)

/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day
	name = "crate contents spawner (garbage)"
	loot = list(
		/obj/effect/spawner/random/trash/deluxe_garbage/no_mobs_ever,
		/obj/effect/spawner/random/maintenance/no_decals,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/garbage_day)

/obj/effect/spawner/random/salvage/crate_loot_spawner/food
	name = "crate contents spawner (food)"
	loot = list(
		/obj/effect/spawner/random/food_or_drink/any_snack_or_beverage,
		/obj/effect/spawner/random/epic_loot/random_provisions,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/food)

/obj/effect/spawner/random/salvage/crate_loot_spawner/produce
	name = "crate contents spawner (produce)"
	loot = list(
		/obj/effect/spawner/random/food_or_drink/plant_produce/one,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/produce)

/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds
	name = "crate contents spawner (seeds)"
	loot = list(
		/obj/effect/spawner/random/food_or_drink/seed_rare/one = 1,
		/obj/effect/spawner/random/food_or_drink/seed/one = 3,
		/obj/effect/spawner/random/food_or_drink/seed_flowers/one = 1,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/seeds)

/obj/effect/spawner/random/salvage/crate_loot_spawner/booze
	name = "crate contents spawner (booze)"
	loot = list(
		/obj/effect/spawner/random/food_or_drink/booze,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/booze)

/obj/effect/spawner/random/salvage/crate_loot_spawner/components
	name = "crate contents spawner (components)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/random_components,
		/obj/effect/spawner/random/epic_loot/random_computer_parts,
		/obj/effect/spawner/random/epic_loot/random_construction,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/components)

/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering
	name = "crate contents spawner (engineering)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/random_engineering,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/engineering)

/obj/effect/spawner/random/salvage/crate_loot_spawner/military
	name = "crate contents spawner (military)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/random_other_military_loot = 4,
		/obj/effect/spawner/random/epic_loot/random_documents = 1,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/military)

/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot
	name = "crate contents spawner (strongbox)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/random_strongbox_loot,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/safe_loot)

/obj/effect/spawner/random/salvage/crate_loot_spawner/money
	name = "crate contents spawner (money)"
	loot = list(
		/obj/effect/spawner/random/entertainment/money_small = 2,
		/obj/effect/spawner/random/entertainment/money = 1,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/money)

/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything
	name = "crate contents spawner (medical, anything)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/medical_everything,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_anything)

/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals
	name = "crate contents spawner (chemicals)"
	loot = list(
		/obj/effect/spawner/random/epic_loot/chemical = 2,
		/obj/effect/spawner/random/epic_loot/medpens = 2,
		/obj/effect/spawner/random/epic_loot/medpens_combat_based_redpilled = 1,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/chemicals)

/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk
	name = "crate contents spawner (medical, bulk)"
	loot = list(
		/obj/effect/spawner/random/medical/minor_healing = 4,
		/obj/effect/spawner/random/medical/supplies = 3,
		/obj/effect/spawner/random/medical/medkit = 3,
		/obj/effect/spawner/random/medical/medkit_rare = 1,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/medical_bulk)

/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes
	name = "crate contents spawner (cigarettes)"
	loot = list(
		/obj/effect/spawner/random/entertainment/cigarette_pack,
	)

SALVAGE_CRATE_LOOT_SPAWNER(/obj/effect/spawner/random/salvage/crate_loot_spawner/five_hundred_cigarettes)
