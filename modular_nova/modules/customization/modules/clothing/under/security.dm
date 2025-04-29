// MODULAR SECURITY WEAR (NOT OVERRIDES, LOOK IN 'modular_nova\modules\sec_haul\code\security_clothing\sec_clothing_overrides.dm')

// DETECTIVE
/obj/item/clothing/under/rank/security/detective/cowboy
	name = "blonde cowboy uniform"
	desc = "A blue shirt and dark jeans, with a pair of spurred cowboy boots to boot."
	icon = 'modular_nova/master_files/icons/donator/obj/clothing/uniform.dmi'	//Donator item-ish? See the /armorless one below it
	worn_icon = 'modular_nova/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "cowboy_uniform"
	supports_variations_flags = NONE
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/cowboy/armorless //Donator variant, just uses the sprite.
	armor_type = /datum/armor/clothing_under/none

/obj/item/clothing/suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/toggle/jacket/nova/det_trench/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

/obj/item/clothing/under/rank/security/detective/runner
	name = "runner sweater"
	desc = "<i>\"You look lonely.\"</i>"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "runner"
	supports_variations_flags = NONE
	can_adjust = FALSE

/// PRISONER
/obj/item/clothing/under/rank/prisoner/protcust
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	name = "protective custody prisoner jumpskirt"
	desc = "A mustard coloured prison jumpskirt, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/lowsec
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/highsec
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	name = "high risk prisoner jumpsuit"
	desc = "A bright red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	name = "high risk prisoner jumpskirt"
	desc = "A bright red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/supermax
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	name = "supermax prisoner jumpsuit"
	desc = "A dark crimson red prison jumpsuit, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	name = "supermax prisoner jumpskirt"
	desc = "A dark crimson red prison jumpskirt, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/classic
	name = "classic prisoner jumpsuit"
	desc = "A black and white striped jumpsuit, like something out of a movie."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/costume_digi.dmi'
	greyscale_colors = null
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/syndicate
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner"
	post_init_icon_state = "jumpsuit"
	name = "syndicate prisoner jumpsuit"
	desc = "A crimson red jumpsuit worn by syndicate captives. Its sensors have been shorted out."
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt/syndicate
	icon = 'icons/map_icons/clothing.dmi'
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt"
	post_init_icon_state = "jumpskirt"
	name = "syndicate prisoner jumpskirt"
	desc = "A crimson red jumpskirt worn by syndicate captives. Its sensors have been shorted out."
	greyscale_colors = "#992300"
	has_sensor = FALSE
	supports_variations_flags = NONE
