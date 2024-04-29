/datum/job/space_sapper
	title = ROLE_SPACE_SAPPER
	policy_index = ROLE_SPACE_SAPPER

/obj/effect/mob_spawn/ghost_role/human/sapper
	name = "sapper gang sleeper"
	desc = "A cryo sleeper smelling faintly of rum."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "a space sapper"
	outfit = /datum/outfit/sapper
	faction = list(FACTION_SAPPER)
	anchored = TRUE
	density = FALSE
	show_flavor = FALSE //Flavour only exists for spawners menu
	you_are_text = "You are a space sapper."
	flavour_text = "You're an illegal credits miner, build to defend your mining machines and your ship to harvest as many credits as you can!"
	spawner_job_path = /datum/job/space_sapper
	random_appearance = FALSE

	///Path of the structure we spawn after creating a sapper.
	var/fluff_spawn = /obj/structure/showcase/machinery/oldpod/used

/obj/effect/mob_spawn/ghost_role/human/sapper/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	SSquirks.AssignQuirks(spawned_mob, spawned_mob.client, TRUE, TRUE, null, FALSE, spawned_mob)
	spawned_mob.mind.add_antag_datum(/datum/antagonist/sapper)

/obj/effect/mob_spawn/ghost_role/human/sapper/create(mob/mob_possessor, newname)
	if(fluff_spawn)
		new fluff_spawn(drop_location())
	return ..()
