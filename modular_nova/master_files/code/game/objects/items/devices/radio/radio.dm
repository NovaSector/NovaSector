 /// DS-2 & Interdyne silicon radios

/obj/item/radio/borg/syndicate/ghost_role // ds2 and interdyne since they both use non-antag Interdyne freq
	name = "\proper Suspicious Integrated Subspace Transceiver "
	syndie = TRUE
	keyslot = /obj/item/encryptionkey/headset_syndicate/interdyne

/obj/item/radio/borg/syndicate/ghost_role/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_INTERDYNE)
