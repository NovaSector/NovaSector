/obj/item/gun/energy/ionrifle // Original had no delay

/obj/item/gun/energy/ionrifle/Initialize(mapload)
	. = ..()
	fire_delay = 1.5 SECONDS
