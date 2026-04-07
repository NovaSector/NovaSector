
/obj/item/clothing/gloves/color/black/security
	name = "security gloves"
	desc = "These security gloves come with microchips that help the user quickly restrain suspects."
	clothing_traits = list(TRAIT_FAST_CUFFING)
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/gloves/color/black/security"
	post_init_icon_state = "secgloves"
	greyscale_config = /datum/greyscale_config/secgloves
	greyscale_config_worn = /datum/greyscale_config/secgloves/worn
	greyscale_colors = "#2F2E31#A52F29"
	flags_1 = NONE

/obj/item/clothing/gloves/color/black/security/blue
	icon_state = "/obj/item/clothing/gloves/color/black/security/blue"
	greyscale_colors = "#2F2E31#3F6E9E"

/obj/item/clothing/gloves/color/black/security/white
	icon_state = "/obj/item/clothing/gloves/color/black/security/white"
	greyscale_colors = "#ECECEC#2F2E31"

/obj/item/clothing/gloves/color/black/security/black
	icon_state = "/obj/item/clothing/gloves/color/black/security/black"
	greyscale_colors = "#2F2E31#ECECEC"
