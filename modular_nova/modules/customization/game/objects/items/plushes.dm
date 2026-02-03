// Because plushes have a second desc var that needs to be updated
/obj/item/toy/plush/on_loadout_custom_described()
	normal_desc = desc

// // MODULAR PLUSHES
/obj/item/toy/plush/nova
	icon = 'modular_nova/master_files/icons/obj/plushes.dmi'
	inhand_icon_state = null

/obj/item/toy/plush/nova/borbplushie
	name = "borb plushie"
	desc = "An adorable stuffed toy that resembles a round, fluffy looking bird. Not to be mistaken for his friend, the birb plushie."
	icon_state = "plushie_borb"
	attack_verb_continuous = list("pecks", "peeps")
	attack_verb_simple = list("peck", "peep")
	squeak_override = list('modular_nova/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/nova/deer
	name = "deer plushie"
	desc = "An adorable stuffed toy that resembles a deer."
	icon_state = "plushie_deer"
	attack_verb_continuous = list("headbutts", "boops", "bapps", "bumps")
	attack_verb_simple = list("headbutt", "boop", "bap", "bump")
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/nova/sechound
	name = "sec-hound plushie"
	desc = "An adorable stuffed toy of a SecHound, the trusty Nanotrasen sponsored security borg!"
	icon_state = "plushie_securityk9"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/medihound
	name = "medi-hound plushie"
	desc = "An adorable stuffed toy of a medihound."
	icon_state = "plushie_medihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/engihound
	name = "engi-hound plushie"
	desc = "An adorable stuffed toy of a engihound."
	icon_state = "plushie_engihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/scrubpuppy
	name = "scrub-puppy plushie"
	desc = "An adorable stuffed toy of a Scrubpuppy, the hard-working pup who keeps the station clean!"
	icon_state = "plushie_scrubpuppy"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/meddrake
	name = "medi-drake plushie"
	desc = "An adorable stuffed toy of a Medidrake."
	icon_state = "plushie_meddrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/secdrake
	name = "sec-drake plushie"
	desc = "An adorable stuffed toy of a Secdrake."
	icon_state = "plushie_secdrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/nova/fox
	name = "fox plushie"
	desc = "An adorable stuffed toy of a Fox."
	icon_state = "plushie_fox"
	attack_verb_continuous = list("geckers", "boops", "nuzzles")
	attack_verb_simple = list("gecker", "boop", "nuzzle")
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/nova/ian
	name = "plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon_state = "ianplushie"
	attack_verb_continuous = list("barks", "woofs", "wags his tail at")
	attack_verb_simple = list("lick", "nuzzle", "bite")
	squeak_override = list('modular_nova/modules/emotes/sound/voice/bark2.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/nova/ian/small
	name = "small plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon_state = "corgi"

/obj/item/toy/plush/nova/ian/lisa
	name = "plush girly corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Lisa\"?"
	icon_state = "girlycorgi"
	attack_verb_continuous = list("barks", "woofs", "wags her tail at")
	gender = FEMALE

/obj/item/toy/plush/nova/cat
	name = "cat plushie"
	desc = "A small cat plushie with black beady eyes."
	icon_state = "blackcat"
	attack_verb_continuous = list("cuddles", "meows", "hisses")
	attack_verb_simple = list("cuddle", "meow", "hiss")
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/merowr.ogg' = 1)

/obj/item/toy/plush/nova/cat/tux
	name = "tux cat plushie"
	icon_state = "tuxedocat"

/obj/item/toy/plush/nova/cat/white
	name = "white cat plushie"
	icon_state = "whitecat"

/obj/item/toy/plush/lizard_plushie
	squeak_override = list('modular_nova/modules/emotes/sound/voice/weh.ogg' = 1)

/obj/item/toy/plush/nova/funniyellowrock
	name = "squishy yellow rock"
	desc = "A familiar looking yellow rock plushie. Touching it won't reduce you to dust. Probably."
	icon_state = "plush_sm"
	squeak_override = list('sound/machines/sm/accent/delam/1.ogg' = 1)

/obj/item/toy/plush/nova/fkinbnuuy
	name = "heckin bnuuy"
	desc = "A small bunny plushie with black beady eyes. The nametag appears to be misspelled?"
	icon_state = "plush_bnuuy"
	attack_verb_continuous = list("cuddles", "squeaks")
	attack_verb_simple = list("cuddle", "squeak")
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/nova/securifox
	name = "securifox slushie"
	desc = "An NT security branded fox plush. Wait. If it has more than one tail, doesn't that make it a kitsune? And why does it look so smug?"
	icon_state = "plush_dee"
	attack_verb_continuous = list("geckers", "boops", "nuzzles")
	attack_verb_simple = list("gecker", "boop", "nuzzle")
	squeak_override = list('sound/vehicles/mecha/justice_shield_broken.ogg' = 1)

/obj/item/toy/plush/nova/towa
	name = "tiny overwatch"
	desc = "It invokes a certain comfort knowing its on your side when the chips are down."
	icon_state = "plush_towa"
	attack_verb_continuous = list("cuddles", "meows", "hisses")
	attack_verb_simple = list("cuddle", "meow", "hiss")
	squeak_override = list('modular_nova/modules/kahraman_equipment/sound/thumper_thump/punch_press_2.wav' = 1)

/obj/item/toy/plush/nova/fushi
	name = "fluffy dragon"
	desc = "A rather adorable soft plush of a dragon, seems rather fluffy."
	icon_state = "plush_fushi_hat"
	attack_verb_continuous = list("cuddles", "nuzzles", "pats")
	attack_verb_simple = list("cuddle", "nuzzle", "pat")
	squeak_override = list(
		'modular_nova/modules/emotes/sound/voice/wurble.ogg' = 10, //10% chance to wurble
		'modular_nova/modules/emotes/sound/voice/weh.ogg' = 90,
	)
	gender = MALE
	/// If TRUE, we are wearing our hat
	var/plushhat = TRUE

	///Sounds the plush makes when hitting something
	var/static/list/responses = list(
		"WEH.",
		"This isnt my office...",
		"Has anyone seen Ian?",
		"Weeeeehhhhhh!",
		"Don't take my hat!",
		"No I cant give you all access.",
		"How are you doing today?",
		"Careful with my tail!",
		"Command is being silly today.",
		"I used to be tiny you know.",
		"I'm not a Fushi, I'm a Plushi!",
		"Cuddle approved. Promotion pending.",
		"Paperwork is temporary. Fluff is eternal.",
		"I'm the HoP, Head of Pats",
		"I’m very busy being approachable.",
		"This is a safe workplace. Mostly.",
		"Tiny dragon, big responsibilities.",
		"You can pet me one more time",
	)
	///Emotes the plush makes when being petted
	var/static/list/responses_action = list(
		"wags his tail happily.",
		"nuzzles affectionately.",
		"purrs contentedly.",
		"does a little happy dance.",
	)

	COOLDOWN_DECLARE(fushi_cooldown)

/obj/item/toy/plush/nova/fushi/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, fushi_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, fushi_cooldown, 3 SECONDS)

// controls the emotes and sound when interacted with
/obj/item/toy/plush/nova/fushi/attack_self(mob/user)
	visible_message("[src] [span_notice(pick(responses_action))]")
	if(!COOLDOWN_FINISHED(src, fushi_cooldown))
		return
	playsound(src, pick(squeak_override), 30)
	COOLDOWN_START(src, fushi_cooldown, 2 SECONDS)

// controls the hat toggle
/obj/item/toy/plush/nova/fushi/attack_self_secondary(mob/user)
	plushhat = !plushhat
	if(plushhat)
		say("My hat is back!")
	else
		say("Hey! That's my hat!")
	update_appearance(UPDATE_ICON_STATE)

/obj/item/toy/plush/nova/fushi/update_icon_state()
	if(plushhat)
		icon_state = initial(icon_state)
	else
		icon_state = "plush_fushi"
	return ..()
