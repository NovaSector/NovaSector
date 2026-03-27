// ITEMS

/obj/item/modular_computer/pda/interdyne
	name = "Interdyne PDA"
	greyscale_config = /datum/greyscale_config/tablet/stripe_thick
	greyscale_colors = "#1A1A1A#1B5E20#2E8B57"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	device_theme = PDA_THEME_TERMINAL
	saved_identification = "Interdyne Employee"

/obj/item/modular_computer/pda/interdyne/Initialize(mapload)
	. = ..()
	var/datum/computer_file/program/messenger/msg = locate() in stored_files
	if(msg)
		msg.invisible = TRUE

/obj/item/gun/energy/laser/pistol/interdyne
	name = "\improper Interdyne LP-3 laser pistol"
	desc = "A compact laser pistol rebranded by Interdyne Pharmaceuticals for facility defense. \
		The casing has been refinished in corporate green. 'Property of IP — Do Not Remove From Premises' is etched on the grip."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_pistol.dmi'
	icon_state = "interdyne_pistol"
	base_icon_state = "interdyne_pistol"
	inhand_icon_state = "interdyne_pistol"
	lefthand_file = 'modular_nova/modules/interdyne/icons/interdyne_pistol_lefthand.dmi'
	righthand_file = 'modular_nova/modules/interdyne/icons/interdyne_pistol_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/radio/headset/interdyne
	name = "\improper Interdyne headset"
	desc = "A bowman headset with a large red cross on the earpiece, has a small 'IP' written on the top strap. Protects the ears from flashbangs."
	icon_state = "syndie_headset"
	inhand_icon_state = null
	radio_talk_sound = 'modular_nova/modules/radiosound/sound/radio/syndie.ogg'
	keyslot = new /obj/item/encryptionkey/headset_syndicate/interdyne
