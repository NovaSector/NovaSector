/obj/machinery/button/door/indestructible/ancient_milsim
	name = "SNPC Zone Entry Control"
	desc = "A special button that, when pushed, deletes itself. Hopefully prevents unintended or malicious softlocks; and equalises the encounter hidden behind the fog."
	id = "engagement_control"
	var/obj/item/radio/radio

/obj/machinery/button/door/indestructible/ancient_milsim/Initialize(mapload, ndir, built)
	. = ..()
	radio = new(src)
	radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun()
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/button/door/indestructible/ancient_milsim/screwdriver_act()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/attackby()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/emag_act()
	return

/obj/machinery/button/door/indestructible/ancient_milsim/attack_hand()
	. = ..()
	if(.)
		return
	radio.talk_into(src, "Fog is down, prepare for contact.", RADIO_CHANNEL_CYBERSUN)
	qdel(src)

/obj/machinery/door/poddoor/ancient_milsim
	name = "fog of war"
	desc = "'Best' game mechanic ever. At least it keeps you protected, you know? Deletes itself when the button is pushed."
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "pyroclastic"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/ancient_milsim/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/machinery/door/poddoor/ancient_milsim/screwdriver_act()
	return

/obj/machinery/door/poddoor/ancient_milsim/welder_act()
	return

/obj/machinery/door/poddoor/ancient_milsim/open()
	qdel(src)
