// .310 magazine for the Lanca rifle

/obj/item/ammo_box/magazine/lanca
	name = "\improper Lanca rifle magazine"
	desc = "A standard size magazine for Lanca rifles, holds ten rounds."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "lanca_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 10

/obj/item/ammo_box/magazine/lanca/spawns_empty
	start_empty = TRUE

// Magazine for the Miecz submachinegun

/obj/item/ammo_box/magazine/miecz
	name = "\improper Miecz submachinegun magazine"
	desc = "A standard size magazine for Miecz submachineguns, holds twenty eight rounds."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "miecz_mag"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	caliber = CALIBER_CESARZOWA
	max_ammo = 28

/obj/item/ammo_box/magazine/miecz/spawns_empty
	start_empty = TRUE

// Magazine for the Napad submachine gun

/obj/item/ammo_box/magazine/napad
	name = "\improper Napad submachinegun magazine"
	desc = "A massive magazine for the Napadayuschiy Submachine gun. Holds fifty rounds of 10mm ammunition."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "napad_mag"

	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 50

/obj/item/ammo_box/magazine/napad/spawns_empty
	start_empty = TRUE

// Plasma thrower 'magazine'

/obj/item/ammo_box/magazine/recharge/plasma_battery
	name = "plasma power pack"
	desc = "A rechargeable, detachable battery that serves as a power source for plasma projectors."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	base_icon_state = "plasma_battery"
	icon_state = "plasma_battery"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/energy/laser/plasma_glob
	caliber = CALIBER_LASER
	max_ammo = 15

/obj/item/ammo_box/magazine/recharge/plasma_battery/update_icon_state() // FUCK YOU /OBJ/ITEM/AMMO_BOX/MAGAZINE/RECHARGE
	. = ..()
	icon_state = base_icon_state

// Shotgun revolver's cylinder

/obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	name = "\improper 12 GA revolver cylinder"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 4
	multiload = FALSE

// AMR magazine

/obj/item/ammo_box/magazine/wylom
	name = "anti-materiel magazine (.60 Strela)"
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "wylom_mag"
	base_icon_state = "wylom_mag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/p60strela
	max_ammo = 3
	caliber = CALIBER_60STRELA

// Magazine for the Zashch pistol

/obj/item/ammo_box/magazine/zashch
	name = "\improper Zashch pistol magazine"
	desc = "A large magazine for the Zashchitnik pistol. Holds 18 rounds of 10mm."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "zashch_mag"
	base_icon_state = "zashch_mag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 18
	caliber = CALIBER_10MM

/obj/item/ammo_box/magazine/zashch/spawns_empty
	start_empty = TRUE
