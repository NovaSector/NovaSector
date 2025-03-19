/obj/item/crusher_trophy/retool_kit/ahab
	name = "crusher ahabs harpoon retool kit"
	desc = "A toolkit for changing the crusher's appearance without affecting the device's function. This one will make it look like ahab's harpoon, the weapon of legends."
	denied_type = /obj/item/crusher_trophy/retool_kit
	icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	icon_state = "ahab_retool"
	retool_icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	retool_icon_state = "crusher_ahab"
	retool_inhand_icon = "crusher_ahab"
	retool_projectile_icon = "ahabprojectile" // stored in icons/obj/weapons/guns/projectiles.dmi
	retool_lefthand_file = 'modular_nova/modules/ahabs_spear/icons/l_hand_ahab.dmi'
	retool_righthand_file = 'modular_nova/modules/ahabs_spear/icons/r_hand_ahab.dmi'
	retool_inhand_x = 32
	retool_inhand_y = 32

/obj/item/crusher_trophy/retool_kit/ahab/effect_desc()
	return "the crusher to have the appearance of the weapon of legends, Ahab's Harpoon"
