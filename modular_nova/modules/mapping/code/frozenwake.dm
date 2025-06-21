/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/frozenwake/
	name = "ancient parchment"
	desc = "A note written in Ættmál."
	default_raw_text = "<i>They say the gods do not fall. But I saw it. I heard the silence after Baldr's light dimmed. The wind stopped singing. The fires would not answer. Even the stones wept — I swear it.<br><br>We carved these walls with aching hands, told his story in ice and stone, hoping the echo would reach the stars. Some say he will return, when the kinfire flares bright once more. I have waited a long time. My breath grows thin. My dreams colder.<br><br>If you’ve found this, you stand where hope froze. Perhaps you carry warmth yet. Perhaps you remember.</i><br><br>-Eldvarn Ice-Binder of the Lost Hall"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/frozenwake/ui_status(mob/user, datum/ui_state/state)
	if(!user.has_language(/datum/language/primitive_catgirl))
		to_chat(user, span_warning("This seems to be in a language you do not understand!"))
		return UI_CLOSE
	. = ..()

/obj/structure/statue/hearthkin/frozenwake
	name = "statue of Baldr, the Fallen Light"
	desc = "A solemn sculpture of Baldr rises from a bed of wind-swept snow, his form draped in robes of carved frost. His face is peaceful — too peaceful. Cracks run through the stone base, as if the grief of the world split it over time. His arms are open, not in triumph, but in farewell. Around the base, ancient runes flicker dimly, half-buried in ice."
	icon = 'modular_nova/modules/primitive_catgirls/icons/gods_statue.dmi'
	icon_state = "odin_statue"
	anchored = 1
	impressiveness = 30
	///variable added to let people understanding Ættmál (icecat, people having read the babel book that can spawn in the ruins.) read the runes.
	var/added_desc = "Your understanding of Ættmál lets you read the runes. 'The light most pure was first to fade. We sang no songs loud enough to hold him here.'"
	///variables used for the puzzle controller.
	var/puzzle_id = ""
	resistance_flags = INDESTRUCTIBLE

/obj/structure/statue/hearthkin/frozenwake/stele
	name = "\improper frozenwake stele"
	desc = "A flat stone slab, worn smooth by time and scarred with ancient pitting. Hearthkin runes engraved deep into its surface, their edges aglow with faint emberlight when read, still radiating a quiet warmth. Soot-smudged fingerprints trail across the face — the marks of hands long vanished, as if the tale it tells was once traced in reverence, again and again."
	icon = 'modular_nova/modules/primitive_catgirls/icons/gods_statue.dmi' // needs its own sprite
	icon_state = "runestone"
	impressiveness = 30
	resistance_flags = INDESTRUCTIBLE

/obj/structure/statue/hearthkin/frozenwake/stele/dream
	name = "stele of the dream"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'In a season of shadowless sky, Baldr dreamt of his own demise. Kin gathered with worried breath, yet none could still the frost in his heart'."

/obj/structure/statue/hearthkin/frozenwake/stele/oath
	name = "stele of the oath of kin"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'All things that crawled or stood or flew were made to swear no harm. Stone, flame, beast, and breath — all but one'."

/obj/structure/statue/hearthkin/frozenwake/stele/weeping_spear
	name = "stele of the weeping spear"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'By a jest most cruel, the blind one threw — a lance of wood that wept no oath. It struck, and Baldr fell with no sound'."

/obj/structure/statue/hearthkin/frozenwake/stele/mourning
	name = "stele of  the mourning"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'The cavern shook. Ice wept. Kin wailed songs the winds remember. His brother, hooded in grief, struck silence into the halls of the betrayer'."

/obj/structure/statue/hearthkin/frozenwake/stele/watch
	name = "stele of  The Watch"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'Baldr was bound in a ring of runes. The cold held him, but the hearth remembered. One day, a voice may call him home'."

/obj/structure/statue/hearthkin/frozenwake/puzzle/dreamer
	name = "statue of the dreamer"
	desc = "A noble Hearthkin with closed eyes, arms folded over his chest. A faint wisp curls from his brow like steam. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'He dreamed of a silence that could not be lifted.'"
	puzzle_id = "dreamer"

/obj/structure/statue/hearthkin/frozenwake/puzzle/circle
	name = "statue of the circle of kin"
	desc = "Multiple figures linked in a ring, palm to palm, beneath a looming sky. Hearthkin runes are engraved on the base"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'They bound the world in oaths for his safety.'"
	puzzle_id = "circle"

/obj/structure/statue/hearthkin/frozenwake/puzzle/betrayer
	name = "statue of the betrayer"
	desc = "A blindfolded figure stands with arm outstretched, a wooden spear in hand. Their face is twisted in sorrow. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'One cast what he did not see.'"
	puzzle_id = "betrayer"

/obj/structure/statue/hearthkin/frozenwake/puzzle/fall
	name = "statue of the fall of light"
	desc = "A noble Hearthkin lies fallen, rays carved behind him like shattered halos. Runes spiral outward from his body. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'The silence that followed was deeper than death.'"
	puzzle_id = "fall"

/obj/structure/statue/hearthkin/frozenwake/puzzle/avenger
	name = "statue of the avenger"
	desc = "A Hearthkin shrouded in a heavy hood, gripping an axe streaked with frost. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'Grief made his hand swift.'"
	puzzle_id = "avenger"

/obj/structure/statue/hearthkin/frozenwake/puzzle/watcher
	name = "statue of the tomb watcher"
	desc = "A guardian carved with closed eyes, standing beside the frozen sword, a hand raised to the ceiling. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'He watches still.'"
	puzzle_id = "watcher"

/obj/structure/statue/hearthkin/frozenwake/examine(mob/user)
	. = ..()
	if(user.has_language(/datum/language/primitive_catgirl))
		. += "<br>" + span_info(added_desc)

/obj/structure/ice_stasis/frozenwake
	name = "ice pillar"
	desc = "Encased within a towering pillar of ancient ice stands a Hearthkin statue, solemn and proud. In its outstretched arms rests a greatsword, its blade wide and etched with runes that pulse faintly beneath the frost, like the heartbeat of a long-silenced memory. The hilt, wrapped in cracked leather, is held tight in stone hands weathered by time. Though imprisoned in stillness, both sword and statue seem to wait — not for freedom, but for remembrance."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "frozen"
	density = TRUE
	max_integrity = 100
	armor_type = /datum/armor/structure_ice_stasis
	resistance_flags = INDESTRUCTIBLE
	anchored = TRUE

///Proc used to check if get_area returns the frozenwake puzzle area.
/proc/get_frozenwake_puzzle_area(atom/location)
	var/area/area_check = get_area(location)
	if (istype(area_check, /area/ruin/unpowered/frozenwake))
		return area_check
	return null

/obj/structure/ice_stasis/frozenwake/Initialize(mapload)
	. = ..()
	var/area/ruin/unpowered/frozenwake/puzzle_area = get_frozenwake_puzzle_area(src)
	if (puzzle_area)
		puzzle_area.frozenwake_stasis_target = src

//Used to check the progression of the puzzle.
/datum/frozenwake_puzzle
	/// what the expected order to solve the puzzle
	var/list/expected_order = list("dreamer", "circle", "betrayer", "fall")
	/// what has currently been selected to compare to the expected_order
	var/list/current_sequence = list()

///Compares the puzzle expected_order to current_sequence
/datum/frozenwake_puzzle/proc/lists_match(list/first_list, list/second_list)
	if(length(first_list) != length(second_list))
		return FALSE

	for(var/list_index = 1, list_index <= length(first_list), list_index++)
		if(first_list[list_index ] != second_list[list_index ])
			return FALSE

	return TRUE

///adds the last clicked statue to the current_sequence. Keeps only the last 4 stored.
/datum/frozenwake_puzzle/proc/register_click(statue_id, puzzle_area)
	if (!istype(puzzle_area, /area/ruin/unpowered/frozenwake))
		return
	var/area/ruin/unpowered/frozenwake/frozenwake_area = puzzle_area

	current_sequence += statue_id

	if(length(current_sequence) > length(expected_order))
		current_sequence.Cut(1, 2) // Keep last inputs

	if(lists_match(current_sequence, expected_order))
		trigger_success(frozenwake_area)



/obj/item/kinetic_crusher/runic_greatsword/vidrhefjandi
	name = "viðrhefjandi"
	desc = "This greatsword pulses faintly with emberlight. Its edge is inscribed in Hearthkin runes — a blade meant not for war, but remembrance. It feels warm in your grasp, like a forgotten promise."

///Breaks the ice and drops the sword if puzzle completed.
/datum/frozenwake_puzzle/proc/trigger_success(success_area)
	if (!istype(success_area, /area/ruin/unpowered/frozenwake))
		return

	var/area/ruin/unpowered/frozenwake/frozenwake_area = success_area

	if (frozenwake_area.frozenwake_stasis_target)
		var/turf/reward_loc = get_turf(frozenwake_area.frozenwake_stasis_target)
		for (var/mob/emoted in view(7, reward_loc))
			to_chat(emoted, span_notice("The ice cracks with a deep groan... and shatters!"))
		qdel(frozenwake_area.frozenwake_stasis_target)
		new /obj/item/kinetic_crusher/runic_greatsword/vidrhefjandi(reward_loc)

//what happen when you touch a statue.
/obj/structure/statue/hearthkin/frozenwake/puzzle/attack_hand(mob/user)
	var/area/ruin/unpowered/frozenwake/puzzle_area = get_frozenwake_puzzle_area(src)
	if (puzzle_area)
		puzzle_area.frozenwake_puzzle_controller.register_click(puzzle_id, puzzle_area)
		to_chat(user, "You touch the statue. The stone hums softly.")
	else
		to_chat(user, "DEBUG: Statue outside of puzzle area.")


//Initializing the glow for the steles.
/obj/structure/statue/hearthkin/frozenwake/stele/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

//Adding the glowing runes overlay to the steles.
/obj/structure/statue/hearthkin/frozenwake/stele/update_overlays()
	. = ..()
	. += add_runic_glow()

///selecting the correct file for the glow.
/obj/structure/statue/hearthkin/frozenwake/stele/proc/add_runic_glow()
	return emissive_appearance(
		'modular_nova/modules/primitive_catgirls/icons/gods_statue.dmi',
		"[icon_state]-emissive",
		src,
		alpha = src.alpha
	)

/mob/living/basic/ghost/swarm/frozenwake
	name = "runebound echo"
	desc = "A pale figure drifts silently through the frostbound halls. Faint, furred ears and a trailing tail mark it as once Hearthkin, though its steps follow a path long forgotten."
	/// list of sayings that the echo can choose from
	var/emotional_damage = list(
		"The oath... it was broken...",
		"He was light. We let it die.",
		"Stone remembers what kin forget.",
		"I sang until my throat froze. No one heard.",
		"The spear wept. The hand did not.",
		"Even the fire turned its face away...",
		"Wake him... let the silence end.",
		"We were bound. We were blind.",
		"His name is carved in sorrow.",
		"I see him, still... waiting beneath the ice.",
		"I begged the wind to carry our grief.",
		"Who will avenge the fallen light?",
		"No oath spared him. No song saved him.",
		"He watched. He knew. He struck.",
		"I dream of warmth... but only snow answers.",
		"It was not supposed to end like this.",
		"Baldr... forgive us.",
		"We lit the fires. They would not burn.",
		"The betrayer weeps, but the wound remains.",
		"A voice... a voice in the dark... is it you?"
	)

/mob/living/basic/ghost/swarm/frozenwake/unproven
	name = "small runebound echo"
	desc = "This small, ghostly form flits between icy pillars, downy ears twitching and a thin tail curling behind it. It hums a tuneless melody, unaware of your presence."
	emotional_damage = list(
		"Where did the sun go?",
		"He said he'd come back... he promised.",
		"It's cold. I'm still waiting.",
		"I made a song for him... but I forgot the end.",
		"Mama said the light would keep us safe...",
		"I held the rune tight... but it didn’t work.",
		"They told me not to look. I looked anyway.",
		"We played in the snow before the silence.",
		"I can't find my brothers. Have you seen them?",
		"I want to go home... but I don’t remember where it is.",
	)

//Initialize the ghosts speaking loop.
/mob/living/basic/ghost/swarm/frozenwake/Initialize(mapload)
	. = ..()
	start_quote_loop()

///Ghost speaking loop, hopefully not too spammy.
/mob/living/basic/ghost/swarm/frozenwake/proc/start_quote_loop()
	// Delay the first line randomly to desync mobs
	addtimer(CALLBACK(src, .proc/speak_emotion), rand(100, 300)) // 10-30 seconds

/// at a chance, allows the echo to say something from emotional_damage
/mob/living/basic/ghost/swarm/frozenwake/proc/speak_emotion()
	if(prob(40)) // 40% chance to speak when timer triggers
		var/message = pick(emotional_damage)
		say(message, language = /datum/language/primitive_catgirl)

	// Re-add the timer with a random interval to keep them from being predictable
	addtimer(CALLBACK(src, .proc/speak_emotion), rand(200, 600)) // 20-60 seconds

//Make sure the ref to the ice pillar is removed if the item is deleted.
/obj/structure/ice_stasis/frozenwake/Destroy()
	var/area/ruin/unpowered/frozenwake/puzzle_area = get_frozenwake_puzzle_area(src)
	if (puzzle_area)
		if (puzzle_area.frozenwake_stasis_target == src)
			puzzle_area.frozenwake_stasis_target = null
	return ..()
