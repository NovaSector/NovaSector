// Roundstartslimes!

#define SLIME_LIMB_BLOOD_LOSS 60

/obj/item/bodypart/head/jelly
	can_dismember = TRUE //Their organs are in their chest now, all slime subspecies, so they can safely be decapitated.

/obj/item/bodypart/head/jelly/slime/roundstart
	is_dimorphic = TRUE
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	teeth_count = 0

/obj/item/bodypart/chest/jelly/slime/roundstart
	is_dimorphic = TRUE
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)

/obj/item/bodypart/arm/left/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)

/obj/item/bodypart/arm/right/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)

/obj/item/bodypart/leg/left/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/jelly/slime/roundstart

/obj/item/bodypart/leg/right/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	biological_state = (BIO_FLESH|BIO_BLOODED)
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/jelly/slime/roundstart

/obj/item/bodypart/leg/left/digitigrade/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	base_limb_id = SPECIES_SLIMEPERSON
	biological_state = (BIO_FLESH|BIO_BLOODED)
	dmg_overlay_type = null
	burn_modifier = 0.5 // = 1/2x generic burn damage

/obj/item/bodypart/leg/right/digitigrade/jelly/slime/roundstart
	icon_greyscale = BODYPART_ICON_ROUNDSTARTSLIME
	base_limb_id = SPECIES_SLIMEPERSON
	biological_state = (BIO_FLESH|BIO_BLOODED)
	dmg_overlay_type = null
	burn_modifier = 0.5 // = 1/2x generic burn damage

/obj/item/bodypart/head/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	qdel(src)
	return .

/obj/item/bodypart/arm/left/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)
	return .

/obj/item/bodypart/arm/right/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)
	return .

/obj/item/bodypart/leg/left/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)
	return .

/obj/item/bodypart/leg/right/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)
	return .

/obj/item/bodypart/leg/left/digitigrade/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)

/obj/item/bodypart/leg/right/digitigrade/jelly/drop_limb(special, dismembered, move_to_floor = FALSE)
	if(special)
		return ..()

	to_chat(owner, span_warning("Your [name] splatters with an unnerving squelch!"))
	playsound(owner, 'sound/effects/blob/blobattack.ogg', 60, TRUE)
	owner.blood_volume -= SLIME_LIMB_BLOOD_LOSS
	. = ..()
	drop_organs(src, TRUE)
	qdel(src)

#undef SLIME_LIMB_BLOOD_LOSS
