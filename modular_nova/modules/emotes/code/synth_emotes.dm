/datum/emote/silicon
	cooldown = 2 SECONDS

/datum/emote/silicon/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/emotes/dwoop.ogg'


/datum/emote/silicon/yes
	key = "yes"
	message = "emits an affirmative blip."
	vary = TRUE
	sound = 'sound/machines/synth/synth_yes.ogg'


/datum/emote/silicon/no
	key = "no"
	message = "emits a negative blip."
	vary = TRUE
	sound = 'sound/machines/synth/synth_no.ogg'


/datum/emote/silicon/beep2
	key = "beep2"
	key_third_person = "beeps sharply"
	message = "beeps sharply."
	message_param = "beeps sharply at %t."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/emotes/twobeep_fast.ogg'


/datum/emote/silicon/laughtrack
	key = "laughtrack"
	message = "plays a laughtrack."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/sitcom_laugh/sitcomLaugh2.ogg'
