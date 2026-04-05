/obj/structure/window/
	var/edge_overlay_file
	var/mutable_appearance/edge_overlay

/obj/structure/window/update_overlays()
	. = ..()

	if(!edge_overlay_file)
		return

	edge_overlay = mutable_appearance(edge_overlay_file, "[smoothing_junction]", layer + 0.05, appearance_flags = RESET_COLOR)
	. += edge_overlay

/obj/structure/window/fulltile
	icon = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	edge_overlay_file = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/window_edges.dmi'

/obj/structure/window/plasma/fulltile
	icon = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/plasma_window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	edge_overlay_file = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/window_edges.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/reinforced_window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	edge_overlay_file = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/reinforced_window_edges.dmi'

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/tinted_window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	edge_overlay_file = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/reinforced_window_edges.dmi'

/obj/structure/window/reinforced/plasma/fulltile
	icon = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/rplasma_window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	edge_overlay_file = 'modular_iris/paradise_ports/icons/obj/smooth_structures/windows/reinforced_window_edges.dmi'

