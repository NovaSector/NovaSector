//Base Jacket - same stats as /obj/item/clothing/suit/jacket, just toggleable and serving as the base for all the departmental jackets and flannels
/obj/item/clothing/suit/toggle/jacket/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "bomber jacket"
	desc = "A warm bomber jacket, with synthetic-wool lining to keep you nice and warm in the depths of space. Aviators not included."
	icon_state = "bomberalt"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/radio)
	body_parts_covered = CHEST|ARMS|GROIN
	cold_protection = CHEST|ARMS|GROIN
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	toggle_noun = "zipper"

//Job Jackets
/obj/item/clothing/suit/toggle/jacket/nova/engi
	name = "engineering jacket"
	desc = "A comfortable jacket in engineering yellow."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/engi"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#f8d860#eae3ce#17161f#f8d860"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

	armor_type = /datum/armor/jacket_engi
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)

/obj/item/clothing/suit/toggle/jacket/nova/tcomm
	name = "telecomms jacket"
	desc = "A comfortable jacket in engineering yellow with blue telecomms trim."
	icon_state = "tcomm_dep_jacket"
	armor_type = /datum/armor/jacket_engi
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/toy,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/lighter,
	)

/datum/armor/jacket_engi
	fire = 30
	acid = 45

/obj/item/clothing/suit/toggle/jacket/nova/sci
	name = "science jacket"
	desc = "A comfortable jacket in science purple."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/sci"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#7e1980#eae3ce#17161f#7e1980"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

	armor_type = /datum/armor/jacket_sci

/datum/armor/jacket_sci
	bomb = 10

/obj/item/clothing/suit/toggle/jacket/nova/med
	name = "medbay jacket"
	desc = "A comfortable jacket in medical blue."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/med"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#becace#eae3ce#17161f#becace"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	armor_type = /datum/armor/jacket_med

/datum/armor/jacket_med
	bio = 50
	acid = 45

/obj/item/clothing/suit/toggle/jacket/nova/supply
	name = "cargo jacket"
	desc = "A comfortable jacket in supply brown."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/supply"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#b7793d#eae3ce#17161f#b7793d"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/jacket/nova/assistant
	name = "non-departmental jacket"
	desc = "A comfortable jacket in a neutral black"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/assistant"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#39393f#eae3ce#17161f#39393f"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/jacket/nova/supply/head
	name = "quartermaster's jacket"
	desc = "Even if people refuse to recognize you as a head, they can recognize you as a badass."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/assistant"
	greyscale_colors = "#292929#eae3ce#b7793d#b7793d"
	post_init_icon_state = "jacket_armband"


/obj/item/clothing/suit/toggle/jacket/nova/sec
	name = "security jacket"
	desc = "A comfortable jacket in security red. Probably against uniform regulations."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/sec"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#a52f29#eae3ce#17161f#a52f29"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

	armor_type = /datum/armor/sec_dep_jacket

/obj/item/clothing/suit/toggle/jacket/nova/sec/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/datum/armor/sec_dep_jacket
	melee = 30
	bullet = 20
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 45

/obj/item/clothing/suit/toggle/jacket/nova/sec/blue
	desc = "An outdated jacket in blue. Probably against uniform regulations."
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/sec/blue"
	greyscale_colors = "#3f6e9e#eae3ce#17161f#3f6e9e"

/obj/item/clothing/suit/toggle/jacket/nova/bridge_officer
	name = "bridge officer's jacket"
	desc = "It's a blue and silver jacket indicating that of a \"Bridge Officer\"."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/bridge_officer"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#FCFCFD#CCCED1#8A8B9D#68697D"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/jacket/nova/interdyne
	name = "bridge officer's jacket"
	desc = "It's a blue and silver jacket indicating that of a \"Bridge Officer\"."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/interdyne"
	post_init_icon_state = "jacket"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#333333#eae3ce#33cc33#33cc33"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/jacket/nova/syndicate
	name = "bridge officer's jacket"
	desc = "It's a blue and silver jacket indicating that of a \"Bridge Officer\"."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/syndicate"
	post_init_icon_state = "jacket_armband"
	greyscale_config = /datum/greyscale_config/dept_jacket
	greyscale_config_worn = /datum/greyscale_config/dept_jacket/worn
	greyscale_colors = "#333333#eae3ce#ff0000#ff0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE



//Flannels
/obj/item/clothing/suit/toggle/jacket/nova/flannel
	icon = 'modular_nova/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/suit.dmi'
	name = "flannel jacket"
	desc = "A cozy and warm plaid flannel jacket. Praised by Lumberjacks and Truckers alike."
	icon_state = "flannel"
	body_parts_covered = CHEST|ARMS //Being a bit shorter, flannels dont cover quite as much as the rest of the woolen jackets (- GROIN)
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS	//As a plus side, they're more insulating, protecting a bit from the heat as well

/obj/item/clothing/suit/toggle/jacket/nova/flannel/red
	name = "red flannel jacket"
	icon_state = "flannel_red"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/aqua
	name = "aqua flannel jacket"
	icon_state = "flannel_aqua"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/brown
	name = "brown flannel jacket"
	icon_state = "flannel_brown"

/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags
	name = "flannel shirt"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/toggle/jacket/nova/flannel/gags"
	post_init_icon_state = "flannelgags"
	greyscale_config = /datum/greyscale_config/flannelgags
	greyscale_config_worn = /datum/greyscale_config/flannelgags/worn
	greyscale_colors = "#a61e1f"
	flags_1 = IS_PLAYER_COLORABLE_1

/// Placed in here for now until a better solution is found.

/obj/item/clothing/suit/nova/trenchcoat
	name = "Ushinkov Trenchcoat"
	desc = "A trenchcoat, made for the cold, dark, and desperate winter nights."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/nova/trenchcoat"
	post_init_icon_state = "coat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	greyscale_config = /datum/greyscale_config/fluffywintercoat
	greyscale_config_worn = /datum/greyscale_config/fluffywintercoat/worn
	greyscale_colors = "#FCFCFD#CCCED1#8A8B9D#68697D"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/nova/overcoat
	name = "Regal Overcoat"
	desc = "An overcoat of regalness, it looks quite fancy."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/nova/overcoat"
	post_init_icon_state = "overcoat"
	greyscale_config = /datum/greyscale_config/overcoat
	greyscale_config_worn = /datum/greyscale_config/overcoat/worn
	greyscale_colors = "#FCFCFD#CCCED1#8A8B9D"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
