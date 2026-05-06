// A semi-permanent "talking head" mob for ATC communications
/mob/atc_voice
	name = "Traffic Control"
	desc = "A voice on the radio."
	/// Radio for sending guild messages
	var/obj/item/radio/radio

/mob/atc_voice/Initialize(mapload, new_name, new_parent)
	. = ..()
	if(new_name)
		name = new_name
	radio = new(src)
	radio.set_listening(FALSE)
	GLOB.atc_voices += src

/mob/atc_voice/Destroy()
	QDEL_NULL(radio)
	GLOB.atc_voices -= src
	UnregisterSignal(src, COMSIG_MOB_SAY)
	return ..()

/mob/atc_voice/get_default_say_verb()
	return "transmits"

/mob/atc_voice/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = "radio")
	radio.talk_into(src, message, RADIO_CHANNEL_COMMON)
