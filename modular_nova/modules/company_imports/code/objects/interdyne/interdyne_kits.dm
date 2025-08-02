/*
/// Dyne Kit Declares
*/

/datum/storage/medkit/tactical/interdyne
	max_slots = 14
	max_total_storage = 16 * WEIGHT_CLASS_SMALL
	max_specific_storage = WEIGHT_CLASS_SMALL

/datum/storage/medkit/tactical/interdyne/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	holdables = list_of_everything_medkits_can_hold
	return ..()

/datum/storage/medkit/tactical/interdyne/medium
	max_slots = 14
	max_total_storage = 12 * WEIGHT_CLASS_SMALL
	max_specific_storage = WEIGHT_CLASS_SMALL

/datum/storage/medkit/tactical/interdyne/medium/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
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
		/obj/item/stack/medical/gauze = 1,
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/advanced = 1,
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/storage/box/evilmeds/interdyne = 1,
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

/obj/item/storage/pouch/medical/firstaid/interdyne
	name = "\improper Interdyne Emergency Trauma Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'
	icon_state = "interdyne_tactical_lite"
	storage_type = /datum/storage/pouch/medical/small

/obj/item/storage/pouch/medical/firstaid/interdyne/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/brute
	name = "\improper Interdyne Emergency Brute Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/pouch/medical/firstaid/interdyne/brute/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 2,
		/obj/item/storage/box/bandages/interdyne = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/corpse
	name = "\improper Interdyne Corpse Emergency Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate aid in situations where more complex aid may not be available. Despite the patient likely already being a corpse."

/obj/item/storage/pouch/medical/firstaid/interdyne/corpse/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/reagent_containers/cup/beaker/rezadone/less = 1,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 1
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/burn
	name = "\improper Interdyne Emergency Burn Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/pouch/medical/firstaid/interdyne/burn/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/box/bandages/interdyne/burn = 1,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 1,
		/obj/item/reagent_containers/hypospray/medipen = 2,
		/obj/item/reagent_containers/spray/hercuri = 1,
	)
	generate_items_inside(items_inside,src)


/obj/item/storage/pouch/medical/firstaid/interdyne/toxin
	name = "\improper Interdyne Emergency Toxins Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/pouch/medical/firstaid/interdyne/toxin/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/pill_bottle/multiver = 1,
		/obj/item/storage/pill_bottle/potassiodide = 1,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 1,
		/obj/item/reagent_containers/syringe/syriniver = 1,
		/obj/item/storage/box/bandages/interdyne/toxin = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen
	name = "\improper Interdyne Emergency Oxyloss Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."

/obj/item/storage/pouch/medical/firstaid/interdyne/oxygen/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/storage/box/bandages/interdyne/oxygen = 1,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 2,
		/obj/item/reagent_containers/hypospray/medipen = 2,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/pouch/medical/firstaid/interdyne/spray
	name = "\improper Interdyne Robust Spray Kit"
	desc = "An immensely small spraykit useful for rapid trauma emergencies, /chemical analyzer not included/."

/obj/item/storage/pouch/medical/firstaid/interdyne/spray/PopulateContents()
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_brutemix = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_oxytox = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_burnmix = 1,
		/obj/item/reagent_containers/cup/beaker/atropine = 1,
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
	generate_items_inside(list(
		/obj/item/reagent_containers/cup/beaker/dyne_brutemix = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_burnmix = 1,
		/obj/item/reagent_containers/cup/beaker/dyne_oxytox = 1,
		/obj/item/reagent_containers/cup/beaker/rezadone/less = 1,
		/obj/item/paper/fluff/interdyne/medicines = 1,
	))
