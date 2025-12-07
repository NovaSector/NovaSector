/datum/emote/living/awuff
	key = "awuff"
	key_third_person = "awuffs"
	message = "wuffs softly."
	message_mime = "snorts, quietly, with sass, and in a belligerent fashion."
	sound = 'modular_nova/master_files/sound/voice/awuff.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/awuff/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/awuff.ogg', 'modular_nova/master_files/sound/voice/awuff2.ogg',  'modular_nova/master_files/sound/voice/awuff3.ogg')
	
/datum/emote/living/arf
	key = "arf"
	key_third_person = "arfs"
	message = "arfs!"
	message_mime = "imitates a small dog's yap!"
	sound = 'modular_nova/master_files/sound/voice/arf.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/arf/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/arf.ogg', 'modular_nova/master_files/sound/voice/arf2.ogg', 'modular_nova/master_files/sound/voice/arf3.ogg', 'modular_nova/master_files/sound/voice/arf4.ogg')

/datum/emote/living/coyhowl
	key = "coyhowl"
	key_third_person = "coyhowls"
	message = "howls like coyote!"
	message_mime = "acts out a coyote's howl!"
	sound = 'modular_nova/master_files/sound/voice/coyotehowl.ogg'
	specific_emote_audio_cooldown = 2.94 SECONDS // Uses longest sound's time
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/coyhowl/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/coyotehowl.ogg', 'modular_nova/master_files/sound/voice/coyotehowl2.ogg', 'modular_nova/master_files/sound/voice/coyotehowl3.ogg', 'modular_nova/master_files/sound/voice/coyotehowl4.ogg', 'modular_nova/master_files/sound/voice/coyotehowl5.ogg')
	
/datum/emote/living/wolfhowl
	key = "wolfhowl"
	key_third_person = "wolfhowls"
	message = "howls like wolf!"
	message_mime = "acts out a wolf's howl!"
	sound = 'modular_nova/master_files/sound/voice/wolfhowl.ogg'
	specific_emote_audio_cooldown = 7 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/wolfhowl/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/wolfhowl.ogg', 'modular_nova/master_files/sound/voice/wolfhowl2.ogg', 'modular_nova/master_files/sound/voice/wolfhowl3.ogg')

/datum/emote/living/dwhine
	key = "dwhine"
	key_third_person = "dwhines"
	message = "whines anxiously like a dog."
	message_mime = "looks distressed and pouts a bit!"
	sound = 'modular_nova/master_files/sound/voice/dwhine.ogg'
	specific_emote_audio_cooldown = 4.1 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dwhine/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/dwhine.ogg', 'modular_nova/master_files/sound/voice/dwhine2.ogg', 'modular_nova/master_files/sound/voice/dwhine3.ogg', 'modular_nova/master_files/sound/voice/dwhine4.ogg', 'modular_nova/master_files/sound/voice/dwhine5.ogg')
	
/datum/emote/living/dgrowl
	key = "dgrowl"
	key_third_person = "dgrowls"
	message = "growls like a dog."
	message_mime = "grits and bares their teeth, leaning in and shaking their head like a dog!"
	sound = 'modular_nova/master_files/sound/voice/dgrowl.ogg'
	specific_emote_audio_cooldown = 3.2 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dgrowl/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/dgrowl.ogg', 'modular_nova/master_files/sound/voice/dgrowl2.ogg', 'modular_nova/master_files/sound/voice/dgrowl3.ogg', 'modular_nova/master_files/sound/voice/dgrowl4.ogg', 'modular_nova/master_files/sound/voice/dgrowl5.ogg')

/datum/emote/living/aggrobark
	key = "aggrobark"
	key_third_person = "aggrobarks"
	message = "barks aggressively!"
	message_mime = "imitates barking aggressively, and gnashes at the air!"
	sound = 'modular_nova/master_files/sound/voice/aggrobark.ogg'
	specific_emote_audio_cooldown = 2.6 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/aggrobark/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/aggrobark.ogg', 'modular_nova/master_files/sound/voice/aggrobark2.ogg', 'modular_nova/master_files/sound/voice/aggrobark3.ogg', 'modular_nova/master_files/sound/voice/aggrobark4.ogg')
	
/datum/emote/living/dcomplain
	key = "dcomplain"
	key_third_person = "dcomplains"
	message = "complains like a dog."
	message_mime = "imitates a canine's whine with neck stretched out."
	sound = 'modular_nova/master_files/sound/voice/dcomplain.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dcomplain/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/dcomplain.ogg', 'modular_nova/master_files/sound/voice/dcomplain2.ogg', 'modular_nova/master_files/sound/voice/dcomplain3.ogg', 'modular_nova/master_files/sound/voice/dcomplain4.ogg', 'modular_nova/master_files/sound/voice/dcomplain5.ogg')
	
/datum/emote/living/meowdeep
	key = "meowdeep"
	key_third_person = "meowdeeps"
	message = "meows, in a deep tone."
	message_mime = "takes on a stern, yet smug expression, and mouths a 'mao'."
	sound = 'modular_nova/master_files/sound/voice/meowdeep.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/meowdeep/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/master_files/sound/voice/meowdeep.ogg', 'modular_nova/master_files/sound/voice/meowdeep2.ogg',  'modular_nova/master_files/sound/voice/meowdeep3.ogg')