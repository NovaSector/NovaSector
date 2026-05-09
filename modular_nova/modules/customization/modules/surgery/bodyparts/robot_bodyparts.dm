/obj/item/bodypart/arm/left/robot/weak
	brute_modifier = 1
	burn_modifier = 1

/obj/item/bodypart/arm/right/robot/weak
	brute_modifier = 1
	burn_modifier = 1

/obj/item/bodypart/leg/left/robot/weak
	brute_modifier = 1
	burn_modifier = 1
	digitigrade_type = /obj/item/bodypart/leg/left/robot/weak/digi

/obj/item/bodypart/leg/left/robot/weak/digi
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/right/robot/weak
	brute_modifier = 1
	burn_modifier = 1
	digitigrade_type = /obj/item/bodypart/leg/right/robot/weak/digi

/obj/item/bodypart/leg/right/robot/weak/digi
	icon_static = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	icon = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/head/robot/weak
	brute_modifier = 1
	burn_modifier = 1

/obj/item/bodypart/chest/robot/weak
	brute_modifier = 1
	burn_modifier = 1

/obj/item/bodypart/head/robot
	head_flags = (HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_EYESPRITES)

// Assorted duplicates created to support greyscaling robotic limbs in the Augments+ tab

/obj/item/bodypart/arm/left/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'

/obj/item/bodypart/arm/right/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'

/obj/item/bodypart/leg/left/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'
	digitigrade_type = /obj/item/bodypart/leg/left/robot/weak/digi/greyscale

/obj/item/bodypart/leg/left/robot/weak/digi/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	digitigrade_type = /obj/item/bodypart/leg/right/robot/weak/digi/greyscale

/obj/item/bodypart/leg/right/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'
	digitigrade_type = /obj/item/bodypart/leg/right/robot/weak/digi/greyscale

/obj/item/bodypart/leg/right/robot/weak/digi/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_nova/modules/digitigrade_cybernetics/icons/digitigrade_parts.dmi'
	digitigrade_type = /obj/item/bodypart/leg/right/robot/weak/digi/greyscale

/obj/item/bodypart/head/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'

/obj/item/bodypart/chest/robot/weak/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/augments.dmi'

/obj/item/bodypart/arm/left/robot/surplus/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/surplus_augments.dmi'

/obj/item/bodypart/arm/right/robot/surplus/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/surplus_augments.dmi'

/obj/item/bodypart/leg/left/robot/surplus/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/surplus_augments.dmi'
	digitigrade_type = /obj/item/bodypart/leg/left/robot/surplus/digi/greyscale

/obj/item/bodypart/leg/right/robot/surplus/greyscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'icons/mob/augmentation/surplus_augments.dmi'
	digitigrade_type = /obj/item/bodypart/leg/right/robot/surplus/digi/greyscale
