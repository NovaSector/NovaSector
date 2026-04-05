#define BODYPART_ICON_POLYSMORPH 'modular_iris/yogs_ports/polysmorphs/icons/bodyparts/polysmorph_bodyparts.dmi'
#define POLYSMORPH_BURN_MODIFIER 1.35
#define POLYSMORPH_PUNCH_LOW 6 //very slightly stronger
#define POLYSMORPH_PUNCH_HIGH 11


//Polysmorph limbs

/obj/item/bodypart/head/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	head_flags = HEAD_LIPS|HEAD_DEBRAIN|HEAD_HAIR|HEAD_FACIAL_HAIR
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	teeth_count = 72
	burn_modifier = POLYSMORPH_BURN_MODIFIER

/obj/item/bodypart/chest/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER
	bodypart_traits = list(TRAIT_NO_UNDERWEAR) //Their legs dont fit

/obj/item/bodypart/chest/polysmorph/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_XENOMORPH) //this is very important

/obj/item/bodypart/arm/left/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER
	unarmed_damage_low = POLYSMORPH_PUNCH_LOW
	unarmed_damage_high = POLYSMORPH_PUNCH_HIGH
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW

/obj/item/bodypart/arm/right/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER
	unarmed_damage_low = POLYSMORPH_PUNCH_LOW
	unarmed_damage_high = POLYSMORPH_PUNCH_HIGH
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	grappled_attack_verb = "lacerate"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW

/obj/item/bodypart/leg/left/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/polysmorph
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER

/obj/item/bodypart/leg/right/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	limb_id = SPECIES_POLYSMORPH
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/polysmorph
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER

/obj/item/bodypart/leg/left/digitigrade/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER

/obj/item/bodypart/leg/right/digitigrade/polysmorph
	icon_greyscale = BODYPART_ICON_POLYSMORPH
	damage_overlay_color = COLOR_DARK_MODERATE_LIME_GREEN
	burn_modifier = POLYSMORPH_BURN_MODIFIER

#undef BODYPART_ICON_POLYSMORPH
#undef POLYSMORPH_BURN_MODIFIER
#undef POLYSMORPH_PUNCH_LOW
#undef POLYSMORPH_PUNCH_HIGH
