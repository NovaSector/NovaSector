/obj/item/ammo_box/magazine/m12g/empty
	name = "shotgun magazine (12g)"
	icon_state = "m12gb-0"
	start_empty = TRUE
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/spikewall/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"
/obj/item/ammo_box/magazine/spikewall/empty
	name = "shotgun magazine (12g buckshot shells)"
	desc = "A drum magazine of shotgun shells, suitable for the c combat shotgun."
	icon_state = "spikewall_mag-empty"
	ammo_type = /obj/item/ammo_casing/shotgun
	start_empty = TRUE
	casing_phrasing = "shell"

/obj/item/ammo_box/magazine/spikewall
	name = "Spikewall Drum Magazine"
	desc = "A drum magazine of shotgun shells, suitable for the Spikewall combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	icon_state = "spikewall_mag"
	base_icon_state = "spikewall_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 16
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
