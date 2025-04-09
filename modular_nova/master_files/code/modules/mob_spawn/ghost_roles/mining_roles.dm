/// Lavaland Hermit

/obj/effect/mob_spawn/ghost_role/human/hermit
	quirks_enabled = TRUE // ghost role quirks
	random_appearance = FALSE // ghost role prefs

/// Beach Dome

/obj/effect/mob_spawn/ghost_role/human/beach
	quirks_enabled = TRUE
	random_appearance = FALSE

/// Space Bar

/obj/effect/mob_spawn/ghost_role/human/bartender
	quirks_enabled = TRUE
	random_appearance = FALSE

/// Preserved Terrarium

/obj/effect/mob_spawn/ghost_role/human/seed_vault
	restricted_species = list(/datum/species/pod)
	quirks_enabled = TRUE
	random_appearance = FALSE

/// Ashwalker Camp

/obj/effect/mob_spawn/ghost_role/human/ash_walker
	restricted_species = list(/datum/species/lizard/ashwalker)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human)
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE))
	quirks_enabled = TRUE // ghost role quirks
	. = ..()

/// Listening Outpost

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

// OUTFITS

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/rank/security/nova/utility/syndicate
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/// Interdyne Planetary Base(s)

// SPAWNERS

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base
	name = "Interdyne Scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "an Interdyne scientist"
	computer_area = /area/ruin/interdyne_planetary_base/main
	you_are_text = "You are a science technician employed in an Interdyne research facility developing biological weapons."
	flavour_text = "Interdyne middle management has relayed that Nanotrasen is actively mining in this sector. A deal with the Syndicate remains. A cargo ferry is docked at the rear of your ship and can be used for trade with both factions. Continue your research as best you can, and try to keep out of trouble."
	outfit = /datum/outfit/interdyne_planetary_base
	spawner_job_path = /datum/job/interdyne_planetary_base
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/ice
	outfit = /datum/outfit/interdyne_planetary_base/ice
	computer_area = /area/ruin/interdyne_planetary_base/main/dorms
	flavour_text = "Interdyne middle management has relayed that Nanotrasen is actively mining in this sector. A deal with the Syndicate remains, but their starship has left the system, leaving our quantum pad without a purpose. Continue your research as best you can, and try to keep out of trouble."
	spawner_job_path = /datum/job/interdyne_planetary_base_icebox

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/shaftminer
	name = "Interdyne Shaft Miner"
	prompt_name = "an Interdyne shaft miner"
	you_are_text = "You are a shaft miner, employed in an Interdyne research facility developing biological weapons."
	outfit = /datum/outfit/interdyne_planetary_base/shaftminer

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/shaftminer/ice
	outfit = /datum/outfit/interdyne_planetary_base/shaftminer/ice
	computer_area = /area/ruin/interdyne_planetary_base/main/dorms
	flavour_text = "Interdyne middle management has relayed that Nanotrasen is actively mining in this sector. A deal with the Syndicate remains, but their starship has left the system, leaving our quantum pad without a purpose. Continue your research as best you can, and try to keep out of trouble."
	spawner_job_path = /datum/job/interdyne_planetary_base_icebox

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/deck_officer
	name = "Interdyne Deck Officer"
	prompt_name = "an Interdyne deck officer"
	you_are_text = "You are a Deck Officer, employed in an Interdyne research facility developing biological weapons."
	outfit = /datum/outfit/interdyne_planetary_base/shaftminer/deckofficer

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/deck_officer/ice
	computer_area = /area/ruin/interdyne_planetary_base/main/dorms
	flavour_text = "Interdyne middle management has relayed that Nanotrasen is actively mining in this sector. A deal with the Syndicate remains, but their starship has left the system, leaving our quantum pad without a purpose. Continue your research as best you can, and try to keep out of trouble."
	spawner_job_path = /datum/job/interdyne_planetary_base_icebox





/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne/deckofficer
	head = /obj/item/clothing/head/hats/syndicate/interdyne_deckofficer_black
	suit = /obj/item/clothing/suit/armor/hos/deckofficer
	ears = /obj/item/radio/headset/interdyne/command
	id = /obj/item/card/id/advanced/silver/generic
	id_trim = /datum/id_trim/syndicom/nova/interdyne/deckofficer

/obj/item/radio/headset/interdyne/green
	name = "interdyne branded headset"
	desc = "A bowman headset in interdyne green, has a small 'IP' written on the earpiece. Protects the ears from flashbangs."
	icon_state = "headset_ip"
	worn_icon_state = "headset_ip"
	icon = 'modular_nova/modules/mapping/icons/obj/headset.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/ears.dmi'


// OUTFITS

/datum/outfit/interdyne_planetary_base
	name = "Interdyne Scientist"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/syndicom/nova/interdyne
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne
	suit = /obj/item/clothing/suit/toggle/labcoat/nova/interdyne_labcoat/white
	head = /obj/item/clothing/head/beret/medical/nova/interdyne
	back = /obj/item/storage/backpack/virology
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne=1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/healthanalyzer/simple/disease=1,
	)
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/interdyne/green
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_hand = /obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil
	implants = list(/obj/item/implant/weapons_auth)
	var/jobtype = /datum/job/interdyne_planetary_base

/datum/outfit/interdyne_planetary_base/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	syndicate.faction |= ROLE_INTERDYNE_PLANETARY_BASE

	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(syndicate)
	return ..()

/datum/outfit/interdyne_planetary_base/ice
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne
	suit = /obj/item/clothing/suit/hooded/wintercoat/medical/viro/interdyne
	ears = /obj/item/radio/headset/interdyne/green
	head = /obj/item/clothing/head/beret/medical/nova/interdyne
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne=1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/healthanalyzer/simple/disease=1,
		/obj/item/clothing/suit/toggle/labcoat/nova/interdyne_labcoat/white=1,
	)

/datum/outfit/interdyne_planetary_base/shaftminer
	name = "Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne/miner
	suit = /obj/item/clothing/suit/syndicate/interdyne_jacket
	r_pocket = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/nova/interdyne/shaftminer
	back = /obj/item/storage/backpack/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne=1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/flashlight/seclite=1,
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/card/mining_point_card=1,
	)

/datum/outfit/interdyne_planetary_base/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne/deckofficer
	head = /obj/item/clothing/head/hats/syndicate/interdyne_deckofficer_black
	suit = /obj/item/clothing/suit/armor/hos/deckofficer
	ears = /obj/item/radio/headset/interdyne/command
	id = /obj/item/card/id/advanced/chameleon/black/silver
	id_trim = /datum/id_trim/syndicom/nova/interdyne/deckofficer

/obj/effect/mob_spawn/ghost_role/human/interdyne_planetary_base/deckofficer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/interdyne_planetary_base/shaftminer/ice
	name = "Icemoon Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/nova/interdyne/miner
	suit = /obj/item/clothing/suit/syndicate/interdyne_jacket

// ITEMS

/obj/item/radio/headset/interdyne
	name = "\improper Interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_syndicate/interdyne

/obj/item/radio/headset/interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/command
	name = "\improper Interdyne command headset"
	desc = "A commanding headset to gather your underlings. Protects the ears from flashbangs. It has a large red cross on the earpiece, and a small 'IP' written on the top strap. Protects the ears from flashbangs."
	command = TRUE

/obj/item/radio/headset/interdyne/comms
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne

// STRUCTURES

/obj/structure/closet/crate/freezer/sansufentanyl
	name = "sansufentanyl crate"
	desc = "A freezer. Contains refrigerated Sansufentanyl, for managing Hereditary Manifold Sickness. A product of Interdyne Pharmaceuticals."

/obj/structure/closet/crate/freezer/sansufentanyl/PopulateContents()
	. = ..()
	for(var/grabbin_pills in 1 to 10)
		new /obj/item/storage/pill_bottle/sansufentanyl(src)

/obj/structure/closet/l3closet/interdyne
	name = "Interdyne level 3 biohazard gear closet"

/obj/structure/closet/l3closet/virology/PopulateContents()
	new /obj/item/storage/bag/bio(src)
	new /obj/item/clothing/suit/bio_suit/interdyne(src)
	new /obj/item/clothing/head/bio_hood/interdyne(src)
	new /obj/item/clothing/mask/breath(src)
	new /obj/item/tank/internals/oxygen(src)
	new /obj/item/reagent_containers/syringe/antiviral(src)
