// Add the melee sweep component to all standard melee weapon types.
// The component self-disables for reach > 1 weapons (spears etc),
// zero-force items, and non-combat-mode interactions.

/obj/item/claymore/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/melee_sweep)

/obj/item/katana/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/melee_sweep)

/obj/item/chainsaw/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/melee_sweep)

/obj/item/dualsaber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/melee_sweep)

/obj/item/soulscythe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/melee_sweep)
