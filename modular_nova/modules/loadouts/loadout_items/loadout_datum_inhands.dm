// LOADOUT ITEM DATUMS FOR BOTH HAND SLOTS
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

/datum/loadout_item/inhand/cane
	name = "Cane"
	item_path = /obj/item/cane

/datum/loadout_item/inhand/cane/crutch
	name = "Crutch"
	item_path = /obj/item/cane/crutch

/datum/loadout_item/inhand/cane/white
	name = "White Cane"
	item_path = /obj/item/cane/white

/datum/loadout_item/inhand/briefcase
	name = "Briefcase"
	item_path = /obj/item/storage/briefcase

/datum/loadout_item/inhand/briefcase_secure
	name = "Secure Briefcase"
	item_path = /obj/item/storage/briefcase/secure

/datum/loadout_item/inhand/guncase_large
	name = "Black Empty Gun Case (Large)"
	item_path = /obj/item/storage/toolbox/guncase/nova/empty

/datum/loadout_item/inhand/guncase_large/yellow
	name = "Yellow Empty Gun Case (Large)"
	item_path = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/empty

/datum/loadout_item/inhand/guncase_small
	name = "Black Empty Gun Case (Small)"
	item_path = /obj/item/storage/toolbox/guncase/nova/pistol/empty

/datum/loadout_item/inhand/skub
	name = "Skub"
	item_path = /obj/item/skub

/datum/loadout_item/inhand/skateboard
	name = "Skateboard"
	item_path = /obj/item/melee/skateboard

/datum/loadout_item/inhand/toolbox
	name = "Full Toolbox"
	item_path = /obj/item/storage/toolbox/mechanical
	blacklisted_roles = list(JOB_PRISONER)

/datum/loadout_item/inhand/bouquet_mixed
	name = "Mixed Bouquet"
	item_path = /obj/item/bouquet

/datum/loadout_item/inhand/bouquet_sunflower
	name = "Sunflower Bouquet"
	item_path = /obj/item/bouquet/sunflower

/datum/loadout_item/inhand/bouquet_poppy
	name = "Poppy Bouquet"
	item_path = /obj/item/bouquet/poppy

/datum/loadout_item/inhand/bouquet_rose
	name = "Rose Bouquet"
	item_path = /obj/item/bouquet/rose

/*
/datum/loadout_item/inhand/smokingpipe
	name = "Smoking Pipe"
	item_path = /obj/item/cigarette/pipe
*/

/datum/loadout_item/inhand/flag_nt
	name = "Folded Nanotrasen Flag"
	item_path = /obj/item/sign/flag/nanotrasen

/datum/loadout_item/inhand/flag_agurk
	name = "Folded Kingdom Of Agurkrral Flag"
	item_path = /obj/item/sign/flag/ssc

/datum/loadout_item/inhand/flag_solfed
	name = "Folded Sol Federation Flag"
	item_path = /obj/item/sign/flag/terragov

/datum/loadout_item/inhand/flag_moghes
	name = "Folded Republic Of Northern Moghes Flag"
	item_path = /obj/item/sign/flag/tizira

/datum/loadout_item/inhand/flag_mothic
	name = "Folded Grand Nomad Fleet Flag"
	item_path = /obj/item/sign/flag/mothic

/datum/loadout_item/inhand/flag_teshari
	name = "Folded Teshari League For Self-Determination Flag"
	item_path = /obj/item/sign/flag/mars

/datum/loadout_item/inhand/flag_nri
	name = "Folded Novaya Rossiyskaya Imperiya Flag"
	item_path = /obj/item/sign/flag/nri

/datum/loadout_item/inhand/flag_azulea
	name = "Folded Azulea Flag"
	item_path = /obj/item/sign/flag/azulea

/datum/loadout_item/inhand/saddlebags
	name = "saddlebags"
	item_path = /obj/item/storage/backpack/saddlebags

/datum/loadout_item/inhand/saddle // these should be in the other category but apparantly those are "pocket" loadout items so idk?
	name = "riding saddle (leather)"
	item_path = /obj/item/riding_saddle/leather

/datum/loadout_item/inhand/saddle_blue
	name = "riding saddle (blue)"
	item_path = /obj/item/riding_saddle/leather/blue

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

/datum/loadout_item/inhand/envirokit_black
	name = "Envirosuit Kit: Black"
	item_path = /obj/item/storage/box/envirosuit/black
	restricted_species = list(SPECIES_PLASMAMAN)

/datum/loadout_item/inhand/envirokit_white
	name = "Envirosuit Kit: White"
	item_path = /obj/item/storage/box/envirosuit/white
	restricted_species = list(SPECIES_PLASMAMAN)

/datum/loadout_item/inhand/envirokit_khaki
	name = "Envirosuit Kit: Khaki"
	item_path = /obj/item/storage/box/envirosuit/khaki
	restricted_species = list(SPECIES_PLASMAMAN)

/datum/loadout_item/inhand/envirokit_slacks
	name = "Envirosuit Kit: Formal Enviroslacks"
	item_path = /obj/item/storage/box/envirosuit/slacks
	restricted_species = list(SPECIES_PLASMAMAN)

/datum/loadout_item/inhand/envirokit_prototype
	name = "Envirosuit Kit: Protoype"
	item_path = /obj/item/storage/box/envirosuit/prototype
	restricted_species = list(SPECIES_PLASMAMAN)

/datum/loadout_item/inhand/envirokit_security
	name = "Alternate Envirosuit Kit: Security Officer"
	item_path = /obj/item/storage/box/envirosuit/security
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/inhand/envirokit_security_warden
	name = "Alternate Envirosuit Kit: Warden"
	item_path = /obj/item/storage/box/envirosuit/security_warden
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/inhand/envirokit_head_of_security
	name = "Alternate Envirosuit Kit: Head of Security"
	item_path = /obj/item/storage/box/envirosuit/security_hos
	restricted_species = list(SPECIES_PLASMAMAN)
	restricted_roles = list(JOB_HEAD_OF_SECURITY)
