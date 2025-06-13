/*
/// Dyne Kit Declares
*/

/datum/storage/medkit/tactical/interdyne
	max_slots = 14
	max_total_storage = 16
	max_specific_storage = WEIGHT_CLASS_SMALL

/datum/storage/medkit/tactical/interdyne/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	holdables = list_of_everything_medkits_can_hold
	return ..()

/datum/storage/medkit/tactical/interdyne/medium
	max_slots = 7
	max_total_storage = 12
	max_specific_storage = WEIGHT_CLASS_SMALL

/datum/storage/medkit/tactical/interdyne/medium/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	holdables = list_of_everything_medkits_can_hold
	return ..()

/datum/storage/medkit/tactical/interdyne/small
	max_slots = 7
	max_total_storage = 10
	max_specific_storage = WEIGHT_CLASS_TINY

/datum/storage/medkit/tactical/interdyne/small/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	holdables = list_of_everything_medkits_can_hold
	return ..()
/*
/// Medkits
*/

/obj/item/defibrillator/compact/combat/loaded/interdyne
	name = "\improper Interdyne rapid combative defibrillator"
	desc = "A belt-equipped combative defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized as a weapon via applying the paddles while in a combat stance."
	icon_state = "defibcompact"
	inhand_icon_state = null
	worn_icon_state = "defibcompact"

/obj/item/storage/medkit/tactical/premium/interdyne
	name = "\improper Interdyne Premium Doctor's Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_tactical_premium"
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'
	storage_type = /datum/storage/medkit/tactical/interdyne

/obj/item/storage/medkit/tactical/premium/interdyne/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/reagent_containers/applicator/patch/libital = 2,
		/obj/item/reagent_containers/applicator/patch/aiuri = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset = 1,
		/obj/item/mod/module/surgical_processor/preloaded = 1,
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/storage/box/evilmeds/interdyne = 1,
		/obj/item/clothing/glasses/hud/health/night/science = 1,
		/obj/item/defibrillator/compact/combat/loaded/interdyne = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/trauma
	name = "\improper Interdyne Premium Trauma Kit"
	desc = "A large emergency medical kit loaded with supplies to fit many emergencies and provide aid."
	icon_state = "interdyne_tactical_premium"

/obj/item/storage/medkit/tactical/premium/interdyne/trauma/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/reagent_containers/applicator/patch/libital = 2,
		/obj/item/reagent_containers/applicator/patch/aiuri = 2,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 2,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/defibrillator/compact/combat/loaded/interdyne = 1,
	)
	generate_items_inside(items_inside,src)

/*
/// Medium Medkits
*/

/obj/item/storage/medkit/tactical/premium/interdyne/medium
	name = "\improper Interdyne Trauma Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_tactical"
	storage_type = /datum/storage/medkit/tactical/interdyne/medium

/obj/item/storage/medkit/tactical/premium/interdyne/medium/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
	)
	generate_items_inside(items_inside,src)

/*
/// Small Medkits
*/

/obj/item/storage/medkit/tactical/premium/interdyne/small
	name = "\improper Interdyne Emergency Trauma Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_tactical_lite"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/medkit/tactical/interdyne/small

/obj/item/storage/medkit/tactical/premium/interdyne/small/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/reagent_containers/applicator/patch/libital = 1,
		/obj/item/reagent_containers/applicator/patch/aiuri = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/small/brute
	name = "\improper Interdyne Emergency Brute Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/medkit/tactical/premium/interdyne/small/brute/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 3,
		/obj/item/reagent_containers/applicator/patch/libital = 4,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/small/burn
	name = "\improper Interdyne Emergency Burn Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/medkit/tactical/premium/interdyne/small/burn/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/reagent_containers/applicator/patch/aiuri = 2,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/small/toxin
	name = "\improper Interdyne Emergency Toxins Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/medkit/tactical/premium/interdyne/small/toxin/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/storage/pill_bottle/multiver = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 2,
		/obj/item/reagent_containers/syringe/syriniver = 3,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/small/oxygen
	name = "\improper Interdyne Emergency Oxyloss Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/medkit/tactical/premium/interdyne/small/oxygen/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/storage/pill_bottle/multiver = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/reagent_containers/syringe/syriniver = 3,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/tactical/premium/interdyne/small/spray
	name = "\improper Interdyne Robust Spray Kit"
	desc = "An immensely small spraykit useful for rapid trauma emergencies, /chemical analyzer not included/."

/obj/item/storage/medkit/tactical/premium/interdyne/small/spray/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/reagent_containers/cup/beaker/sal_acid = 1,
		/obj/item/reagent_containers/cup/beaker/salbutamol = 1,
		/obj/item/reagent_containers/cup/beaker/oxandrolone = 1,
		/obj/item/reagent_containers/cup/beaker/pen_acid = 1,
		/obj/item/reagent_containers/cup/beaker/rezadone = 1,
	)
	generate_items_inside(items_inside,src)

/*
/// Duffel Bags Past this point
*/

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	name = "tactical maid kit"
	desc = "Only carries one tactical maid set."

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)

/obj/item/storage/box/evilmeds/interdyne
	name = "box of Interdyne Medicines"
	desc = "Contains a large number of beakers filled with premium medical supplies. Straight from Interdyne Pharmaceutics!"
	icon_state = "syndiebox"
	illustration = "beaker"

/obj/item/storage/box/evilmeds/interdyne/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/cup/beaker/omnizine = 1,
		/obj/item/reagent_containers/cup/beaker/sal_acid = 1,
		/obj/item/reagent_containers/cup/beaker/oxandrolone = 1,
		/obj/item/reagent_containers/cup/beaker/pen_acid = 1,
		/obj/item/reagent_containers/cup/beaker/atropine = 1,
		/obj/item/reagent_containers/cup/beaker/salbutamol = 1,
		/obj/item/reagent_containers/cup/beaker/rezadone = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/reagent_containers/cup/beaker/omnizine
	name = "Omnizine Beaker"
	list_reagents = list(/datum/reagent/medicine/omnizine = 60)

/obj/item/reagent_containers/cup/beaker/sal_acid
	name = "Salicylic-Acid Beaker"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 60)

/obj/item/reagent_containers/cup/beaker/oxandrolone
	name = "Oxandrolone Beaker"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 60)

/obj/item/reagent_containers/cup/beaker/pen_acid
	name = "Pentetic Acid Beaker"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 60)

/obj/item/reagent_containers/cup/beaker/atropine
	name = "Atropine Beaker"
	list_reagents = list(/datum/reagent/medicine/atropine = 60)

/obj/item/reagent_containers/cup/beaker/salbutamol
	name = "Salbutamol Beaker"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 60)

/obj/item/reagent_containers/cup/beaker/rezadone
	name = "Rezadone Beaker"
	list_reagents = list(/datum/reagent/medicine/rezadone = 60)
