/datum/action/vehicle/sealed/mecha/warden_smoke
	name = "Smoke"
	button_icon_state = "mech_smoke"

/datum/action/vehicle/sealed/mecha/warden_smoke/IsAvailable(feedback)
	. = ..()
	if (!.)
		return

	var/obj/vehicle/sealed/mecha/warden/smoker = chassis
	if(!TIMER_COOLDOWN_FINISHED(smoker, COOLDOWN_MECHA_SMOKE))
		if (feedback)
			owner.balloon_alert(owner, "smoke charges on cooldown!")
		return FALSE

	if (!smoker.smoke_charges)
		if (feedback)
			owner.balloon_alert(owner, "out of smoke charges!")
		return FALSE

/datum/action/vehicle/sealed/mecha/warden_smoke/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(!chassis || !(owner in chassis.occupants))
		return
	var/obj/vehicle/sealed/mecha/warden/smoker = chassis
	if(TIMER_COOLDOWN_FINISHED(smoker, COOLDOWN_MECHA_SMOKE) && smoker.smoke_charges)
		smoker.smoke_system.start()
		smoker.smoke_charges--
		TIMER_COOLDOWN_START(smoker, COOLDOWN_MECHA_SMOKE, smoker.smoke_cooldown)

/datum/action/vehicle/sealed/mecha/warden_zoom
	name = "Zoom"
	button_icon_state = "mech_zoom_off"

/datum/action/vehicle/sealed/mecha/warden_zoom/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(!owner.client || !chassis || !(owner in chassis.occupants))
		return
	var/obj/vehicle/sealed/mecha/warden/scoper = chassis
	scoper.zoom_mode = !scoper.zoom_mode
	button_icon_state = "mech_zoom_[scoper.zoom_mode ? "on" : "off"]"
	scoper.log_message("Toggled zoom mode.", LOG_MECHA)
	to_chat(owner, "[icon2html(scoper, owner)]<font color='[scoper.zoom_mode ? "blue" : "red"]'>Zoom mode [scoper.zoom_mode ? "en" : "dis"]abled.</font>")
	if(scoper.zoom_mode)
		owner.client.view_size.setTo(4.5)
		SEND_SOUND(owner, sound('sound/vehicles/mecha/imag_enh.ogg', volume=50))
	else
		owner.client.view_size.resetToDefault()
	build_all_button_icons()
