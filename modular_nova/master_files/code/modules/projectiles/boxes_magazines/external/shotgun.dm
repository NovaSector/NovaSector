/obj/item/ammo_box/magazine/m12g/empty
	name = "shotgun magazine (12g)"
	icon_state = "m12gb-0"
	start_empty = TRUE
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/katyusha/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"

/obj/item/ammo_box/magazine/katyusha/empty
	icon_state = "spikewall_mag-empty"
	start_empty = TRUE

/obj/item/ammo_box/magazine/katyusha
	name = "\improper Katyusha Drum Magazine"
	desc = "A drum magazine of shotgun shells, suitable for the Katyusha combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	icon_state = "spikewall_mag"
	base_icon_state = "spikewall_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 10
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/katyusha/buckshot
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/magazine/jager/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[LAZYLEN(stored_ammo) ? "full" : "empty"]"

/obj/item/ammo_box/magazine/jager/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/jager
	name = "\improper Jäger Magazine"
	desc = "A magazine of shotgun shells, suitable for the 'Jäger' combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armouries/magazines.dmi'
	icon_state = "marauder_mag"
	base_icon_state = "marauder_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 7

/obj/item/ammo_box/magazine/jager/rubbershot
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/jager/large
	name = "large Jäger Magazine"
	desc = "A magazine of shotgun shells, suitable for the 'Jager' combat shotgun."
	icon_state = "marauder_mag_large"
	base_icon_state = "marauder_mag_large"
	max_ammo = 9

/obj/item/ammo_box/magazine/jager/large/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/shitzu/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/shitzu
	name = "\improper Shitzu Shotgun Magazine"
	desc = "A magazine of shotgun shells, suitable for the 'Shitzu' combat shotgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/syndicate_armaments/magazines.dmi'
	icon_state = "shitzu_mag"
	base_icon_state = "shitzu_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 10
	casing_phrasing = "shell"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/shitzu/milspec
	ammo_type = /obj/item/ammo_casing/shotgun/milspec
