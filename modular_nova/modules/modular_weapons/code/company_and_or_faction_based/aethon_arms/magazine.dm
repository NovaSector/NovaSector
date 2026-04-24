// Magazine for the M-94 'Rapier' Submachinegun

/obj/item/ammo_box/magazine/rapier
	name = "M-94 'Rapier' magazine"
	desc = "A standard magazine for a M-94 'Rapier' Submachine Gun. Holds 30 rounds of ammunition."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/aethon_arms/ammo.dmi'
	icon_state = "burya"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = CALIBER_46X30MM
	max_ammo = 30
	custom_price = PAYCHECK_CREW * 2
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/rapier/empty
	start_empty = TRUE
