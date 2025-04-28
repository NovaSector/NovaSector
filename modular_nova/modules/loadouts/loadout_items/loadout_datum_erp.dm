/datum/loadout_category/erp
	category_name = "Erotic"
	category_ui_icon = FA_ICON_HEART
	erp_category = TRUE
	type_to_generate = /datum/loadout_item/erp
	tab_order = /datum/loadout_category/pocket::tab_order + 1

/datum/loadout_category/erp/New()
	. = ..()
	category_info = "([MAX_ALLOWED_ERP_ITEMS] allowed)"

/datum/loadout_category/erp/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/list/datum/loadout_item/erp/other_items = list()
	for(var/datum/loadout_item/erp/other_item in all_loadout_items)
		other_items += other_item

	if(length(other_items) >= MAX_ALLOWED_ERP_ITEMS)
		manager.deselect_item(other_items[1])
	return TRUE

/datum/loadout_item/erp/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	return FALSE

/datum/loadout_item/erp
	abstract_type = /datum/loadout_item/erp
	erp_item = TRUE
	erp_box = TRUE

/*
*	SEX TOYS
*/

/datum/loadout_item/erp/buttplug
	name = "Buttplug"
	item_path = /obj/item/clothing/sextoy/buttplug

/datum/loadout_item/erp/clamps
	name = "Nipple Clamps"
	item_path = /obj/item/clothing/sextoy/nipple_clamps

/datum/loadout_item/erp/egg
	name = "Vibrating Egg"
	item_path = /obj/item/clothing/sextoy/eggvib

/datum/loadout_item/erp/egg/signal
	name = "Signal Vibrating Egg"
	item_path = /obj/item/clothing/sextoy/eggvib/signalvib

/datum/loadout_item/erp/signaler
	name = "Signaler"
	item_path = /obj/item/assembly/signaler

/datum/loadout_item/erp/vibroring
	name = "Vibrating Ring"
	item_path = /obj/item/clothing/sextoy/vibroring

/*
*	DILDOS
*/

/datum/loadout_item/erp/dildo
	name = "Dildo"
	item_path = /obj/item/clothing/sextoy/dildo

/datum/loadout_item/erp/dildo/custom
	name = "Custom Dildo"
	item_path = /obj/item/clothing/sextoy/dildo/custom_dildo

/datum/loadout_item/erp/dildo/double
	name = "Double Dildo"
	item_path = /obj/item/clothing/sextoy/dildo/double_dildo

/datum/loadout_item/erp/fleshlight
	name = "Fleshlight"
	item_path = /obj/item/clothing/sextoy/fleshlight

/datum/loadout_item/erp/magic_wand
	name = "Magic Wand"
	item_path = /obj/item/clothing/sextoy/magic_wand

/datum/loadout_item/erp/vibrator
	name = "Vibrator"
	item_path = /obj/item/clothing/sextoy/vibrator

/*
*	BELT
*/

/datum/loadout_item/erp/strapon
	name = "Strap-On"
	item_path = /obj/item/clothing/strapon

/*
*	MULTI USE
*/

/datum/loadout_item/erp/kinky_shocker
	name = "Kinky Shocker"
	item_path = /obj/item/kinky_shocker

/datum/loadout_item/erp/whip
	name = "Whip"
	item_path = /obj/item/clothing/mask/leatherwhip

/datum/loadout_item/erp/candle
	name = "Soy Candle"
	item_path = /obj/item/bdsm_candle

/datum/loadout_item/erp/spanking_pad
	name = "Spanking Pad"
	item_path = /obj/item/spanking_pad

/datum/loadout_item/erp/feather
	name = "Tickling Feather"
	item_path = /obj/item/tickle_feather

/datum/loadout_item/erp/borg_dom
	name = "Borg Dominatrix Module"
	item_path = /obj/item/borg/upgrade/dominatrixmodule

/datum/loadout_item/erp/holosign
	name = "Personal Holosign Projector"
	item_path = /obj/item/holosign_creator/privacy

/*
*	RESTRAINTS
*/

/datum/loadout_item/erp/handcuffs_lewd
	name = "Kinky Handcuffs"
	item_path = /obj/item/restraints/handcuffs/lewd

/datum/loadout_item/erp/shibari
	name = "Shibari Ropes"
	item_path = /obj/item/stack/shibari_rope/full

/datum/loadout_item/erp/shibari/glow
	name = "Glowy Shibari Ropes"
	item_path = /obj/item/stack/shibari_rope/glow/full

/datum/loadout_item/erp/ballgag
	name = "Ball Gag"
	item_path = /obj/item/clothing/mask/ballgag

/datum/loadout_item/erp/ballgag/choking
	name = "Phallic Ball Gag"
	item_path = /obj/item/clothing/mask/ballgag/choking

/datum/loadout_item/erp/muzzle_ring
	name = "Ring Gag"
	item_path = /obj/item/clothing/mask/muzzle/ring

/datum/loadout_item/erp/deprivation_helmet
	name = "Deprivation Helmet"
	item_path = /obj/item/clothing/head/deprivation_helmet

/datum/loadout_item/erp/blindfold
	name = "Luxury Blindfold"
	item_path = /obj/item/clothing/glasses/blindfold/dorms

/datum/loadout_item/erp/kinky_headphones
	name = "Padded Headphones"
	item_path = /obj/item/clothing/ears/dorms_headphones

/datum/loadout_item/erp/lewd_filter
	name = "Crocin Filter"
	item_path = /obj/item/reagent_containers/cup/lewd_filter

/datum/loadout_item/erp/hypno_glasses
	name = "Suspicious Glasses"
	item_path = /obj/item/clothing/glasses/hypno

/datum/loadout_item/erp/leash
	name = "Leash"
	item_path = /obj/item/clothing/erp_leash

/datum/loadout_item/erp/ball_mittens
	name = "Ball Mittens"
	item_path = /obj/item/clothing/gloves/ball_mittens

/datum/loadout_item/erp/collar_shock
	name = "Shock Collar"
	item_path = /obj/item/electropack/shockcollar

/datum/loadout_item/erp/collar_mind
	name = "Mind Collar"
	item_path = /obj/item/clothing/neck/mind_collar

/datum/loadout_item/erp/collar_size
	name = "Size Collar (Interlink Only)"
	item_path = /obj/item/clothing/neck/size_collar

/datum/loadout_item/erp/collar_key
	name = "Collar Key"
	item_path = /obj/item/key/collar

/datum/loadout_item/erp/latex_straight_jacket
	name = "Latex Straight Jacket"
	item_path = /obj/item/clothing/suit/straight_jacket/latex_straight_jacket

/datum/loadout_item/erp/shackles
	name = "Shackles"
	item_path = /obj/item/clothing/suit/straight_jacket/shackles

/datum/loadout_item/erp/kinky_sleepbag
	name = "Latex Sleeping Bag"
	item_path = /obj/item/clothing/suit/straight_jacket/kinky_sleepbag

/datum/loadout_item/erp/libidine
	name = "Libidine Contract"
	item_path = /obj/item/disk/nifsoft_uploader/dorms/contract

/*
*	CONSUMABLES
*/

/datum/loadout_item/erp/condom
	name = "Condom Pack"
	item_path = /obj/item/condom_pack

/datum/loadout_item/erp/serviette_pack
	name = "Serviette Pack"
	item_path = /obj/item/serviette_pack

/datum/loadout_item/erp/pillow
	name = "Fancy Pillow"
	item_path = /obj/item/fancy_pillow

/datum/loadout_item/erp/crocin
	name = "Crocin Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/crocin

/datum/loadout_item/erp/camphor
	name = "Camphor Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/camphor

/datum/loadout_item/erp/hexacrocin
	name = "Hexacrocin Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/hexacrocin

/datum/loadout_item/erp/pentacamphor
	name = "Pentacamphor Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/pentacamphor

/datum/loadout_item/erp/crocin/pill
	name = "Crocin Pill"
	item_path = /obj/item/reagent_containers/applicator/pill/crocin

/datum/loadout_item/erp/camphor/pill
	name = "Camphor Pill"
	item_path = /obj/item/reagent_containers/applicator/pill/camphor

/datum/loadout_item/erp/hexacrocin/pill
	name = "Hexacrocin Pill"
	item_path = /obj/item/reagent_containers/applicator/pill/hexacrocin

/datum/loadout_item/erp/pentacamphor/pill
	name = "Pentacamphor Pill"
	item_path = /obj/item/reagent_containers/applicator/pill/pentacamphor

/datum/loadout_item/erp/succubus_milk
	name = "Succubus Milk Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/succubus_milk

/datum/loadout_item/erp/incubus_draft
	name = "Incubus Draft Bottle"
	item_path = /obj/item/reagent_containers/cup/bottle/incubus_draft
