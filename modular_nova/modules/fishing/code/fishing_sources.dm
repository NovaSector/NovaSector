// This makes the mob spawner be a limited item, so its not spawned by explosions, lighting and lobsters. Adds the item to the table to avoid problems with changes in the future.
/datum/fish_source/lavaland/New()
	fish_table[/obj/effect/mob_spawn/corpse/human/charredskeleton] = 1
	fish_counts[/obj/effect/mob_spawn/corpse/human/charredskeleton] = 1
	return ..()
