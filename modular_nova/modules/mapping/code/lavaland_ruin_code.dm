//SPAWNERS//
/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer
	name = "Interdyne Shaft Miner"
	you_are_text = "You are a shaft miner, employed in an Interdyne research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	outfit = /datum/outfit/lavaland_syndicate/comms/space

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/shaftminer/ice
	name = "Interdyne Shaft Miner"
	you_are_text = "You are a shaft miner, employed in an Interdyne research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/ice

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "Interdyne Bioweapon Scientist"
	you_are_text = "You are a science technician employed in an Interdyne research facility developing biological weapons."

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/ice
	outfit = /datum/outfit/lavaland_syndicate/ice

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/deckofficer
	name = "Interdyne Deck Officer"
	you_are_text = "You are a Deck Officer, employed in an Interdyne research facility developing biological weapons."
	outfit = /datum/outfit/lavaland_syndicate/shaftminer/deckofficer

//OUTFITS//
/datum/outfit/lavaland_syndicate
	name = "Interdyne Bioweapon Scientist"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/nova/utility/syndicate
	ears = /obj/item/radio/headset/interdyne
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne=1,
		/obj/item/healthanalyzer/simple/disease=1)

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	syndicate.faction |= ROLE_SYNDICATE

	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	handlebank(syndicate)
	return ..()

/datum/outfit/lavaland_syndicate/ice
	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/nova/syndicate
	ears = /obj/item/radio/headset/interdyne

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/rank/security/nova/utility/redsec/syndicate
	ears = /obj/item/radio/headset/interdyne/comms

/datum/outfit/lavaland_syndicate/comms/space
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/lavaland_syndicate/shaftminer
	name = "Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/rank/cargo/tech/nova/utility/syndicate
	suit = null //Subtype moment
	r_pocket = /obj/item/storage/bag/ore
	id_trim = /datum/id_trim/syndicom/nova/interdyne
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne=1,
		/obj/item/flashlight/seclite=1,
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/lavaland_syndicate/shaftminer/deckofficer
	name = "Interdyne Deck Officer"
	uniform = /obj/item/clothing/under/rank/cargo/qm/nova/interdyne
	neck = /obj/item/clothing/neck/cloak/qm/nova/interdyne
	ears = /obj/item/radio/headset/interdyne/command
	id = /obj/item/card/id/advanced/chameleon/black/silver
	id_trim = /datum/id_trim/syndicom/nova/interdyne/deckofficer

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/deckofficer/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/lavaland_syndicate/shaftminer/ice
	name = "Icemoon Interdyne Shaft Miner"
	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	suit = /obj/item/clothing/suit/hooded/wintercoat/nova/syndicate

//ITEMS

/obj/item/radio/headset/interdyne
	name = "\improper Interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radiosound = 'modular_nova/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = new /obj/item/encryptionkey/syndicate

/obj/item/radio/headset/interdyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/interdyne/command
	name = "\improper Interdyne command headset"
	desc = "A commanding headset to gather your underlings. Protects the ears from flashbangs. It has a large red cross on the earpiece, and a small 'IP' written on the top strap. Protects the ears from flashbangs."
	command = TRUE

/obj/item/radio/headset/interdyne/comms
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne
	keyslot2 = /obj/item/encryptionkey/syndicate

/obj/structure/closet/crate/freezer/sansufentanyl
	name = "sansufentanyl crate"
	desc = "A freezer. Contains refrigerated Sansufentanyl, for managing Hereditary Manifold Sickness. A product of Interdyne Pharmaceuticals."

/obj/structure/closet/crate/freezer/sansufentanyl/PopulateContents()
	. = ..()
	for(var/grabbin_pills in 1 to 10)
		new /obj/item/storage/pill_bottle/sansufentanyl(src)

//MOBS

// hivelords that stand guard where they spawn
/mob/living/basic/mining/hivelord/no_wander
	ai_controller = /datum/ai_controller/basic_controller/hivelord/no_wander

//MOB AI

// same as a regular hivelord minus the idle walking
/datum/ai_controller/basic_controller/hivelord/no_wander
	idle_behavior = null
