/*
*	NOVA MODULAR OUTFITS FILE
*	PUT ANY NEW ERT OUTFITS HERE
*/

/datum/outfit/centcom/asset_protection
	name = "Asset Protection"

	uniform = /obj/item/clothing/under/rank/centcom/commander
	back = /obj/item/mod/control/pre_equipped/apocryphal
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/hud/toggle/thermal
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	belt = /obj/item/storage/belt/security/full
	l_hand = /obj/item/gun/energy/pulse/carbine/loyalpin // if this is still bulky make it not bulky and storable on belt/back/bag/exosuit
	id = /obj/item/card/id/advanced/centcom/ert
	ears = /obj/item/radio/headset/headset_cent/alt

	skillchips = list(/obj/item/skillchip/disk_verifier)

	backpack_contents = list(/obj/item/storage/box/survival/engineer = 1,\
		/obj/item/storage/medkit/regular = 1,\
		/obj/item/storage/box/handcuffs = 1,\
		/obj/item/crowbar/power = 1, // this is their "all access" pass lmao
		)

/datum/outfit/centcom/asset_protection/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/Radio = person.ears
	Radio.set_frequency(FREQ_CENTCOM)
	Radio.freqlock = TRUE
	var/obj/item/card/id/ID = person.wear_id
	ID.assignment = "Asset Protection"
	ID.registered_name = person.real_name
	ID.update_label()
	..()

/datum/outfit/centcom/asset_protection/leader
	name = "Asset Protection Officer"
	head = /obj/item/clothing/head/helmet/space/beret

/datum/outfit/solfed/espatier
	name = "SolFed Espatier Rifleman"

	uniform = /obj/item/clothing/under/solfed/marines
	head = /obj/item/clothing/head/helmet/solfed
	mask = /obj/item/clothing/mask/gas/alt
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/det_suit/sol/marine
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/military
	neck = /obj/item/clothing/neck/mantle/solfed
	accessory = null
	belt_contents = list (
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
		/obj/item/melee/baton/security/loaded = 1,
		)

	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/solfed
	ears = /obj/item/radio/headset/headset_solfed/espatier
	l_pocket = /obj/item/tank/internals/emergency_oxygen/double
	r_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/tank/internals/emergency_oxygen/double = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/storage/box/flashbangs = 1,
		/obj/item/storage/box/nri_flares = 1,
		/obj/item/storage/medkit/frontier/stocked = 1,
	)

	id_trim = /datum/id_trim/solfed/espatier

/datum/outfit/solfed/espatier/engineer
	name = "SolFed Espatier Engineer"
	head = /obj/item/clothing/head/helmet/solfed/engineer
	belt = /obj/item/storage/belt/utility/full/powertools
	belt_contents = list(
		/obj/item/screwdriver/power = 1,
		/obj/item/crowbar/power = 1,
		/obj/item/weldingtool/electric = 1, // NOVA EDIT - original: new /obj/item/weldingtool/experimental(src)
		/obj/item/multitool = 1,
		/obj/item/holosign_creator/atmos = 1,
		/obj/item/extinguisher/mini = 1,
		/obj/item/stack/cable_coil = 1,
	)
	mask = /obj/item/clothing/mask/gas/welding/up
	ears = /obj/item/radio/headset/headset_solfed/espatier/engineer
	backpack_contents = list(
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
		/obj/item/storage/box/nri_flares = 1,
		/obj/item/storage/box/smart_metal_foam = 1,
		/obj/item/stack/sheet/iron/fifty = 1,
		/obj/item/storage/medkit/frontier/stocked = 1,
	)

/datum/outfit/solfed/espatier/corpsman
	name = "SolFed Espatier Corpsman"
	head = /obj/item/clothing/head/helmet/solfed/corpsman
	ears = /obj/item/radio/headset/headset_solfed/espatier/corpsman
	backpack_contents = list(
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/storage/box/nri_flares = 1,
		/obj/item/storage/medkit/tactical = 1,
	)

/datum/outfit/solfed/espatier/squadleader
	name = "SolFed Espatier Squad Leader"
	head = /obj/item/clothing/head/helmet/solfed/squadlead
	ears = /obj/item/radio/headset/headset_solfed/espatier/squadleader

	backpack_contents = list(
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/storage/medkit/tactical_lite = 1,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 4,
		/obj/item/storage/box/nri_flares = 1,
		/obj/item/binoculars = 1,
	)

/datum/outfit/solfed/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/Radio = person.ears
	Radio.set_frequency(FREQ_SOLFED)
	Radio.freqlock = TRUE
	var/obj/item/card/id/ID = person.wear_id
	ID.registered_name = person.real_name
	ID.update_label()
	..()

/datum/outfit/solfed/espatier/corpsman/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID = person.wear_id
	ID.assignment = "Solfed Espatier Corpsman"
	ID.update_label()
	..()

/datum/outfit/solfed/espatier/engineer/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID = person.wear_id
	ID.assignment = "Solfed Espatier Engineer"
	ID.update_label()
	..()

/datum/outfit/solfed/espatier/squadleader/post_equip(mob/living/carbon/human/person, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID = person.wear_id
	ID.assignment = "Solfed Espatier Squad Leader"
	ID.update_label()
	..()

/obj/item/radio/headset/headset_solfed/officials
	name = "\improper SolFed Officials Headset"
	icon_state = "com_headset"
	worn_icon_state = "com_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader

/obj/item/radio/headset/headset_solfed/espatier
	name = "\improper SolFed Espatier headset"
	desc = "A headset used by the Solar Federation espatiers."
	icon_state = "com_headset_alt"
	worn_icon_state = "com_headset_alt"
	keyslot = /obj/item/encryptionkey/headset_solfed/sec
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/security.ogg'

/obj/item/radio/headset/headset_solfed/espatier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_solfed/espatier/corpsman
	keyslot = /obj/item/encryptionkey/headset_solfed/med

/obj/item/radio/headset/headset_solfed/espatier/engineer
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos

/obj/item/radio/headset/headset_solfed/espatier/squadleader
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader

/obj/item/encryptionkey/headset_solfed/squadleader
	name = "\improper SolFed grand encryption key"
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/squadleader"
	post_init_icon_state = "cypherkey_espitator"
	greyscale_config = /datum/greyscale_config/encryptionkey_syndicate
	greyscale_colors = "#ebebeb#2b2793"
