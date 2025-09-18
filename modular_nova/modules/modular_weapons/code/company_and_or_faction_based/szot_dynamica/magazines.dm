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
	ammo_box_multiload = AMMO_BOX_MULTILOAD_NONE 

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

// Magazine for the legally distinct AR2

/obj/item/ammo_box/magazine/pulse
	name = "\improper Žaibas rifle pulse magazine"
	desc = "A restricted-capacity magazine containing pulse energy cells for the Žaibas rifle. Holds three crystalline plasma plugs, each good for fifteen shots. \
			The casing bears a stamped 'SD-3C' mark (Szot Dynamica 3-Plug Civilian) alongside SolFed compliance certifications."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "zaibas_mag"
	ammo_type = /obj/item/ammo_casing/pulse
	caliber = "pulse"
	max_ammo = 3
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	///Purely flavor short designation that appears in the magazines' notes.
	var/magazine_designation = "'SD-3C'"
	///Lore blurb that appears on examining twice.
	var/lore_blurb = "The 'SD-3C' magazine exists solely because of Carwo Defense Systems' lobbying. While Coalition-designed Žaibas rifles typically use eight-plug military mags (120 pulses total), \
		Carwo pushed SolFed legislators to restrict plug counts — not realizing Szot Dynamica's plasma plugs each hold fifteen pulses. The result? This 'compliant' 3-plug magazine still delivers \
		45 pulses — still outclassing Carwo's own ballistic rifles in sheer volume of fire.<br><br>\
		Coalition armorers mocked the legislation as 'counting fuel cans instead of measuring gas,' while Sakhno Concern quietly released a 'civilian maintenance manual' suggesting users \
		'store plugs in thermally shielded containers' (read: military-grade magazines with the capacity indicators filed off). The included compliance certificate even lists pulse counts as \
		'auxiliary discharge cycles' — a technicality that forced Carwo to admit they'd misunderstood the technology they were trying to ban.<br><br>\
		A tiny etching inside the housing reads: <i>'For optimal performance, consult Xhihao Light Arms catalog page 47.'</i>—\
		a reference to their unmodified eight-plug magazines, conveniently classified as 'industrial capacitors.'"

/obj/item/ammo_box/magazine/pulse/examine_more(mob/user)
	. = ..()
	. += "[lore_blurb]"

/obj/item/ammo_box/magazine/pulse/examine(mob/user)
	. = ..()
	if(length(stored_ammo))
		var/obj/item/ammo_casing/pulse/top_cell = get_round()
		if(istype(top_cell))
			. += span_notice("The topmost loaded cell has <b>[top_cell.remaining_uses]</b> out of <b>[top_cell.max_uses]</b> shots remaining.")

/obj/item/ammo_box/magazine/pulse/add_notes_box()
	var/list/readout = list()
	var/obj/item/ammo_casing/pulse/sample_casing = ammo_type

	// Display magazine capacity info
	readout += "This [span_warning(magazine_designation)] magazine holds up to [span_warning("[max_ammo] plasma plugs")], with each plug capable of [span_warning("[initial(sample_casing.max_uses)] pulses")]."
	readout += "Total capacity: [span_warning("[max_ammo * initial(sample_casing.max_uses)] pulses")] when fully loaded."

	// Get actual round info if available
	var/obj/item/ammo_casing/mag_ammo = get_and_shuffle_round()
	if(istype(mag_ammo))
		readout += "\n[mag_ammo.add_notes_ammo()]"

	return readout.Join("\n")

/obj/item/ammo_box/magazine/pulse/ammo_count(countempties = TRUE)
	if(countempties) // If we're counting empty casings too (like for chambering)
		return length(stored_ammo)
	// Otherwise use the original behavior
	var/boolets = 0
	for(var/obj/item/ammo_casing/pulse/bullet in stored_ammo)
		if(bullet.remaining_uses > 0)
			boolets++
	return boolets

/obj/item/ammo_box/magazine/pulse/top_off(load_type, starting=FALSE)
	. = ..(load_type, starting = FALSE)

/obj/item/ammo_box/magazine/pulse/spawns_empty
	start_empty = TRUE
