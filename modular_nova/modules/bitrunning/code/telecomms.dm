/obj/item/radio/headset/silicon/ai/faction // Gives the announcement system "faction" access used for bitrunner announcements.
	keyslot = /obj/item/encryptionkey/headset_bitrunning // primary channels are all in keyslot2

/obj/machinery/announcement_system
	radio_type = /obj/item/radio/headset/silicon/ai/faction

// Makes sure faction messages can actually be transmitted on the station. Added to whichever preset has existing supply comms.
/obj/machinery/telecomms/server/presets/supply/Initialize(mapload)
	. = ..()
	freq_listening += FREQ_FACTION

/obj/machinery/telecomms/receiver/preset_left/Initialize(mapload)
	. = ..()
	freq_listening += FREQ_FACTION

/obj/machinery/telecomms/bus/preset_two/Initialize(mapload)
	. = ..()
	freq_listening += FREQ_FACTION
