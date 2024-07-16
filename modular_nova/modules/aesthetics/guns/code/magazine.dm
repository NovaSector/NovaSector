/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9x25mm)"
	multiple_sprites = AMMO_BOX_PER_BULLET
	icon = 'modular_nova/modules/aesthetics/guns/icons/magazine.dmi'


//SP-8 fortynr mag
/obj/item/ammo_box/magazine/sp8
	name = "handgun magazine 40N&R"
	icon = "modular_nova/modules/aesthetics/guns/icons/magazine.dmi"
	icon_state = "sp8mag-10"
	base_icon_state = "sp8mag"
	ammo_type = /obj/item/ammo_casing/fortynr
	caliber = CALIBER_40NR
	max_ammo = 10
	multiple_sprite_use_base = TRUE

/obj/item/ammo_box/magazine/sp8/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"


/datum/design/fortynr
	name = "40nr magazine (Lethal)"
	desc = "Magazine designed for SP-8 pistol. Bullets have good stopping power."
	id = "fortynr"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	build_path = /obj/item/ammo_box/magazine/sp8
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
