/obj/item/ammo_box/magazine/enforcer
	name = "\improper Enforcer magazine (10mm)"
	desc = "A robust magazine for a robust handgun."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/ammo.dmi'
	icon_state = "baypistol"
	base_icon_state = "baypistol"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	multiple_sprite_use_base = TRUE
	ammo_band_icon = "+baypistol_band"
	ammo_band_color = null

/obj/item/ammo_box/magazine/enforcer/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/enforcer/rubber
	name = "\improper Enforcer magazine (10mm rubber)"
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	desc = parent_type::desc + "<br>Carries rubber rounds, which are less-lethal, dealing primarily stamina damage.";
	ammo_band_color = COLOR_AMMO_RUBBER

/obj/item/ammo_box/magazine/enforcer/ap
	name = "\improper Enforcer magazine (10mm AP)"
	MAGAZINE_TYPE_ARMORPIERCE
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/enforcer/hp
	name = "\improper Enforcer magazine (10mm HP)"
	MAGAZINE_TYPE_HOLLOWPOINT
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/enforcer/fire
	name = "\improper Enforcer magazine (10mm incendiary)"
	MAGAZINE_TYPE_INCENDIARY
	ammo_type = /obj/item/ammo_casing/c10mm/fire
