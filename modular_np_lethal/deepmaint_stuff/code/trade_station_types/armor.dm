/obj/structure/epic_loot_crafting_bench/armor
	name = "armor trade station"
	desc = "A direct connection to an underworld merchant known as either 'outfitter' or 'pac-3', \
		who will exchange goods for various pieces of wearable equipment and gear."
	icon_state = "trade_armor"

	light_color = LIGHT_COLOR_INTENSE_RED

	allowed_choices = list(
		// Glasses
		/datum/crafting_bench_recipe_real/coolglasses,
		/datum/crafting_bench_recipe_real/nvg,
		/datum/crafting_bench_recipe_real/thermals,
		// Armor
		/datum/crafting_bench_recipe_real/paper_vest,
		/datum/crafting_bench_recipe_real/koranda_vest,
		/datum/crafting_bench_recipe_real/cin_vest,
		/datum/crafting_bench_recipe_real/cin_helmet,
		/datum/crafting_bench_recipe_real/soft_vest,
		/datum/crafting_bench_recipe_real/un_helmet,
		/datum/crafting_bench_recipe_real/cin_vest,
		/datum/crafting_bench_recipe_real/cin_helmet,
		/datum/crafting_bench_recipe_real/kulon_vest,
		/datum/crafting_bench_recipe_real/kulon_helmet,
		// Headsets
		/datum/crafting_bench_recipe_real/talker_set,
		/datum/crafting_bench_recipe_real/bowman,
	)

/obj/structure/epic_loot_crafting_bench/armor/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>1</b> slim diary = <b>1</b> sunglasses")
	. += span_notice("<b>1</b> signal amplifier + <b>1</b> current converter = <b>1</b> night vision goggles")
	. += span_notice("<b>1</b> cold weld + <b>1</b> signal amplifier + <b>1</b> thermal camera = <b>1</b> thermal vision goggles")
	. += span_notice("<b>1</b> high-resistance fabric = <b>1</b> type I 'Kami' vest")
	. += span_notice("<b>1</b> high-resistance fabric + <b>1</b> appendix = <b>1</b> type II 'Koranda' vest")
	. += span_notice("<b>1</b> polymer weave fabric + <b>1</b> tear-resistant fabric = <b>1</b> type II 'Touvou' vest")
	. += span_notice("<b>1</b> electric motor = <b>1</b> type II 'Kastrol' helmet")
	. += span_notice("<b>1</b> shuttle gyroscope = <b>1</b> type II 'Muur' vest")
	. += span_notice("<b>1</b> shuttle battery = <b>1</b> type II 'Muur' helmet")
	. += span_notice("<b>2</b> hearts = <b>1</b> CIN surplus vest")
	. += span_notice("<b>2</b> stomachs = <b>1</b> CIN surplus helmet")
	. += span_notice("<b>1</b> fuel conditioner = <b>1</b> frontier headset")
	. += span_notice("<b>1</b> phased array element = <b>1</b> bowman headset")
	return .

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
	resulting_item = /obj/item/clothing/glasses/night

/datum/crafting_bench_recipe_real/thermals
	recipe_name = "thermal vision goggles"
	recipe_requirements = list(
		/obj/item/epic_loot/cold_weld = 1,
		/obj/item/epic_loot/signal_amp = 1,
		/obj/item/epic_loot/thermal_camera = 1,
	)
	resulting_item = /obj/item/clothing/glasses/thermal

// Armor

/datum/crafting_bench_recipe_real/paper_vest
	recipe_name = "type I 'Kami' vest"
	recipe_requirements = list(
		/obj/item/epic_loot/aramid = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/lethal_paper

/datum/crafting_bench_recipe_real/cin_vest
	recipe_name = "CIN surplus vest"
	recipe_requirements = list(
		/obj/item/epic_loot/graphics = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_peacekeeper

/datum/crafting_bench_recipe_real/cin_helmet
	recipe_name = "CIN surplus helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/display_broken = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/sf_peacekeeper

/datum/crafting_bench_recipe_real/koranda_vest
	recipe_name = "type II 'Koranda' vest"
	recipe_requirements = list(
		/obj/item/epic_loot/aramid = 1,
		/obj/item/organ/internal/appendix = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/lethal_koranda

/datum/crafting_bench_recipe_real/soft_vest
	recipe_name = "type II 'Touvou' vest"
	recipe_requirements = list(
		/obj/item/epic_loot/ripstop = 1,
		/obj/item/epic_loot/cordura = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_peacekeeper

/datum/crafting_bench_recipe_real/un_helmet
	recipe_name = "type II 'Kastrol' helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/electric_motor = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/sf_peacekeeper

/datum/crafting_bench_recipe_real/cin_vest
	recipe_name = "CIN surplus vest"
	recipe_requirements = list(
		/obj/item/epic_loot/graphics = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/vest/cin_surplus_vest

/datum/crafting_bench_recipe_real/cin_helmet
	recipe_name = "CIN surplus helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/display_broken = 2,
	)
	resulting_item = /obj/item/clothing/head/helmet/cin_surplus_helmet/random_color

/datum/crafting_bench_recipe_real/kulon_vest
	recipe_name = "type II 'Muur' vest"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_gyro = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_hardened

/datum/crafting_bench_recipe_real/kulon_helmet
	recipe_name = "type II 'Muur' helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_battery = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/toggleable/sf_hardened

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
		/obj/item/epic_loot/phased_array = 1,
	)
	resulting_item = /obj/item/radio/headset/headset_sec/alt
