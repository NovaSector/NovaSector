/datum/crafting_bench_recipe_real
	/// The name of the recipe to show
	var/recipe_name = "generic debug recipe"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/resulting_item = /obj/item/forging

// Grenades

/datum/crafting_bench_recipe_real/concussion_grenade
	recipe_name = "concussion grenade"
	recipe_requirements = list(
		/obj/item/epic_loot/grenade_fuze = 1,
		/obj/item/epic_loot/plasma_explosive = 1,
	)
	resulting_item = /obj/item/grenade/syndieminibomb/concussion

/datum/crafting_bench_recipe_real/pipe_bomb
	recipe_name = "improvised explosive"
	recipe_requirements = list(
		/obj/item/epic_loot/grenade_fuze = 1,
		/obj/item/epic_loot/water_filter = 1,
	)
	resulting_item = /obj/item/grenade/iedcasing/spawned

/datum/crafting_bench_recipe_real/stingbang
	recipe_name = "stingbang"
	recipe_requirements = list(
		/obj/item/epic_loot/thermometer = 1,
		/obj/item/epic_loot/nail_box = 1,
	)
	resulting_item = /obj/item/grenade/stingbang

/datum/crafting_bench_recipe_real/flashbang
	recipe_name = "flashbang"
	recipe_requirements = list(
		/obj/item/epic_loot/thermometer = 1,
	)
	resulting_item = /obj/item/grenade/flashbang

// Gun stuff

/datum/crafting_bench_recipe_real/suppressor
	recipe_name = "suppressor"
	recipe_requirements = list(
		/obj/item/epic_loot/water_filter = 1,
	)
	resulting_item = /obj/item/suppressor/standard

/datum/crafting_bench_recipe_real/eland
	recipe_name = "eland revolver"
	recipe_requirements = list(
		/obj/item/epic_loot/device_fan = 2,
	)
	resulting_item = /obj/item/gun/ballistic/revolver/sol

/datum/crafting_bench_recipe_real/bobr
	recipe_name = "12ga revolver"
	recipe_requirements = list(
		/obj/item/epic_loot/display = 1,
	)
	resulting_item = /obj/item/gun/ballistic/revolver/shotgun_revolver

/datum/crafting_bench_recipe_real/projector
	recipe_name = "plasma projector"
	recipe_requirements = list(
		/obj/item/epic_loot/display_broken = 2,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/pistol/plasma_thrower

/datum/crafting_bench_recipe_real/sindano
	recipe_name = "sindano submachinegun"
	recipe_requirements = list(
		/obj/item/epic_loot/graphics = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/sol_smg

/datum/crafting_bench_recipe_real/shotgun
	recipe_name = "renoster shotgun"
	recipe_requirements = list(
		/obj/item/epic_loot/military_circuit = 1,
		/obj/item/epic_loot/civilian_circuit = 1,
	)
	resulting_item = /obj/item/gun/ballistic/shotgun/riot/sol

/datum/crafting_bench_recipe_real/sakhno
	recipe_name = "sakhno M2442 rifle"
	recipe_requirements = list(
		/obj/item/epic_loot/processor = 1,
	)
	resulting_item = /obj/item/gun/ballistic/rifle/boltaction/surplus

/datum/crafting_bench_recipe_real/boxer
	recipe_name = "bogseo submachinegun"
	recipe_requirements = list(
		/obj/item/epic_loot/power_supply = 1,
		/obj/item/epic_loot/disk_drive = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/xhihao_smg

// Glasses

/datum/crafting_bench_recipe_real/coolglasses
	recipe_name = "sunglasses"
	recipe_requirements = list(
		/obj/item/epic_loot/slim_diary = 1,
	)
	resulting_item = /obj/item/clothing/glasses/sunglasses/big

/datum/crafting_bench_recipe_real/nvg
	recipe_name = "night vision goggles"
	recipe_requirements = list(
		/obj/item/epic_loot/signal_amp = 1,
		/obj/item/epic_loot/current_converter = 1,
	)
	resulting_item = /obj/item/clothing/glasses/thermal

/datum/crafting_bench_recipe_real/thermals
	recipe_name = "thermal vision goggles"
	recipe_requirements = list(
		/obj/item/epic_loot/cold_weld = 1,
		/obj/item/epic_loot/signal_amp = 1,
		/obj/item/epic_loot/thermal_camera = 1,
	)
	resulting_item = /obj/item/clothing/glasses/thermal

// Armor

/datum/crafting_bench_recipe_real/flak_jacket
	recipe_name = "flak jacket"
	recipe_requirements = list(
		/obj/item/epic_loot/aramid = 1,
	)
	resulting_item = /obj/item/clothing/suit/frontier_colonist_flak

/datum/crafting_bench_recipe_real/flak_helmet
	recipe_name = "soft helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/aramid = 1,
	)
	resulting_item = /obj/item/clothing/head/frontier_colonist_helmet

/datum/crafting_bench_recipe_real/soft_vest
	recipe_name = "soft armor vest"
	recipe_requirements = list(
		/obj/item/epic_loot/ripstop = 1,
		/obj/item/epic_loot/cordura = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_peacekeeper/debranded

/datum/crafting_bench_recipe_real/un_helmet
	recipe_name = "ballistic helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/electric_motor = 1,
		/obj/item/epic_loot/cordura = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/sf_peacekeeper/debranded

/datum/crafting_bench_recipe_real/sacrificial_vest
	recipe_name = "sacrificial armor vest"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_gyro = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_sacrificial

/datum/crafting_bench_recipe_real/sacrificial_helmet
	recipe_name = "sacrificial helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_battery = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/sf_sacrificial/spawns_with_shield

// Headsets

/datum/crafting_bench_recipe_real/talker_set
	recipe_name = "frontier headset"
	recipe_requirements = list(
		/obj/item/epic_loot/fuel_conditioner = 1,
	)
	resulting_item = /obj/item/radio/headset/headset_frontier_colonist

/datum/crafting_bench_recipe_real/bowman
	recipe_name = "bowman headset"
	recipe_requirements = list(
		/obj/item/epic_loot/phased_array = 2,
	)
	resulting_item = /obj/item/radio/headset/headset_sec/alt

// Medical stuff

/datum/crafting_bench_recipe_real/super_medkit
	recipe_name = "satchel medical kit"
	recipe_requirements = list(
		/obj/item/epic_loot/eye_scope = 1,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked

/datum/crafting_bench_recipe_real/super_medkit_ultra
	recipe_name = "advanced satchel medical kit"
	recipe_requirements = list(
		/obj/item/epic_loot/vein_finder = 1,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/super

/datum/crafting_bench_recipe_real/slewa
	recipe_name = "frontier first aid kit"
	recipe_requirements = list(
		/obj/item/epic_loot/press_pass = 1,
	)
	resulting_item = /obj/item/storage/medkit/frontier/stocked

// Misc tools

/datum/crafting_bench_recipe_real/binoculars
	recipe_name = "binoculars"
	recipe_requirements = list(
		/obj/item/epic_loot/ssd = 1,
	)
	resulting_item = /obj/item/binoculars

/datum/crafting_bench_recipe_real/duffelpack
	recipe_name = "assault pack"
	recipe_requirements = list(
		/obj/item/epic_loot/hdd = 1,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/syndie/nri/captain

/datum/crafting_bench_recipe_real/dogtag_case
	recipe_name = "tag case"
	recipe_requirements = list(
		/obj/item/epic_loot/military_flash = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_tag_case

/datum/crafting_bench_recipe_real/sick_case
	recipe_name = "organizational pouch"
	recipe_requirements = list(
		/obj/item/epic_loot/corpo_folder = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_org_pouch

/datum/crafting_bench_recipe_real/docs_bag
	recipe_name = "organizational pouch"
	recipe_requirements = list(
		/obj/item/epic_loot/silver_chainlet = 1,
		/obj/item/epic_loot/gold_chainlet = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_docs_case

/datum/crafting_bench_recipe_real/ballistic_shield
	recipe_name = "ballistic shield"
	recipe_requirements = list(
		/obj/item/epic_loot/diary = 1,
	)
	resulting_item = /obj/item/shield/ballistic

/datum/crafting_bench_recipe_real/black_keycard
	recipe_name = "black keycard"
	recipe_requirements = list(
		/obj/item/epic_loot/intel_folder = 3,
	)
	resulting_item = /obj/item/keycard/epic_loot/black
