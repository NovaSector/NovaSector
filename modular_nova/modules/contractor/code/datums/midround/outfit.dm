/datum/outfit/contractor
	name = "Syndicate Contractor - Full Kit"

	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/neck_gaiter/syndicate
	back = /obj/item/mod/control/pre_equipped/contractor/upgraded
	box = /obj/item/storage/box/survival/syndie
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	internals_slot = ITEM_SLOT_RPOCKET
	belt = /obj/item/storage/belt/military

	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	accessory = /obj/item/clothing/accessory/webbing/pouch/black
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	l_pocket = /obj/item/modular_computer/pda/contractor
	id = /obj/item/card/id/advanced/chameleon/elite
	// this mostly gets set in pre_equip()
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie,
		/obj/item/storage/box/syndicate/contract_kit/midround,
		/obj/item/storage/box/syndicate/contractor_loadout/stealth_contractor,
		/obj/item/trench_tool,
		/obj/item/pinpointer/crew/contractor,
	)

	implants = list(
		/obj/item/implant/uplink,
	)

	id_trim = /datum/id_trim/chameleon/contractor

/datum/outfit/contractor/pre_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	if(user.jumpsuit_style == PREF_SKIRT)
		uniform = /obj/item/clothing/under/syndicate/nova/tactical/skirt

	var/obj/item/storage/medkit/suitable_medkit = /obj/item/storage/medkit/tactical_lite
	var/cyber_limb_amount = 0
	for(var/obj/item/bodypart/limb as anything in user.bodyparts)
		if(limb.bodytype & BODYTYPE_ROBOTIC)
			cyber_limb_amount += 1
	if(issynthetic(user) || cyber_limb_amount >= 3)
		suitable_medkit = /obj/item/storage/medkit/robotic_repair/preemo/stocked
	//set the backpack contents
	backpack_contents = list(
		suitable_medkit,
		/obj/item/storage/box/syndicate/contractor_loadout/tools,
		/obj/item/storage/box/syndicate/contract_kit/midround,
		/obj/item/storage/box/syndicate/contractor_loadout/stealth_contractor,
		/obj/item/trench_tool, // multipurpose! digging graves. mining rocks. caving in faces. matches survival knife for force
		/obj/item/pinpointer/crew/contractor,
	)

/datum/outfit/contractor/post_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()
	if(visuals_only)
		return
	handlebank(user)


/datum/outfit/contractor_preview
	name = "Syndicate Contractor (Preview only)"

	back = /obj/item/mod/control/pre_equipped/empty/contractor
	uniform = /obj/item/clothing/under/syndicate
	glasses = /obj/item/clothing/glasses/night

/datum/outfit/contractor/upgraded
	name = "Syndicate Contractor (Upgraded)"
	back = /obj/item/mod/control/pre_equipped/contractor/upgraded/adminbus
