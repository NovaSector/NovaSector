#define SHORTS_PANTS_SHIRTS_DIGIFILE 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts_digi.dmi'

/obj/item/clothing/under/pants
	worn_icon_digi = SHORTS_PANTS_SHIRTS_DIGIFILE

/obj/item/clothing/under/shorts
	worn_icon_digi = SHORTS_PANTS_SHIRTS_DIGIFILE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION //That's right, TG, I have icons for ALL of these!! Mwahahaha!!!!

/obj/item/clothing/under/pants/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'

/obj/item/clothing/under/shorts/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/shorts_pants_shirts.dmi'
	icon_state = "shorts"
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/shorts_pants_shirts.dmi'
	post_init_icon_state = null
	//Need to reset all these so our custom stuff can choose independently to be greyscale or not. TG putting these on the basetype was kinda gross.
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_colors = null
	flags_1 = NONE

//TG's files separate this into Shorts.dmi and Pants.dmi. We wont have as many, so both go into here.

/*
*	PANTS
*/

/obj/item/clothing/under/pants/nova/jeans_ripped
	name = "ripped jeans"
	desc = "A nondescript pair of tough jeans, with several rips and tears. The staple pants choice of both rebels and the poor."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/jeans_ripped"
	post_init_icon_state = "jeans_ripped"
	greyscale_config = /datum/greyscale_config/jeans_ripped //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/jeans_ripped/worn
	greyscale_config_worn_digi = /datum/greyscale_config/jeans_ripped/worn/digi
	greyscale_colors = "#787878#723E0E#4D7EAC"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/nova/yoga
	name = "yoga pants"
	desc = "Breathable and stretchy, perfect for exercising comfortably!"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/yoga"
	post_init_icon_state = "yoga_pants"
	greyscale_config = /datum/greyscale_config/yoga_pants //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/yoga_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/yoga_pants/worn/digi
	greyscale_colors = "#3d3d3d" //Having all the configs for a single color feels wrong. This is wrong.
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/nova/chaps
	name = "chaps"
	desc = "Padding worn to protect the outside of one's legs from hazards. Usually it'd be worn over pants, \
		but worn alone they technically still function as intended."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/chaps"
	post_init_icon_state = "chaps"
	greyscale_config = /datum/greyscale_config/chaps
	greyscale_config_worn = /datum/greyscale_config/chaps/worn
	greyscale_config_worn_digi = /datum/greyscale_config/chaps/worn/digi
	greyscale_colors = "#787878#252525#2B2B2B"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/nova/chaps/click_ctrl_shift(mob/user)
	if(attached_accessories) //Make sure they don't have any attachments first
		balloon_alert(user, "remove attached accessories!")
		return
	//Converts the Chaps into an attachment
	//See accessories.dm for the accessory version
	var/obj/item/clothing/accessory/chaps/chaps_accessory = new /obj/item/clothing/accessory/chaps(user.drop_location())
	chaps_accessory.greyscale_colors = greyscale_colors
	chaps_accessory.update_greyscale()
	user.balloon_alert(user, "changed to accessory!")
	qdel(src)
	user.put_in_hands(chaps_accessory)

/obj/item/clothing/under/pants/nova/chaps/examine(mob/user)
	. = ..()
	. += span_notice("It can be [EXAMINE_HINT("ctrl+shift clicked")] to be worn as an accessory.")

/obj/item/clothing/under/pants/nova/chaps/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item != source) //Only works if held in-hand
		return .
	context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "Make attachable to uniform"
	return CONTEXTUAL_SCREENTIP_SET

/*
*	SHORTS
*/

/obj/item/clothing/under/shorts/nova/shorts_ripped
	name = "ripped shorts"
	desc = "A nondescript pair of tough jean shorts, with the ends of the pantlegs frayed and torn. No one will ever know if this was done intentionally."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shorts/nova/shorts_ripped"
	post_init_icon_state = "shorts_ripped"
	greyscale_config = /datum/greyscale_config/shorts_ripped //These configs are defined in the GAGS module for now; the icons and item will remain in these files.
	greyscale_config_worn = /datum/greyscale_config/shorts_ripped/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shorts_ripped/worn/digi
	greyscale_config_worn_teshari = /datum/greyscale_config/shorts_ripped/worn/teshari
	greyscale_colors = "#787878#723E0E#202020"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/shorts/nova/shortershorts
	name = "shorter shorts"
	desc = "Show those legs off with these even shorter shorts!"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/shorts/nova/shortershorts"
	post_init_icon_state = "shortershorts"
	greyscale_config = /datum/greyscale_config/shortershorts
	greyscale_config_worn = /datum/greyscale_config/shortershorts/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shortershorts/worn/digi
	greyscale_colors = "#787878#723E0E#202020"
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	MISC (Technically belongs in this file as a shorts/pants/shirt combo)
*	Here's hoping TG gives these their own typepath, but for now this is gonna be under/pants/nova. No, it's not all pants, but it's better than a whole new type
*/

/obj/item/clothing/under/pants/nova/kilt
	name = "recolorable kilt"
	desc = "A kilt and buttondown, adorned with a tartan sash. It is NOT a skirt."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/kilt"
	post_init_icon_state = "kilt"
	greyscale_config = /datum/greyscale_config/kilt
	greyscale_config_worn = /datum/greyscale_config/kilt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/kilt/worn/digi
	greyscale_colors = "#FFFFFF#365736#d9e6e5"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/pants/nova/vicvest //there's no way I'm typing out a path called double_breasted 10 times over, too complex and everyone will be scared of it
	name = "buttondown shirt with double-breasted vest"
	desc = "A fancy buttondown shirt with slacks and a vest worn overtop, with a second row of buttons. Truly an outdated fashion statement."
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/vicvest"
	post_init_icon_state = "buttondown_vicvest"
	greyscale_config = /datum/greyscale_config/buttondown_vicvest
	greyscale_config_worn = /datum/greyscale_config/buttondown_vicvest/worn
	greyscale_config_worn_digi = /datum/greyscale_config/buttondown_vicvest/worn/digi
	greyscale_colors = "#8b2c2c#222227#222227#fbc056"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1

/*
*	Shorts that were previously using nonmodular edits to add their greyscale data, pulled from code/modules/clothing/under/shorts.dm
*/

/obj/item/clothing/under/shorts
	greyscale_config_worn_digi = /datum/greyscale_config/shorts/worn/digi

/obj/item/clothing/under/shorts/jeanshorts
	greyscale_config_worn_digi = /datum/greyscale_config/jeanshorts/worn/digi

/*
*	Pants that were previously using nonmodular edits to add their greyscale data, pulled from code/modules/clothing/under/pants.dm
*/

/obj/item/clothing/under/pants/slacks
	greyscale_config_worn_digi = /datum/greyscale_config/slacks/worn/digi

/obj/item/clothing/under/pants/jeans
	greyscale_config_worn_digi = /datum/greyscale_config/jeans/worn/digi

/obj/item/clothing/under/pants/camo
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/camo"
	post_init_icon_state = "camopants"
	greyscale_config = /datum/greyscale_config/camo_pants
	greyscale_config_worn = /datum/greyscale_config/camo_pants/worn
	greyscale_config_worn_digi = /datum/greyscale_config/camo_pants/worn/digi
	greyscale_colors = "#69704C#6E5B4C#343741"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/pants/nova/shorted_overall
	name = "shortened overalls"
	desc = "A Shortened pair of denim overalls to show off your legs and adorability. The Clothing tag labeled 'DarkRilo Apperel'"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/pants/nova/shorted_overall"
	post_init_icon_state = "shorted_overall"
	greyscale_config = /datum/greyscale_config/overalls/shorted_overall
	greyscale_config_worn = /datum/greyscale_config/overalls/shorted_overall/worn
	greyscale_colors = "#cccccc"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE
