#define SHADOW_BODYPARTS_ICON 'modular_nova/modules/shadow/icons/bodyparts.dmi'

/obj/item/bodypart/head/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON
	eyes_icon = SHADOW_BODYPARTS_ICON

	is_dimorphic = TRUE
	head_flags = (HEAD_HAIR|HEAD_LIPS|HEAD_EYESPRITES|HEAD_EYEHOLES|HEAD_DEBRAIN)

/obj/item/bodypart/chest/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

	is_dimorphic = TRUE

/obj/item/bodypart/arm/left/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

/obj/item/bodypart/arm/right/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

/obj/item/bodypart/leg/left/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/shadow

/obj/item/bodypart/leg/right/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/shadow

/obj/item/bodypart/leg/left/digitigrade/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

	should_draw_greyscale = /obj/item/bodypart/leg/left/shadow::should_draw_greyscale

/obj/item/bodypart/leg/right/digitigrade/shadow
	icon = SHADOW_BODYPARTS_ICON
	icon_static = SHADOW_BODYPARTS_ICON

	should_draw_greyscale = /obj/item/bodypart/leg/right/shadow::should_draw_greyscale

#undef SHADOW_BODYPARTS_ICON

//nightmare subspecies
/obj/item/bodypart/arm/left/shadow/nightmare
	bodypart_traits = /obj/item/bodypart/arm/left/shadow::bodypart_traits

/obj/item/bodypart/arm/right/shadow/nightmare
	bodypart_traits = /obj/item/bodypart/arm/right/shadow::bodypart_traits
