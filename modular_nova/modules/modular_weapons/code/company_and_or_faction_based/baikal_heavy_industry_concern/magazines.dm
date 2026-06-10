// .310 magazine for the Sokol rifle

/obj/item/ammo_box/magazine/sokol
	name = "\improper Sokol rifle magazine"
	desc = "A standard size magazine for Sokol rifles, holds twenty four rounds."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/baikal_heavy_industry_concern/ammo.dmi'
	icon_state = "sokol_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 24

/obj/item/ammo_box/magazine/sokol/spawns_empty
	start_empty = TRUE
