
/obj/item/clothing/under/suit
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/suits_digi.dmi'

/obj/item/clothing/under/suit/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/suits.dmi'

//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/nova. USE /obj/item/clothing/under/suit/nova FOR MODULAR SUITS

/*
*	RECOLORABLE
*/
/obj/item/clothing/under/suit/nova/recolorable
	name = "recolorable suit"
	desc = "A semi-formal suit, clean-cut with a matching vest and slacks."
	can_adjust = FALSE
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/recolorable"
	post_init_icon_state = "recolorable_suit"
	greyscale_config = /datum/greyscale_config/recolorable_suit
	greyscale_config_worn = /datum/greyscale_config/recolorable_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suit/worn/digi
	greyscale_colors = "#a99780#ffffff#6e2727#ffc500"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/suit/nova/recolorable/skirt
	name = "recolorable suitskirt"
	desc = "A semi-formal suitskirt, clean-cut with a matching vest and skirt."
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|GROIN|LEGS
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/recolorable/skirt"
	post_init_icon_state = "recolorable_suitskirt"
	greyscale_config = /datum/greyscale_config/recolorable_suitskirt
	greyscale_config_worn = /datum/greyscale_config/recolorable_suitskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/recolorable_suitskirt/worn/digi

/obj/item/clothing/under/suit/nova/recolorable/casual
	name = "office casual suit"
	desc = "A semi-formal suit, clean-cut with a matching vest and slacks."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/recolorable/casual"
	post_init_icon_state = "fancysuit_casual"
	greyscale_config = /datum/greyscale_config/fancysuit_casual
	greyscale_config_worn = /datum/greyscale_config/fancysuit_casual/worn
	greyscale_config_worn_digi = /datum/greyscale_config/fancysuit_casual/worn/digi
	greyscale_colors = "#37373e#ffffff"

/obj/item/clothing/under/suit/nova/recolorable/executive
	name = "executive casual suit"
	desc = "A formal suit, clean-cut with a matching vest, undershirt, tie and slacks."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/recolorable/executive"
	post_init_icon_state = "fancysuit_executive"
	greyscale_config = /datum/greyscale_config/fancysuit_executive
	greyscale_config_worn = /datum/greyscale_config/fancysuit_executive/worn
	greyscale_config_worn_digi = /datum/greyscale_config/fancysuit_executive/worn/digi
	greyscale_colors = "#37373e#37373e#ffffff#ac3232"

/obj/item/clothing/under/suit/nova/pencil
	name = "pencilskirt and shirt"
	desc = "A clean shirt with a tight-fitting pencilskirt."
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	greyscale_colors = "#37373e#ffffff"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/pencil"
	post_init_icon_state = "pencilskirt_shirt"
	greyscale_config = /datum/greyscale_config/pencilskirt_withshirt
	greyscale_config_worn = /datum/greyscale_config/pencilskirt_withshirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/pencilskirt_withshirt/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/suit/nova/pencil/noshirt
	name = "pencilskirt"
	desc = "A tight-fitting pencilskirt, perfect to augment an undershirt."
	greyscale_colors = "#37373e"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/noshirt"
	post_init_icon_state = "pencilskirt"
	greyscale_config = /datum/greyscale_config/pencilskirt
	greyscale_config_worn = /datum/greyscale_config/pencilskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/pencilskirt/worn/digi
	body_parts_covered = GROIN|LEGS

/obj/item/clothing/under/suit/nova/pencil/charcoal
	name = "charcoal pencilskirt"
	desc = "A clean white shirt with a tight-fitting charcoal pencilskirt."
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/charcoal"
	greyscale_colors = "#303030#ffffff"

/obj/item/clothing/under/suit/nova/pencil/navy
	name = "navy pencilskirt"
	desc = "A clean white shirt with a tight-fitting navy-blue pencilskirt."
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/navy"
	greyscale_colors = "#112334#ffffff"

/obj/item/clothing/under/suit/nova/pencil/burgundy
	name = "burgundy pencilskirt"
	desc = "A clean white shirt with a tight-fitting burgandy-red pencilskirt."
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/burgundy"
	greyscale_colors = "#3e1111#ffffff"

/obj/item/clothing/under/suit/nova/pencil/tan
	name = "tan pencilskirt"
	desc = "A clean white shirt with a tight-fitting tan pencilskirt."
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/tan"
	greyscale_colors = "#8b7458#ffffff"

/obj/item/clothing/under/suit/nova/pencil/green
	name = "green pencilskirt"
	desc = "A clean white shirt with a tight-fitting green pencilskirt."
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/green"
	greyscale_colors = "#113e20#ffffff"

/obj/item/clothing/under/suit/nova/pencil/black_really
	name = "executive pencilskirt"
	desc = "A sleek suit with a tight-fitting pencilskirt."
	greyscale_colors = "#37373e#37373e#ffffff#ac3232"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/black_really"
	post_init_icon_state = "pencilskirt_suit"
	greyscale_config = /datum/greyscale_config/pencilskirt_withsuit
	greyscale_config_worn = /datum/greyscale_config/pencilskirt_withsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/pencilskirt_withsuit/worn/digi

/obj/item/clothing/under/suit/nova/pencil/checkered
	name = "checkered pencilskirt and shirt"
	desc = "A clean shirt with a tight-fitting checkered pencilskirt."
	greyscale_colors = "#37373e#232323#ffffff"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/checkered"
	post_init_icon_state = "pencilskirt_checkers_shirt"
	greyscale_config = /datum/greyscale_config/pencilskirt_checkers_withshirt
	greyscale_config_worn = /datum/greyscale_config/pencilskirt_checkers_withshirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/pencilskirt_checkers_withshirt/worn/digi

/obj/item/clothing/under/suit/nova/pencil/checkered/noshirt
	name = "checkered pencilskirt"
	desc = "A tight-fitting checkered pencilskirt."
	greyscale_colors = "#37373e#232323"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/suit/nova/pencil/checkered/noshirt"
	post_init_icon_state = "pencilskirt_checkers"
	greyscale_config = /datum/greyscale_config/pencilskirt_checkers
	greyscale_config_worn = /datum/greyscale_config/pencilskirt_checkers/worn
	greyscale_config_worn_digi = /datum/greyscale_config/pencilskirt_checkers/worn/digi
	body_parts_covered = GROIN|LEGS

/*
*	STATIC SUITS (NO GAGS)
*/
/obj/item/clothing/under/suit/nova/scarface
	name = "cuban suit"
	desc = "A yayo coloured silk suit with a crimson shirt. You just know how to hide, how to lie. Me, I don't have that problem. Me, I always tell the truth. Even when I lie."
	icon_state = "scarface"

/obj/item/clothing/under/suit/nova/black_really_collared
	name = "wide-collared executive suit"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_collar"

/obj/item/clothing/under/suit/nova/black_really_collared/skirt
	name = "wide-collared executive suitskirt"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_skirt_collar"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/datum/atom_skin/inferno_suit
	abstract_type = /datum/atom_skin/inferno_suit

/datum/atom_skin/inferno_suit/lucifer
	preview_name = "Pride"
	new_icon_state = "lucifer"

/datum/atom_skin/inferno_suit/justice
	preview_name = "Wrath"
	new_icon_state = "justice"

/datum/atom_skin/inferno_suit/malina
	preview_name = "Gluttony"
	new_icon_state = "malina"

/datum/atom_skin/inferno_suit/zdara
	preview_name = "Envy"
	new_icon_state = "zdara"

/datum/atom_skin/inferno_suit/cereberus
	preview_name = "Vanity"
	new_icon_state = "cereberus"

/datum/atom_skin/inferno_suit/beeze
	preview_name = "Designer"
	new_icon_state = "beeze"

/obj/item/clothing/under/suit/nova/inferno
	name = "inferno suit"
	desc = "Stylish enough to impress the devil."
	icon_state = "lucifer"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	obj_flags = UNIQUE_RENAME

/obj/item/clothing/under/suit/nova/inferno/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suit)

/datum/atom_skin/inferno_suitskirt
	abstract_type = /datum/atom_skin/inferno_suitskirt

/datum/atom_skin/inferno_suitskirt/modeus
	preview_name = "Lust"
	new_icon_state = "modeus"

/datum/atom_skin/inferno_suitskirt/pande
	preview_name = "Sloth"
	new_icon_state = "pande"

/obj/item/clothing/under/suit/nova/inferno/skirt
	name = "inferno suitskirt"
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/nova/inferno/skirt/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/inferno_suitskirt)

