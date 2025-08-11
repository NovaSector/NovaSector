//ship crew from the random ship event.

/obj/effect/mob_spawn/ghost_role/human/ship_crew
	name = "ship crew sleeper"
	desc = "A cryo sleeper for ship crew."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a ship crew member"
	outfit = /datum/outfit/ship_crew
	anchored = TRUE
	density = FALSE
	show_flavor = FALSE //Flavour only exists for spawners menu
	you_are_text = "You are a member of a ship crew."
	flavour_text = "You are part of a ship crew. Follow your captain's orders and complete your mission."
	spawner_job_path = /datum/job/ship_crew
	///Rank of the crew member on the ship, it's used in generating names!
	var/rank = "Crewman"
	///Path of the structure we spawn after creating a crew member.
	var/fluff_spawn = /obj/structure/showcase/machinery/oldpod/used

	//obviously, these name vars are only used if you don't override `generate_crew_name()`
	///json key to crew names, the first part ("Comet" in "Cometfish")
	var/name_beginnings = "generic_beginnings"
	///json key to crew names, the last part ("fish" in "Cometfish")
	var/name_endings = "generic_endings"

/obj/effect/mob_spawn/ghost_role/human/ship_crew/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.fully_replace_character_name(spawned_mob.real_name, generate_crew_name(spawned_mob.gender))
	spawned_mob.mind.add_antag_datum(/datum/antagonist/ship_crew)

/obj/effect/mob_spawn/ghost_role/human/ship_crew/proc/generate_crew_name(spawn_gender)
	var/beggings = strings(PIRATE_NAMES_FILE, name_beginnings)
	var/endings = strings(PIRATE_NAMES_FILE, name_endings)
	return "[rank ? rank + " " : ""][pick(beggings)][pick(endings)]"

/obj/effect/mob_spawn/ghost_role/human/ship_crew/create(mob/mob_possessor, newname)
	if(fluff_spawn)
		new fluff_spawn(drop_location())
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ship_crew/captain
	rank = "Captain"
	outfit = /datum/outfit/ship_crew/captain

/obj/effect/mob_spawn/ghost_role/human/ship_crew/engineer
	rank = "Engineer"
	outfit = /datum/outfit/ship_crew

/obj/effect/mob_spawn/ghost_role/human/ship_crew/gunner
	rank = "Gunner"

/obj/effect/mob_spawn/ghost_role/human/ship_crew/rogue_trader
	name = "rogue trader sleeper"
	desc = "A cryo sleeper smelling faintly of rum."
	prompt_name = "a rogue trader"
	outfit = /datum/outfit/ship_crew/rogue_trader
	you_are_text = "You are a rogue trader."
	flavour_text = "You are a rogue trader looking to make a profit. Trade with the station or take what you need by force."

/obj/effect/mob_spawn/ghost_role/human/ship_crew/rogue_trader/captain
	rank = "Trader Captain"
	outfit = /datum/outfit/ship_crew/rogue_trader

/obj/effect/mob_spawn/ghost_role/human/ship_crew/rogue_trader/crew
	rank = "Trader"
