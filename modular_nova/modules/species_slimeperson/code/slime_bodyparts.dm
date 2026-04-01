#define SLIME_LIMB_BLOOD_LOSS 60

/obj/item/bodypart/head/jelly
	can_dismember = TRUE //Their organs are in their chest now, all slime subspecies, so they can safely be decapitated.

/obj/item/bodypart/head/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/head/jelly/slime/roundstart
	is_dimorphic = TRUE
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	teeth_count = 0
	burn_modifier = 0.8

/obj/item/bodypart/chest/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/chest/jelly/slime/roundstart
	is_dimorphic = TRUE
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	burn_modifier = 0.8

/obj/item/bodypart/arm/left/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/arm/left/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	burn_modifier = 0.8

/obj/item/bodypart/arm/right/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/arm/right/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	burn_modifier = 0.8

/obj/item/bodypart/leg/left/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/leg/left/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/jelly/slime/roundstart
	burn_modifier = 0.8

/obj/item/bodypart/leg/right/jelly/slime
	icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC

/obj/item/bodypart/leg/right/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/jelly/slime/roundstart
	burn_modifier = 0.8

/obj/item/bodypart/leg/left/digitigrade/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	base_limb_id = SPECIES_SLIMEPERSON
	biological_state = (BIO_FLESH|BIO_BLOODED)
	dmg_overlay_type = null
	burn_modifier = 0.8

/obj/item/bodypart/leg/right/digitigrade/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	base_limb_id = SPECIES_SLIMEPERSON
	biological_state = (BIO_FLESH|BIO_BLOODED)
	dmg_overlay_type = null
	burn_modifier = 0.8

///
// Slime Dismembering
///

/obj/item/bodypart/proc/slime_drop_limb()
		return

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.adjust_blood_volume(-SLIME_LIMB_BLOOD_LOSS)

/obj/item/bodypart/head/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/arm/left/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/arm/right/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/leg/left/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/leg/right/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/leg/left/digitigrade/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

/obj/item/bodypart/leg/right/digitigrade/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	slime_drop_limb(special)
	return ..()

#undef SLIME_LIMB_BLOOD_LOSS
