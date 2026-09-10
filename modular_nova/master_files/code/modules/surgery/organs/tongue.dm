// Remove the could_speak_language check from the tongue code. This is a much better solution than trying to grant omnitongue on prefs load, and prevents any funny breakages.
/obj/item/organ/tongue/could_speak_language(datum/language/language_path)
	return TRUE

/obj/item/organ/tongue/lizard
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'modular_nova/modules/emotes/sound/voice/scream_lizard.ogg',
			'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
			'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
			'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
		),
		/datum/emote/living/carbon/hiss::key = 'sound/mobs/humanoids/lizard/lizard_hiss.ogg',
		/datum/emote/living/laugh::key = 'sound/mobs/humanoids/lizard/lizard_laugh1.ogg',
		/datum/emote/living/deathgasp::key = 'sound/mobs/humanoids/lizard/deathsound.ogg',
	)

/obj/item/organ/tongue/robot
	emote_sounds = list(
		/datum/emote/living/deathgasp::key = 'sound/mobs/non-humanoids/cyborg/borg_deathsound.ogg',
		/datum/emote/living/scream::key = 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg',
	)

/obj/item/organ/tongue/bone
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_nova/modules/emotes/sound/voice/scream_skeleton.ogg',
	)

/obj/item/organ/tongue/jelly
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_nova/modules/emotes/sound/emotes/jelly_scream.ogg',
	)

/obj/item/organ/tongue/zombie
	emote_sounds = list(
		/datum/emote/living/scream::key = 'modular_nova/modules/emotes/sound/emotes/zombie_scream.ogg',
	)

/obj/item/organ/tongue/fly
	emote_sounds = list(
		/datum/emote/living/scream::key = 'sound/mobs/humanoids/moth/scream_moth.ogg',
	)
