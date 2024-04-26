/obj/structure/epic_loot_crafting_bench/medical
	name = "medical trade station"
	desc = "A direct connection to an underworld doctor known only as 'archangel', who will exchange goods for \
		medical supplies and possibly even implants."
	icon_state = "trade_med"

	light_color = LIGHT_COLOR_GREEN

	allowed_choices = list(
		/datum/crafting_bench_recipe_real/medpen_kit,
		/datum/crafting_bench_recipe_real/pocket_medkit_small,
		/datum/crafting_bench_recipe_real/pocket_medkit,
		/datum/crafting_bench_recipe_real/medical_box,
		/datum/crafting_bench_recipe_real/super_medkit,
		/datum/crafting_bench_recipe_real/super_surgical_kit,
		/datum/crafting_bench_recipe_real/super_medkit_ultra,
		/datum/crafting_bench_recipe_real/slewa,
		/datum/crafting_bench_recipe_real/cms,
	)

/obj/structure/epic_loot_crafting_bench/medical/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>1</b> military flash drive = <b>1</b> autoinjector pouch")
	. += span_notice("<b>1</b> general-purpose circuit board = <b>1</b> pocket first aid kit")
	. += span_notice("<b>1</b> military grade circuit board = <b>1<b> pocket medical kit")
	. += span_notice("<b>2</b> ID card = <b>1</b> medical case")
	. += span_notice("<b>1</b> press pass = <b>1</b> frontier first aid kit")
	. += span_notice("<b>1</b> eyes = <b>1</b> combat surgeon kit")
	. += span_notice("<b>1</b> vein finder = <b>1</b> stachel first aid kit")
	. += span_notice("<b>1</b> eye scope = <b>1</b> first responder surgical kit")
	. += span_notice("<b>1</b> stachel first aid kit + <b>3</b> ID cards = <b>1</b> advanced satchel first aid kit")

	return .

// Storage stuff

/datum/crafting_bench_recipe_real/medpen_kit
	recipe_name = "autoinjector pouch"
	recipe_requirements = list(
		/obj/item/epic_loot/military_flash = 1,
	)
	resulting_item = /obj/item/storage/epic_loot_medpen_case

/datum/crafting_bench_recipe_real/pocket_medkit_small
	recipe_name = "pocket first aid kit"
	recipe_requirements = list(
		/obj/item/epic_loot/civilian_circuit = 1,
	)
	resulting_item = /obj/item/storage/pouch/medical/firstaid/loaded

/datum/crafting_bench_recipe_real/pocket_medkit
	recipe_name = "pocket medical kit"
	recipe_requirements = list(
		/obj/item/epic_loot/military_circuit = 1,
	)
	resulting_item = /obj/item/storage/pouch/medical/loaded

/datum/crafting_bench_recipe_real/medical_box
	recipe_name = "medical case"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 2,
	)
	resulting_item = /obj/item/storage/epic_loot_medical_case

// Medkits

/datum/crafting_bench_recipe_real/slewa
	recipe_name = "frontier first aid kit"
	recipe_requirements = list(
		/obj/item/epic_loot/press_pass = 1,
	)
	resulting_item = /obj/item/storage/medkit/frontier/stocked

/datum/crafting_bench_recipe_real/cms
	recipe_name = "combat surgeon kit"
	recipe_requirements = list(
		/obj/item/organ/internal/eyes = 1,
	)
	resulting_item = /obj/item/storage/medkit/combat_surgeon/stocked

/datum/crafting_bench_recipe_real/super_medkit
	recipe_name = "satchel medical kit"
	recipe_requirements = list(
		/obj/item/epic_loot/vein_finder = 1,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked

/datum/crafting_bench_recipe_real/super_surgical_kit
	recipe_name = "first responder surgical kit"
	recipe_requirements = list(
		/obj/item/epic_loot/eye_scope = 1,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/deforest_surgical/stocked

/datum/crafting_bench_recipe_real/super_medkit_ultra
	recipe_name = "advanced satchel medical kit"
	recipe_requirements = list(
		/obj/item/storage/backpack/duffelbag/deforest_medkit = 1,
		/obj/item/card/id/advanced = 3,
	)
	resulting_item = /obj/item/storage/backpack/duffelbag/deforest_medkit/stocked/super
