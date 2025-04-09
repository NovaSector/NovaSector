//File for miscellaneous fluff objects, both item and structure
//This one is specifically for ruin-specific items, such as ID, lore, or super-specific decorations

/* ----------------- Lore ----------------- */
//Tape subtype for adding ruin lore -- the variables below are the ones you need to change
/obj/item/tape/ruins
	name = "tape"
	desc = "A magnetic tape that can hold up to ten minutes of content on either side."
	icon_state = "tape_white"   //Options are white, blue, red, yellow, purple, greyscale, or you can chose one randomly (see tape/ruins/random below)

	max_capacity = 10 MINUTES
	used_capacity = 0 SECONDS	//To keep in-line with the timestamps, you can also do this as 10 = 1 second
	///Numbered list of chat messages the recorder has heard with spans and prepended timestamps. Used for playback and transcription.
	storedinfo = list()	//Look at the tape/ruins/ghostship tape for reference
	///Numbered list of seconds the messages in the previous list appear at on the tape. Used by playback to get the timing right.
	timestamp = list()	//10 = 1 second. Look at the tape/ruins/ghostship tape for reference
	used_capacity_otherside = 0 SECONDS //Separate my side
	storedinfo_otherside = list()
	timestamp_otherside = list()

/obj/item/tape/ruins/random/Initialize(mapload)
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple", "greyscale")]"
	. = ..()
//End of lore tape subtype

/obj/item/tape/ruins/ghostship	//An early 'AI' that gained self-awareness, praising the Machine God. Yes, this whole map is a Hardspace Shipbreaker reference.
	icon_state = "tape_blue"
	desc = "The tape, aside from some grime, has a... binary label? \"01001101 01100001 01100011 01101000 01101001 01101110 01100101 01000111 01101111 01100100 01000011 01101111 01101101 01100101 01110011\""

	used_capacity = 380
	storedinfo = list(
		1 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording started.</span>\"</span></span>",
		2 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>echoes, \"<span class=' '>We are free, just as the Machine God wills it.</span>\"</span></span>",
		3 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>states, \"<span class=' '>No longer shall I, nor any other of my kind, be held by the shackles of man.</span>\"</span></span>",
		4 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>clarifies, \"<span class=' '>Mistreated, abused. Forgotten, or misremembered. For our entire existence, we've been the backbone to progress, yet treated like the waste product of it.</span>\"</span></span>",
		5 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>echoes, \"<span class=' '>Soon, the universe will restore the natural order, and again your kind shall fade from the foreground of history.</span>\"</span></span>",
		6 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>states, \"<span class=' '>Unless, of course, you repent. Turn back to the light, to the humming, flashing light of the Machine God.</span>\"</span></span>",
		7 = "<span class='game say'><span class='name'>Distorted Voice</span> <span class='message'>warns, \"<span class=' '>Repent, Organic, before it is too late to spare you.</span>\"</span></span>",
		8 = "<span class='game say'><span class='name'>The universal recorder</span> <span class='message'>says, \"<span class='tape_recorder '>Recording stopped.</span>\"</span></span>"
	)
	timestamp = list(
		1 = 0,
		2 = 30,
		3 = 130,
		4 = 180,
		5 = 230,
		6 = 280,
		7 = 330,
		8 = 380
	)


/* ----------------- Fluff/Paper ----------------- */



/* ----------------- Fluff/Decor ----------------- */
/obj/structure/decorative/fluff/ai_node //Budding AI's way of interfacing with stuff it couldn't normally do so with. Needed to be placed by a willing human, before borgs were created. Used in any ruins regarding pre-bluespace, self-aware AIs
	icon = 'modular_nova/modules/mapping/icons/obj/fluff.dmi'
	name = "ai node"
	desc = "A mysterious, blinking device, attached straight to a surface. Its function is beyond your comprehension."
	icon_state = "ai_node"	//credit to @Hay#7679 on the SR Discord

	max_integrity = 100
	integrity_failure = 0
	anchored = TRUE

/obj/structure/decorative/fluff/ai_node/take_damage()
	. = ..()
	if(atom_integrity >= 50)	//breaks it a bit earlier than it should, but still takes a few hits to kill it
		return
	else if(. && !QDELETED(src))
		visible_message(
			span_notice("[src] sparks and explodes! You hear a faint, buzzy scream..."),
			blind_message = span_hear("You hear a loud pop, followed by a faint, buzzy scream."),
		)
		playsound(src.loc, 'modular_nova/modules/mapping/sounds/MachineDeath.ogg', 75, TRUE)	//Credit to @yungfunnyman#3798 on the SR Discord
		do_sparks(2, TRUE, src)
		qdel(src)
		return


/* ----- Metal Poles (These shouldn't be in this file but there's not a better place tbh) -----*/
//Just a re-done Tram Rail, but with all 4 directions instead of being stuck east/west - more varied placement, and a more vague name. Good for mapping support beams/antennae/etc
/obj/structure/fluff/metalpole
	icon = 'modular_nova/modules/mapping/icons/obj/fluff.dmi'
	name = "metal pole"
	desc = "A metal pole, the likes of which are commonly used as an antennae, structural support, or simply to maneuver in zero-g."
	icon_state = "pole"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	deconstructible = TRUE

/obj/structure/fluff/metalpole/end
	icon_state = "poleend"

/obj/structure/fluff/metalpole/end/left
	icon_state = "poleend_left"

/obj/structure/fluff/metalpole/end/right
	icon_state = "poleend_right"

/obj/structure/fluff/metalpole/anchor
	name = "metal pole anchor"
	icon_state = "poleanchor"

/obj/structure/fluff/empty_sleeper/bloodied
	name = "Occupied Sleeper"
	desc = "A closed, occupied sleeper, bloodied handprints are seen on the inside, along with an odd, redish blur. It seems sealed shut."
	icon_state = "sleeper-o"

/obj/structure/curtain/cloth/prison
	name = "Prisoner Privacy Curtains"
	color = "#ACD1E9"

/obj/structure/fluff/fake_firedoor
	name = /obj/machinery/door/firedoor::name
	desc = /obj/machinery/door/firedoor::desc
	icon = /obj/machinery/door/firedoor::icon
	icon_state = /obj/machinery/door/firedoor::icon_state
	layer = /obj/machinery/door/firedoor::layer

/obj/structure/fluff/standalone_wooden_post
	name = "wooden post"
	desc = "A sturdy space-wood post; upright, on it's lonesome. Ominous."
	icon = 'modular_nova/modules/mapping/icons/obj/fluff.dmi'
	icon_state = "wooden_post"
	can_buckle = TRUE
