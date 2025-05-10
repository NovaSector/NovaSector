#define MODULAR_HANDS_ICON 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
#define MODULAR_HANDS_WORN_ICON 'modular_nova/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/gloves/color/ffyellow // EXTRA fake, for the loadout
	name = "yellow gloves"
	desc = "At first glance these may look like insulated gloves, but they're actually just plain fabric."
	icon_state = "yellow"
	inhand_icon_state = "ygloves"
	siemens_coefficient = 0.5

/obj/item/clothing/gloves/evening
	name = "evening gloves"
	desc = "Thin, elegant gloves intended for use in regal attire. An unsubtle way to say you don't need to use your hands for laborious work."
	worn_icon = MODULAR_HANDS_WORN_ICON
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/evening"
	post_init_icon_state = "evening"
	greyscale_config = /datum/greyscale_config/evening_gloves
	greyscale_config_worn = /datum/greyscale_config/evening_gloves/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves/designer
	name = "designer gloves"
	desc = "A fancy set of bicep-length designer gloves. For those who live a life of luxury, and/or have poor spending habits."
	worn_icon = MODULAR_HANDS_WORN_ICON
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/designer"
	post_init_icon_state = "designer"
	greyscale_config = /datum/greyscale_config/designer_gloves
	greyscale_config_worn = /datum/greyscale_config/designer_gloves/worn
	greyscale_colors = "#2F2E31"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves/military
	name = "military gloves"
	desc = "Tactical gloves made for military personnel, they are thin to allow easy operation of most firearms."
	icon_state = "military_gloves"
	icon = MODULAR_HANDS_ICON
	worn_icon = MODULAR_HANDS_WORN_ICON
	siemens_coefficient = 0.4
	strip_delay = 60
	equip_delay_other = 60
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/bracer/wraps
	name = "cloth arm wraps"
	desc = "Cloth bracers, the colour all left up to the choice of the wearer."
	inhand_icon_state = "greyscale_gloves"
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/bracer/wraps"
	post_init_icon_state = "arm_wraps"
	greyscale_config = /datum/greyscale_config/armwraps
	greyscale_config_worn = /datum/greyscale_config/armwraps/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/gloves
	worn_icon_teshari = TESHARI_HANDS_ICON

/obj/item/clothing/gloves/maid_arm_covers
	name = "maid arm covers"
	desc = "Maid in China."
	icon = 'icons/map_icons/clothing/_clothing.dmi'
	icon_state = "/obj/item/clothing/gloves/maid_arm_covers"
	post_init_icon_state = "maid_arm_covers"
	greyscale_config = /datum/greyscale_config/maid_arm_covers
	greyscale_config_worn = /datum/greyscale_config/maid_arm_covers/worn
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
