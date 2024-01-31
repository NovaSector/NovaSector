/obj/machinery/jukebox/update_icon_state()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	luminosity = 0

	if(active)
		luminosity = 1
		SSvis_overlays.add_vis_overlay(src, icon, "active", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "active", 0, EMISSIVE_PLANE, dir, alpha)
