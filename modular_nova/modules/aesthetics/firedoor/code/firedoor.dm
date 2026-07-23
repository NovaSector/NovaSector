/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'modular_nova/modules/aesthetics/firedoor/icons/firedoor_glass.dmi'
	/// The sound that plays when the door opens
	var/door_open_sound = 'modular_nova/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	/// The sound that plays when the door closes
	var/door_close_sound = 'modular_nova/modules/aesthetics/firedoor/sound/firedoor_open.ogg'
	/// Suppresses the bottom light immediately instead of waiting for density to catch up otherwise you get an extra blink animation as the door begins to raise.
	var/reset_reopen_pending = FALSE

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return

	if(density && !reset_reopen_pending) // if the door is closed (and not about to open from a just-cleared alarm), add the bottom blinking overlay
		. += mutable_appearance(icon, "firelock_alarm_type_bottom")
		. += emissive_appearance(icon, "firelock_alarm_type_bottom", src, alpha = src.alpha)

/obj/machinery/door/firedoor/open()
	playsound(loc, door_open_sound, 100, TRUE)
	. = ..()
	reset_reopen_pending = FALSE

/obj/machinery/door/firedoor/close()
	playsound(loc, door_close_sound, 100, TRUE)
	return ..()

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'modular_nova/modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC
