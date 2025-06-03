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

/obj/item/storage/medkit/tactical/premium/interdyne/Initialize(mapload)
	. = ..()
	atom_storage.allow_big_nesting = TRUE // so you can put back the box you took out
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 14
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL*14
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

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
		/obj/item/storage/box/evilmeds = 1,
		/obj/item/clothing/glasses/hud/health/night/science = 1,
		/obj/item/defibrillator/compact/combat/loaded/interdyne = 1,
	)
	generate_items_inside(items_inside,src)
	list_of_everything_medkits_can_hold += items_inside

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
	list_of_everything_medkits_can_hold += items_inside

/*
/// Medium Medkits
*/

/obj/item/storage/medkit/tactical/premium/interdyne/medium
	name = "\improper Interdyne Trauma Kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_tactical"

/obj/item/storage/medkit/tactical/premium/interdyne/medium/Initialize(mapload)
	. = ..()
	atom_storage.allow_big_nesting = TRUE // so you can put back the box you took out
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 7
	atom_storage.max_total_storage = WEIGHT_CLASS_SMALL*7
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

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
	list_of_everything_medkits_can_hold += items_inside

/*
/// Small Medkits
*/




/obj/item/storage/medkit/tactical/premium/interdyne/small
	name = "\improper Interdyne Emergency Trauma Kit"
	desc = "An Interdyne Pharmaceuticals Trauma kit, for immediate first aid in situations where more complex aid may not be available."
	icon_state = "interdyne_tactical_lite"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/medkit/tactical/premium/interdyne/small/Initialize(mapload)
	. = ..()
	atom_storage.allow_big_nesting = TRUE // so you can put back the box you took out
	atom_storage.max_specific_storage = WEIGHT_CLASS_TINY
	atom_storage.max_slots = 7
	atom_storage.max_total_storage = WEIGHT_CLASS_TINY*7
	atom_storage.set_holdable(list_of_everything_medkits_can_hold)

/obj/item/storage/medkit/tactical/premium/interdyne/small/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 1,
		/obj/item/stack/medical/mesh/advanced = 1,
		/obj/item/reagent_containers/applicator/patch/libital = 1,
		/obj/item/reagent_containers/applicator/patch/aiuri = 1,
	)
	generate_items_inside(items_inside,src)
	list_of_everything_medkits_can_hold += items_inside

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
	list_of_everything_medkits_can_hold += items_inside

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
	list_of_everything_medkits_can_hold += items_inside

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
	list_of_everything_medkits_can_hold += items_inside

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
	list_of_everything_medkits_can_hold += items_inside

/obj/item/storage/medkit/tactical/premium/interdyne/small/spray
	name = "\improper Interdyne Robust Spray Kit"
	desc = "An immensely small spraykit useful for rapid trauma emergencies, /chemical analyzer not included/."

/obj/item/storage/medkit/tactical/premium/interdyne/small/spray/PopulateContents()
	if(empty)
		return
	var/static/list/items_inside = list(
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/reagent_containers/cup/beaker/meta/sal_acid = 1,
		/obj/item/reagent_containers/cup/beaker/meta/salbutamol = 1,
		/obj/item/reagent_containers/cup/beaker/meta/oxandrolone = 1,
		/obj/item/reagent_containers/cup/beaker/meta/pen_acid = 1,
		/obj/item/reagent_containers/cup/beaker/meta/rezadone = 1,
	)
	generate_items_inside(items_inside,src)
	list_of_everything_medkits_can_hold += items_inside

/*
/// Duffel Bags Past this point
*/

/obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit
	name = "\improper Interdyne advanced kit"
	desc = "Carries three premium tactical medical kits for your most intense needs!"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/biohazard
	name = "\improper Interdyne biohazard kit"
	desc = "Carries three Interdyne Pharmaceuticals Biohazard suits"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit/PopulateContents()
	new /obj/item/storage/medkit/tactical/premium/interdyne(src)
	new /obj/item/storage/medkit/tactical/premium/interdyne(src)
	new /obj/item/storage/medkit/tactical/premium/interdyne(src)

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing
	name = "tactical maid kit"
	desc = "Only carries one tactical maid set."

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_sing/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_multi
	name = "bulk tactical maid kit"
	desc = "Carries 3 Tactical maid sets!"

/obj/item/storage/backpack/duffelbag/syndie/interdyne/maidkit_multi/PopulateContents()
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/head/costume/maidheadband/syndicate(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/under/syndicate/nova/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/gloves/combat/maid(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)
	new /obj/item/clothing/accessory/maidcorset/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/interdyne/biohazard/PopulateContents()
	new /obj/item/clothing/suit/bio_suit/interdyne(src)
	new /obj/item/clothing/suit/bio_suit/interdyne(src)
	new /obj/item/clothing/head/bio_hood/interdyne(src)
	new /obj/item/clothing/head/bio_hood/interdyne(src)
