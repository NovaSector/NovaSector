/datum/loadout_category/weapons
	category_name = "Weapons"
	category_ui_icon = FA_ICON_GUN
	type_to_generate = /datum/loadout_item/weapons
	tab_order = /datum/loadout_category/inhands::tab_order + 1

/datum/loadout_item/weapons/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	return FALSE

/datum/loadout_item/weapons/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(outfit.r_hand && !outfit.l_hand)
		outfit.l_hand = item_path
	else
		if(outfit.r_hand)
			LAZYADD(outfit.backpack_contents, outfit.r_hand)
		outfit.r_hand = item_path

/datum/loadout_item/weapons
	abstract_type = /datum/loadout_item/weapons
	mechanical_item = TRUE
	blacklisted_roles = list(JOB_PRISONER)

/*
*	GHETTO GUNS
*/

/datum/loadout_item/weapons/ghettoguns
	abstract_type = /datum/loadout_item/weapons/ghettoguns
	group = "Improvised Ballistics"

/datum/loadout_item/weapons/ghettoguns/pipegun
	name = /obj/item/gun/ballistic/rifle/boltaction/pipegun::name
	item_path = /obj/item/gun/ballistic/rifle/boltaction/pipegun

/datum/loadout_item/weapons/ghettoguns/pipepistol
	name = /obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol::name
	item_path = /obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol

/datum/loadout_item/weapons/ghettoguns/lasermusket
	name = /obj/item/gun/energy/laser/musket::name
	item_path = /obj/item/gun/energy/laser/musket

/datum/loadout_item/weapons/ghettoguns/smoothbore
	name = /obj/item/gun/energy/disabler/smoothbore::name
	item_path = /obj/item/gun/energy/disabler/smoothbore

/*
*	FORGE WEAPONRY
*/

/datum/loadout_item/weapons/forgeweapons
	abstract_type = /datum/loadout_item/weapons/forgeweapons
	group = "Forge Weapons"

/datum/loadout_item/weapons/forgeweapons/dagger
	name = /obj/item/forging/reagent_weapon/dagger::name
	item_path = /obj/item/forging/reagent_weapon/dagger

/datum/loadout_item/weapons/forgeweapons/sword
	name = /obj/item/forging/reagent_weapon/sword::name
	item_path = /obj/item/forging/reagent_weapon/sword

/datum/loadout_item/weapons/forgeweapons/katana
	name = /obj/item/forging/reagent_weapon/katana::name
	item_path = /obj/item/forging/reagent_weapon/katana

/datum/loadout_item/weapons/forgeweapons/bokken
	name = /obj/item/forging/reagent_weapon/bokken::name
	item_path = /obj/item/forging/reagent_weapon/bokken

/datum/loadout_item/weapons/forgeweapons/spear
	name = /obj/item/forging/reagent_weapon/spear::name
	item_path = /obj/item/forging/reagent_weapon/spear

/datum/loadout_item/weapons/forgeweapons/hammer
	name = /obj/item/forging/reagent_weapon/hammer::name
	item_path = /obj/item/forging/reagent_weapon/hammer

/datum/loadout_item/weapons/forgeweapons/axe
	name = /obj/item/forging/reagent_weapon/axe::name
	item_path = /obj/item/forging/reagent_weapon/axe

/datum/loadout_item/weapons/forgeweapons/staff
	name = /obj/item/forging/reagent_weapon/staff::name
	item_path = /obj/item/forging/reagent_weapon/staff
