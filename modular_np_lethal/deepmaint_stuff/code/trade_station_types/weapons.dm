/obj/structure/epic_loot_crafting_bench/war
	name = "weapons trade station"
	desc = "A direct connection to an underworld trader known only as 'warlord', \
		who will exchange goods for many different types of weapons of war."
	icon_state = "trade_war"

	light_color = LIGHT_COLOR_YELLOW

	allowed_choices = list(
		// Melee (based)
		/datum/crafting_bench_recipe_real/sabre,
		/datum/crafting_bench_recipe_real/fire_axe,
		/datum/crafting_bench_recipe_real/bowie,
		/datum/crafting_bench_recipe_real/esword,
		/datum/crafting_bench_recipe_real/armblade,
		// Grenades
		/datum/crafting_bench_recipe_real/offensive_impact,
		/datum/crafting_bench_recipe_real/defensive_impact,
		/datum/crafting_bench_recipe_real/smoke_grenade,
		/datum/crafting_bench_recipe_real/pipe_bomb,
		/datum/crafting_bench_recipe_real/stingbang,
		/datum/crafting_bench_recipe_real/flashbang,
		// Gun stuff
		/datum/crafting_bench_recipe_real/suppressor,
		/datum/crafting_bench_recipe_real/zomushi,
		/datum/crafting_bench_recipe_real/signalis_rifle,
		/datum/crafting_bench_recipe_real/super_shotgun,
		/datum/crafting_bench_recipe_real/seiba,
		/datum/crafting_bench_recipe_real/sindano,
		/datum/crafting_bench_recipe_real/shotgun,
		/datum/crafting_bench_recipe_real/sakhno,
		/datum/crafting_bench_recipe_real/sakhno_larp,
		/datum/crafting_bench_recipe_real/boxer,
		/datum/crafting_bench_recipe_real/chokyu,
		/datum/crafting_bench_recipe_real/suppressed_rifle,
		/datum/crafting_bench_recipe_real/auto_shotgun,
	)

/obj/structure/epic_loot_crafting_bench/war/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>2</b> computer power supplies = <b>1</b> fancy sabre")
	. += span_notice("<b>1</b> intelligence folder + <b>1</b> corporate data folder = <b>1</b> fire axe")
	. += span_notice("<b>1</b> box of nails = <b>1</b> bowie knife")
	. += span_notice("<b>1</b> shuttle battery = <b>1</b> energy sword")
	. += span_notice("<b>1</b> shuttle gyroscope = <b>1</b> implanted armblade")
	. += span_notice("<b>1</b> grenade fuze + <b>1</b> plasma explosive = <b>2</b> offensive impact grenades")
	. += span_notice("<b>1</b> grenade fuze + <b>1</b> plasma explosive + <b>1</b> box of nails = <b>2</b> defensive impact grenades")
	. += span_notice("<b>1</b> slim diary = <b>2</b> smoke bombs")
	. += span_notice("<b>1</b> grenade fuze + <b>1</b> water filter = <b>2</b> improvised explosives")
	. += span_notice("<b>1</b> thermometer + <b>1</b> box of nails = <b>2</b> sting bangs")
	. += span_notice("<b>1</b> thermometer = <b>2</b> flashbangs")
	. += span_notice("<b>1</b> water filter = <b>1</b> suppressor")
	. += span_notice("<b>1</b> solid state drive = <b>1</b> binoculars")
	. += span_notice("<b>2</b> device fans = <b>1</b> zomushi pistol")
	. += span_notice("<b>1</b> display = <b>1</b> fukiya rifle")
	. += span_notice("<b>2</b> broken displays = <b>1</b> seiba submachinegun")
	. += span_notice("<b>1</b> graphics processor = <b>1</b> sindano submachinegun")
	. += span_notice("<b>1</b> military circuit board + <b>1</b> civilian circuit board = <b>1</b> renoster shotgun")
	. += span_notice("<b>1</b> processor core = <b>1</b> sakhno-xhihao rifle")
	. += span_notice("<b>2</b> sealed diaries = <b>1</b> rengo precision rifle")
	. += span_notice("<b>1</b> power supply + <b>1</b> disk drive = <b>1</b> bogseo submachinegun")
	. += span_notice("<b>1</b> eyes = <b>1</b> zomushi pistol")
	. += span_notice("<b>1</b> stomach = <b>1</b> ramu 6ga shotgun")
	. += span_notice("<b>1</b> lungs = <b>1</b> yari suppressed rifle")
	. += span_notice("<b>2</b> livers = <b>1</b> nomi repeating shotgun")

	return .

// Melee weapons (based)

/datum/crafting_bench_recipe_real/sabre
	recipe_name = "fancy sabre"
	recipe_requirements = list(
		/obj/item/epic_loot/power_supply = 2,
	)
	resulting_item = /obj/item/storage/belt/sabre
	amount_to_make = 1

/datum/crafting_bench_recipe_real/fire_axe
	recipe_name = "fire axe"
	recipe_requirements = list(
		/obj/item/epic_loot/intel_folder = 1,
		/obj/item/epic_loot/corpo_folder = 1,
	)
	resulting_item = /obj/item/fireaxe
	amount_to_make = 1

/datum/crafting_bench_recipe_real/bowie
	recipe_name = "bowie knife"
	recipe_requirements = list(
		/obj/item/epic_loot/nail_box = 1,
	)
	resulting_item = /obj/item/storage/belt/bowie_sheath
	amount_to_make = 1

/datum/crafting_bench_recipe_real/esword
	recipe_name = "energy sword"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_battery = 1,
	)
	resulting_item = /obj/item/melee/energy/sword
	amount_to_make = 1

/datum/crafting_bench_recipe_real/armblade
	recipe_name = "implanted armblade"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_gyro = 1,
	)
	resulting_item = /obj/item/autosurgeon/armblade
	amount_to_make = 1

// Grenades

/datum/crafting_bench_recipe_real/offensive_impact
	recipe_name = "offensive impact grenade"
	recipe_requirements = list(
		/obj/item/epic_loot/grenade_fuze = 1,
		/obj/item/epic_loot/plasma_explosive = 1,
	)
	resulting_item = /obj/item/grenade/syndieminibomb/concussion/impact
	amount_to_make = 2

/datum/crafting_bench_recipe_real/defensive_impact
	recipe_name = "defensive impact grenade"
	recipe_requirements = list(
		/obj/item/epic_loot/grenade_fuze = 1,
		/obj/item/epic_loot/plasma_explosive = 1,
		/obj/item/epic_loot/nail_box = 1,
	)
	resulting_item = /obj/item/grenade/frag/impact
	amount_to_make = 2

/datum/crafting_bench_recipe_real/smoke_grenade
	recipe_name = "smoke grenade"
	recipe_requirements = list(
		/obj/item/epic_loot/slim_diary = 1,
	)
	resulting_item = /obj/item/grenade/smokebomb
	amount_to_make = 2

/datum/crafting_bench_recipe_real/pipe_bomb
	recipe_name = "improvised explosive"
	recipe_requirements = list(
		/obj/item/epic_loot/grenade_fuze = 1,
		/obj/item/epic_loot/water_filter = 1,
	)
	resulting_item = /obj/item/grenade/iedcasing/spawned
	amount_to_make = 2

/datum/crafting_bench_recipe_real/stingbang
	recipe_name = "stingbang"
	recipe_requirements = list(
		/obj/item/epic_loot/thermometer = 1,
		/obj/item/epic_loot/nail_box = 1,
	)
	resulting_item = /obj/item/grenade/stingbang
	amount_to_make = 2

/datum/crafting_bench_recipe_real/flashbang
	recipe_name = "flashbang"
	recipe_requirements = list(
		/obj/item/epic_loot/thermometer = 1,
	)
	resulting_item = /obj/item/grenade/flashbang
	amount_to_make = 2

// Gun stuff

/datum/crafting_bench_recipe_real/suppressor
	recipe_name = "suppressor"
	recipe_requirements = list(
		/obj/item/epic_loot/water_filter = 1,
	)
	resulting_item = /obj/item/suppressor/standard

/datum/crafting_bench_recipe_real/zomushi
	recipe_name = "zomushi pistol"
	recipe_requirements = list(
		/obj/item/epic_loot/device_fan = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/pistol/weevil

/datum/crafting_bench_recipe_real/signalis_rifle
	recipe_name = "fukiya rifle"
	recipe_requirements = list(
		/obj/item/epic_loot/display = 1,
	)
	resulting_item = /obj/item/gun/ballistic/marsian_super_rifle

/datum/crafting_bench_recipe_real/seiba
	recipe_name = "seiba submachinegun"
	recipe_requirements = list(
		/obj/item/epic_loot/display_broken = 2,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/seiba_smg

/datum/crafting_bench_recipe_real/sindano
	recipe_name = "sindano submachinegun"
	recipe_requirements = list(
		/obj/item/epic_loot/graphics = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/sol_smg/evil

/datum/crafting_bench_recipe_real/shotgun
	recipe_name = "renoster shotgun"
	recipe_requirements = list(
		/obj/item/epic_loot/military_circuit = 1,
		/obj/item/epic_loot/civilian_circuit = 1,
	)
	resulting_item = /obj/item/gun/ballistic/shotgun/riot/sol/evil/thunderdome

/datum/crafting_bench_recipe_real/sakhno
	recipe_name = "sakhno-xhihao rifle"
	recipe_requirements = list(
		/obj/item/epic_loot/processor = 1,
	)
	resulting_item = /obj/item/gun/ballistic/rifle/boltaction/prime

/datum/crafting_bench_recipe_real/sakhno_larp
	recipe_name = "rengo precision rifle"
	recipe_requirements = list(
		/obj/item/epic_loot/diary = 2,
	)
	resulting_item = /obj/item/gun/ballistic/rifle/boltaction/sporterized

/datum/crafting_bench_recipe_real/boxer
	recipe_name = "bogseo submachinegun"
	recipe_requirements = list(
		/obj/item/epic_loot/power_supply = 1,
		/obj/item/epic_loot/disk_drive = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/xhihao_smg

// Guns that require killing your fellow man to attain

/datum/crafting_bench_recipe_real/chokyu
	recipe_name = "chokyu sniper rifle"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/gun/ballistic/rifle/chokyu

/datum/crafting_bench_recipe_real/super_shotgun
	recipe_name = "ramu 6ga shotgun"
	recipe_requirements = list(
		/obj/item/organ/internal/stomach = 1,
	)
	resulting_item = /obj/item/gun/ballistic/shotgun/ramu

/datum/crafting_bench_recipe_real/suppressed_rifle
	recipe_name = "yari suppressed rifle"
	recipe_requirements = list(
		/obj/item/organ/internal/lungs = 1,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/suppressed_rifle

/datum/crafting_bench_recipe_real/auto_shotgun
	recipe_name = "nomi repeating shotgun"
	recipe_requirements = list(
		/obj/item/organ/internal/liver = 2,
	)
	resulting_item = /obj/item/gun/ballistic/automatic/nomi_shotgun
