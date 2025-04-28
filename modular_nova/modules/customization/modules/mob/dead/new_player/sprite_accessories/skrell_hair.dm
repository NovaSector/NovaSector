/datum/sprite_accessory/skrell_hair
	icon = 'modular_nova/master_files/icons/mob/sprite_accessory/skrell_hair.dmi'
	generic = "Skrell Headtails"
	key = "skrell_hair"
	color_src = USE_ONE_COLOR
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/skrell_hair

/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/wearer)
	// Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE

	if((wearer.head?.flags_inv & HIDEHAIR) || (wearer.wear_mask?.flags_inv & HIDEHAIR))
		return TRUE

	return FALSE

/datum/sprite_accessory/skrell_hair/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/skrell_hair/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/skrell_hair/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/skrell_hair/very_short
	name = "Very short"
	icon_state = "veryshort"

/datum/sprite_accessory/skrell_hair/very_long
	name = "Very Long"
	icon_state = "verylong"

/datum/sprite_accessory/skrell_hair/hoop
	name = "Hoop"
	icon_state = "hoop"

/datum/sprite_accessory/skrell_hair/backwater
	name = "Backwater"
	icon_state = "backwater"

/datum/sprite_accessory/skrell_hair/reef
	name = "Reef"
	icon_state = "reef"

/datum/sprite_accessory/skrell_hair/tucked
	name = "Tucked"
	icon_state = "tucked"

/datum/sprite_accessory/skrell_hair/straight_tuux
	name = "Straight Tuux"
	icon_state = "straight_tuux"

/datum/sprite_accessory/skrell_hair/straight_tuux_long
	name = "Straight Tuux Long"
	icon_state = "straight_tuux_long"

/datum/sprite_accessory/skrell_hair/long_tuux
	name = "Long Tuux"
	icon_state = "long_tuux"

/datum/sprite_accessory/skrell_hair/short_tuux
	name = "Short Tuux"
	icon_state = "short_tuux"

/datum/sprite_accessory/skrell_hair/left_behind
	name = "Left Behind"
	icon_state = "left_behind"

/datum/sprite_accessory/skrell_hair/left_behind_long
	name = "Left Behind Long"
	icon_state = "left_behind_long"

/datum/sprite_accessory/skrell_hair/right_behind
	name = "Right Behind"
	icon_state = "right_behind"

/datum/sprite_accessory/skrell_hair/right_behind_long
	name = "Right Behind Long"
	icon_state = "right_behind_long"

/datum/sprite_accessory/skrell_hair/mid_bun
	name = "Mid Bun"
	icon_state = "mid_bun"

/datum/sprite_accessory/skrell_hair/long_mid_bun
	name = "Long Mid Bun"
	icon_state = "long_mid_bun"

/datum/sprite_accessory/skrell_hair/loose_braid
	name = "Loose Braid"
	icon_state = "loose_braid"

/datum/sprite_accessory/skrell_hair/verylong_dmg_r
	name = "Very Long Right Damaged"
	icon_state = "verylong_dmg_r"

/datum/sprite_accessory/skrell_hair/verylong_dmg_l
	name = "Very Long Left Damaged"
	icon_state = "verylong_dmg_l"
