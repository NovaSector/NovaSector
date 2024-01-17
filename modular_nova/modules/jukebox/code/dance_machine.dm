/obj/machinery/jukebox/update_icon_state()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	luminosity = 0

	if(active)
		luminosity = 1
		SSvis_overlays.add_vis_overlay(src, icon, "active", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "active", 0, EMISSIVE_PLANE, dir, alpha)

/obj/machinery/jukebox/proc/activate_music()
	var/jukeboxslottotake = SSjukeboxes.addjukebox(src, selection, 2)
	if(jukeboxslottotake)
		active = TRUE
		update_use_power(ACTIVE_POWER_USE)
		update_appearance(UPDATE_ICON_STATE)
		START_PROCESSING(SSobj, src)
		stop = world.time + selection.song_length

/obj/machinery/jukebox/proc/dance_over()
	var/position = SSjukeboxes.findjukeboxindex(src)
	if(!position)
		return
	SSjukeboxes.removejukebox(position)
	STOP_PROCESSING(SSobj, src)
	rangers.Cut()

/obj/machinery/jukebox/process()
	if(active && world.time >= stop)
		active = FALSE
		update_use_power(IDLE_POWER_USE)
		STOP_PROCESSING(SSobj, src)
		dance_over()
		playsound(src,'sound/machines/terminal_off.ogg',50,TRUE)
		update_appearance(UPDATE_ICON_STATE)
		stop = world.time + 100
