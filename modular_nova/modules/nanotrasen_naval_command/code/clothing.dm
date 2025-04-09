
// UNDER
/obj/item/clothing/under/rank/centcom/nova/naval
	name = "ensign uniform"
	desc = "A uniform worn by those with the rank Ensign in the Nanotrasen Navy."
	icon_state = "naval_ensign"
	can_adjust = TRUE

/obj/item/clothing/under/rank/centcom/nova/naval/commander
	name = "command uniform"
	desc = "A uniform worn by those with a command rank in the Nanotrasen Navy."
	icon_state = "naval_command"

/obj/item/clothing/under/rank/centcom/nova/naval/admiral
	name = "admiral's uniform"
	desc = "A uniform worn by those with the rank Admiral in the Nanotrasen Navy."
	icon_state = "naval_admiral"

/obj/item/clothing/under/rank/centcom/nova/naval/fleet_admiral
	name = "fleet admiral's uniform"
	desc = "A uniform worn by those with the rank Fleet Admiral in the Nanotrasen Navy."
	icon_state = "naval_fleet_admiral"

// GLOVES
/obj/item/clothing/gloves/combat/naval
	name = "nanotrasen naval gloves"
	desc = "A high quality pair of thick gloves covered in gold stitching, given to Nanotrasen's Naval Commanders."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/hands.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/gloves.dmi'
	icon_state = "naval_command"

/obj/item/clothing/gloves/combat/naval/fleet_admiral
	name = "fleet admiral's gloves"
	icon_state = "naval_fleet_admiral"


// HATS
/obj/item/clothing/head/hats/caphat/naval
	name = "naval cap"
	desc = "A cap worn by those in the Nanotrasen Navy."
	icon_state = "naval_command"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/caphat/naval/fleet_admiral
	name = "fleet admiral's cap"
	desc = "A cap worn by the Nanotrasen Fleet Admiral."
	icon_state = "naval_fleet_admiral"

/obj/item/clothing/head/hats/caphat/naval/custom
	icon_state = "naval_silver"
	greyscale_config = /datum/greyscale_config/naval
	greyscale_config_worn = /datum/greyscale_config/naval/worn
	greyscale_colors = "#FF0000#333333#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1
	armor_type = /datum/armor/none

/obj/item/clothing/head/hats/caphat/naval/custom/gold
	icon_state = "naval_gold"
	greyscale_config = /datum/greyscale_config/naval_gold
	greyscale_config_worn = /datum/greyscale_config/naval_gold/worn
	greyscale_colors = "#FF0000#333333"


// NECK
/obj/item/clothing/neck/pauldron
	name = "lieutenant commander's pauldron"
	desc = "A red padded pauldron signifying the rank of Lieutenant Commander of the Nanotrasen Navy."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "pauldron_ltcr"

/obj/item/clothing/neck/pauldron/commander
	name = "commander's pauldron"
	desc = "A red padded pauldron signifying the rank of Commander in the Nanotrasen Navy."
	icon_state = "pauldron_commander"

/obj/item/clothing/neck/pauldron/captain
	name = "captain's pauldron"
	desc = "A red padded pauldron signifying the rank of Captain in the Nanotrasen Navy."
	icon_state = "pauldron_captain"

/obj/item/clothing/neck/cloak/admiral
	name = "admiral's cape"
	desc = "A vibrant green cape with gold stitching, worn by Nanotrasen Navy Admirals."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "cape_admiral"

/obj/item/clothing/neck/cloak/fleet_admiral
	name = "fleet admiral's cape"
	desc = "A godly cape worn by the highest ranking person in the Nanotrasen Navy, the Fleet Admiral."
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_nova/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "cape_fleet_admiral"

// SUITS
/obj/item/clothing/suit/armor/vest/capcarapace/naval
	name = "naval carapace"
	desc = "A carapace worn by Naval Command members."
	icon = 'modular_nova/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "naval_carapace"

// GLASSES
/obj/item/clothing/glasses/hud/security/sunglasses/black
	name = "black security sunglasses"
	desc = "A pair of black sunglasses worn by Naval Command officers."
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sun"
	unique_reskin = null
