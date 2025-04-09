/obj/item/radio
	/// The sound that plays when someone uses the headset
	var/radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/walkie_talkie.ogg'
	/// The volume of the radio sound we make
	var/radio_sound_volume = 25
	/// The sound range of the radio sound we make
	var/radio_sound_range = SHORT_RANGE_SOUND_EXTRARANGE
	/// If the radio talk sound allows vary
	var/radio_sound_has_vary = TRUE

/obj/item/radio/headset
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/radio_chirp.ogg'
	radio_sound_range = SILENCED_SOUND_EXTRARANGE
	radio_sound_has_vary = FALSE

/obj/item/radio/intercom
	radio_sound_range = SHORT_RANGE_SOUND_EXTRARANGE

/obj/item/radio/headset/syndicate //disguised to look like a normal headset for stealth ops
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/syndie.ogg'

/obj/item/radio/headset/headset_sec
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/security.ogg'
