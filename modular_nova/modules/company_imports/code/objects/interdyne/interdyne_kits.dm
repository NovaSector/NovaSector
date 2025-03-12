/obj/item/defibrillator/compact/combat/loaded/interdyne
	name = "\improper Interdyne rapid combative defibrillator"
	desc = "A belt-equipped combative defibrillator. Can revive through thick clothing, has an experimental self-recharging battery, and can be utilized as a weapon via applying the paddles while in a combat stance."
	icon_state = "defibcompact"
	inhand_icon_state = null
	worn_icon_state = "defibcompact"

/obj/item/storage/medkit/tactical/premium/interdyne
	name = "\improper Interdyne advanced medical kit"
	desc = "a kit specially made by the interdyne corporation to utilize the most essential tools."
	icon_state = "interdyne_tactical_premium"
	icon = 'modular_nova/master_files/icons/obj/storage/medkit.dmi'

/obj/item/storage/backpack/duffelbag/syndie/interdyne/advancedkit
	name = "\improper Interdyne advanced kit"
	desc = "Carries three premium tactical medical kits for your most intense needs!"

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
		/obj/item/reagent_containers/pill/patch/libital = 2,
		/obj/item/reagent_containers/pill/patch/aiuri = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/mod/module/surgical_processor/preloaded = 1,
		/obj/item/reagent_containers/hypospray/combat/empty = 1,
		/obj/item/storage/box/evilmeds = 1,
		/obj/item/clothing/glasses/hud/health/night/science = 1,
		/obj/item/defibrillator/compact/combat/loaded/interdyne = 1,
	)
	generate_items_inside(items_inside,src)
	list_of_everything_medkits_can_hold += items_inside


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
