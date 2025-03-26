/obj/item/crusher_trophy/retool_kit/ahab
	name = "crusher Ahab's harpoon retool kit"
	desc = "A toolkit for changing the crusher's appearance without affecting the device's function. This one will make it look like Ahab's harpoon, the weapon of legends."
	denied_type = /obj/item/crusher_trophy/retool_kit
	icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	icon_state = "ahab_retool"
	retool_icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	retool_icon_state = "crusher_ahab"
	retool_inhand_icon = "crusher_ahab"
	retool_projectile_icon = "ahabprojectile"
	retool_projectile_icon_file = 'modular_nova/modules/ahabs_spear/icons/projectiles.dmi'
	retool_lefthand_file = 'modular_nova/modules/ahabs_spear/icons/l_hand_ahab.dmi'
	retool_righthand_file = 'modular_nova/modules/ahabs_spear/icons/r_hand_ahab.dmi'

/obj/item/crusher_trophy/retool_kit/ahab/effect_desc()
	return "the crusher to have the appearance of the weapon of legends, Ahab's Harpoon"

/obj/item/crusher_trophy/retool_kit/ahab/add_to(obj/item/kinetic_crusher/pkc, mob/user)
	. = ..()
	pkc.worn_icon = 'modular_nova/modules/ahabs_spear/icons/back.dmi'

/obj/item/crusher_trophy/retool_kit/ahab/remove_from(obj/item/kinetic_crusher/pkc)
	. = ..()
	pkc.worn_icon = initial(pkc.worn_icon)
