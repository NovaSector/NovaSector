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

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/proc/apply_pref_alias(mob/living/carbon/human/spawned_human)
	var/pref_alias = spawned_human.client?.prefs?.read_preference(/datum/preference/name/hacker_alias)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[pref_alias]")

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/proc/apply_random_alias(mob/living/carbon/human/spawned_human)
	var/random_alias = pick(GLOB.hacker_aliases)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[random_alias]")

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/special(mob/living/carbon/human/spawned_human)
	. = ..()
	var/datum/action/cooldown/spell/home_network/norton = new(spawned_human)
	norton.Grant(spawned_human)
	apply_random_alias(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/virtual_domain/syndie/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_pref_alias(spawned_human)

/datum/action/cooldown/spell/home_network
	name = "Home Network"
	desc = "Makes the caster immune to many forms of practical hacks, backing themselves to the home network."

	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "bci_shield"
	sound = 'sound/effects/magic/staff_animation.ogg'
	cooldown_time = 10 SECONDS
	spell_requirements = SPELL_REQUIRES_HUMAN

	invocation = "NOR TON"
	invocation_type = INVOCATION_SHOUT

/datum/action/cooldown/spell/home_network/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/home_network/cast(mob/living/cast_on)
	. = ..()
	cast_on.visible_message(
		span_warning("Numerous loading bars and nano-scale hexagonal energy shields briefly cover [cast_on]!"),
		span_notice("You protect yourself from foreign intrusion!"),
	)
	ADD_TRAIT(cast_on, TRAIT_ANTIMAGIC, REF(src))
	Remove(cast_on)
