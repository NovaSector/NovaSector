/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"

/datum/map_template/ruin/icemoon/nova/
	prefix = "_maps/RandomRuins/IceRuins/nova/"
/*----- Underground -----*/

/datum/map_template/ruin/icemoon/underground/nova/mining_site_below
	name = "Ice-ruin Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_mining_site.dmm"
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/interdyne_base
	name = "Ice-ruin Interdyne Pharmaceuticals Nova Sector Base 8817238"
	id = "ice-base"
	description = "A planetside Interdyne research facility developing biological weapons; it is closely guarded by an elite team of agents."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_interdyne_base1.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/nova/interdyne_base)
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/nova/magic_hotsprings
	name = "Magic Hotsprings"
	id = "magic-hotsprings"
	description = "A beautiful hot springs spot, surrounded by unnatural fairy grass and exotic trees."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_magical_hotsprings.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/abandoned_hearth
	name = "Abandoned Hearth"
	id = "abandoned-hearth"
	description = "Something went terribly wrong in this hearth, if the signs of struggle are anything to go by."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_abandoned_icewalker_den.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/duo_hermit
	name = "Ice-ruin Duo Hermit"
	id = "icemoon-duo-hermit"
	description = "A place of shelter for a duet of hermits, scraping by to live another day."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_duo_hermit.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/abandoned_sacred_temple
	name = "Sacred Temple"
	id = "abandoned-sacred-temple"
	description = "The dusty remains of a temple, sacred in nature."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_abandoned_sacred_temple.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/underground/nova/ice_boss_vent
	name = "Ice-Ruin Frozen Rite Location"
	id = "ice_r_boss_vent"
	description = "They believed sacrifices could give more rewards. They were not prepared for the felling of their hubris."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_boss_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1

/datum/map_template/ruin/icemoon/underground/nova/ice_elite_vent
	name = "Ice-Ruin Frozen Well Location"
	id = "ice_r_elite_vent"
	description = "Jimmy never fell in the well. But it wasn't Jimmy that walked away"
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_underground_elite_vent.dmm"
	allow_duplicates = FALSE
	cost = 0
	mineral_cost = 1

//Code for the Abandoned Sacred Temple
/obj/structure/statue/hearthkin/odin
	name = "statue of Óðinn"
	desc = "A gold statue, representing the All-Father Óðinn. It is strangely in good state."
	icon = 'modular_nova/modules/primitive_catgirls/icons/gods_statue.dmi'
	icon_state = "odin_statue"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/sacred_temple/
	name = "moon 34, of the year 2283"
	desc = "A note written in Ættmál. It seems to have been ripped from a diary of some sort."
	default_raw_text = "<i>I refuse to believe we're reduced to this- to sacrifice our own in hopes of our gods taking pity and rescuing us. We've lost too many already... I regret not joining with the rest. But I won't sit here and wait for my turn to be sacrificed, moping about like some sort of useless bastard. Me, my husband, and my sibling Halko will soon make our move, once the grand priest goes to sleep.</i>"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/sacred_temple/ui_status(mob/user, datum/ui_state/state)
    if(!user.has_language(/datum/language/primitive_catgirl))
        to_chat(user, span_warning("This seems to be in a language you do not understand!"))
        return UI_CLOSE

    . = ..()

//code for the Frozenwake ruin
var/global/datum/frozenwake_puzzle/FROZENWAKE_PUZZLE = new()
var/global/obj/structure/ice_stasis/frozenwake/stasis_target = null

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/frozenwake/
	name = "ancient parchment"
	desc = "A note written in Ættmál."
	default_raw_text = "<i>They say the gods do not fall. But I saw it. I heard the silence after Baldr's light dimmed. The wind stopped singing. The fires would not answer. Even the stones wept — I swear it.<br>We carved these walls with aching hands, told his story in ice and stone, hoping the echo would reach the stars. Some say he will return, when the kinfire flares bright once more. I have waited a long time. My breath grows thin. My dreams colder.<br>If you’ve found this, you stand where hope froze. Perhaps you carry warmth yet. Perhaps you remember.</i><br>-Eldvarn Ice-Binder of the Lost Hall"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/frozenwake/ui_status(mob/user, datum/ui_state/state)
	if(!user.has_language(/datum/language/primitive_catgirl))
		to_chat(user, span_warning("This seems to be in a language you do not understand!"))
		return UI_CLOSE
	. = ..()

/obj/structure/statue/hearthkin/frozenwake
	name = "baldr, the Fallen Light"
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
	icon_state = "odin_statue"
	impressiveness = 30
	resistance_flags = INDESTRUCTIBLE

/obj/structure/statue/hearthkin/frozenwake/stele/dream
	name = "\improper the dream"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'In a season of shadowless sky, Baldr dreamt of his own demise. Kin gathered with worried breath, yet none could still the frost in his heart'."

/obj/structure/statue/hearthkin/frozenwake/stele/oath
	name = "\improper the oath of kin"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'All things that crawled or stood or flew were made to swear no harm. Stone, flame, beast, and breath — all but one'."

/obj/structure/statue/hearthkin/frozenwake/stele/weeping_spear
	name = "\improper the weeping spear"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'By a jest most cruel, the blind one threw — a lance of wood that wept no oath. It struck, and Baldr fell with no sound'."

/obj/structure/statue/hearthkin/frozenwake/stele/mourning
	name = "\improper the mourning"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'The cavern shook. Ice wept. Kin wailed songs the winds remember. His brother, hooded in grief, struck silence into the halls of the betrayer'."

/obj/structure/statue/hearthkin/frozenwake/stele/watch
	name = "\improper The Watch"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'Baldr was bound in a ring of runes. The cold held him, but the hearth remembered. One day, a voice may call him home'."

/obj/structure/statue/hearthkin/frozenwake/puzzle/dreamer
	name = "the dreamer"
	desc = "A noble Hearthkin with closed eyes, arms folded over his chest. A faint wisp curls from his brow like steam. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'He dreamed of a silence that could not be lifted.'"
	puzzle_id = "dreamer"

/obj/structure/statue/hearthkin/frozenwake/puzzle/circle
	name = "the circle of kin"
	desc = "Multiple figures linked in a ring, palm to palm, beneath a looming sky. Hearthkin runes are engraved on the base"
	added_desc = "Your understanding of Ættmál lets you read the runes. 'They bound the world in oaths for his safety.'"
	puzzle_id = "circle"

/obj/structure/statue/hearthkin/frozenwake/puzzle/betrayer
	name = "the betrayer"
	desc = "A blindfolded figure stands with arm outstretched, a wooden spear in hand. Their face is twisted in sorrow. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'One cast what he did not see.'"
	puzzle_id = "betrayer"

/obj/structure/statue/hearthkin/frozenwake/puzzle/fall
	name = "the fall of light"
	desc = "A noble Hearthkin lies fallen, rays carved behind him like shattered halos. Runes spiral outward from his body. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'The silence that followed was deeper than death.'"
	puzzle_id = "fall"

/obj/structure/statue/hearthkin/frozenwake/puzzle/avenger
	name = "the avenger"
	desc = "A Hearthkin shrouded in a heavy hood, gripping an axe streaked with frost. Hearthkin runes are engraved on the base."
	added_desc = "Your understanding of Ættmál lets you read the runes. 'Grief made his hand swift.'"
	puzzle_id = "avenger"

/obj/structure/statue/hearthkin/frozenwake/puzzle/watcher
	name = "the tomb watcher"
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

/obj/structure/ice_stasis/frozenwake/Initialize()
	. = ..()
	stasis_target = src

/datum/frozenwake_puzzle
	var/list/expected_order = list("dreamer", "circle", "betrayer", "fall")
	var/list/current_sequence = list()

/datum/frozenwake_puzzle/proc/register_click(statue_id)
	current_sequence += statue_id

	if(length(current_sequence) > length(expected_order))
		current_sequence.Cut(1, 2) // Keep last N inputs

	if(current_sequence == expected_order)
		trigger_success()

/obj/item/kinetic_crusher/runic_greatsword/vidrhefjandi
	name = "viðrhefjandi"
	desc = "This greatsword pulses faintly with emberlight. Its edge is inscribed in Hearthkin runes — a blade meant not for war, but remembrance. It feels warm in your grasp, like a forgotten promise."

/datum/frozenwake_puzzle/proc/trigger_success()
	if(stasis_target)
		var/turf/reward_loc = get_turf(stasis_target)
		for(var/mob/emoted in view(7, reward_loc))
			to_chat(emoted, span_notice("The ice cracks with a deep groan... and shatters!"))
		qdel(stasis_target)
		new /obj/item/kinetic_crusher/runic_greatsword/vidrhefjandi(reward_loc)

/obj/structure/statue/hearthkin/frozenwake/puzzle/attack_hand(mob/user)
	FROZENWAKE_PUZZLE.register_click(puzzle_id)
	to_chat(user, "You touch the statue. The stone hums softly.")

/*----- Above Ground -----*/
////// Yes, I know the "Above Ground" Is very limited in space. This is a... ~17x17? ruin.
/datum/map_template/ruin/icemoon/nova/turret_bunker
	name = "Ice-ruin Surface Geological Research Bunker"
	id = "turret_bunker"
	description = "A ramshackle research bunker for geological survey on the icemoon. Its inhabitants, however, forgot to scrub their turret's AI after an electrical event."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_surface_turretbunker.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/icemoon/nova/snow_geosite
	name = "Ice-Ruin Surface Geological Site"
	id = "snow_geosite"
	description = "A mishap during geological site testing ended a poor man's life. Anyways, Roll a d10 to loot the body."
	prefix = "_maps/RandomRuins/IceRuins/nova/"
	suffix = "icemoon_surface_geosite.dmm"
	allow_duplicates = FALSE
