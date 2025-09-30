// This makes the mob spawner be a limited item, so its not spawned by explosions, lighting and lobsters.
/datum/fish_source/lavaland/New()
	fish_counts[/obj/effect/mob_spawn/corpse/human/charredskeleton] = 1
	return ..()
