/obj/item/bodypart/head/lizard
	icon_greyscale = BODYPART_ICON_LIZARD
	head_flags = HEAD_DEFAULT_FEATURES

/obj/item/bodypart/chest/lizard
	icon_greyscale = BODYPART_ICON_LIZARD

/obj/item/bodypart/arm/left/lizard
	icon_greyscale = BODYPART_ICON_LIZARD

/obj/item/bodypart/arm/right/lizard
	icon_greyscale = BODYPART_ICON_LIZARD

/obj/item/bodypart/leg/left/lizard
	icon_greyscale = BODYPART_ICON_LIZARD
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/lizard

/obj/item/bodypart/leg/right/lizard
	icon_greyscale = BODYPART_ICON_LIZARD
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/lizard

/obj/item/bodypart/leg/left/digitigrade/lizard
	icon_greyscale = BODYPART_ICON_LIZARD
	limb_id = SPECIES_LIZARD

/obj/item/bodypart/leg/right/digitigrade/lizard
	icon_greyscale = BODYPART_ICON_LIZARD
	limb_id = SPECIES_LIZARD

// tg's always-digitigrade lizard legs (limbgrower designs, tg ashwalkers) rely on the digitigrade_limb component, which Nova disables.
// Make them Nova-style digitigrade legs directly instead.
/obj/item/bodypart/leg/left/lizard/digitigrade
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_CLAWS
	footstep_type = FOOTSTEP_MOB_CLAW

/obj/item/bodypart/leg/right/lizard/digitigrade
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	footprint_sprite = FOOTPRINT_SPRITE_CLAWS
	footstep_type = FOOTSTEP_MOB_CLAW
