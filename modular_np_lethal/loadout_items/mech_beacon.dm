///mech beacon for the signature loadout menu.

//the beacon
/obj/item/choice_beacon/mecha
	name = "Exosuit Deployment Beacon"
	desc = "Owing to the expense of deploying exosuit fleets it has become common practice to field pilots ahead of their vehicles. \
	Long range communication and beacon devices are used to coordinate the timely delivery of their mechs."
	icon = 'icons/obj/antags/gang/cell_phone.dmi'
	icon_state = "phone_off"
	company_source = "Ahkter Frontier Corps Exosuit Support Team"
	company_message = span_bold("Pilot coordinates received. War Machine inbound.")

/obj/item/choice_beacon/mecha/generate_display_names()
	var/static/list/exosuit_packs
	if(!exosuit_packs)
		exosuit_packs = list()
		var/list/possible_exosuit_packs = list(
			/obj/vehicle/sealed/mecha/gygax/streetsweeper,
			/obj/vehicle/sealed/mecha/savannah_ivanov/exstasi
		)
		for(var/obj/vehicle/sealed/mecha/exosuit_pack as anything in possible_exosuit_packs)
			exosuit_packs[initial(exosuit_pack.name)] = exosuit_pack
	return exosuit_packs

//special pre equipped exosuits for it to deploy. they get max ammo and better parts.
/obj/vehicle/sealed/mecha/gygax/streetsweeper
	name = "\improper Gygax 'Streetsweeper'"
	desc = "A medium, high mobility exosuit equipped with an LBX-10 Autocannon and PEP-6 anti-structural missiles, intended for breachwork and urban crowd control."
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/breaching,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),)

/obj/vehicle/sealed/mecha/gygax/streetsweeper/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/gygax/streetsweeper/populate_parts()
	cell = new /obj/item/stock_parts/cell/hyper(src)
	scanmod = new /obj/item/stock_parts/scanning_module/adv(src)
	capacitor = new /obj/item/stock_parts/capacitor/adv(src)
	servo = new /obj/item/stock_parts/servo/nano(src)
	update_part_values()

/obj/vehicle/sealed/mecha/savannah_ivanov/exstasi
	name = "\improper Savannah Ivanov 'Ecstasy of Saint Teresa'"
	desc = "A high mobility fire support mech with a lightweight, long range loadout, named for Bernini's masterpiece sculpture of Teresa of Avila."
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		MECHA_R_ARM = null,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),)

/obj/vehicle/sealed/mecha/savannah_ivanov/exstasi/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/savannah_ivanov/exstasi/populate_parts()
	cell = new /obj/item/stock_parts/cell/hyper(src)
	scanmod = new /obj/item/stock_parts/scanning_module/adv(src)
	capacitor = new /obj/item/stock_parts/capacitor/adv(src)
	servo = new /obj/item/stock_parts/servo/nano(src)
	update_part_values()
