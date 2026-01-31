// SHADEKIN //
#define BODYPART_ICON_SHADEKIN 'modular_nova/modules/shadekin/icons/human_parts_greyscale.dmi'

/obj/item/bodypart/head/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	is_dimorphic = TRUE
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_LIPS|HEAD_EYESPRITES|HEAD_EYECOLOR|HEAD_EYEHOLES|HEAD_DEBRAIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	eyes_icon = 'modular_nova/modules/shadekin/icons/shadekin_eyes.dmi'

/obj/item/bodypart/chest/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	is_dimorphic = TRUE
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/left/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/right/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/leg/left/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/shadekin

/obj/item/bodypart/leg/right/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/shadekin

/obj/item/bodypart/leg/left/digitigrade/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = BODYPART_ID_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_PAWS
	footstep_type = FOOTSTEP_MOB_CLAW
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/leg/right/digitigrade/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = BODYPART_ID_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_PAWS
	footstep_type = FOOTSTEP_MOB_CLAW
	brute_modifier = 1.2
	burn_modifier = 1.2

#undef BODYPART_ICON_SHADEKIN
