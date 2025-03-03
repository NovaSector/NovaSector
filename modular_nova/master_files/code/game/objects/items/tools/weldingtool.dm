/obj/item/weldingtool
	/// How long it takes to weld your own robotic limbs.
	var/self_delay = 5 SECONDS
	/// How long it takes to weld someone else's robotic limbs.
	var/other_delay = 1 SECONDS

/obj/item/weldingtool/Initialize(mapload)
	. = ..()
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagents_change))

/obj/item/weldingtool/set_welding(new_value)
	. = ..()
	on_reagents_change()

/obj/item/weldingtool/proc/on_reagents_change(datum/reagents/source)
	SIGNAL_HANDLER

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
