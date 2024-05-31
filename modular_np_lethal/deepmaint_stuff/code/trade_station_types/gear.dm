/obj/structure/epic_loot_crafting_bench/gear
	name = "equipment trade station"
	desc = "A direct connection to an underworld supplier known only as 'tekkie', \
		who will exchange goods for various pieces of important equipment."
	icon_state = "trade_gear"

	light_color = LIGHT_COLOR_BLUE

	allowed_choices = list(
		/datum/crafting_bench_recipe_real/binoculars,
		/datum/crafting_bench_recipe_real/duffelpack,
		/datum/crafting_bench_recipe_real/sec_belt,
		/datum/crafting_bench_recipe_real/ammo_pouch,
		/datum/crafting_bench_recipe_real/cowboy_holster,
		/datum/crafting_bench_recipe_real/assault_belt,
		/datum/crafting_bench_recipe_real/grenade_belt,
		/datum/crafting_bench_recipe_real/chest_rig,
		/datum/crafting_bench_recipe_real/dogtag_case,
		/datum/crafting_bench_recipe_real/sick_case,
		/datum/crafting_bench_recipe_real/docs_bag,
		/datum/crafting_bench_recipe_real/keycard_holder,
		/datum/crafting_bench_recipe_real/tele_shield,
		/datum/crafting_bench_recipe_real/ballistic_shield,
		/datum/crafting_bench_recipe_real/black_keycard,
		/datum/crafting_bench_recipe_real/exo_beacon,
	)

/obj/structure/epic_loot_crafting_bench/gear/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>1</b> solid state drive = <b>1</b> binoculars")
	. += span_notice("<b>1</b> hard disk drive = <b>1</b> assault pack")
	. += span_notice("<b>1</b> intelligence folder = <b>1</b> security belt")
	. += span_notice("<b>1</b> gold chainlet = <b>1</b> ammo pouch")
	. += span_notice("<b>1</b> display = <b>1</b> operative holster")
	. += span_notice("<b>1</b> solid state drive = <b>1</b> assault belt")
	. += span_notice("<b>1</b> tongue = <b>1</b> grenade belt")
	. += span_notice("<b>1</b> ears = <b>1</b> chest rig")
	. += span_notice("<b>1</b> military flash drive = <b>1</b> tag case")
	. += span_notice("<b>1</b> corporate data folder = <b>1</b> organizational pouch")
	. += span_notice("<b>1</b> silver chainlet + <b>1</b> gold chainlet = <b>1</b> documents pouch")
	. += span_notice("<b>1</b> sealed diary = <b>1</b> keycard holder")
	. += span_notice("<b>3</b> device fans = <b>1</b> telescopic shield")
	. += span_notice("<b>1</b> lungs = <b>1</b> ballistic shield")
	. += span_notice("<b>9</b> ID cards = <b>1</b> black keycard")
	. += span_notice("<b>1</b> black keycard = <b>1</b> exosuit beacon") // horrible dente creation
	return .

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
	resulting_item = /obj/item/storage/backpack/duffelbag/syndie/nri/captain/lethal

/datum/crafting_bench_recipe_real/sec_belt
	recipe_name = "security belt"
	recipe_requirements = list(
		/obj/item/epic_loot/intel_folder = 1,
	)
	resulting_item = /obj/item/storage/belt/security

/datum/crafting_bench_recipe_real/ammo_pouch
	recipe_name = "ammo pouch"
	recipe_requirements = list(
		/obj/item/epic_loot/gold_chainlet = 1,
	)
	resulting_item = /obj/item/storage/pouch/ammo

/datum/crafting_bench_recipe_real/cowboy_holster
	recipe_name = "pistol holster"
	recipe_requirements = list(
		/obj/item/epic_loot/display = 1,
	)
	resulting_item = /obj/item/storage/belt/holster/nukie/cowboy

/datum/crafting_bench_recipe_real/assault_belt
	recipe_name = "assault belt"
	recipe_requirements = list(
		/obj/item/epic_loot/ssd = 1,
	)
	resulting_item = /obj/item/storage/belt/military/assault

/datum/crafting_bench_recipe_real/grenade_belt
	recipe_name = "grenade belt"
	recipe_requirements = list(
		/obj/item/organ/internal/tongue = 1,
	)
	resulting_item = /obj/item/storage/belt/grenade

/datum/crafting_bench_recipe_real/chest_rig
	recipe_name = "chest rig"
	recipe_requirements = list(
		/obj/item/organ/internal/ears = 1,
	)
	resulting_item = /obj/item/storage/belt/military/cin_surplus/random_color

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
	recipe_name = "documents case"
	recipe_requirements = list(
		/obj/item/epic_loot/silver_chainlet = 1,
		/obj/item/epic_loot/gold_chainlet = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_docs_case

/datum/crafting_bench_recipe_real/keycard_holder
	recipe_name = "keycard holder"
	recipe_requirements = list(
		/obj/item/epic_loot/diary = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_card_holder

/datum/crafting_bench_recipe_real/tele_shield
	recipe_name = "telescopic shield"
	recipe_requirements = list(
		/obj/item/epic_loot/device_fan = 3,
	)
	resulting_item = /obj/item/shield/ballistic

/datum/crafting_bench_recipe_real/ballistic_shield
	recipe_name = "ballistic shield"
	recipe_requirements = list(
		/obj/item/organ/internal/lungs = 1,
	)
	resulting_item = /obj/item/shield/ballistic

/datum/crafting_bench_recipe_real/black_keycard
	recipe_name = "black keycard"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 9,
	)
	resulting_item = /obj/item/keycard/epic_loot/black

/datum/crafting_bench_recipe_real/exo_beacon // horrible dente creation
	recipe_name = "exo beacon"
	recipe_requirements = list(
		/obj/item/keycard/epic_loot/black = 1,
	)
	resulting_item = /obj/item/choice_beacon/mecha
