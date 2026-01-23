/obj/item/ammo_box/magazine/m9mm
	icon = 'modular_nova/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 4)]"

/obj/item/ammo_box/magazine/m10mm
	icon_state = "10mm_p"
	base_icon_state = "10mm_p"
	ammo_band_icon = "+10mm_p-ab"
	icon = 'modular_nova/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m10mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"
