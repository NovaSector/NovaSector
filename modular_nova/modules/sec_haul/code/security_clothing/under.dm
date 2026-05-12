// Sec overrides can be found on
// modular_nova\modules\sec_haul\code\security_clothing\sec_clothing_overrides.dm

/obj/item/clothing/under/rank/security/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/security_digi.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1

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

/obj/item/clothing/under/rank/security/nova/uniform
	name = "security jumpsuit"
	desc = "A tactical jumpsuit for guards complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/uniform"
	post_init_icon_state = "depgag_jumpsuit"
	greyscale_config = /datum/greyscale_config/depgag_jumpsuit
	greyscale_config_worn = /datum/greyscale_config/depgag_jumpsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_jumpsuit/worn/digi
	greyscale_colors = "#A52F29#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/blue"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/cargo
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/cargo"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/engineering
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/engineering"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/research
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/research"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/medical
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/medical"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/officer/service
	icon_state = "/obj/item/clothing/under/rank/security/nova/officer/service"
	greyscale_colors = "#3F6E9E#39393F#39393F"

/obj/item/clothing/under/rank/security/nova/formal
	name = "security formal suit"
	desc = "A formal suit for guards complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal"
	post_init_icon_state = "depgag_formal"
	greyscale_config = /datum/greyscale_config/depgag_formal
	greyscale_config_worn = /datum/greyscale_config/depgag_formal/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_formal/worn/digi
	greyscale_colors = "#39393F#EBEBEB#A52F29#39393F"

/obj/item/clothing/under/rank/security/nova/formal/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/formal/blue"
	greyscale_colors = "#39393F#EBEBEB#3F6E9E#39393F"

/obj/item/clothing/under/rank/security/nova/turtleneck
	name = "security turtleneck"
	desc = "A turtleneck issued to guards complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck"
	post_init_icon_state = "depgag_turtleneck"
	greyscale_config = /datum/greyscale_config/depgag_turtleneck
	greyscale_config_worn = /datum/greyscale_config/depgag_turtleneck/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_turtleneck/worn/digi
	greyscale_colors = "#39393F#A52F29#39393F"

/obj/item/clothing/under/rank/security/nova/turtleneck/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/blue"
	greyscale_colors = "#39393F#3F6E9E#39393F"
//turtleneck trousers patches
/obj/item/clothing/under/rank/security/nova/turtleneck/cargo
	name = "customs agent turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/cargo"
	greyscale_colors = "#39393F#ba832f#ba832f"

/obj/item/clothing/under/rank/security/nova/turtleneck/engineering
	name = "engineering guard turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/engineering"
	greyscale_colors = "#ee7900#a78962#FFE12F"

/obj/item/clothing/under/rank/security/nova/turtleneck/research
	name = "research guard turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/research"
	greyscale_colors = "#daeaf0#66748c#830085"

/obj/item/clothing/under/rank/security/nova/turtleneck/medical
	name = "orderly turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/medical"
	greyscale_colors = "#CBCDD1#39393F#40657b"

/obj/item/clothing/under/rank/security/nova/turtleneck/service
	name = "bouncer turtleneck"
	icon_state = "/obj/item/clothing/under/rank/security/nova/turtleneck/service"
	greyscale_colors = "#39393F#4876A1#57852A"

/obj/item/clothing/under/rank/security/nova/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" uniform with the legs replaced by a skirt."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt"
	post_init_icon_state = "depgag_skirt"
	greyscale_config = /datum/greyscale_config/depgag_skirt
	greyscale_config_worn = /datum/greyscale_config/depgag_skirt/worn
	greyscale_colors = "#A52F29#39393F#39393F#A52F29"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/nova/skirt/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/skirt/blue"
	greyscale_colors = "#3F6E9E#39393F#39393F#3F6E9E"

/obj/item/clothing/under/rank/security/nova/plainskirt
	name = "security plain skirt"
	desc = "Plain-shirted uniform commonly worn by Nanotrasen protection guards, attached with a skirt."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt"
	post_init_icon_state = "depgag_skirt_plain"
	greyscale_config = /datum/greyscale_config/depgag_skirt_plain
	greyscale_config_worn = /datum/greyscale_config/depgag_skirt_plain/worn
	greyscale_colors = "#A52F29#39393F#39393F#A52F29"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/nova/plainskirt/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/plainskirt/blue"
	greyscale_colors = "#3F6E9E#39393F#3F6E9E#3F6E9E"

/obj/item/clothing/under/rank/security/nova/miniskirt
	name = "security miniskirt"
	desc = "This miniskirt was originally featured in a gag calendar, but entered official use once they realized its potential for arid climates."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/miniskirt"
	post_init_icon_state = "depgag_mini"
	greyscale_config = /datum/greyscale_config/depgag_mini
	greyscale_config_worn = /datum/greyscale_config/depgag_mini/worn
	greyscale_colors = "#A52F29#39393F"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/nova/miniskirt/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/miniskirt/blue"
	greyscale_colors = "#3F6E9E#39393F"

/obj/item/clothing/under/rank/security/nova/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by trained guards."
	icon_state = "util_sec"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/nova/dress
	name = "security battle dress"
	desc = "An asymmetrical, unisex uniform with the legs replaced by a utility skirt."
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress"
	post_init_icon_state = "depgag_dress"
	greyscale_config = /datum/greyscale_config/depgag_dress
	greyscale_config_worn = /datum/greyscale_config/depgag_dress/worn
	greyscale_colors = "#A52F29#39393F#A52F29"
//shirt dress trim
/obj/item/clothing/under/rank/security/nova/dress/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/dress/blue"
	greyscale_colors = "#3F6E9E#39393F#3F6E9E"

/obj/item/clothing/under/rank/security/nova/shorts
	name = "security shorts"
	desc = "Some \"combat\" shorts. Please don't actually wear these."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts"
	post_init_icon_state = "depgag_shorts"
	greyscale_config = /datum/greyscale_config/depgag_shorts
	greyscale_config_worn = /datum/greyscale_config/depgag_shorts/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_shorts/worn/digi
	greyscale_colors = "#A52F29"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS|FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/nova/secshorts/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/secshorts/blue"
	greyscale_colors = "#3F6E9E"

/obj/item/clothing/under/rank/security/nova/trousers
	name = "pair of security trousers"
	desc = "Some \"combat\" trousers. Probably should pair it with a vest for safety."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers"
	post_init_icon_state = "depgag_trousers"
	greyscale_config = /datum/greyscale_config/depgag_trousers
	greyscale_config_worn = /datum/greyscale_config/depgag_trousers/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_trousers/worn/digi
	greyscale_colors = "#A52F29"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/nova/trousers/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/trousers/blue"
	greyscale_colors = "#3F6E9E"

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

/obj/item/clothing/under/rank/security/nova/depgag_pantsuit
	name = "security pantsuit"
	desc = "A tactical jumpsuit for officers complete with Nanotrasen belt buckle."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/rank/security/nova/depgag_pantsuit"
	post_init_icon_state = "depgag_pantsuit"
	greyscale_config = /datum/greyscale_config/depgag_pantsuit
	greyscale_config_worn = /datum/greyscale_config/depgag_pantsuit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/depgag_pantsuit/worn/digi
	greyscale_colors = "#A52F29#39393F#39393F#39393F"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/nova/depgag_pantsuit/blue
	icon_state = "/obj/item/clothing/under/rank/security/nova/depgag_pantsuit/blue"
	greyscale_colors = "#3F6E9E#39393F#39393F#39393F"

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
	name = "head of security's naval skirt"
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
