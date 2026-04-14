/obj/machinery/computer/cargo
	/// Flag that controls which supplies packs this console is allowed to order from.
	var/console_flag = CARGO_CONSOLE_NT
	///Flag to indicate that this console can bypass the express console block.
	var/bypass_express_lock = FALSE

/obj/machinery/computer/cargo/Initialize(mapload)
	. = ..()
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(on_security_level_changed))

/// Refresh the UI when the station alert level changes, since some packs are gated behind alert levels.
/obj/machinery/computer/cargo/proc/on_security_level_changed(datum/source)
	SIGNAL_HANDLER
	SStgui.update_uis(src)

/obj/machinery/computer/cargo/ui_data(mob/user)
	. = ..()
	.["current_alert_level"] = SSsecurity_level.get_current_level_as_number()
	var/has_armory_access = FALSE
	if(isliving(user))
		var/mob/living/living_user = user
		var/obj/item/card/id/id_card = living_user.get_idcard(TRUE)
		if(id_card)
			var/list/access = id_card.GetAccess()
			has_armory_access = (ACCESS_ARMORY in access)
	.["has_armory_access"] = has_armory_access || (obj_flags & EMAGGED)
