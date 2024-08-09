/obj/effect/mob_spawn/ghost_role/human/sapper
	name = "space sapper sleeper"
	desc = "Try and say that three times in a row without stumbling over your own tongue."
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

/obj/effect/mob_spawn/ghost_role/human/sapper/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.mind.add_antag_datum(/datum/antagonist/sapper)
