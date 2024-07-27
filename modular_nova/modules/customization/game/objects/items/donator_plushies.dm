/*
* Donation reward plushies go in this file
* Plushies in this file are not usable in maps, so if you WISH for your plushie to /maybe/ be used in maps
* don't put in this file.
* Please contact Golden if you want your plushie(s) usable on maps.
*/


// Donation reward for tobjv
/obj/item/toy/plush/nova/donator/tesh
	name = "Squish-Me-Tesh"
	desc = "Winner of Be Made Into A Plushy by ClownCo!"
	icon_state = "plushie_tobjv2"

// Donation reward for tobjv
/obj/item/toy/plush/nova/donator/immovable_rod
	name = "immovable rod"
	desc = "Realistic! But also squishy and certainly not as dangerous as its real counterpart."
	icon_state = "plushie_tobjv"

/obj/item/toy/plush/nova/donator/immovable_rod/Bump(atom/clong)
	. = ..()
	if(isliving(clong))
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		return

// Donation reward for gamerguy14948
/obj/item/toy/plush/nova/donator/voodoo
	name = "voodoo doll"
	desc = "A not so small voodoo doll made out of cut and sewn potato bags. It almost looks cute."
	icon_state = "plushie_gamerguy"

// Donation reward for shyshadow
/obj/item/toy/plush/nova/donator/plushie_winrow
	name = "dark and brooding lizard plush"
	desc = "An almost intimidating black lizard plush, this one's got a \
			little beret to come with it! Best not to separate the two. Its eyes shine with suggestion, no maidens?"
	icon_state = "plushie_shyshadow"

// Donation reward for Dudewithatude
/obj/item/toy/plush/nova/donator/plushie_star
	name = "star angel plush"
	desc = "The plushie of a celestial in the known universe."
	icon_state = "plushie_star"
	gender = FEMALE
	squeak_override = list('modular_nova/modules/emotes/sound/voice/trills.ogg' = 1)

// Donation reward for SRQ
/obj/item/toy/plush/nova/donator/plushie_chiara
	name = "commanding fox plush"
	desc = "A large stuffed fox which radiates confidence and vigor from their emerald eyes."
	icon_state = "plushie_chiara"

// Donation reward for Superlagg
/obj/item/toy/plush/nova/donator/plushie_dan
	name = "comfy fox plush"
	desc = "A stuffed fox with an aura of endearment leaking from their soft exterior."
	icon_state = "plushie_dan"

//Donation reward for KLB100
/obj/item/toy/plush/nova/fox/plushie_jeanne
	name = "masked roboticist plushie"
	desc = "A familiar snow white Vulpkanin plushie. This one appears to be wearing a mask obscuring their face."
	icon_state = "plushie_jeanne"
	attack_verb_continuous = list(
		"cuddles",
		"squishes",
		"blushes",
		)
	attack_verb_simple = list(
		"cuddle",
		"squish",
		"blush",
		)

//Donation reward for Dalao Azure
/obj/item/toy/plush/nova/donator/plushie_azyre
	name = "handsome chef plushie"
	desc = "A need to cook only rivaled by a hunger for fox tail."
	icon_state = "plushie_azyre"

//Donation reward for Razurath
/obj/item/toy/plush/nova/donator/plushie_razurath
	name = "science shark plushie"
	desc = "A determined scientist with a hint of mischief in her smile."
	icon_state = "plush_scishark"
	attack_verb_continuous = list(
		"bites",
		"eats",
		"fin slaps",
		)
	attack_verb_simple = list(
		"bite",
		"eat",
		"fin slap",
		)
	squeak_override = list('sound/weapons/bite.ogg' = 1)

//Other donation reward for Razurath
/obj/item/toy/plush/nova/donator/plushie_razurath/second
	name = "dwarf shark plushie"
	desc = "Despite her height, the plushie regards you with keen and frankly unamused eyes; the look on her face, and the \
			elegance of her little tiny coat tell you that she knows something you don't."
	icon_state = "plushie_nedilla"

//Donation reward for October23
/obj/item/toy/plush/nova/donator/plushie_elofy
	name = "bumbling wolfgirl plushie"
	desc = "A white-haired wolfgirl in a stylish red security skirt. Despite her scary cybernetic arm, she is soft to hug and only wishes to be praised and comforted."
	icon_state = "plush_lonie"
	attack_verb_continuous = list(
		"snuggles",
		"nibbles",
		"awoos",
		"tail whaps",
		)
	attack_verb_simple = list(
		"snuggle",
		"nibble",
		"awoo",
		"tail whap",
		)
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/merowr.ogg' = 1)

//Donation reward for syntax1112
/obj/item/toy/plush/nova/donator/plushie_syntax1112
	name = "lop bunny plushie"
	desc = "A floppy-eared rabbit in marketable plushie form. Complete with an internal self-inflating squeaker device!"
	icon_state = "fuzz_bunny"
	attack_verb_continuous = list(
		"nibbles",
		"squeaks",
		"nose twitches",
		"thumps",
		"whops",
		)
	attack_verb_simple = list(
		"nibble",
		"squeak",
		"nose twitch",
		"thump",
		"whop",
		)
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

// Donation reward for SomeRandomOwl
/obj/item/toy/plush/nova/donator/snow_owl
	name = "snowy owl plush"
	desc = "A very soft plush resembling a feathery snow owl. It has a cute witch like hat and hoots every time you squeeze it. It smells faintly of oreo cookies."
	icon_state = "plushie_owl"
	attack_verb_continuous = list(
		"nuzzles",
		"hoots",
		"hugs",
		)
	attack_verb_simple = list(
		"nuzzle",
		"hoot",
		"hug",
		)
	squeak_override = list('modular_nova/modules/emotes/sound/voice/hoot.ogg' = 1)

// Donation reward for Jolly66
/obj/item/toy/plush/nova/donator/derg_plushie
	name = "wingless dragon plush"
	desc = "A cute green-and-yellow wingless dragon plushie! For what its worth, it does have a comically large tail. \
		Comes with an additional paramedic cap."
	icon_state = "plushie_derg"
	attack_verb_continuous = list(
		"wehs",
		"wehs softly",
		"stutters",
		)
	attack_verb_simple = list(
		"weh",
		"weh softly",
		"stutter",
		)
	squeak_override = list('modular_nova/modules/emotes/sound/voice/weh.ogg' = 1)

// Donation reward for Gofawful5
/obj/item/toy/plush/nova/donator/tracy
	name = "creature plushie"
	desc = "An astonishingly well-endowed catfox plushie... It seems content."
	icon_state = "plush_tracy"
	attack_verb_continuous = list("expands")
	attack_verb_simple = list("expand")
	squeak_override = list('modular_nova/modules/customization/game/objects/items/sound/tracymrowr.ogg' = 1)
	gender = FEMALE

//Donation reward for Frixit
/obj/item/toy/plush/nova/donator/plushie_synthia
	name = "adventurous synth plushie"
	desc = "This plush is perfect For adventures in space and in bed, a cuddly purple Synth, their scarf is extra soft!"
	icon_state = "plushie_synthia"
	attack_verb_continuous = list(
		"blushes",
		"hugs",
		"whips",
		)
	attack_verb_simple = list(
		"blush",
		"hug",
		"whip",
		)
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for Kitsun
/obj/item/toy/plush/nova/donator/jecca
	name = "sexy snoodle plushie"
	desc = "For some reason, this plushie is rather shiny, with glistening, glittering scales, \
			and its ruby colored eyes seem to be rather enticing and full of mischievous, lewd thoughts behind them."
	icon_state = "plushie_jecca"
	attack_verb_continuous = list("sighs")
	attack_verb_simple = list("sigh")
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/female/female_sigh.ogg' = 1)
	gender = FEMALE

//Donation reward for BriareosBlue
/obj/item/toy/plush/nova/donator/courier_synth
	name = "courier synth plushie"
	desc = "This synth plushie looks about ready to deliver hugs and beeps straight to the heart! The tag seems to have an advertisement for a delivery company on it..."
	icon_state = "plushie_courier"
	attack_verb_continuous = list(
		"delivers",
		"export scans",
		"dwoops",
		"bwuhs",
		"stamps",
		)
	attack_verb_simple = list(
		"deliver",
		"export scan",
		"dwoop",
		"bwuh",
		"stamp",
		)
	squeak_override = list('modular_nova/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for olirant
/obj/item/toy/plush/nova/donator/plush_janiborg
	name = "Friendly Janiborg Plush"
	desc = "A miniature omnidroid toy straight from the Lockstep Enterprises Corporation marketing department in handsome janitorial purple. Now with real squirting action!"
	icon_state = "plush_janiborg"
	attack_verb_continuous = list(
		"beeps",
		"washes",
		"mops",
		"squirts",
		"soaps",
		)
	attack_verb_simple = list(
		"beep",
		"wash",
		"mop",
		"squirt",
		"soap",
		)
	squeak_override = list('sound/machines/twobeep.ogg' = 1)
