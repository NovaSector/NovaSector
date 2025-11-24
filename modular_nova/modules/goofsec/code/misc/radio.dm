/*
	Encryption Keys
*/

/obj/item/encryptionkey/headset_solfed/headset_solfed
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	icon = 'icons/map_icons/items/_item.dmi'

/obj/item/encryptionkey/headset_solfed/atmos
	name = "\improper SolFed adv. atmos encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/atmos"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/sec
	name = "\improper SolFed adv. Security encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/sec"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/med
	name = "\improper SolFed adv. Medical encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/med"
	post_init_icon_state = "cypherkey_medical"
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

/obj/item/encryptionkey/headset_solfed/squadleader
	name = "\improper SolFed grand encryption key"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1, RADIO_CHANNEL_COMMAND = 1)
	icon_state = "/obj/item/encryptionkey/headset_solfed/squadleader"
	post_init_icon_state = "cypherkey_syndicate"
	greyscale_config = /datum/greyscale_config/encryptionkey_syndicate
	greyscale_colors = "#ebebeb#2b2793"

/*
	Headsets
*/

/obj/item/radio/headset/headset_solfed/atmos
	name = "\improper SolFed adv. atmos headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos

/obj/item/radio/headset/headset_solfed/sec
	name = "\improper SolFed adv. Security headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/sec

/obj/item/radio/headset/headset_solfed/med
	name = "\improper SolFed adv. Medical headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/med

/obj/item/radio/headset/headset_solfed/officials
	name = "\improper SolFed Officials Headset"
	icon_state = "com_headset"
	worn_icon_state = "com_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader

/obj/item/radio/headset/headset_solfed/espatier
	name = "\improper SolFed Espatier headset"
	desc = "A headset used by the Solar Federation espatiers."
	icon_state = "com_headset_alt"
	worn_icon_state = "com_headset_alt"
	keyslot = /obj/item/encryptionkey/headset_solfed/sec

/obj/item/radio/headset/headset_solfed/espatier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_solfed/espatier/corpsman
	name = "\improper Solfed Espatier Corpsman Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/med

/obj/item/radio/headset/headset_solfed/espatier/engineer
	name = "\improper Solfed Espatier Engineer Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos

/obj/item/radio/headset/headset_solfed/espatier/squadleader
	name = "\improper Solfed Espatier Squadleader Headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/squadleader
