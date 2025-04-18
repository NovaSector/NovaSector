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
