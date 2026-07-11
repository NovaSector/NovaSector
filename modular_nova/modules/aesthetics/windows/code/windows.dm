/obj/structure/window/fulltile
	icon = 'modular_nova/modules/aesthetics/windows/icons/window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/fulltile/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/simple_rotation)

/obj/structure/window/reinforced/fulltile
	icon = 'modular_nova/modules/aesthetics/windows/icons/r_window.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/fulltile/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/simple_rotation)

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'modular_nova/modules/aesthetics/windows/icons/r_window_tinted.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/tinted/fulltile/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/simple_rotation)

/obj/structure/window/plasma/fulltile
	icon = 'modular_nova/modules/aesthetics/windows/icons/window_plasma.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/plasma/fulltile/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/simple_rotation)

/obj/structure/window/reinforced/plasma/fulltile
	icon = 'modular_nova/modules/aesthetics/windows/icons/r_window_plasma.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/obj/structure/window/reinforced/plasma/fulltile/Initialize(mapload, direct)
	. = ..()
	RemoveElement(/datum/element/simple_rotation)

/obj/structure/window/reinforced/fulltile/ice

//Pod objects indy edition

//Window
/obj/structure/window/reinforced/survival_pod/indestructible
	name = "strong pod window"
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/window/reinforced/survival_pod/indestructible/spawner, 0)
