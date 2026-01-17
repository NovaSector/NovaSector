/datum/outfit/job/bitrunner
	r_pocket = /obj/item/disk/bitrunning/prefs
	ears = /obj/item/radio/headset/headset_cargo/bitrunning

/obj/item/radio/headset/headset_cargo/bitrunning
	name = "bitrunning radio headset"
	desc = "A headset used by the Cargo's screen-smashers."
	keyslot = /obj/item/encryptionkey/headset_bitrunning

/obj/item/encryptionkey/headset_bitrunning
	name = "bitrunning radio encryption key"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SCIENCE = 1, RADIO_CHANNEL_FACTION = 1)
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/encryptionkey/headset_bitrunning"
	post_init_icon_state = "cypherkey_cargo"
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#49241a#a3344c"

/datum/outfit/subcontracted_bitrunner
	name = "Subcontracted Bitrunner"
	uniform = /obj/item/clothing/under/rank/cargo/bitrunner
	back = /obj/item/storage/backpack/messenger
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/advanced
