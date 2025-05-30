/datum/fish_source/lavaland/New() //This is an override to add skeleton keys, tendril chests and runite to both lavaland and icemoon, so that the loot for tribals and the dangerous zone for fishers is consistent.
	..()

	fish_table[/obj/item/skeleton_key] = 1
	fish_counts[/obj/item/skeleton_key] = 1
	fish_count_regen[/obj/item/skeleton_key] = 13 MINUTES
	fish_table[/obj/item/stack/sheet/mineral/runite] = 1
	fish_counts[/obj/item/stack/sheet/mineral/runite] = 2
	fish_count_regen[/obj/item/stack/sheet/mineral/runite] = 15 MINUTES

/datum/fish_source/lavaland/icemoon/New()
	..()

	fish_table[/obj/structure/closet/crate/necropolis/tendril] = 1
	fish_counts[/obj/structure/closet/crate/necropolis/tendril] = 1
	fish_count_regen[/obj/structure/closet/crate/necropolis/tendril] = 30 MINUTES
	fish_table[/obj/item/skeleton_key] = 1
	fish_counts[/obj/item/skeleton_key] = 1
	fish_count_regen[/obj/item/skeleton_key] = 15 MINUTES
