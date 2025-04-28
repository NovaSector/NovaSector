/*
* Staff reward plushies go in this file
* Plushies in this file are not usable in maps, so if you WISH for your plushie to /maybe/ be used in maps
* don't put in this file.
* Please contact Golden if you want your plushie(s) usable on maps.
*/

/obj/item/toy/plush/nova/staff
	icon = 'modular_nova/master_files/icons/obj/staff_plushies.dmi'

// Staff reward for Deadmon
/obj/item/toy/plush/nova/staff/melon
	name = "Melon Plushie"
	desc = "Soft, yet bouncy. The eeriely smiling melon made for the appreciation of melons"
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
/obj/item/toy/plush/nova/staff/parsec
	name = "Engine Dog"
	desc = "."
	icon_state = "plush_parsec"
	gender = FEMALE
	attack_verb_continuous = list(
		"borks",
		"glares",
		)
	attack_verb_simple = list(
		"bork",
		"glare",
		)
	squeak_override = list('modular_nova/modules/emotes/sound/voice/bork.ogg' = 1)

/obj/item/toy/plush/nova/staff/akinshi
	name = "Scary Cat Plushie"
	desc = "A cat in full sec gear. Tired of everyones shit. \
	Looks adorable in some ways, but it still cant beat the femboy allegations."
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

/obj/item/toy/plush/nova/staff/akinshi/attackby()
	. = ..()
	if(!COOLDOWN_FINISHED(src, akinshi_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, akinshi_cooldown, 2 SECONDS)

/obj/item/toy/plush/nova/staff/akinshi/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, akinshi_cooldown))
		return
	say(pick(responses))

//additional stock code pay no attention
	//special_desc_requirement = EXAMINE_CHECK_JOB
	//special_desc_jobs = list(JOB_ASSISTANT, JOB_HEAD_OF_SECURITY)
	//special_desc = "text here."
