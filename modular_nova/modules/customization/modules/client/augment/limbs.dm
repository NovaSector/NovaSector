/datum/augment_item/limb
	category = AUGMENT_CATEGORY_LIMBS
	abstract_type = /datum/augment_item/limb
	allows_implants = TRUE
	///Should we draw these greyscale?
	var/uses_greyscale = FALSE

/datum/augment_item/limb/apply(mob/living/carbon/human/augmented, character_setup = FALSE, datum/preferences/prefs)
	var/digi_legs = prefs?.read_preference(/datum/preference/choiced/digitigrade_legs) == DIGITIGRADE_LEGS
	// Resolves the correct limb path accounting for digitigrade preference
	var/obj/item/bodypart/new_limb_path = path
	if(digi_legs && ispath(path, /obj/item/bodypart/leg) && !(new_limb_path::bodyshape & BODYSHAPE_DIGITIGRADE))
		var/obj/item/bodypart/leg/new_leg = path
		var/digi_type = new_leg::digitigrade_type
		if(digi_type)
			new_limb_path = digi_type

	// prefs menu dummies
	if(character_setup)
		var/body_zone = initial(new_limb_path.body_zone)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(body_zone, include_stumps = TRUE)
		if(isnull(old_limb))
			return body_zone

		// for the prefs menu, we're going to swap the icon and vars around to achieve our preview result, instead of allocating and deleting limbs. it's cheaper.
		old_limb.limb_id        = new_limb_path::limb_id
		old_limb.bodyshape      = new_limb_path::bodyshape
		old_limb.is_dimorphic   = new_limb_path::is_dimorphic
		old_limb.bodypart_flags = new_limb_path::bodypart_flags

		if(istype(old_limb, /obj/item/bodypart/head))
			var/obj/item/bodypart/head/old_head = old_limb
			var/obj/item/bodypart/head/new_head = new_limb_path
			old_head.eyes_icon = new_head::eyes_icon

		var/chosen_style_name = prefs?.augment_limb_styles[slot]
		if(!uses_robotic_styles || !chosen_style_name || !apply_style_to_limb(old_limb, GLOB.robotic_styles_list[chosen_style_name], slot, digi_legs, prefs))
			if(!uses_greyscale)
				old_limb.set_icon_static(new_limb_path::icon)
			else
				old_limb.set_icon_greyscale(UNLINT(new_limb_path::icon_greyscale))

		old_limb.should_draw_greyscale = uses_greyscale
		return body_zone
	// actual mob spawns and prefs transfer
	else
		var/obj/item/bodypart/new_limb = new new_limb_path(augmented)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(new_limb.body_zone, include_stumps = TRUE)

		var/chosen_style_name = prefs?.augment_limb_styles[slot]
		if(uses_robotic_styles && chosen_style_name)
			apply_style_to_limb(new_limb, GLOB.robotic_styles_list[chosen_style_name], slot, digi_legs, prefs)

		new_limb.replace_limb(augmented)
		qdel(old_limb)

/// Applies a robotic style to a bodypart, setting limb_id, bodyshape, dimorphic override, and icon
/datum/augment_item/limb/proc/apply_style_to_limb(obj/item/bodypart/limb, datum/robotic_style/chosen_style, slot, has_digi_legs, datum/preferences/prefs)
	var/style_valid = (chosen_style.supported_slots & slot_flag) && (!has_digi_legs || chosen_style.has_digi)
	if(!style_valid)
		prefs?.augment_limb_styles -= slot
		return FALSE
	limb.current_style = chosen_style.name
	var/dimorphic_override = LAZYACCESS(chosen_style.dimorphic_overrides, limb.body_zone)
	if(!isnull(dimorphic_override))
		limb.is_dimorphic = dimorphic_override
	if(chosen_style.limb_id_override)
		limb.limb_id = chosen_style.limb_id_override
	if(chosen_style.bodyshape_override)
		limb.bodyshape = chosen_style.bodyshape_override
	if(!uses_greyscale)
		limb.set_icon_static(chosen_style.icon)
	else
		limb.set_icon_greyscale(chosen_style.icon)
	return TRUE

//HEADS
/datum/augment_item/limb/head
	abstract_type = /datum/augment_item/limb/head
	slot = AUGMENT_SLOT_HEAD
	slot_flag = HEAD
	body_zone = BODY_ZONE_HEAD

/datum/augment_item/limb/head/cyborg
	name = "Cyborg head"
	path = /obj/item/bodypart/head/robot/weak
	uses_robotic_styles = TRUE

/datum/augment_item/limb/head/cyborg/greyscale
	uses_greyscale = TRUE
	name = "Cyborg head (Greyscale)"
	path = /obj/item/bodypart/head/robot/weak/greyscale

//CHESTS
/datum/augment_item/limb/chest
	abstract_type = /datum/augment_item/limb/chest
	slot = AUGMENT_SLOT_CHEST
	slot_flag = CHEST
	body_zone = BODY_ZONE_CHEST

/datum/augment_item/limb/chest/cyborg
	name = "Cyborg chest"
	path = /obj/item/bodypart/chest/robot/weak
	uses_robotic_styles = TRUE

/datum/augment_item/limb/chest/cyborg/greyscale
	uses_greyscale = TRUE
	name = "Cyborg chest (Greyscale)"
	path = /obj/item/bodypart/chest/robot/weak/greyscale

//LEFT ARMS
/datum/augment_item/limb/l_arm
	abstract_type = /datum/augment_item/limb/l_arm
	slot = AUGMENT_SLOT_L_ARM
	slot_flag = ARM_LEFT
	body_zone = BODY_ZONE_L_ARM

/datum/augment_item/limb/l_arm/prosthetic
	name = "Prosthetic left arm"
	path = /obj/item/bodypart/arm/left/robot/surplus
	cost = -1
	uses_robotic_styles = TRUE

/datum/augment_item/limb/l_arm/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "Prosthetic left arm (Greyscale)"
	path = /obj/item/bodypart/arm/left/robot/surplus/greyscale

/datum/augment_item/limb/l_arm/cyborg
	name = "Cyborg left arm"
	path = /obj/item/bodypart/arm/left/robot/weak
	uses_robotic_styles = TRUE

/datum/augment_item/limb/l_arm/cyborg/greyscale
	uses_greyscale = TRUE
	name = "Cyborg left arm (Greyscale)"
	path = /obj/item/bodypart/arm/left/robot/weak/greyscale

/datum/augment_item/limb/l_arm/plasmaman
	name = "Plasmaman left arm"
	path = /obj/item/bodypart/arm/left/plasmaman

/datum/augment_item/limb/l_arm/peg
	name = "Left peg arm"
	path = /obj/item/bodypart/arm/left/ghetto
	cost = -2

/datum/augment_item/limb/l_arm/stump
	name = "No Left Arm"
	path = /obj/item/bodypart/arm/left/stump
	cost = -3
	allows_implants = FALSE

// Abstract hand type - only exists for markings
/datum/augment_item/limb/l_hand
	abstract_type = /datum/augment_item/limb/l_hand
	slot = AUGMENT_SLOT_L_HAND
	slot_flag = HAND_LEFT
	body_zone = BODY_ZONE_PRECISE_L_HAND

//RIGHT ARMS
/datum/augment_item/limb/r_arm
	abstract_type = /datum/augment_item/limb/r_arm
	slot = AUGMENT_SLOT_R_ARM
	slot_flag = ARM_RIGHT
	body_zone = BODY_ZONE_R_ARM

/datum/augment_item/limb/r_arm/prosthetic
	name = "Prosthetic right arm"
	path = /obj/item/bodypart/arm/right/robot/surplus
	cost = -1
	uses_robotic_styles = TRUE

/datum/augment_item/limb/r_arm/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "Prosthetic right arm (Greyscale)"
	path = /obj/item/bodypart/arm/right/robot/surplus/greyscale

/datum/augment_item/limb/r_arm/cyborg
	name = "Cyborg right arm"
	path = /obj/item/bodypart/arm/right/robot/weak
	uses_robotic_styles = TRUE

/datum/augment_item/limb/r_arm/cyborg/greyscale
	uses_greyscale = TRUE
	name = "Cyborg right arm (Greyscale)"
	path = /obj/item/bodypart/arm/right/robot/weak/greyscale

/datum/augment_item/limb/r_arm/plasmaman
	name = "Plasmaman right arm"
	path = /obj/item/bodypart/arm/right/plasmaman

/datum/augment_item/limb/r_arm/peg
	name = "Right peg arm"
	path = /obj/item/bodypart/arm/right/ghetto
	cost = -2

/datum/augment_item/limb/r_arm/stump
	name = "No right arm"
	path = /obj/item/bodypart/arm/right/stump
	cost = -3
	allows_implants = FALSE

// Abstract hand type - only exists for markings
/datum/augment_item/limb/r_hand
	abstract_type = /datum/augment_item/limb/r_hand
	slot = AUGMENT_SLOT_R_HAND
	slot_flag = HAND_RIGHT
	body_zone = BODY_ZONE_PRECISE_R_HAND

//LEFT LEGS
/datum/augment_item/limb/l_leg
	abstract_type = /datum/augment_item/limb/l_leg
	slot = AUGMENT_SLOT_L_LEG
	slot_flag = LEG_LEFT
	body_zone = BODY_ZONE_L_LEG

/datum/augment_item/limb/l_leg/New()
	var/obj/item/bodypart/leg/left/leg_path = path
	if(leg_path::bodyshape & BODYSHAPE_DIGITIGRADE)
		supports_digitigrade = TRUE
	return ..()

/datum/augment_item/limb/l_leg/prosthetic
	name = "Prosthetic left leg"
	path = /obj/item/bodypart/leg/left/robot/surplus
	cost = -1
	uses_robotic_styles = TRUE
	supports_digitigrade = TRUE

/datum/augment_item/limb/l_leg/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "Prosthetic left leg (Greyscale)"
	path = /obj/item/bodypart/leg/left/robot/surplus/greyscale
	supports_digitigrade = TRUE

/datum/augment_item/limb/l_leg/cyborg
	name = "Cyborg left leg"
	path = /obj/item/bodypart/leg/left/robot/weak
	uses_robotic_styles = TRUE
	supports_digitigrade = TRUE

/datum/augment_item/limb/l_leg/cyborg/greyscale

	name = "Cyborg left leg (Greyscale)"
	path = /obj/item/bodypart/leg/left/robot/weak/greyscale
	uses_greyscale = TRUE
	supports_digitigrade = TRUE

/datum/augment_item/limb/l_leg/plasmaman
	name = "Plasmaman left leg"
	path = /obj/item/bodypart/leg/left/plasmaman

/datum/augment_item/limb/l_leg/peg
	name = "Left peg leg"
	path = /obj/item/bodypart/leg/left/ghetto
	cost = -2

/datum/augment_item/limb/l_leg/stump
	name = "No Left Leg"
	path = /obj/item/bodypart/leg/left/stump
	cost = -3
	supports_digitigrade = TRUE
	allows_implants = FALSE

//RIGHT LEGS
/datum/augment_item/limb/r_leg
	abstract_type = /datum/augment_item/limb/r_leg
	slot = AUGMENT_SLOT_R_LEG
	slot_flag = LEG_RIGHT
	body_zone = BODY_ZONE_R_LEG

/datum/augment_item/limb/r_leg/New()
	var/obj/item/bodypart/leg/right/leg_path = path
	if(leg_path::bodyshape & BODYSHAPE_DIGITIGRADE)
		supports_digitigrade = TRUE
	return ..()

/datum/augment_item/limb/r_leg/prosthetic
	name = "Prosthetic right leg"
	path = /obj/item/bodypart/leg/right/robot/surplus
	cost = -1
	uses_robotic_styles = TRUE
	supports_digitigrade = TRUE

/datum/augment_item/limb/r_leg/prosthetic/greyscale
	uses_greyscale = TRUE
	name = "Prosthetic right leg (Greyscale)"
	path = /obj/item/bodypart/leg/right/robot/surplus/greyscale
	supports_digitigrade = TRUE

/datum/augment_item/limb/r_leg/cyborg
	name = "Cyborg right leg"
	path = /obj/item/bodypart/leg/right/robot/weak
	uses_robotic_styles = TRUE
	supports_digitigrade = TRUE

/datum/augment_item/limb/r_leg/cyborg/greyscale
	uses_greyscale = TRUE
	name = "Cyborg right leg (Greyscale)"
	path = /obj/item/bodypart/leg/right/robot/weak/greyscale
	supports_digitigrade = TRUE

/datum/augment_item/limb/r_leg/plasmaman
	name = "Plasmaman right leg"
	path = /obj/item/bodypart/leg/right/plasmaman

/datum/augment_item/limb/r_leg/peg
	name = "Right peg leg"
	path = /obj/item/bodypart/leg/right/ghetto
	cost = -2

/datum/augment_item/limb/r_leg/stump
	name = "No Right Leg"
	path = /obj/item/bodypart/leg/right/stump
	cost = -3
	supports_digitigrade = TRUE
	allows_implants = FALSE
