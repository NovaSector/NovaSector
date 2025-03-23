/obj/item/clothing/under/rank/security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

//DEBATE MOVING *ALL* SECURITY STUFF HERE? Even overrides, at least as a like, sub-file?

/*
*	SECURITY OFFICER
*/

/obj/item/clothing/under/rank/security/nova/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/nova/utility/blue
	icon_state = "util_sec_blue"

/obj/item/clothing/under/rank/security/nova/dress
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	icon_state = "security_skirt"
	uses_advanced_reskins = FALSE
	unique_reskin = null
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/security/nova/dress/blue
	icon_state = "security_skirt_blue"

/obj/item/clothing/under/rank/security/nova/trousers
	name = "security trousers"
	desc = "Some \"combat\" trousers. Probably should pair it with a vest for safety."
	icon_state = "workpants"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "workpants",
			RESKIN_WORN_ICON_STATE = "workpants"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "workpants_white",
			RESKIN_WORN_ICON_STATE = "workpants_white"
		),
	)

/obj/item/clothing/under/rank/security/nova/trousers/blue
	icon_state = "workpants_blue"
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "workpants_blue",
			RESKIN_WORN_ICON_STATE = "workpants_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "workpants_white",
			RESKIN_WORN_ICON_STATE = "workpants_white"
		),
	)

/obj/item/clothing/under/rank/security/nova/trousers/shorts
	name = "security shorts"
	desc = "Some \"combat\" shorts. Probably should pair it with a vest for safety."
	icon_state = "workshorts"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts",
			RESKIN_WORN_ICON_STATE = "workshorts"
		),
		"Red Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_short",
			RESKIN_WORN_ICON_STATE = "workshorts_short"
		),
		"White Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts_white",
			RESKIN_WORN_ICON_STATE = "workshorts_white"
		),
		"White Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_white_short",
			RESKIN_WORN_ICON_STATE = "workshorts_white_short"
		),
	)

/obj/item/clothing/under/rank/security/nova/trousers/shorts/blue
	icon_state = "workshorts_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts_blue",
			RESKIN_WORN_ICON_STATE = "workshorts_blue"
		),
		"Blue Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_blue_short",
			RESKIN_WORN_ICON_STATE = "workshorts_blue_short"
		),
		"White Variant, Short" = list(
			RESKIN_ICON_STATE = "workshorts_white",
			RESKIN_WORN_ICON_STATE = "workshorts_white"
		),
		"White Variant, Short Short" = list(
			RESKIN_ICON_STATE = "workshorts_white_short",
			RESKIN_WORN_ICON_STATE = "workshorts_white_short"
		),
	)

/obj/item/clothing/under/rank/security/nova/turtleneck
	name = "security turtleneck"
	desc = "Turtleneck sweater commonly worn by trained Officers, attached with pants."
	icon_state = "turtleneck" // switch to turtleneck on both mob and obj
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/nova/turtleneck/blue
	icon_state = "jumpsuit_blue"

/obj/item/clothing/under/rank/security/nova/plain_skirt
	name = "security plain skirt"
	desc = "Plain-shirted uniform commonly worn by NT officers, attached with a skirt."
	icon_state = "plain_skirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "plain_skirt",
			RESKIN_WORN_ICON_STATE = "plain_skirt"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "plain_skirt_black",
			RESKIN_WORN_ICON_STATE = "plain_skirt_black"
	    ),
	)

/obj/item/clothing/under/rank/security/nova/plain_skirt/blue
	icon_state = "plain_skirt_blue"
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "plain_skirt_blue",
			RESKIN_WORN_ICON_STATE = "plain_skirt_blue"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "plain_skirt_black",
			RESKIN_WORN_ICON_STATE = "plain_skirt_black"
	    ),
	)

/obj/item/clothing/under/rank/security/nova/miniskirt
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon_state = "miniskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Red Variant" = list(
			RESKIN_ICON_STATE = "miniskirt",
			RESKIN_WORN_ICON_STATE = "miniskirt"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "miniskirt_black",
			RESKIN_WORN_ICON_STATE = "miniskirt_black"
	    ),
	)

/obj/item/clothing/under/rank/security/nova/miniskirt/blue
	icon_state = "miniskirt_blue"
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "miniskirt_blue",
			RESKIN_WORN_ICON_STATE = "miniskirt_blue"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "miniskirt_black",
			RESKIN_WORN_ICON_STATE = "miniskirt_black"
	    ),
	)

/*
*	HEAD OF SECURITY
*/

/obj/item/clothing/under/rank/security/head_of_security/nova/imperial //Rank pins of the Grand General
	desc = "A tar black naval suit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"

/*
*	SYNDICATE
*/

/obj/item/clothing/under/rank/security/nova/utility/syndicate
	armor_type = /datum/armor/clothing_under/sec_syndicate
	has_sensor = NO_SENSORS

/datum/armor/clothing_under/sec_syndicate
	melee = 10
	fire = 50
	acid = 40
