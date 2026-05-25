//makes digi-robo limbs
//for now, all digi limbs use the same sprites. This will be changed eventually.

/obj/item/bodypart/leg/right/robot
	digitigrade_type = /obj/item/bodypart/leg/right/robot/digi

/obj/item/bodypart/leg/right/robot/digi
	name = "cyborg digitigrade right leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/left/robot
	digitigrade_type = /obj/item/bodypart/leg/left/robot/digi

/obj/item/bodypart/leg/left/robot/digi
	name = "cyborg digitigrade left leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/right/robot/surplus/digi
	name = "prosthetic digitigrade right leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/left/robot/surplus/digi
	name = "prosthetic digitigrade left leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/right/robot/advanced
	digitigrade_type = /obj/item/bodypart/leg/right/robot/advanced/digi

/obj/item/bodypart/leg/right/robot/advanced/digi
	name = "advanced digitigrade right leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

/obj/item/bodypart/leg/left/robot/advanced
	digitigrade_type = /obj/item/bodypart/leg/left/robot/advanced/digi

/obj/item/bodypart/leg/left/robot/advanced/digi
	name = "advanced digitigrade right leg"
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	is_emissive = FALSE

// Greyscale variants

/obj/item/bodypart/leg/right/robot/surplus/digi/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'

/obj/item/bodypart/leg/left/robot/surplus/digi/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
