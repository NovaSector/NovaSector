/obj/effect/landmark/bitrunning/bitrunning_relay
	name = "bitrunning relay marker"

/obj/machinery/telecomms/relay/preset/auto/bitrunning
	circuit = null
	freq_listening = list(FREQ_COMMON, FREQ_SUPPLY, FREQ_SCIENCE, FREQ_FACTION)
	receiving = FALSE // Yes, receiving and not broadcasting, they are backwards

/obj/item/radio/bitrunning
	name = "internal bitrunner radio"
	keyslot = /obj/item/encryptionkey/headset_bitrunning

/obj/machinery/quantum_server
	var/telecomms_radio = TRUE

/obj/machinery/quantum_server/proc/toggle_radio()
	telecomms_radio = !telecomms_radio
