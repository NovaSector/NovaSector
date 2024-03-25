/*
*	LOADOUT ITEM DATUMS FOR SIGNATURE ITEMS
*/

///WEAPONS
GLOBAL_LIST_INIT(loadout_signature, generate_loadout_items(/datum/loadout_item/signature))

/datum/loadout_item/signature
	category = LOADOUT_ITEM_SIGNATURE

/datum/loadout_item/signature/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.r_hand) && initial(outfit_important_for_life.l_hand))
		if(!visuals_only)
			LAZYADD(outfit.backpack_contents, item_path)
		return TRUE

/datum/loadout_item/signature/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(outfit.l_hand && !outfit.r_hand)
		outfit.r_hand = item_path
	else
		if(outfit.l_hand)
			LAZYADD(outfit.backpack_contents, outfit.l_hand)
		outfit.l_hand = item_path

///MELEE
/datum/loadout_item/signature/bowie_sheath
	name = "Bowie Sheath"
	item_path = /obj/item/storage/belt/bowie_sheath

/datum/loadout_item/signature/sabre
	name = "Samshir Leather Sheath"
	item_path = /obj/item/storage/belt/sabre/cargo

/datum/loadout_item/signature/teknodachi
	name = "Teknodachi"
	item_path = /obj/item/katana/teknodachi

/datum/loadout_item/signature/highfrequencyblade
	name = "Vibrodachi"
	item_path = /obj/item/highfrequencyblade/vibrodachi

/datum/loadout_item/signature/crusher
	name = "Proto-Kinetic Crusher"
	item_path = /obj/item/kinetic_crusher

/datum/loadout_item/signature/metal_h2_axe
	name = "Metallic Hydrogen Axe"
	item_path = /obj/item/fireaxe/metal_h2_axe

///RANGED
/datum/loadout_item/signature/sol_smg
	name = "Carwo Sindano Submachine Gun Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil

/datum/loadout_item/signature/bogseo
	name = "Xhihao Bogseo Personal Defense Weapon Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo

/datum/loadout_item/signature/takbok
	name = "Trappiste Takbok Revolver Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/takbok

/datum/loadout_item/signature/rebar_crossbow
	name = "Rebar Crossbow Case"
	item_path = /obj/item/storage/toolbox/guncase/nova/opfor/rebar_crossbow

