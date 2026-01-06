
/datum/atom_skin/crusher_skin/locked/ahabs_harpoon
	new_name = "Ahab's harpoon"
	preview_name = "Ahab's harpoon"
	new_icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	new_icon_state = "crusher_ahab"
	new_inhand_icon_state = "crusher_ahab"
	new_projectile_icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	new_projectile_icon_state = "crusher_ahab"
	new_inhand_icon_state = "crusher_ahab"
	new_projectile_icon = 'modular_nova/modules/ahabs_spear/icons/projectiles.dmi'
	new_projectile_icon_state = "ahabprojectile"
	new_lefthand_file = 'modular_nova/modules/ahabs_spear/icons/l_hand_ahab.dmi'
	new_righthand_file = 'modular_nova/modules/ahabs_spear/icons/r_hand_ahab.dmi'
	new_worn_icon = 'modular_nova/modules/ahabs_spear/icons/back.dmi'

/obj/item/crusher_trophy/retool_kit/ahab
	name = "Ahab's harpoon retool kit"
	desc = "A toolkit for changing the crusher's appearance without affecting the device's function. This one will make it look like Ahab's harpoon, the weapon of legends."
	icon = 'modular_nova/modules/ahabs_spear/icons/ahabs_spear.dmi'
	icon_state = "ahab_retool"
	forced_skin = /datum/atom_skin/crusher_skin/locked/ahabs_harpoon

/obj/item/crusher_trophy/retool_kit/ahab/effect_desc()
	return "the crusher to have the appearance of the weapon of legends, Ahab's Harpoon"
