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
	desc = "A massive magazine for the Napadayuschiy submachine gun. Holds fifty rounds of 10mm ammunition."

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
	desc = "A rechargeable, detachable battery that serves as a power source for plasma projectors. \
		The casing reads \"Heating advised when battery is low. Do not microwave.\" "
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	base_icon_state = "plasma_battery"
	icon_state = "plasma_battery"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/energy/laser/plasma_glob
	caliber = CALIBER_LASER
	max_ammo = 15
	/// anti-cheese cooldown
	COOLDOWN_DECLARE(recharge_cooldown)

/obj/item/ammo_box/magazine/recharge/plasma_battery/update_icon_state() // FUCK YOU /OBJ/ITEM/AMMO_BOX/MAGAZINE/RECHARGE
	. = ..()
	icon_state = base_icon_state

/obj/item/ammo_box/magazine/recharge/plasma_battery/update_desc() //No, It does not have 0 shots left.
	. = ..()
	desc = initial(desc) // FUCK YOU /OBJ/ITEM/AMMO_BOX/MAGAZINE/RECHARGE WE HAVE EXAMINE TEXT THAT ACTUALLY DOES AMMO COUNTING

/obj/item/ammo_box/magazine/recharge/plasma_battery/examine_more(mob/user)
	. = ..()

	. += "The Mark-2 Energy Cells for plasma-based weaponry are a unique combination of neccessity and ingenuity. \
		Using an inner sleeve of quartz and cupronickel, these cells are capable of absorbing thermal energy and converting it \
		into electric potential through thermal expansion and piezo-electricity. While the capacity of shots are quite low, \
		this is due to plasma guns requirement to burn small amounts of material inside a compressed medium. \
		The results are often viscious burns on contacted skin, though travel often cools it too much for punching through armor."

	return .

/obj/item/ammo_box/magazine/recharge/plasma_battery/fire_act(exposed_temperature, exposed_volume) //if exposed to heat hot enough to burn, recharge. gives innate fire/lavaproofing
	if(length(stored_ammo) == max_ammo)
		return
	if(exposed_temperature < FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		return
	if(!COOLDOWN_FINISHED(src, recharge_cooldown))
		return
	COOLDOWN_START(src, recharge_cooldown, 4 SECONDS)
	stored_ammo += new ammo_type(src)
	var/sparks_volume = 30
	if(length(stored_ammo) == max_ammo)
		sparks_volume = 80 //full charge should be noticeable
		balloon_alert_to_viewers("[src] crackles with energy!")
	playsound(src, 'sound/effects/sparks/sparks2.ogg', sparks_volume, TRUE)

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
