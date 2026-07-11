/obj/item/bodypart/leg/right/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR_GENERIC
	brute_modifier = 0.8
	burn_modifier = 0.8
	wound_resistance = 20
	digitigrade_type = null
	is_actually_just_invisible = TRUE

/obj/item/bodypart/leg/right/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list(FEATURE_TAUR)

// We will set this on insertion
/obj/item/bodypart/leg/right/taur/on_adding(mob/living/carbon/new_owner)
	. = ..()
	if(bodyshape == initial(bodyshape))
		bodyshape = /obj/item/bodypart/leg/right::bodyshape | new_owner.get_taur_mode()

/obj/item/bodypart/leg/left/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR_GENERIC
	brute_modifier = 0.8
	burn_modifier = 0.8
	wound_resistance = 20
	digitigrade_type = null
	is_actually_just_invisible = TRUE

/obj/item/bodypart/leg/left/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list(FEATURE_TAUR)

/obj/item/bodypart/leg/left/taur/on_adding(mob/living/carbon/new_owner)
	. = ..()
	if(bodyshape == initial(bodyshape))
		bodyshape = /obj/item/bodypart/leg/left::bodyshape | new_owner.get_taur_mode()

/obj/item/bodypart/leg/right/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR_GENERIC
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	brute_modifier = 0.8
	burn_modifier = 0.8
	wound_resistance = 20
	digitigrade_type = null
	is_actually_just_invisible = TRUE

/obj/item/bodypart/leg/right/synth/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list(FEATURE_TAUR)

/obj/item/bodypart/leg/right/synth/taur/on_adding(mob/living/carbon/new_owner)
	. = ..()
	if(bodyshape == initial(bodyshape))
		bodyshape = /obj/item/bodypart/leg/right/synth::bodyshape | new_owner.get_taur_mode()

/obj/item/bodypart/leg/left/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR_GENERIC
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	brute_modifier = 0.8
	burn_modifier = 0.8
	wound_resistance = 20
	digitigrade_type = null
	is_actually_just_invisible = TRUE

/obj/item/bodypart/leg/left/synth/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list(FEATURE_TAUR)

/obj/item/bodypart/leg/left/synth/taur/on_adding(mob/living/carbon/new_owner)
	. = ..()
	if(bodyshape == initial(bodyshape))
		bodyshape = /obj/item/bodypart/leg/left/synth::bodyshape | new_owner.get_taur_mode()
