
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

/obj/item/clothing/accessory/nova/acc_medal/neckpin/centcomm
	name = "\improper Central Command neckpin"
	icon_state = "/obj/item/clothing/accessory/nova/acc_medal/neckpin/centcomm"
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
