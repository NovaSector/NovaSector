/obj/item/clothing/under/rank/captain
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/command_digi.dmi'
	//NOTE - TG uses "captain.dmi"; because we have a few non-captain items going in here for ease of access, this will just be "command.dmi"

/obj/item/clothing/under/rank/captain/nova
	icon = 'modular_nova/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/command.dmi'

/*
*	CAPTAIN
*/

/obj/item/clothing/under/rank/captain/nova/kilt
	name = "captain's kilt"
	desc = "A midnight blue kilt, padded with nano-kevlar and adorned with gold and a tartan sash."
	icon_state = "capkilt"

/obj/item/clothing/under/imperial/captain
	name = "captain's naval jumpsuit"
	desc = "A white naval suit adorned with a gold rank badge denoting a Captain. There are two ways to destroy a person, kill him, or ruin his reputation."
	icon_state = "/obj/item/clothing/under/imperial/captain"
	greyscale_colors = "#eeeeee#eeeeee#eeeeee#373741#FFCE5B#FFCE5B#FFCE5B"
	flags_1 = NONE
	armor_type = /datum/armor/clothing_under/rank_captain

/obj/item/clothing/under/imperialskirt/captain
	name = "captain's naval skirt"
	desc = "A white naval suit adorned with a gold rank badge denoting a Captain. There are two ways to destroy a person, kill him, or ruin his reputation."
	greyscale_colors = "#eeeeee#eeeeee#373741#FFCE5B#FFCE5B#FFCE5B"
	icon_state = "/obj/item/clothing/under/imperialskirt/captain"
	flags_1 = NONE
	armor_type = /datum/armor/clothing_under/rank_captain

//Donor item for Gandalf - all donors have access
/obj/item/clothing/under/rank/captain/nova/black
	name = "captain's black suit"
	desc = "A very sleek, albeit outdated, naval captain's uniform for those who think they're commanding a battleship."
	icon_state = "captainblacksuit"
	can_adjust = FALSE

/*
*	BLUESHIELD
*/
//Why is this in command.dm? Simple: Centcom.dmi will already be packed with CC/NTNavy/AD/LL/SOL/FTU - all of them more event-based clothes, while this will appear
//on-station often.

/obj/item/clothing/under/rank/blueshield
	icon = 'modular_nova/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/command_digi.dmi'
	name = "blueshield's suit"
	desc = "A classic bodyguard's suit, with custom-fitted Blueshield-Blue cuffs and a Nanotrasen insignia over one of the pockets."
	icon_state = "blueshield"
	strip_delay = 50
	armor_type = /datum/armor/clothing_under/rank_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	alt_covers_chest = TRUE

/datum/armor/clothing_under/rank_blueshield
	melee = 10
	bullet = 5
	laser = 5
	energy = 10
	bomb = 10
	fire = 50
	acid = 50

/obj/item/clothing/under/rank/blueshield/skirt
	name = "blueshield's suitskirt"
	desc = "A classic bodyguard's suitskirt, with custom-fitted Blueshield-Blue cuffs and a Nanotrasen insignia over one of the pockets."
	icon_state = "blueshieldskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/turtleneck
	name = "blueshield's turtleneck"
	desc = "A tactical jumper fit for only the best of bodyguards, with plenty of tactical pockets for your tactical needs."
	icon_state = "bs_turtleneck"

/obj/item/clothing/under/rank/blueshield/turtleneck/skirt
	name = "blueshield's skirtleneck"
	desc = "A tactical jumper fit for only the best of bodyguards - instead of tactical pockets, this one has a tactical lack of leg protection."
	icon_state = "bs_skirtleneck"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/consult
	name = "blueshield's consulting suit"
	desc = "A not so tactical uniform, held up to a greater standard of care by the company, tailored to be fancy with its golden trims matching that of the Nanotrasen Consultant. A symbol of unity, cohesion, and an annoyingly massive amount of paperwork."
	icon_state = "bs_consult"

/obj/item/clothing/under/rank/blueshield/consult/skirt
	name = "blueshield's consulting skirt"
	icon_state = "bs_consult_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/blueshield/russian
	name = "blueshield's sweatsuit"
	desc = "An older styled jumpsuit meant for military application by soldiers, still plenty useful nowadays, dyed and seamed to newer NT standards."
	icon_state = "bs_rus"
	can_adjust = FALSE

/obj/item/clothing/under/rank/blueshield/formal
	name = "blueshield's formal uniform"
	desc = "A budget efficient uniform, making yourself stand out from others yet not drawing too much attention."
	icon_state = "bs_formal"

/obj/item/clothing/under/imperialvest/blueshield
	name = "blueshield's naval skirt"
	desc = "An upper level uniform granted to shields alike, representing CentCom's grand naval fleet."
	icon_state = "/obj/item/clothing/under/imperialvest/bs"
	greyscale_colors = "#363740#363740#3c485a#373741#bbbbbb#21212B#bbbbbb#bbbbbb"
	flags_1 = NONE
	armor_type = /datum/armor/clothing_under/rank_blueshield

/obj/item/clothing/under/imperialskirtvest/blueshield
	name = "blueshield's naval skirt"
	desc = "An upper level uniform granted to shields alike, representing CentCom's grand naval fleet."
	greyscale_colors = "#363740#3c485a#373741#bbbbbb#21212B#bbbbbb#bbbbbb"
	icon_state = "/obj/item/clothing/under/imperialskirtvest/bs"
	flags_1 = NONE
	armor_type = /datum/armor/clothing_under/rank_blueshield

/*
*	NT CONSULTANT
*/
//See Blueshield note - tl;dr, this role is a station role, while Centcom.dmi is more event roles

/obj/item/clothing/under/rank/nanotrasen_consultant
	icon = 'modular_nova/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/command_digi.dmi'
	desc = "It's a green jumpsuit with some gold markings denoting the rank of \"Nanotrasen Consultant\"."
	name = "nanotrasen consultant's jumpsuit"
	icon_state = "nt_consultant"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/nanotrasen_consultant/skirt
	name = "nanotrasen consultant's jumpskirt"
	desc = "It's a green jumpskirt with some gold markings denoting the rank of \"Nanotrasen Consultant\"."
	icon_state = "nt_consultant_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/imperial/nanotrasen_consultant
	name = "nanotrasen consultant's naval uniform"
	desc = "An upper level uniform granted to consultants and representatives alike, representing CentCom's grand naval fleet."
	icon_state = "/obj/item/clothing/under/imperial/nanotrasen_consultant"
	greyscale_colors = "#54a57e#54a57e#47464e#373741#ffce5b#ffce5b#f2b050"
	flags_1 = NONE

/obj/item/clothing/under/imperialskirt/nanotrasen_consultant
	name = "nanotrasen consultant's naval skirt"
	desc = "An upper level uniform granted to consultants and representatives alike, representing CentCom's grand naval fleet."
	greyscale_colors = "#54a57e#47464e#373741#ffce5b#ffce5b#f2b050"
	icon_state = "/obj/item/clothing/under/imperialskirt/nanotrasen_consultant"
	flags_1 = NONE

/*
*	Bridge Officer
*/

/obj/item/clothing/under/rank/bridge_officer
	name = "bridge officer's jumpsuit"
	desc = "It's a blue jumpsuit with silver markings denoting the rank of \"Bridge Officer\"."
	icon_state = "bo_uniform"
	icon = 'modular_nova/master_files/icons/obj/clothing/under/command.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/under/command.dmi'
	worn_icon_digi = 'modular_nova/master_files/icons/mob/clothing/under/command_digi.dmi'
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/bridge_officer/skirt
	name = "bridge officer's jumpskirt"
	desc = "It's a blue jumpskirt with silver markings denoting the rank of \"Bridge Officer\"."
	icon_state = "bo_skirt"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/bridge_officer/turtle
	name = "bridge officer's turtleneck"
	desc = "It's a blue turtleneck with silver markings denoting the rank of \"Bridge Officer\"."
	icon_state = "bo_turtleneck"

/obj/item/clothing/under/rank/bridge_officer/turtle/skirt
	name = "bridge officer's skirtleneck"
	desc = "It's a blue skirtleneck with silver markings denoting the rank of \"Bridge Officer\"."
	icon_state = "bo_skirtleneck"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/imperial/bridge_officer
	name = "bridge officer's naval uniform"
	desc = "An \"upper\" level uniform granted to bridge attendants. You did clear your internship, right?"
	icon_state = "/obj/item/clothing/under/imperial/bridge_officer"
	greyscale_colors = "#41579a#41579a#3b3c3f#373741#ccced1#41579a#ccced1"
	flags_1 = NONE

/obj/item/clothing/under/imperialskirt/bridge_officer
	name = "bridge officer's naval skirt"
	desc = "An \"upper\" level uniform granted to bridge attendants. You did clear your internship, right?"
	greyscale_colors = "#41579a#3b3c3f#373741#ccced1#41579a#ccced1"
	icon_state = "/obj/item/clothing/under/imperialskirt/bridge_officer"
	flags_1 = NONE

/*
*	UNASSIGNED (Any head of staff)
*/

/obj/item/clothing/under/rank/captain/nova/utility
	name = "command utility uniform"
	desc = "A utility uniform worn by Station Command."
	icon_state = "util_com"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/captain/nova/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/imperial
	desc = "A naval uniform, with a rank badge denoting an Officer. Doesn't protect against blaster fire."
	name = "officer's naval jumpsuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#A49C9C#A49C9C#A49C9C#373741#FFFFFF#FFFFFF#FFFFFF"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/imperial"
	post_init_icon_state = "officersnaval"
	greyscale_config = /datum/greyscale_config/officersnaval
	greyscale_config_worn = /datum/greyscale_config/officersnaval/worn
	greyscale_config_worn_digi = /datum/greyscale_config/officersnaval/worn/digi
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/imperialskirt
	desc = "A naval skirt, with a rank badge denoting an Officer. Doesn't protect against blaster fire."
	name = "officer's naval jumpskirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#A49C9C#A49C9C#373741#FFFFFF#FFFFFF#FFFFFF"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/imperialskirt"
	post_init_icon_state = "officersnavalskirt"
	greyscale_config = /datum/greyscale_config/officersnavalskirt
	greyscale_config_worn = /datum/greyscale_config/officersnavalskirt/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/imperialvest
	post_init_icon_state = "officersnavalvest"
	greyscale_colors = "#39393f#39393f#39393f#373741#FFFFFF#21212B#f8d860#a52f29"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	greyscale_config = /datum/greyscale_config/officersnavalvest
	greyscale_config_worn = /datum/greyscale_config/officersnavalvest/worn
	greyscale_config_worn_digi = /datum/greyscale_config/officersnavalvest/worn/digi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION | CLOTHING_BIG_LEGS_MASK
	armor_type = /datum/armor/clothing_under/security_head_of_security
	can_adjust = FALSE

/obj/item/clothing/under/imperialskirtvest
	post_init_icon_state = "officersnavalskirtvest"
	greyscale_colors = "#39393f#39393f#373741#FFFFFF#21212B#f8d860#a52f29"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	greyscale_config = /datum/greyscale_config/officersnavalskirtvest
	greyscale_config_worn = /datum/greyscale_config/officersnavalskirtvest/worn
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/clothing_under/security_head_of_security
	can_adjust = FALSE

/obj/item/clothing/under/imperial/red
	name = "red naval jumpsuit"
	desc = "A generic red naval jumpsuit with rank badges pinned to it's chest."
	icon_state = "/obj/item/clothing/under/imperial/red"
	greyscale_colors = "#C12E24#C12E24#C12E24#373741#FFFFFF#2979CD#2979CD"
	flags_1 = NONE

/*
*	MISC
*/

/obj/item/clothing/under/rank/captain/nova/pilot
	name = "shuttle pilot's jumpsuit"
	desc = "It's a blue jumpsuit with some silver markings denoting the wearer as a certified pilot."
	icon_state = "pilot"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/nova/pilot/skirt
	name = "shuttle pilot's jumpskirt"
	desc = "It's a blue jumpskirt with some silver markings denoting the wearer as a certified pilot."
	icon_state = "pilot_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
