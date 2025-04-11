// Sec overrides can be found on
// modular_nova\modules\sec_haul\code\security_clothing\sec_clothing_overrides.dm

/obj/item/clothing/under/rank/security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/warden/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'

/*
*	SECURITY OFFICER
*/

//Redsec uniform with black pants
/obj/item/clothing/under/rank/security/nova/officer/black
	icon_state = "security_black"
	alt_covers_chest = TRUE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ALT_COVERS_CHEST = TRUE,
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "security_black",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "security_black"
		),
		"White Variant" = list(
			RESKIN_ALT_COVERS_CHEST = TRUE,
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "security_white",
			RESKIN_WORN_ICON = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "security_white"
		),
	)

//Bluesec uniform
/obj/item/clothing/under/rank/security/nova/officer
	name = "security uniform"
	desc = "A tactical security uniform for officers complete with Nanotrasen belt buckle."
	icon_state = "security_blue_black"
	alt_covers_chest = TRUE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_blue_black",
			RESKIN_WORN_ICON_STATE = "security_blue_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_blue",
			RESKIN_WORN_ICON_STATE = "security_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_white",
			RESKIN_WORN_ICON_STATE = "security_white"
		),
	)

/obj/item/clothing/under/rank/security/nova/formal
	name = "security formal suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "formal"

/obj/item/clothing/under/rank/security/nova/formal/blue
	icon_state = "formal_blue"

/obj/item/clothing/under/rank/security/nova/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" security uniform with the legs replaced by a skirt."
	icon_state = "jumpskirt_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_blue",
			RESKIN_WORN_ICON_STATE = "jumpskirt_blue"
        ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "jumpskirt_black",
			RESKIN_WORN_ICON_STATE = "jumpskirt_black"
		),
	)

/obj/item/clothing/under/rank/security/nova/skirt/plain
	name = "security plain skirt"
	desc = "Plain-shirted uniform commonly worn by Nanotrasen officers, attached with a skirt."
	icon_state = "plain_skirt_blue"
	uses_advanced_reskins = TRUE
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

/obj/item/clothing/under/rank/security/nova/skirt/mini
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon_state = "miniskirt"
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

/obj/item/clothing/under/rank/security/nova/skirt/mini/blue
	icon_state = "miniskirt_blue"
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "miniskirt_blue",
			RESKIN_WORN_ICON_STATE = "miniskirt_blue"
	    ),
		"Black Variant" = list(
			RESKIN_ICON_STATE = "miniskirt_blue_black",
			RESKIN_WORN_ICON_STATE = "miniskirt_blue_black"
	    ),
	)

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
	icon_state = "secturtleneck"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/nova/turtleneck/blue
	icon_state = "secturtleneck_blue"

/*
*	WARDEN
*/

/obj/item/clothing/under/rank/security/warden/nova
	icon_state = "warden_black"

/obj/item/clothing/under/rank/security/warden/nova/blue
	icon_state = "warden_blue_black"

/obj/item/clothing/under/rank/security/warden/nova/suit
	name = "warden's suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "formal_warden"

/obj/item/clothing/under/rank/security/warden/nova/suit/blue
	icon_state = "formal_warden_blue"

/*
*	HEAD OF SECURITY
*/

/obj/item/clothing/under/rank/security/head_of_security/nova
	icon_state = "hos_black"

/obj/item/clothing/under/rank/security/head_of_security/nova/blue
	icon_state = "hos_blue_black"

/obj/item/clothing/under/rank/security/head_of_security/nova/formal
	name = "head of security's formal suit"
	desc = "A security suit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "formal_hos"

/obj/item/clothing/under/rank/security/head_of_security/nova/formal/blue
	icon_state = "formal_hos_blue"

/obj/item/clothing/under/rank/security/head_of_security/nova/imperial //Rank pins of the Grand General
	desc = "A tar black naval suit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"

/obj/item/clothing/under/rank/security/head_of_security/nova/parade
	name = "head of security's parade uniform"
	desc = "A male head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_male_blue"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/nova/parade/female
	name = "head of security's formal uniform"
	desc = "A female head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_fem_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/head_of_security/nova/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt_blue"
	inhand_icon_state = "bl_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/head_of_security/nova/alt/skirt
	name = "head of security's turtleneck skirt"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with a tactical skirt."
	icon_state = "hosalt_skirt_blue"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

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
