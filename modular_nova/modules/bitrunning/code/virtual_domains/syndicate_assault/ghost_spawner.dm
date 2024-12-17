/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie
	name = "delayed secure connection"
	desc = "Constant 'handshake no response' errors are flickering across the static-covered figure."
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	prompt_name = "a cybersun counter-bitrunner avatar"
	you_are_text = "You are a virtual avatar of a Cybersun-aligned counter-bitrunner, or an aligned SNPC."
	flavour_text = "Servers are throwing intrusion errors - you are here to fix the problem. \
	Running from your own servers, you have the ability to revive your colleagues without the fear of being tossed out."
	important_text = "Stalling for long enough will also allow us to recoup the costs. Complete denial is still preferable."
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/proc/apply_syndiename(mob/living/carbon/human/spawned_human)
	var/bitrunning_alias = spawned_human.client?.prefs?.read_preference(/datum/preference/name/hacker_alias) || pick(GLOB.hacker_aliases)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[bitrunning_alias]")

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/special(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_syndiename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_syndiename(spawned_human)
