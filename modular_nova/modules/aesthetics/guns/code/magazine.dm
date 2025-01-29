/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9x25mm)"
	icon = 'modular_nova/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 4)]"
