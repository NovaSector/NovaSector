/obj/structure/emergency_shield/timer
	icon_state = "shield-greyscale"
	color = "#ff0000b9"
	resistance_flags = INDESTRUCTIBLE

/obj/structure/emergency_shield/timer/Initialize(mapload)
	. = ..()
	QDEL_IN(src, 17 SECONDS)

/obj/machinery/porta_turret/dm
	installation = /obj/item/gun/energy/e_gun/turret/dm
	faction = list(FACTION_TURRET)

/obj/item/gun/energy/e_gun/turret/dm
	ammo_type = list(/obj/item/ammo_casing/energy/laser)
