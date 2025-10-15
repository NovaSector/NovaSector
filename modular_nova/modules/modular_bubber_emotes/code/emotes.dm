// Emotes ported from Bubberstation
// Original credits: Bubberstation contributors
// https://github.com/BubberStation/Bubberstation

/datum/emote/living/chirp
	key = "chirp"
	key_third_person = "chirps"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/chirp.ogg'

/datum/emote/living/fpurr
	key = "fpurr"
	key_third_person = "fpurrs"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/fox_purr.ogg'

/datum/emote/living/gecker
	key = "gecker"
	key_third_person = "geckers"
	message = "geckers!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/foxgecker.ogg'

/datum/emote/living/mar
	key = "mar"
	key_third_person = "mars"
	message = "lets out a mar!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/sound_voice_mar.ogg' // Credit to vorestation

/datum/emote/living/meow_alt
	key = "meow1"
	key_third_person = "meowalt"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/meow1.ogg'

/datum/emote/living/mrowl
	key = "mrowl"
	key_third_person = "mrowls"
	message = "mrowls!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/mrowl.ogg'

/datum/emote/living/tail_thump
	key = "tailthump"
	key_third_person = "tailthumps"
	message = "thumps their tail!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/tailthump.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/tail_thump/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(isnull(tail))
		return FALSE
	return ..()

/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals"
	message = "squeals!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/squeal.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/yipyip
	key = "yipyip"
	key_third_person = "yips twice"
	message = "yips twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/yip.ogg'

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "yips!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/yip/get_sound(mob/living/user)
	return pick('modular_nova/modules/modular_bubber_emotes/sound/voice/yip1.ogg',
				'modular_nova/modules/modular_bubber_emotes/sound/voice/yip2.ogg',
				'modular_nova/modules/modular_bubber_emotes/sound/voice/yip3.ogg')

/datum/emote/living/kweh
	key = "kweh"
	key_third_person = "kwehs"
	message = "kwehs out loud!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/kweh/get_sound(mob/living/user)
	return pick('sound/mobs/non-humanoids/raptor/raptor_1.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_4.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_5.ogg')

/datum/emote/living/kweh_sad
	key = "skweh"
	key_third_person = "skwehs"
	message = "kwehs sadly"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/kweh_sad/get_sound(mob/living/user)
	return pick('sound/mobs/non-humanoids/raptor/raptor_2.ogg',
				'sound/mobs/non-humanoids/raptor/raptor_3.ogg')

/datum/emote/living/xenogrowl
	key = "xenogrowl"
	key_third_person = "xenogrowls"
	message = "growls unnervingly."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/xenogrowl.ogg'

/datum/emote/living/xenohiss
	key = "xenohiss"
	key_third_person = "xenohisses"
	message = "hisses unnervingly."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_nova/modules/modular_bubber_emotes/sound/voice/xenohiss.ogg'

/datum/emote/living/stoatchirp
	key = "schirp" // short for stoatchirp
	key_third_person = "schirps"
	message = "chirp chirp chirps!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/mobs/non-humanoids/stoat/stoat_sounds.ogg'

/datum/emote/living/shortmoo
	key = "smoo" // short for shortmoo
	key_third_person = "smoos"
	message = "quickly moos!"
	emote_type = EMOTE_AUDIBLE
	sound = 'goon/sounds/cow.ogg'

/datum/emote/living/deermah
	key = "mah"
	key_third_person = "mahs"
	message = "bleats like a deer!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_nova/modules/customization/game/objects/items/sound/leaplush.ogg'

