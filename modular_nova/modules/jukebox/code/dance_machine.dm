/obj/machinery/jukebox/update_icon_state()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	luminosity = 0

	if(active)
		luminosity = 1
		SSvis_overlays.add_vis_overlay(src, icon, "active", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "active", 0, EMISSIVE_PLANE, dir, alpha)

// overridden because the music playing to mobs is handled by the subsystem
/obj/machinery/jukebox/process()
	if(active && world.time >= stop)
		active = FALSE
		update_use_power(IDLE_POWER_USE)
		STOP_PROCESSING(SSobj, src)
		dance_over()
		playsound(src,'sound/machines/terminal_off.ogg',50,TRUE)
		update_appearance(UPDATE_ICON_STATE)
		stop = world.time + 100
