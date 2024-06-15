/obj/structure/epic_loot_crafting_bench/gear_filtre
	name = "equipment trade station"
	desc = "A direct connection to the requisitions officer aboard the RLOS Relicten, \
		allowing filtres to call down special equipment using special remotes in exchange \
		for ID cards taken off of gaksters."
	icon_state = "trade_gear"

	light_color = LIGHT_COLOR_BLUE

	allowed_choices = list(
		/datum/crafting_bench_recipe_real/medical_drop_pod,
		/datum/crafting_bench_recipe_real/grenade_drop_pod,
		/datum/crafting_bench_recipe_real/breaching_weapons_drop_pod,
		/datum/crafting_bench_recipe_real/explosives_drop_pod,
		/datum/crafting_bench_recipe_real/turret_drop_pod,
	)

/obj/structure/epic_loot_crafting_bench/gear_filtre/examine_more(mob/user)
	. = ..()

	. += span_notice("<b>1</b> ID card = <b>1</b> medical support beacon")
	. += span_notice("<b>1</b> ID card = <b>1</b> consumable weapon beacon")
	. += span_notice("<b>2</b> ID cards = <b>1</b> breaching weapon beacon")
	. += span_notice("<b>3</b> ID cards = <b>1</b> point defense weapon beacon")
	. += span_notice("<b>4</b> ID cards = <b>1</b> explosive support weapon beacon")
	return .

/// Drop pod callers

/datum/crafting_bench_recipe_real/medical_drop_pod
	recipe_name = "medical support beacon"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/choice_beacon/filtre/medical

/datum/crafting_bench_recipe_real/grenade_drop_pod
	recipe_name = "consumable weapon beacon"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 1,
	)
	resulting_item = /obj/item/choice_beacon/filtre/grenade

/datum/crafting_bench_recipe_real/breaching_weapons_drop_pod
	recipe_name = "breaching weapon beacon"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 2,
	)
	resulting_item = /obj/item/choice_beacon/filtre/breaching

/datum/crafting_bench_recipe_real/turret_drop_pod
	recipe_name = "point defense weapon beacon"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 3,
	)
	resulting_item = /obj/item/choice_beacon/filtre/turret

/datum/crafting_bench_recipe_real/explosives_drop_pod
	recipe_name = "explosive support weapon beacon"
	recipe_requirements = list(
		/obj/item/card/id/advanced = 4,
	)
	resulting_item = /obj/item/choice_beacon/filtre/rocket
