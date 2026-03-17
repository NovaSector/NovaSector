// Shadekin bodyparts - custom body sprites with increased damage modifiers.

#define BODYPART_ICON_SHADEKIN 'modular_nova/modules/bodyparts/icons/shadekin_parts_greyscale.dmi'

/obj/item/bodypart/head/mutant/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	is_dimorphic = TRUE
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/chest/mutant/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	is_dimorphic = TRUE
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/left/mutant/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/arm/right/mutant/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2

/obj/item/bodypart/leg/left/mutant/shadekin
	icon_greyscale = BODYPART_ICON_SHADEKIN
	limb_id = SPECIES_SHADEKIN
	brute_modifier = 1.2
	burn_modifier = 1.2
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/shadekin

/obj/item/bodypart/leg/right/mutant/shadekin
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
