//Trekkie Caps
/obj/item/clothing/head/hats/caphat/parade/fedcap
	name = "Officer's cap"
	desc = "An officer's cap that demands discipline from the one who wears it."
	icon_state = "fedcapofficer"
	armor_type = /datum/armor/none
	icon = 'modular_nova/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/head.dmi'

//Variants
/obj/item/clothing/head/hats/caphat/parade/fedcap/medsci
		icon_state = "fedcapsci"

/obj/item/clothing/head/hats/caphat/parade/fedcap/eng
		icon_state = "fedcapeng"

/obj/item/clothing/head/hats/caphat/parade/fedcap/sec
		icon_state = "fedcapsec"

/obj/item/clothing/head/hats/caphat/parade/fedcap/black
		icon_state = "fedcapblack"

/obj/item/clothing/head/hats/caphat/parade/fedcap/custom
		icon_state = "fedcap_silver"
		greyscale_config = /datum/greyscale_config/fedcap
		greyscale_config_worn = /datum/greyscale_config/fedcap/worn
		greyscale_colors = "#FF0000#333333#FFFFFF"
		flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/hats/caphat/parade/fedcap/custom/gold
		icon_state = "fedcap_gold"
		greyscale_config = /datum/greyscale_config/fedcap_gold
		greyscale_config_worn = /datum/greyscale_config/fedcap_gold/worn
		greyscale_colors = "#FF0000#333333"
