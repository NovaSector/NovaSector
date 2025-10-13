#define MODULAR_SHOES_ICON 'modular_nova/master_files/icons/obj/clothing/shoes.dmi'
#define MODULAR_SHOES_WORN_ICON 'modular_nova/master_files/icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/wraps
	name = "gilded leg wraps"
	desc = "Ankle coverings. These ones have a golden design."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "gildedcuffs"
	body_parts_covered = FALSE

/obj/item/clothing/shoes/wraps/silver
	name = "silver leg wraps"
	desc = "Ankle coverings. Not made of real silver."
	icon_state = "silvergildedcuffs"

/obj/item/clothing/shoes/wraps/red
	name = "red leg wraps"
	desc = "Ankle coverings. Show off your style with these shiny red ones!"
	icon_state = "redcuffs"

/obj/item/clothing/shoes/wraps/blue
	name = "blue leg wraps"
	desc = "Ankle coverings. Hang ten, brother."
	icon_state = "bluecuffs"

/obj/item/clothing/shoes/cowboy/laced/recolorable
	worn_icon = MODULAR_SHOES_WORN_ICON
	greyscale_colors = "#412e22#daeeee"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/cowboy/laced/recolorable"
	post_init_icon_state = "cowboy_greyscale"
	greyscale_config = /datum/greyscale_config/cowboy_boots
	greyscale_config_worn = /datum/greyscale_config/cowboy_boots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/cowboy_boots/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/high_heels
	name = "high heels"
	desc = "A fancy pair of high heels. Won't compensate for your below average height that much."
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/high_heels"
	post_init_icon_state = "heels"
	greyscale_config = /datum/greyscale_config/heels
	greyscale_config_worn = /datum/greyscale_config/heels/worn
	greyscale_config_worn_digi = /datum/greyscale_config/heels/worn/digi
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/high_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/master_files/sound/effects/heel1.ogg' = 1, 'modular_nova/master_files/sound/effects/heel2.ogg' = 1), 50)

/obj/item/clothing/shoes/fancy_heels
	name = "fancy heels"
	desc = "A pair of fancy high heels that are much smaller on your feet."
	worn_icon = MODULAR_SHOES_WORN_ICON
	greyscale_colors = "#FFFFFF"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/fancy_heels"
	post_init_icon_state = "fancyheels"
	greyscale_config = /datum/greyscale_config/fancyheels
	greyscale_config_worn = /datum/greyscale_config/fancyheels/worn
	greyscale_config_worn_digi = /datum/greyscale_config/fancyheels/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/fancy_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_nova/master_files/sound/effects/heel1.ogg' = 1, 'modular_nova/master_files/sound/effects/heel2.ogg' = 1), 50)

/obj/item/clothing/shoes/jungleboots
	name = "jungle boots"
	desc = "Take me to your paradise, I want to see the Jungle. A brown pair of boots."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "jungle"
	inhand_icon_state = "jackboots"
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE

/obj/item/clothing/shoes/jungleboots/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/obj/item/clothing/shoes/jackboots/black
	name = "dark jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time. These are fully black."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "blackjack"

/obj/item/clothing/shoes/wraps/cloth
	name = "cloth foot wraps"
	desc = "Boxer tape or bandages wrapped like a mummy, all left up to the choice of the wearer."
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/wraps/cloth"
	post_init_icon_state = "clothwrap"
	greyscale_config = /datum/greyscale_config/clothwraps
	greyscale_config_worn = /datum/greyscale_config/clothwraps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/clothwraps/worn/digi
	greyscale_colors = "#FFFFFF"
	body_parts_covered = FALSE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/wraps/colourable
	name = "colourable foot wraps"
	desc = "Ankle coverings. These ones have a customisable colour design."
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/wraps/colourable"
	post_init_icon_state = "legwrap"
	greyscale_config = /datum/greyscale_config/legwraps
	greyscale_config_worn = /datum/greyscale_config/legwraps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/legwraps/worn/digi
	greyscale_colors = "#FFFFFF"
	body_parts_covered = FALSE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/sports
	name = "sport shoes"
	desc = "Shoes for the sporty individual. The giants of Charlton play host to the titans of Ipswich - making them both seem normal sized."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "sportshoe"

/obj/item/clothing/shoes/jackboots/knee
	name = "knee boots"
	desc = "A pair of typical Nanotrasen-issue combat jackboots, long enough to reach the wearer's knee. Most commonly worn by commanding officers."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "kneeboots"

/obj/item/clothing/shoes/jackboots/timbs
	name = "hiking boots"
	desc = "While not quite as protective as Nanotrasen-issue workboots, these fashionable boots are still plenty effective in harsh climates."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "timbs"
	fastening_type = SHOES_LACED

/obj/item/clothing/shoes/jackboots/duckboots
	name = "northeastern duck boots"
	desc = "A sturdy pair of winter boots. A cowhide top stitched to a rubber bottom provides unparalleled water resistance, while the tread pattern ensures high grip in rough terrain."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "duckboots"
	fastening_type = SHOES_LACED

/obj/item/clothing/shoes/jackboots/duckboots/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, "It has a small <b>[span_red("red five pointed star")]</b> stamped onto the heel, and <b>[span_red("DIRIGO")]</b> etched under the soles.")


/obj/item/clothing/shoes/winterboots/christmas
	name = "christmas boots"
	desc = "A pair of fluffy christmas boots!"
	greyscale_colors = "#cc0f0f#c4c2c2"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/winterboots/christmas"
	post_init_icon_state = "christmas_boots"
	greyscale_config = /datum/greyscale_config/boots/christmasboots
	greyscale_config_worn = /datum/greyscale_config/boots/christmasboots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/boots/christmasboots/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/clown_shoes/pink
	name = "pink clown shoes"
	desc = "A particularly pink pair of punny shoes."
	icon = MODULAR_SHOES_ICON
	worn_icon = MODULAR_SHOES_WORN_ICON
	icon_state = "pink_clown_shoes"

/obj/item/clothing/shoes/colorable_laceups
	name = "laceup shoes"
	desc = "These don't seem to come pre-polished, how saddening."
	worn_icon = 'modular_nova/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_nova/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/colorable_laceups"
	post_init_icon_state = "laceups"
	greyscale_config = /datum/greyscale_config/laceup
	greyscale_config_worn = /datum/greyscale_config/laceup/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/laceup/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/laceup/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/laceup/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/colorable_sandals
	name = "sandals"
	desc = "Rumor has it that wearing these with socks puts you on a no entry list in several sectors."
	worn_icon = 'modular_nova/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_nova/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/colorable_sandals"
	post_init_icon_state = "sandals"
	greyscale_config = /datum/greyscale_config/sandals
	greyscale_config_worn = /datum/greyscale_config/sandals/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sandals/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/sandals/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/sandals/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/sandals/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/jackboots/recolorable
	worn_icon = 'modular_nova/modules/GAGS/icons/shoes/shoes.dmi'
	worn_icon_teshari = 'modular_nova/modules/GAGS/icons/shoes/shoes_teshari.dmi'
	greyscale_colors = "#383631"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/jackboots/recolorable"
	post_init_icon_state = "boots"
	greyscale_config = /datum/greyscale_config/boots
	greyscale_config_worn = /datum/greyscale_config/boots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/boots/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/boots/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/boots/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/boots/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/clothing/shoes/sport_boots
	name = "sport boots"
	desc = "A pair of comfortable athletic boots suitable for running and sports activities."
	worn_icon = MODULAR_SHOES_WORN_ICON
	greyscale_colors = "#292929#ffffff#ff9900"
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/sport_boots"
	post_init_icon_state = "sport_boots"
	greyscale_config = /datum/greyscale_config/sport_boots
	greyscale_config_worn = /datum/greyscale_config/sport_boots/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sport_boots/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/shoes/wraps/cloth
	name = "cloth foot wraps"
	desc = "Boxer tape or bandages wrapped like a mummy, all left up to the choice of the wearer."
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/wraps/cloth"
	post_init_icon_state = "clothwrap"
	greyscale_config = /datum/greyscale_config/clothwraps
	greyscale_config_worn = /datum/greyscale_config/clothwraps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/clothwraps/worn/digi
	greyscale_colors = "#FFFFFF"
	body_parts_covered = FALSE
	flags_1 = IS_PLAYER_COLORABLE_1
