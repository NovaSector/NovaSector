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
/datum/atom_skin/security_uniform_black
	abstract_type = /datum/atom_skin/security_uniform_black

/datum/atom_skin/security_uniform_black/black
	preview_name = "Black Variant"
	new_icon_state = "security_black"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

/datum/atom_skin/security_uniform_black/white
	preview_name = "White Variant"
	new_icon_state = "security_white"
	new_worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/nova/officer/black
	icon_state = "security_black"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/officer/black/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_uniform_black)

//Bluesec uniform
/datum/atom_skin/security_uniform_blue
	abstract_type = /datum/atom_skin/security_uniform_blue

/datum/atom_skin/security_uniform_blue/black
	preview_name = "Black Variant"
	new_icon_state = "security_blue_black"

/datum/atom_skin/security_uniform_blue/blue
	preview_name = "Blue Variant"
	new_icon_state = "security_blue"

/datum/atom_skin/security_uniform_blue/white
	preview_name = "White Variant"
	new_icon_state = "security_white"

/obj/item/clothing/under/rank/security/nova/officer
	name = "security uniform"
	desc = "A tactical security uniform for officers complete with Nanotrasen belt buckle."
	icon_state = "security_blue_black"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/officer/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_uniform_blue)

/obj/item/clothing/under/rank/security/nova/formal
	name = "security formal suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal"
	post_init_icon_state = "secformal"
	greyscale_config = /datum/greyscale_config/secformal
	greyscale_config_worn = /datum/greyscale_config/secformal/worn
	greyscale_config_worn_digi = /datum/greyscale_config/secformal/worn/digi
	greyscale_colors = "#39393F#EBEBEB#A52F29#39393F"
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/formal/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal/blue"
	greyscale_colors = "#39393F#EBEBEB#3F6E9E#39393F"

/obj/item/clothing/under/rank/security/nova/formal/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal/white"
	greyscale_colors = "#39393F#EBEBEB#EBEBEB#39393F"

/obj/item/clothing/under/rank/security/nova/formal/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal/black"
	greyscale_colors = "#39393F#EBEBEB#39393F#EBEBEB"

/obj/item/clothing/under/rank/security/nova/turtleneck
	name = "security turtleneck"
	desc = "A turtleneck issued to officers complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck"
	post_init_icon_state = "secturtleneck"
	greyscale_config = /datum/greyscale_config/secturtleneck
	greyscale_config_worn = /datum/greyscale_config/secturtleneck/worn
	greyscale_config_worn_digi = /datum/greyscale_config/secturtleneck/worn/digi
	greyscale_colors = "#39393F#A52F29#39393F"
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/turtleneck/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/blue"
	greyscale_colors = "#39393F#3F6E9E#39393F"

/obj/item/clothing/under/rank/security/nova/turtleneck/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/white"
	greyscale_colors = "#ECECEC#ECECEC#39393F"

/obj/item/clothing/under/rank/security/nova/turtleneck/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/black"
	greyscale_colors = "#39393F#39393F#ECECEC"

/datum/atom_skin/security_jumpskirt
	abstract_type = /datum/atom_skin/security_jumpskirt

/datum/atom_skin/security_jumpskirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "jumpskirt_blue"

/datum/atom_skin/security_jumpskirt/black
	preview_name = "Black Variant"
	new_icon_state = "jumpskirt_black"

/obj/item/clothing/under/rank/security/nova/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" security uniform with the legs replaced by a skirt."
	icon_state = "jumpskirt_blue"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/nova/skirt/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jumpskirt, infinite = TRUE)

/datum/atom_skin/security_plain_skirt
	abstract_type = /datum/atom_skin/security_plain_skirt

/datum/atom_skin/security_plain_skirt/blue
	preview_name = "Blue Variant"
	new_icon_state = "plain_skirt_blue"

/datum/atom_skin/security_plain_skirt/black
	preview_name = "Black Variant"
	new_icon_state = "plain_skirt_black"

/obj/item/clothing/under/rank/security/nova/skirt/plain
	name = "security plain skirt"
	desc = "Plain-shirted uniform commonly worn by Nanotrasen officers, attached with a skirt."
	icon_state = "plain_skirt_blue"

/obj/item/clothing/under/rank/security/nova/skirt/plain/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_plain_skirt)
/*
/datum/atom_skin/security_miniskirt
	abstract_type = /datum/atom_skin/security_miniskirt

/datum/atom_skin/security_miniskirt/red
	preview_name = "Red Variant"
	new_icon_state = "miniskirt"

/datum/atom_skin/security_miniskirt/black
	preview_name = "Black Variant"
	new_icon_state = "miniskirt_black"

/obj/item/clothing/under/rank/security/nova/skirt/mini
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/mini"
	post_init_icon_state = "secmini"
	greyscale_config = /datum/greyscale_config/secmini
	greyscale_config_worn = /datum/greyscale_config/secmini/worn
	greyscale_colors = "#A52F29#39393F"
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/skirt/mini/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/mini/blue"
	greyscale_colors = "#3F6E9E#39393F"

/obj/item/clothing/under/rank/security/nova/skirt/mini/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/mini/white"
	greyscale_colors = "#ECECEC#39393F"

/obj/item/clothing/under/rank/security/nova/skirt/mini/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/mini/black"
	greyscale_colors = "#39393F#ECECEC"
*/
/obj/item/clothing/under/rank/security/nova/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/utility/blue
	icon_state = "util_sec_blue"

/obj/item/clothing/under/rank/security/nova/dress
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress"
	post_init_icon_state = "secdress"
	greyscale_config = /datum/greyscale_config/secdress
	greyscale_config_worn = /datum/greyscale_config/secdress/worn
	greyscale_colors = "#A52F29#A52F29"
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/dress/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/blue"
	greyscale_colors = "#3F6E9E#3F6E9E"

/obj/item/clothing/under/rank/security/nova/dress/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/white"
	greyscale_colors = "#ECECEC#ECECEC"

/obj/item/clothing/under/rank/security/nova/dress/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/black"
	greyscale_colors = "#39393F#ECECEC"

/obj/item/clothing/under/rank/security/nova/secshorts
	name = "security shorts"
	desc = "Some \"combat\" shorts. Please don't actually wear these."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts"
	post_init_icon_state = "secshorts"
	greyscale_config = /datum/greyscale_config/secshorts
	greyscale_config_worn = /datum/greyscale_config/secshorts/worn
	greyscale_config_worn_digi = /datum/greyscale_config/secshorts/worn/digi
	greyscale_colors = "#A52F29"
	flags_1 = NONE
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/nova/secshorts/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts/blue"
	greyscale_colors = "#3F6E9E"

/obj/item/clothing/under/rank/security/nova/secshorts/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts/white"
	greyscale_colors = "#ECECEC"

/obj/item/clothing/under/rank/security/nova/secshorts/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts/black"
	greyscale_colors = "#39393F"

/obj/item/clothing/under/rank/security/nova/trousers
	name = "pair of security trousers"
	desc = "Some \"combat\" trousers. Probably should pair it with a vest for safety."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers"
	post_init_icon_state = "sectrousers"
	greyscale_config = /datum/greyscale_config/sectrousers
	greyscale_config_worn = /datum/greyscale_config/sectrousers/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sectrousers/worn/digi
	greyscale_colors = "#A52F29"
	flags_1 = NONE
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/nova/trousers/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers/blue"
	greyscale_colors = "#3F6E9E"

/obj/item/clothing/under/rank/security/nova/trousers/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers/white"
	greyscale_colors = "#ECECEC"

/obj/item/clothing/under/rank/security/nova/trousers/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers/black"
	greyscale_colors = "#39393F"

/obj/item/clothing/under/rank/security/nova/modskin
	name = "security M.O.D. skinsuit"
	desc = "A M.O.D. skinsuit worn by trained Security officers."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/modskin"
	post_init_icon_state = "modskin"
	greyscale_config = /datum/greyscale_config/modskin
	greyscale_config_worn = /datum/greyscale_config/modskin/worn
	greyscale_config_worn_digi = /datum/greyscale_config/modskin/worn/digi
	greyscale_colors = "#4E4E54#A52F29"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/modskin/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/modskin/blue"
	greyscale_colors = "#4E4E54#3F6E9E"

/obj/item/clothing/under/rank/security/nova/modskin/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/modskin/white"
	greyscale_colors = "#4E4E54#ECECEC"

/obj/item/clothing/under/rank/security/nova/modskin/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/modskin/black"
	greyscale_colors = "#4E4E54#4E4E54"

/obj/item/clothing/under/rank/security/nova/secjumpsuit
	name = "security uniform"
	desc = "A tactical security jumpsuit for officers complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/secjumpsuit"
	post_init_icon_state = "secjumpsuit"
	greyscale_config = /datum/greyscale_config/secjumpsuit
	greyscale_config_worn = /datum/greyscale_config/secjumpsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/secjumpsuit/worn/digi
	greyscale_colors = "#A52F29#39393F#39393F"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	flags_1 = NONE

/obj/item/clothing/under/rank/security/nova/secjumpsuit/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/secjumpsuit/blue"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/secjumpsuit/white
	icon_state = "/obj/item/clothing/under/rank/security/nova/secjumpsuit/white"
	greyscale_colors = "#ECECEC#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/secjumpsuit/black
	icon_state = "/obj/item/clothing/under/rank/security/nova/secjumpsuit/black"
	greyscale_colors = "#39393F#39393F#ECECEC"

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


/obj/item/clothing/under/imperialvest/hos
	name = "head of security's naval jumpsuit"
	desc = "A tar black naval suit with a rank badge denoting the officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	icon_state = "/obj/item/clothing/under/imperialvest/hos"
	greyscale_colors = "#39393f#39393f#39393f#373741#f8d860#21212B#f8d860#a52f29"
	flags_1 = NONE

/obj/item/clothing/under/imperialskirtvest/hos
	name = "head of security's naval jumpsuit"
	desc = "A tar black naval skirt with a rank badge denoting the officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	greyscale_colors = "#39393f#39393f#373741#f8d860#21212B#f8d860#a52f29"
	icon_state = "/obj/item/clothing/under/imperialskirtvest/hos"
	flags_1 = NONE

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
	gets_cropped_on_taurs = FALSE

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
