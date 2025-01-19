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
