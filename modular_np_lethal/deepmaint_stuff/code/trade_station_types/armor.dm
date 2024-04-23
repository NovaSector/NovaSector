/obj/structure/epic_loot_crafting_bench/armor
	name = "armor trade station"
	desc = "A direct connection to an underworld merchant known as either 'outfitter' or 'pac-3', \
		who will exchange goods for various pieces of wearable equipment and gear."
	icon_state = "trade_armor"

	allowed_choices = list(
		// Glasses
		/datum/crafting_bench_recipe_real/coolglasses,
		/datum/crafting_bench_recipe_real/nvg,
		/datum/crafting_bench_recipe_real/thermals,
		// Armor
		/datum/crafting_bench_recipe_real/paper_vest,
		/datum/crafting_bench_recipe_real/koranda_vest,
		/datum/crafting_bench_recipe_real/soft_vest,
		/datum/crafting_bench_recipe_real/un_helmet,
		/datum/crafting_bench_recipe_real/kulon_vest,
		/datum/crafting_bench_recipe_real/kulon_vest_super,
		/datum/crafting_bench_recipe_real/kulon_helmet,
		/datum/crafting_bench_recipe_real/sacrificial_vest,
		/datum/crafting_bench_recipe_real/sacrificial_helmet,
		// Headsets
		/datum/crafting_bench_recipe_real/talker_set,
		/datum/crafting_bench_recipe_real/bowman,
	)

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
		/obj/item/epic_loot/cordura = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/sf_peacekeeper

/datum/crafting_bench_recipe_real/kulon_vest
	recipe_name = "type III 'Kinu-Kuroba' vest"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_gyro = 1,
	)
	resulting_item = /obj/item/clothing/suit/armor/lethal_kora_kulon

/datum/crafting_bench_recipe_real/kulon_vest_super
	recipe_name = "type III 'Kinu-Kuroba' full armor kit"
	recipe_requirements = list(
		/obj/item/clothing/suit/armor/lethal_kora_kulon = 1,
		/obj/item/organ/internal/eyes = 2,
	)
	resulting_item = /obj/item/clothing/suit/armor/lethal_kora_kulon/full_set

/datum/crafting_bench_recipe_real/kulon_helmet
	recipe_name = "type III 'Robusuta' helmet"
	recipe_requirements = list(
		/obj/item/epic_loot/shuttle_battery = 1,
	)
	resulting_item = /obj/item/clothing/head/helmet/lethal_kulon_helmet/spawns_with_shield

/datum/crafting_bench_recipe_real/sacrificial_vest
	recipe_name = "type IV 'Val' vest"
	recipe_requirements = list(
		/obj/item/organ/internal/heart = 2,
	)
	resulting_item = /obj/item/clothing/suit/armor/sf_sacrificial

/datum/crafting_bench_recipe_real/sacrificial_helmet
	recipe_name = "type IV 'Val' helmet"
	recipe_requirements = list(
		/obj/item/organ/internal/stomach = 2,
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
		/obj/item/epic_loot/phased_array = 1,
	)
	resulting_item = /obj/item/radio/headset/headset_sec/alt
