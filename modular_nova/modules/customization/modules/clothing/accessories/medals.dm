
/*
Greyscaled Medals

Highly modular and customizable spriteset.
Just a note - the .jsons will NOT agree with having different amounts of components per icon.
Use the 'blank' icon to keep the medals all sorted in their correct file,
even if they have different numbers of components.

Potential future ideas:
- Tie to job hours
- Unlock in Loadout when a requirement is met (i.e. job hours, as above)
- Department medals (adding to TG's existing medal lockboxes)
*/

/*
// AWARDABLE MEDALS
// These can be pinned onto others to 'award' them, appearing in the round-end screen
*/
/obj/item/clothing/accessory/medal/nova
	name = "debug medal"
	desc = "You shouldn't have this, make a bug report!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/medal/nova"
	post_init_icon_state = "barmedal_barribbon" //Makes a pink-black error icon
	greyscale_config = /datum/greyscale_config/medals
	greyscale_config_worn = /datum/greyscale_config/medals
	greyscale_colors = "#FF00DC#000000#FF00DC#000000#000000#000000"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/*
// ACCESSORY MEDALS
// These ones are purely cosmetic attachments
*/
/obj/item/clothing/accessory/nova/acc_medal
	name = "debug medal"
	desc = "You shouldn't have this, make a bug report!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal"
	post_init_icon_state = "barmedal_barribbon" //Makes a pink-black error icon
	greyscale_config = /datum/greyscale_config/medals
	greyscale_config_worn = /datum/greyscale_config/medals
	greyscale_colors = "#FF00DC#000000#FF00DC#000000#000000#000000"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/*
// Shield Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/shield
	name = "shield medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/shield"
	post_init_icon_state = "ccmedal"
	greyscale_config = /datum/greyscale_config/medals/shield
	greyscale_config_worn = /datum/greyscale_config/medals/shield/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"

/obj/item/clothing/accessory/nova/acc_medal/shield/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/shield/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/nova/acc_medal/shield/hollow
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/shield/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Bar Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/bar
	name = "bar medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/bar"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/bar
	greyscale_config_worn = /datum/greyscale_config/medals/bar/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"

/obj/item/clothing/accessory/nova/acc_medal/bar/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/bar/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/nova/acc_medal/bar/hollow
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/bar/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Circle Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/circle
	name = "circle medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/circle"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/circle
	greyscale_config_worn = /datum/greyscale_config/medals/circle/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"

/obj/item/clothing/accessory/nova/acc_medal/circle/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/circle/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/circle/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/nova/acc_medal/circle/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/circle/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Heart Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/heart
	name = "heart medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/heart"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/heart
	greyscale_config_worn = /datum/greyscale_config/medals/heart/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"

/obj/item/clothing/accessory/nova/acc_medal/heart/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/heart/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/nova/acc_medal/heart/special
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/heart/special"
	post_init_icon_state = "medal_special"

/obj/item/clothing/accessory/nova/acc_medal/heart/special/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/heart/special/bar_ribbon"
	post_init_icon_state = "medal_special_bar_ribbon"

/*
// Crown Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/crown
	name = "crown medal"
	desc = "A regular everyday medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/crown"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/crown
	greyscale_config_worn = /datum/greyscale_config/medals/crown/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"

/obj/item/clothing/accessory/nova/acc_medal/crown/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/crown/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/crown/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/nova/acc_medal/crown/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/crown/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Special Medals
*/
/obj/item/clothing/accessory/nova/acc_medal/glowbar
	name = "glowbar necklace"
	desc = "A glowing rock strung from a necklace, a token of gratitude similar to a medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/glowbar"
	post_init_icon_state = "bar"
	greyscale_config = /datum/greyscale_config/medals/glow
	greyscale_config_worn = /datum/greyscale_config/medals/glow/worn
	greyscale_colors = "#ff99ff"

/obj/item/clothing/accessory/nova/acc_medal/glowcrystal
	name = "glowcrystal necklace"
	desc = "A glowing rock strung from a necklace, a token of gratitude similar to a medal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/glowcrystal"
	post_init_icon_state = "crystal"
	greyscale_config = /datum/greyscale_config/medals/glow
	greyscale_config_worn = /datum/greyscale_config/medals/glow/worn
	greyscale_colors = "#ff99ff"

/*
// Rank pins
*/
/obj/item/clothing/accessory/nova/acc_medal/rankpin
	name = "Rank Pin"
	desc = "A pin used to display accomplishments, advancements, or otherwise earned recognition."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/rankpin"
	post_init_icon_state = "star"
	greyscale_config = /datum/greyscale_config/medals/rank_pins
	greyscale_config_worn = /datum/greyscale_config/medals/rank_pins/worn
	greyscale_colors = "#FFFFFF"

/obj/item/clothing/accessory/nova/acc_medal/rankpin/bar
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/rankpin/bar"
	post_init_icon_state = "bar"

/obj/item/clothing/accessory/nova/acc_medal/rankpin/two_bar
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/rankpin/two_bar"
	post_init_icon_state = "two_bar"

/*
// Neckpins
*/
/obj/item/clothing/accessory/nova/acc_medal/neckpin
	name = "\improper NT company neckpin"
	desc = "A pin specially dedicated to show loyalty to your company!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin"
	post_init_icon_state = "ntpin"
	greyscale_config = /datum/greyscale_config/medals/neckpins
	greyscale_config_worn = /datum/greyscale_config/medals/neckpins/worn
	greyscale_colors = "#FFFFFF#CCCED1"
	minimize_when_attached = TRUE
	attachment_slot = NONE

/obj/item/clothing/accessory/nova/acc_medal/neckpin/centcom
	name = "\improper Central Command neckpin"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/centcom"
	post_init_icon_state = "ccpin"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed
	name = "\improper Solfed neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed"
	post_init_icon_state = "sfpin"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed911
	name = "\improper Solfed 911 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed911"
	post_init_icon_state = "911pin"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed811
	name = "\improper Solfed 811 neckpin"
	desc = "A pin specially dedicated to show loyalty to your federation!"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/solfed811"
	post_init_icon_state = "811pin"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/syndicate
	name = "\improper Syndicate neckpin"
	desc = "A pin specially dedicated to show loyalty to the Syndicate!"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/syndicate"
	post_init_icon_state = "syndipin"
	greyscale_colors = "#262626#9c0000"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/interdyne
	name = "\improper Interdyne neckpin"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/interdyne"
	post_init_icon_state = "ippin"
	greyscale_colors = "#FFFFFF#3aba1e"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/porttarkon
	name = "\improper Port Tarkon neckpin"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/porttarkon"
	post_init_icon_state = "ptpin"
