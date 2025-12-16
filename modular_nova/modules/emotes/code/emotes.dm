
#define EMOTE_DELAY (2 SECONDS) //To prevent spam emotes.

/mob
	var/nextsoundemote = 1 //Time at which the next emote can be played

/datum/emote
	cooldown = EMOTE_DELAY
	var/muzzle_ignore = FALSE

//Disables the custom emote blacklist from TG that normally applies to slimes.
/datum/emote/living/custom
	mob_type_blacklist_typecache = list(/mob/living/brain)
	cooldown = 0
	stat_allowed = SOFT_CRIT

//me-verb emotes should not have a cooldown check
/datum/emote/living/custom/check_cooldown(mob/user, intentional)
	return TRUE


/datum/emote/imaginary_friend/custom/check_cooldown(mob/user, intentional)
	return TRUE


/datum/emote/living/nodnod
	key = "nod2"
	key_third_person = "nod2s"
	message = "nods twice."
	message_param = "nods twice at %t."

/datum/emote/living/blush
	sound = 'modular_nova/modules/emotes/sound/emotes/blush.ogg'

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/emotes/voxrustle.ogg'


/datum/emote/living/cough/get_sound(mob/living/user)
	. = ..()
	if(isvox(user))
		return 'modular_nova/modules/emotes/sound/emotes/voxcough.ogg'
	return

/datum/emote/living/cough
	specific_emote_audio_cooldown = 5 SECONDS

/datum/emote/living/carbon/whistle
	specific_emote_audio_cooldown = 5 SECONDS

/datum/emote/living/sneeze
	specific_emote_audio_cooldown = 5 SECONDS

/datum/emote/living/sneeze/get_sound(mob/living/user)
	. = ..()
	if(isvox(user))
		return 'modular_nova/modules/emotes/sound/emotes/voxsneeze.ogg'
	return

/datum/emote/living/yawn
	message_robot = "synthesizes a yawn."
	message_AI = "synthesizes a yawns."

/datum/emote/living/sniff/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/turf/open/current_turf = get_turf(user)
	if(istype(current_turf) && current_turf.pollution)
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			if(carbon_user.internal) //Breathing from internals means we cant smell
				return
			carbon_user.next_smell = world.time + SMELL_COOLDOWN
		current_turf.pollution.smell_act(user)


/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/peep_once.ogg'

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice"
	message = "peeps twice like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/peep.ogg'

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	message_param = "snaps twice at %t."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/snap2.ogg'

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	message_param = "snaps thrice at %t."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/snap3.ogg'

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/awoo.ogg'

/datum/emote/living/nya
	key = "nya"
	key_third_person = "nyas"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/nya.ogg'

/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/weh.ogg'

/datum/emote/living/carbon/msqueak
	key = "msqueak"
	vary = TRUE

/datum/emote/living/mousesqueak
	key = "squeak"
	key_third_person = "squeaks"
	message = "squeaks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg'

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "yips!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/fox_squeak.ogg'

/datum/emote/living/fwhine
	key = "fwhine"
	key_third_person = "fwhines"
	message = "whines like a fox."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/fwhine/get_sound(mob/living/user)
	return pick('modular_nova/modules/emotes/sound/voice/fox1.ogg',
				'modular_nova/modules/emotes/sound/voice/fox2.ogg',
				'modular_nova/modules/emotes/sound/voice/fox3.ogg',
				'modular_nova/modules/emotes/sound/voice/fox4.ogg',
				'modular_nova/modules/emotes/sound/voice/fox5.ogg',
				'modular_nova/modules/emotes/sound/voice/fox6.ogg',
				'modular_nova/modules/emotes/sound/voice/fox7.ogg',
				'modular_nova/modules/emotes/sound/voice/fox8.ogg',
				'modular_nova/modules/emotes/sound/voice/fox9.ogg',
				'modular_nova/modules/emotes/sound/voice/fox10.ogg',
				'modular_nova/modules/emotes/sound/voice/fox11.ogg',
				'modular_nova/modules/emotes/sound/voice/fox12.ogg',
				'modular_nova/modules/emotes/sound/voice/fox13.ogg')

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/merp.ogg'

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/bark2.ogg'

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "squishes!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/slime_squish.ogg'

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = SFX_CAT_MEOW

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE

/datum/emote/living/hiss/get_sound(mob/living/user)
	if(isxenohybrid(user))
		return SFX_HISS
	else
		return 'modular_nova/modules/emotes/sound/emotes/hiss.ogg'

/datum/emote/living/carbon/mchitter
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE

/datum/emote/living/carbon/mchitter/get_sound(mob/living/user)
	if(ismoth(user))
		return 'sound/mobs/humanoids/moth/moth_chitter.ogg'
	else
		return 'sound/mobs/non-humanoids/insect/chitter.ogg'

/datum/emote/living/sigh/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_nova/modules/emotes/sound/emotes/male/male_sigh.ogg'
		return 'modular_nova/modules/emotes/sound/emotes/female/female_sigh.ogg'
	return

/datum/emote/living/gasp/get_sound(mob/living/user)
	. = ..()
	if(iscarbon(user))
		if(isxenohybrid(user))
			return pick('sound/mobs/non-humanoids/hiss/lowHiss2.ogg',
						'sound/mobs/non-humanoids/hiss/lowHiss3.ogg',
						'sound/mobs/non-humanoids/hiss/lowHiss4.ogg')
	return

/datum/emote/living/snore
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/emotes/snore.ogg'

/datum/emote/living/burp
	vary = TRUE

/datum/emote/living/burp/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_nova/modules/emotes/sound/emotes/male/burp_m.ogg'
		return 'modular_nova/modules/emotes/sound/emotes/female/burp_f.ogg'
	return

/datum/emote/living/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	specific_emote_audio_cooldown = 5 SECONDS
	affected_by_pitch = FALSE

/datum/emote/living/clap/get_sound(mob/living/user)
	return pick('sound/mobs/humanoids/human/clap/clap1.ogg',
				'sound/mobs/humanoids/human/clap/clap2.ogg',
				'sound/mobs/humanoids/human/clap/clap3.ogg',
				'sound/mobs/humanoids/human/clap/clap4.ogg')

/datum/emote/living/clap/can_run_emote(mob/living/carbon/user, status_check = TRUE, intentional, params)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "claps once."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	affected_by_pitch = FALSE

/datum/emote/living/clap1/get_sound(mob/living/user)
	return pick('modular_nova/modules/emotes/sound/emotes/claponce1.ogg',
				'modular_nova/modules/emotes/sound/emotes/claponce2.ogg')

/datum/emote/living/clap1/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	message_AI = "tilts the image on their display."

/datum/emote/beep
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/emotes/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living) //Beep already exists on brains and silicons

/datum/emote/living/blink2
	key = "blink2"
	key_third_person = "blinks twice"
	message = "blinks twice."
	message_AI = "has their display flicker twice."

/datum/emote/living/rblink
	key = "rblink"
	key_third_person = "rapidly blinks"
	message = "rapidly blinks!"
	message_AI = "has their display port flash rapidly!"

/datum/emote/living/squint
	key = "squint"
	key_third_person = "squints"
	message = "squints."
	message_AI = "zooms in."

/datum/emote/living/smirk
	key = "smirk"
	key_third_person = "smirks"
	message = "smirks."

/datum/emote/living/eyeroll
	key = "eyeroll"
	key_third_person = "rolls their eyes"
	message = "rolls their eyes."

/datum/emote/living/huff
	key = "huffs"
	key_third_person = "huffs"
	message = "huffs!"

/datum/emote/living/etwitch
	key = "etwitch"
	key_third_person = "twitches their ears"
	message = "twitches their ears!"

/datum/emote/living/clear
	key = "clear"
	key_third_person = "clears their throat"
	message = "clears their throat."

// Avian revolution
/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "bawks"
	message = "bawks like a chicken."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/bawk.ogg'

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/caw.ogg'

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/caw2.ogg'

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "bleps their tongue out. Blep."
	message_AI = "shows an image of a random blepping animal. Blep."
	message_robot = "bleps their robo-tongue out. Blep."

/datum/emote/living/bork
	key = "bork"
	key_third_person = "borks"
	message = "lets out a bork."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/bork.ogg'
	specific_emote_audio_cooldown = 4 SECONDS

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/hoot.ogg'

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "lets out a growl."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/growl.ogg'
	specific_emote_audio_cooldown = 4 SECONDS

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "lets out a woof."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/woof.ogg'

/datum/emote/living/baa
	key = "baa"
	key_third_person = "baas"
	message = "lets out a baa."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/baa.ogg'

/datum/emote/living/baa2
	key = "baa2"
	key_third_person = "baas"
	message = "bleats."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/baa2.ogg'

/datum/emote/living/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "lets out a wurble."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/wurble.ogg'
	specific_emote_audio_cooldown = 4 SECONDS

/datum/emote/living/rattle
	key = "rattle"
	key_third_person = "rattles"
	message = "rattles!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/rattle.ogg'

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/cackle_yeen.ogg'
	specific_emote_audio_cooldown = 5 SECONDS

/mob/living/proc/do_ass_slap_animation(atom/slapped)
	do_attack_animation(slapped, no_effect=TRUE)
	var/image/gloveimg = image('icons/effects/effects.dmi', slapped, "slapglove", slapped.layer + 0.1)
	gloveimg.pixel_y = -5
	gloveimg.pixel_x = 0
	slapped.flick_overlay_view(gloveimg, 1 SECONDS)

	// And animate the attack!
	animate(gloveimg, alpha = 175, transform = matrix() * 0.75, pixel_x = 0, pixel_y = -5, pixel_z = 0, time = 0.3 SECONDS)
	animate(time = 0.1 SECONDS)
	animate(alpha = 0, time = 0.3 SECONDS, easing = CIRCULAR_EASING|EASE_OUT)

//Froggie Revolution
/datum/emote/living/warble
	key = "warble"
	key_third_person = "warbles"
	message = "warbles!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/warbles.ogg'

/datum/emote/living/trills
	key = "trills"
	key_third_person = "trills!"
	message = "trills!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/trills.ogg'

/datum/emote/living/rpurr
	key = "rpurr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/raptor_purr.ogg'

/datum/emote/living/purr //Ported from CitRP originally by buffyuwu.
	key = "purr"
	key_third_person = "purrs!"
	message = "purrs!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = SFX_CAT_PURR
	specific_emote_audio_cooldown = 5 SECONDS

/datum/emote/living/moo
	key = "moo"
	key_third_person = "moos!"
	message = "moos!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/moo.ogg'

/datum/emote/living/honk
	key = "honk1"
	key_third_person = "honks loudly like a goose!"
	message = "honks loudly like a goose!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/goose_honk.ogg'

/datum/emote/living/mggaow
	key = "mggaow"
	key_third_person = "meows loudly"
	message = "meows loudly!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/mggaow.ogg'

/datum/emote/living/mrrp
	key = "mrrp"
	key_third_person = "mrrps"
	message = "mrrps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/mrrp.ogg'

/datum/emote/living/prbt
	key = "prbt"
	key_third_person = "prbts!"
	message = "prbts!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/prbt.ogg'

/datum/emote/living/gnash
	key = "gnash"
	key_third_person = "gnashes"
	message = "gnashes."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/weapons/bite.ogg'

/datum/emote/living/thump
	key = "thump"
	key_third_person = "thumps"
	message = "thumps their foot!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'sound/effects/glass/glassbash.ogg'

/datum/emote/living/flutter
	key = "flutter"
	key_third_person = "rapidly flutters their wings!"
	message = "rapidly flutters their wings!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'sound/mobs/humanoids/moth/moth_flutter.ogg'

/datum/emote/living/sigh_exasperated
	key = "esigh" // short for exasperated sigh
	key_third_person = "esighs"
	message = "lets out an exasperated sigh."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh_exasperated/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!ishuman(user))
		return
	var/image/emote_animation = image('icons/mob/human/emote_visuals.dmi', user, "sigh")
	flick_overlay_global(emote_animation, GLOB.clients, 2.0 SECONDS)

/datum/emote/living/sigh_exasperated/get_sound(mob/living/user)
	if(iscarbon(user))
		if(user.gender == MALE)
			return 'modular_nova/modules/emotes/sound/emotes/male/male_sigh_exasperated.ogg'
		return 'modular_nova/modules/emotes/sound/emotes/female/female_sigh_exasperated.ogg'
	return

/datum/emote/living/surrender
	muzzle_ignore = TRUE

/datum/emote/living/awuff
	key = "awuff"
	key_third_person = "awuffs"
	message = "wuffs softly."
	message_mime = "snorts, quietly, with sass, and in a belligerent fashion."
	sound = 'modular_nova/modules/emotes/sound/voice/awuff.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/awuff/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/modules/emotes/sound/voice/awuff.ogg', 'modular_nova/modules/emotes/sound/voice/awuff2.ogg', 'modular_nova/modules/emotes/sound/voice/awuff3.ogg')

/datum/emote/living/arf
	key = "arf"
	key_third_person = "arfs"
	message = "arfs!"
	message_mime = "imitates a small dog's yap!"
	sound = 'modular_nova/modules/emotes/sound/voice/arf.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/arf/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/modules/emotes/sound/voice/arf.ogg', 'modular_nova/modules/emotes/sound/voice/arf2.ogg', 'modular_nova/modules/emotes/sound/voice/arf3.ogg')

/datum/emote/living/coyhowl
	key = "coyhowl"
	key_third_person = "coyhowls"
	message = "howls like coyote!"
	message_mime = "acts out a coyote's howl!"
	sound = 'modular_nova/modules/emotes/sound/voice/coyotehowl.ogg'
	specific_emote_audio_cooldown = 2.8 SECONDS // Uses longest sound's time
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/coyhowl/get_sound(mob/living/user)
	. = ..()
	return pick(
		'modular_nova/modules/emotes/sound/voice/coyotehowl.ogg',
		'modular_nova/modules/emotes/sound/voice/coyotehowl2.ogg',
		'modular_nova/modules/emotes/sound/voice/coyotehowl3.ogg',
		'modular_nova/modules/emotes/sound/voice/coyotehowl4.ogg',
		'modular_nova/modules/emotes/sound/voice/coyotehowl5.ogg',
	)

/datum/emote/living/wolfhowl
	key = "wolfhowl"
	key_third_person = "wolfhowls"
	message = "howls like wolf!"
	message_mime = "acts out a wolf's howl!"
	sound = 'modular_nova/modules/emotes/sound/voice/wolfhowl.ogg'
	specific_emote_audio_cooldown = 6.3 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/wolfhowl/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/modules/emotes/sound/voice/wolfhowl.ogg', 'modular_nova/modules/emotes/sound/voice/wolfhowl2.ogg', 'modular_nova/modules/emotes/sound/voice/wolfhowl3.ogg')

/datum/emote/living/dwhine
	key = "dwhine"
	key_third_person = "dwhines"
	message = "whines anxiously like a dog."
	message_mime = "looks distressed and pouts a bit!"
	sound = 'modular_nova/modules/emotes/sound/voice/dwhine.ogg'
	specific_emote_audio_cooldown = 3.52 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dwhine/get_sound(mob/living/user)
	. = ..()
	return pick(
		'modular_nova/modules/emotes/sound/voice/dwhine.ogg',
		'modular_nova/modules/emotes/sound/voice/dwhine2.ogg',
		'modular_nova/modules/emotes/sound/voice/dwhine3.ogg',
		'modular_nova/modules/emotes/sound/voice/dwhine4.ogg',
		'modular_nova/modules/emotes/sound/voice/dwhine5.ogg',
	)

/datum/emote/living/dgrowl
	key = "dgrowl"
	key_third_person = "dgrowls"
	message = "growls like a dog."
	message_mime = "grits and bares their teeth, leaning in and shaking their head like a dog!"
	sound = 'modular_nova/modules/emotes/sound/voice/dgrowl.ogg'
	specific_emote_audio_cooldown = 3.17 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dgrowl/get_sound(mob/living/user)
	. = ..()
	return pick(
		'modular_nova/modules/emotes/sound/voice/dgrowl.ogg',
		'modular_nova/modules/emotes/sound/voice/dgrowl2.ogg',
		'modular_nova/modules/emotes/sound/voice/dgrowl3.ogg',
		'modular_nova/modules/emotes/sound/voice/dgrowl4.ogg',
		'modular_nova/modules/emotes/sound/voice/dgrowl5.ogg',
	)

/datum/emote/living/aggrobark
	key = "aggrobark"
	key_third_person = "aggrobarks"
	message = "barks aggressively!"
	message_mime = "imitates barking aggressively, and gnashes at the air!"
	sound = 'modular_nova/modules/emotes/sound/voice/aggrobark.ogg'
	specific_emote_audio_cooldown = 2.5 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/aggrobark/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/modules/emotes/sound/voice/aggrobark.ogg', 'modular_nova/modules/emotes/sound/voice/aggrobark2.ogg', 'modular_nova/modules/emotes/sound/voice/aggrobark3.ogg', 'modular_nova/modules/emotes/sound/voice/aggrobark4.ogg')

/datum/emote/living/dcomplain
	key = "dcomplain"
	key_third_person = "dcomplains"
	message = "complains like a dog."
	message_mime = "imitates a canine's whine with neck stretched out."
	sound = 'modular_nova/modules/emotes/sound/voice/dcomplain.ogg'
	specific_emote_audio_cooldown = 2.6 SECONDS // Use length of longest sound file
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/dcomplain/get_sound(mob/living/user)
	. = ..()
	return pick(
		'modular_nova/modules/emotes/sound/voice/dcomplain.ogg',
		'modular_nova/modules/emotes/sound/voice/dcomplain2.ogg',
		'modular_nova/modules/emotes/sound/voice/dcomplain3.ogg',
		'modular_nova/modules/emotes/sound/voice/dcomplain4.ogg',
		'modular_nova/modules/emotes/sound/voice/dcomplain5.ogg',
	)

/datum/emote/living/meowdeep
	key = "meowdeep"
	key_third_person = "meowdeeps"
	message = "meows, in a deep tone."
	message_mime = "takes on a stern, yet smug expression, and mouths a 'mao'."
	sound = 'modular_nova/modules/emotes/sound/voice/meowdeep.ogg'
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/meowdeep/get_sound(mob/living/user)
	. = ..()
	return pick('modular_nova/modules/emotes/sound/voice/meowdeep.ogg', 'modular_nova/modules/emotes/sound/voice/meowdeep2.ogg', 'modular_nova/modules/emotes/sound/voice/meowdeep3.ogg')

/datum/emote/living/teshchirp
	key = "teshchirp"
	key_third_person = "chirps!"
	message = "chirps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/teshchirp.ogg' // Credits to Virgo Station for the files.

/datum/emote/living/teshsqueak
	key = "teshsqueak"
	key_third_person = "squeaks!"
	message = "squeaks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/teshsqueak.ogg' // Credits to Virgo Station for the files.

/datum/emote/living/teshtrill
	key = "teshtrill"
	key_third_person = "trills!"
	message = "trills!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_nova/modules/emotes/sound/voice/teshtrill.ogg' // Credits to Virgo Station for the files.
