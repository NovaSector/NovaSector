// LOADOUT ITEM DATUMS FOR BOTH IN-HANDS SLOTS

/datum/loadout_category/inhands
	tab_order = /datum/loadout_category/shoes::tab_order + 1

/datum/loadout_item/inhand/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	// if no hands are available then put in backpack
	if(initial(outfit_important_for_life.r_hand) && initial(outfit_important_for_life.l_hand))
		if(!visuals_only)
			LAZYADD(outfit.backpack_contents, item_path)
		return TRUE

/datum/loadout_item/inhand/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(outfit.l_hand && !outfit.r_hand)
		outfit.r_hand = item_path
	else
		if(outfit.l_hand)
			LAZYADD(outfit.backpack_contents, outfit.l_hand)
		outfit.l_hand = item_path

/*
*	ITEMS BELOW HERE
*/

/datum/loadout_item/inhand/bouquet_mixed
	name = "Bouquet - Mixed"
	item_path = /obj/item/bouquet

/datum/loadout_item/inhand/bouquet_sunflower
	name = "Bouquet - Sunflower"
	item_path = /obj/item/bouquet/sunflower

/datum/loadout_item/inhand/bouquet_poppy
	name = "Bouquet - Poppy"
	item_path = /obj/item/bouquet/poppy

/datum/loadout_item/inhand/bouquet_rose
	name = "Bouquet - Rose"
	item_path = /obj/item/bouquet/rose

/datum/loadout_item/inhand/cane
	name = "Cane"
	item_path = /obj/item/cane

/datum/loadout_item/inhand/cane/white
	name = "Cane - White"
	item_path = /obj/item/cane/white

/datum/loadout_item/inhand/cane/crutch
	name = "Crutch"
	item_path = /obj/item/cane/crutch

/datum/loadout_item/inhand/guncase_large
	name = "Empty Gun Case (Black, Large)"
	item_path = /obj/item/storage/toolbox/guncase/nova

/datum/loadout_item/inhand/guncase_small
	name = "Empty Gun Case (Black, Small)"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol

/datum/loadout_item/inhand/guncase_large/yellow
	name = "Empty Gun Case (Yellow, Large)"
	item_path = /obj/item/storage/toolbox/guncase/nova/carwo_large_case

/datum/loadout_item/inhand/flag_azulea
	name = "Flag - Azulea"
	item_path = /obj/item/sign/flag/azulea

/datum/loadout_item/inhand/flag_mothic
	name = "Flag - Grand Nomad Fleet"
	item_path = /obj/item/sign/flag/mothic

/datum/loadout_item/inhand/flag_agurk
	name = "Flag - Kingdom Of Agurkrral"
	item_path = /obj/item/sign/flag/ssc

/datum/loadout_item/inhand/flag_nt
	name = "Flag - Nanotrasen"
	item_path = /obj/item/sign/flag/nanotrasen

/datum/loadout_item/inhand/flag_nri
	name = "Flag - Novaya Rossiyskaya Imperiya"
	item_path = /obj/item/sign/flag/nri

/datum/loadout_item/inhand/flag_moghes
	name = "Flag - Republic Of Northern Moghes"
	item_path = /obj/item/sign/flag/tizira

/datum/loadout_item/inhand/flag_solfed
	name = "Flag - Sol Federation"
	item_path = /obj/item/sign/flag/terragov

/datum/loadout_item/inhand/flag_teshari
	name = "Flag - Teshari League For Self-Determination"
	item_path = /obj/item/sign/flag/mars

/datum/loadout_item/inhand/toolbox
	name = "Full Toolbox"
	item_path = /obj/item/storage/toolbox/mechanical
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "Riding Saddle (Leather)"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_blue
	name = "Riding Saddle (Blue)"
	item_path = /obj/item/riding_saddle/leather/blue

/datum/loadout_item/inhand/skateboard
	name = "Skateboard"
	item_path = /obj/item/melee/skateboard

/datum/loadout_item/inhand/skub
	name = "Skub"
	item_path = /obj/item/skub

/datum/loadout_item/inhand/saddlebags
	name = "Saddlebags"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/pet
	abstract_type = /datum/loadout_item/inhand/pet

/datum/loadout_item/inhand/pet/post_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper)
	var/obj/item/clothing/head/mob_holder/pet/equipped_pet = locate(item_path) in equipper.get_all_gear()
	equipped_pet.held_mob.befriend(equipper)

/*
PLASMAMAN ENVIROSUIT KITS
SPECIES RESTRICTED
*/

/datum/loadout_item/inhand/envirokit_orange
	name = "Envirosuit Kit: Orange"
	item_path = /obj/item/storage/box/envirosuit
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_black
	name = "Envirosuit Kit: Black"
	item_path = /obj/item/storage/box/envirosuit/black
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_white
	name = "Envirosuit Kit: White"
	item_path = /obj/item/storage/box/envirosuit/white
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_khaki
	name = "Envirosuit Kit: Khaki"
	item_path = /obj/item/storage/box/envirosuit/khaki
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_slacks
	name = "Envirosuit Kit: Formal Enviroslacks"
	item_path = /obj/item/storage/box/envirosuit/slacks
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_prototype
	name = "Envirosuit Kit: Protoype"
	item_path = /obj/item/storage/box/envirosuit/prototype
	restricted_species = list(SPECIES_PLASMAMAN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_security
	name = "Alternate Envirosuit Kit: Security Officer"
	item_path = /obj/item/storage/box/envirosuit/security
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_security_warden
	name = "Alternate Envirosuit Kit: Warden"
	item_path = /obj/item/storage/box/envirosuit/security_warden
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_WARDEN)
	group = "Species-Unique"

/datum/loadout_item/inhand/envirokit_head_of_security
	name = "Alternate Envirosuit Kit: Head of Security"
	item_path = /obj/item/storage/box/envirosuit/security_hos
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
	group = "Species-Unique"
