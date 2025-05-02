/datum/outfit/job/bitrunner
	r_pocket = /obj/item/bitrunning_disk/prefs
	ears = /obj/item/radio/headset/headset_cargo/bitrunning

/obj/item/radio/headset/headset_cargo/bitrunning
	name = "bitrunning radio headset"
	desc = "A headset used by the Cargo's screen-smashers."
	keyslot = /obj/item/encryptionkey/headset_bitrunning

/obj/item/encryptionkey/headset_bitrunning
	name = "bitrunning radio encryption key"
	icon_state = "cypherkey_cargo"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_FACTION = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#49241a#a3344c"

/datum/outfit/subcontracted_bitrunner
	name = "Subcontracted Bitrunner"
	uniform = /obj/item/clothing/under/rank/cargo/bitrunner
	belt = /obj/item/modular_computer/pda/bitrunner
	ears = /obj/item/radio/headset/headset_cargo
	back = /obj/item/storage/backpack/messenger
	shoes = /obj/item/clothing/shoes/sneakers/black
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/storage/medkit/regular,
		/obj/item/flashlight,
		/obj/item/storage/box/nif_ghost_box,
		/obj/item/storage/box/syndie_kit/chameleon/ghostcafe,
	)
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/bit_avatar
