/obj/item/radio/headset/silicon/aas
	name = "\proper AAS Integrated Subspace Transceiver"
	keyslot = /obj/item/encryptionkey/aas

/obj/item/encryptionkey/aas
	name = "automated announcement system encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SECURITY = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		RADIO_CHANNEL_MEDICAL = 1,
		RADIO_CHANNEL_SUPPLY = 1,
		RADIO_CHANNEL_SERVICE = 1,
		RADIO_CHANNEL_FACTION = 1,
		RADIO_CHANNEL_AI_PRIVATE = 1,
		RADIO_CHANNEL_ENTERTAINMENT = 1,
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_INTERDYNE = 1,
	)
