/*
* Staff reward plushies go in this file
* Plushies in this file are not usable in maps, so if you WISH for your plushie to /maybe/ be used in maps
* don't put in this file.
* Please contact Golden if you want your plushie(s) usable on maps.
*/

// Staff reward for Deadmon
/obj/item/toy/plush/nova/melon
	name = "Melon Plushie"
	desc = "Soft, yet bouncy. The eerily smiling melon made for the appreciation of melons"
	icon = 'modular_nova/master_files/icons/obj/staff_plushies.dmi'
	icon_state = "plush_melon"
	gender = FEMALE
	attack_verb_continuous = list(
		"bounces",
		"glares",
	)
	attack_verb_simple = list(
		"bounce",
		"glare",
	)
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

// Staff reward for Moonridden
/obj/item/toy/plush/nova/parsec
	name = "Engine Stray"
	desc = "This loud fuzzy plushie comes with a limited edition Singularity-Squish stressball! It barks, constantly, especially at new people or things. \
		It carries that special station smell, with just a hint of plasma. Very pliable and pleasant to squeeze, with just enough bounce. \
		Comes with a label warning of the product's flammability, and advises against inserting any object other than the provided stressball into the mouth."
	icon = 'modular_nova/master_files/icons/obj/staff_plushies.dmi'
	icon_state = "plush_parsec"
	gender = FEMALE
	attack_verb_continuous = list(
		"borks",
		"barks",
		"wuffs",
		"wans",
		"growls",
		"mrrps",
		"sniffs",
		"woofs",
	)
	attack_verb_simple = list(
		"bork",
		"bark",
		"wuff",
		"wan",
		"growl",
		"mrrp",
		"sniff",
		"woof",
	)
	// Sound effects for squeaking the plushie
	squeak_override = list(
		'modular_nova/modules/emotes/sound/voice/bork.ogg' = 2,
		'modular_nova/modules/emotes/sound/voice/mrrp.ogg' = 1,
		'modular_nova/modules/emotes/sound/voice/bark1.ogg' = 3,
		'modular_nova/modules/emotes/sound/voice/growl.ogg' = 1,
		'modular_nova/modules/emotes/sound/voice/awoo.ogg' = 1,
		'modular_nova/modules/emotes/sound/emotes/blush.ogg' = 1,
		'sound/effects/magic/charge.ogg' = 1,
		'sound/effects/supermatter.ogg' = 1,
	)
	/// What the Plushie replies when used on another person
	var/static/list/responses = list(
		"Ball.",
		"Ball!",
		"+BALL!+",
		"Ball?",
		"Ball...",
		"Bark.",
		"Bark!",
		"+BARK!+",
		"Awooooo!",
		"Did you know Amollin has sugar in it? Guess how I found out!",
		"Take a seat before you unwrench that pipe!",
		"It's not the size of the pipe, it's how you connect it.",
		"There is never an appropriate time for Zauker!",
		"Leave the emitters on, I'm sure it's fine.",
		"NO SLIMES.",
		"I will bite.",
		"That Singuloose was not my fault!",
		"What do you mean I can't keep the rad mold for free tritium?!",
		"Every pipe counts!",
		"Come sit on the guard rails with me...",
		"Have you ever laid down under the emitter firing line?",
	)
	COOLDOWN_DECLARE(parsec_cooldown)

/obj/item/toy/plush/nova/parsec/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, parsec_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, parsec_cooldown, 3 SECONDS)

/obj/item/toy/plush/nova/parsec/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, parsec_cooldown))
		return
	say(pick(responses))

/obj/item/toy/plush/nova/parsec/attack_self(mob/user)
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE) // To avoid spam, in some cases (sadly not all of them)
	var/mob/living/living_user = user
	if(istype(living_user))
		living_user.add_mood_event("hug", /datum/mood_event/warmhug/parsec, src)
	user.visible_message(span_notice("[user] is licked by \the [src]."), span_notice("You get licked by \the [src]."))

/datum/mood_event/warmhug/parsec
	description = span_nicegreen("She licked me right on my nose! Awwwh!")
	mood_change = 3
	timeout = 5 MINUTES

/obj/item/toy/plush/nova/akinshi
	name = "Scary Cat Plushie"
	desc = "A cat in full sec gear. Tired of everyone's shit. \
		Looks adorable in some ways, but it still cant beat the femboy allegations."
	icon = 'modular_nova/master_files/icons/obj/staff_plushies.dmi'
	icon_state = "plush_nik"
	gender = MALE
	attack_verb_continuous = list(
		"smokes",
		"shoots",
		"smacks",
		"hits",
		)
	attack_verb_simple = list(
		"smoke",
		"shoot",
		"smack",
		"hit",
		)
	squeak_override = list(
		'modular_nova/modules/emotes/sound/voice/nya.ogg' = 1,
		'modular_nova/modules/emotes/sound/voice/mggaow.ogg' = 1,
		'modular_nova/modules/emotes/sound/voice/scream_cat.ogg' = 1,
		)
	var/responses = list(
		"Uh huh.",
		"Go back to training.",
		"Make a deal with the devil, will you?", "I'm watching. . .",
		"I need a drink.",
	)
	COOLDOWN_DECLARE(akinshi_cooldown)

/obj/item/toy/plush/nova/akinshi/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, akinshi_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, akinshi_cooldown, 3 SECONDS)

/obj/item/toy/plush/nova/akinshi/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, akinshi_cooldown))
		return
	say(pick(responses))
