/obj/item/ammo_box/magazine/m12g/empty
	name = "shotgun magazine (12g)"
	icon_state = "m12gb-0"
	start_empty = TRUE
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/katyusha/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"
/obj/item/ammo_box/magazine/katyusha/empty
	name = "Katyusha Drum Magazine (12g shells)"
	desc = "A drum magazine of shotgun shells, suitable for the c combat shotgun."
	icon_state = "spikewall_mag-empty"
	ammo_type = /obj/item/ammo_casing/shotgun
	start_empty = TRUE
	casing_phrasing = "shell"

/obj/item/ammo_box/magazine/katyusha
	name = "Katyusha Drum Magazine"
	desc = "A drum magazine of shotgun shells, suitable for the Katyusha combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	icon_state = "spikewall_mag"
	base_icon_state = "spikewall_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 16
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/katyusha/buckshot
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/marauder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"

/obj/item/ammo_box/magazine/jager/empty
	icon_state = "marauder_mag-empty"
	ammo_type = /obj/item/ammo_casing/shotgun
	start_empty = TRUE
	casing_phrasing = "shell"

/obj/item/ammo_box/magazine/jager
	name = "Jäger Magazine"
	desc = "A magazine of shotgun shells, suitable for the 'Jäger' combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	icon_state = "marauder_mag"
	base_icon_state = "marauder_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 8
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/jager/rubbershot

	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/jager/large
	name = "Large Jäger Magazine"
	desc = "A magazine of shotgun shells, suitable for the 'Jager' combat shotgun."
	icon_state = "marauder_mag_large"
	base_icon_state = "marauder_mag_large"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 12
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/jager/large/empty
	icon_state = "marauder_mag-empty"
	ammo_type = /obj/item/ammo_casing/shotgun
	start_empty = TRUE
	casing_phrasing = "shell"
