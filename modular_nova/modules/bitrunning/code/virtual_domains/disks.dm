/obj/item/bitrunning_disk/item/tier1/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/storage/belt/military/snack,
	)

/obj/item/bitrunning_disk/item/tier2/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/clothing/head/helmet,
	)

/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/clothing/neck/necklace/memento_mori,
	)

/obj/item/bitrunning_disk/ability/tier1/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/spell/touch/lay_on_hands,
	)

/obj/item/bitrunning_disk/ability/tier3/Initialize(mapload)
	. = ..()
	selectable_actions += list(
	/datum/action/cooldown/spell/timestop,
	)
