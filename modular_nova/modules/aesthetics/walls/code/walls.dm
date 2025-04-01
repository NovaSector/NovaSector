/turf/closed/wall
	icon = 'modular_nova/modules/aesthetics/walls/icons/wall.dmi'
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS

/turf/closed/wall/r_wall
	icon = 'modular_nova/modules/aesthetics/walls/icons/reinforced_wall.dmi'

/turf/closed/wall/rust
	icon = 'modular_nova/modules/aesthetics/walls/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"

/turf/closed/wall/r_wall/rust
	icon = 'modular_nova/modules/aesthetics/walls/icons/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	base_decon_state = "r_wall"

/turf/closed/wall/material
	icon = 'modular_nova/modules/aesthetics/walls/icons/material_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"

// Modular false wall overrides
/obj/structure/falsewall
	icon = 'modular_nova/modules/aesthetics/walls/icons/wall.dmi'
	fake_icon = 'modular_nova/modules/aesthetics/walls/icons/wall.dmi'

/obj/structure/falsewall/reinforced
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to separate rooms."
	icon = 'modular_nova/modules/aesthetics/walls/icons/reinforced_wall.dmi'
	fake_icon = 'modular_nova/modules/aesthetics/walls/icons/reinforced_wall.dmi'

/obj/structure/falsewall/material
	icon = 'modular_nova/modules/aesthetics/walls/icons/material_wall.dmi'
	icon_state = "wall-open"
	base_icon_state = "wall"
	fake_icon = 'modular_nova/modules/aesthetics/walls/icons/material_wall.dmi'

