// Modified .40 Sol rifle magazines to fit 12mm chinmoku

/obj/item/ammo_box/magazine/c12chinmoku
	name = "\improper Chinmoku short magazine"
	desc = "A shortened magazine for SolFed rifles, holds fifteen rounds. \
		This one has been modified to fit the dimensionally-close-enough 12mm Chinmoku casings. \
		A white line has been added to indicate you should not try using this in standard sol rifles."

	icon = 'modular_np_lethal/lethalguns/icons/ammo.dmi'
	icon_state = "rifle_short"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_TINY

	ammo_type = /obj/item/ammo_casing/c12chinmoku
	caliber = CALIBER_12MMCHINMOKU
	max_ammo = 15

/obj/item/ammo_box/magazine/c12chinmoku/starts_empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c12chinmoku/standard
	name = "\improper Chinmoku magazine"
	desc = "A standard size magazine for SolFed rifles, holds thirty rounds. \
		This one has been modified to fit the dimensionally-close-enough 12mm Chinmoku casings. \
		A white line has been added to indicate you should not try using this in standard sol rifles."

	icon_state = "rifle_standard"

	w_class = WEIGHT_CLASS_SMALL

	max_ammo = 30

/obj/item/ammo_box/magazine/c12chinmoku/standard/starts_empty
	start_empty = TRUE

// 12ga drum for the nomi semi-automatic shotgun

/obj/item/ammo_box/magazine/c12nomi
	name = "\improper Nomi 12ga drum"
	desc = "A large drum for the Nomi repeating shotgun that fits 12ga shotgun shells within. \
		Holds ten shells."

	icon = 'modular_np_lethal/lethalguns/icons/ammo.dmi'
	icon_state = "nomi_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 10

/obj/item/ammo_box/magazine/c12nomi/starts_empty
	start_empty = TRUE

// Magazines for the 8mm Marsian snipers

/obj/item/ammo_box/magazine/c8marsian
	name = "\improper Chokyu sniper magazine"
	desc = "A standard magazine for holding seven rounds of 8mm Marsian, usually for the Chokyu sniper rifle."

	icon = 'modular_np_lethal/lethalguns/icons/ammo.dmi'
	icon_state = "chokyu_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_SMALL

	ammo_type = /obj/item/ammo_casing/c8marsian
	caliber = CALIBER_8MMMARSIAN
	max_ammo = 7

/obj/item/ammo_box/magazine/c8marsian/starts_empty
	start_empty = TRUE

// Internal magazine for the fukiya double rifle

/obj/item/ammo_box/magazine/internal/c8marsian
	name = "8mm marsian over-under tubes"
	ammo_type = /obj/item/ammo_casing/c8marsian
	caliber = CALIBER_8MMMARSIAN
	max_ammo = 2
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/c8marsian/starts_empty
	start_empty = TRUE

// Internal shotgun tube for 6 gauge shotguns

/obj/item/ammo_box/magazine/internal/s6gauge
	name = "6 gauge shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/s6gauge
	caliber = CALIBER_6GAUGE
	max_ammo = 3
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/s6gauge/starts_empty
	start_empty = TRUE
