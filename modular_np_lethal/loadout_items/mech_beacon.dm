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

/obj/item/choice_beacon/mecha/can_use_beacon(mob/living/user)
	var/area/our_area = get_area(src)
	if((istype(our_area, /area/gakster_location/hideout_real)) || (istype(our_area, /area/gakster_location/filtre_spawn)))
		balloon_alert(user, "cannot deploy in hideout")
		return FALSE
	return ..()

/obj/item/choice_beacon/mecha/generate_display_names()
	var/static/list/exosuit_packs
	if(!exosuit_packs)
		exosuit_packs = list()
		var/list/possible_exosuit_packs = list(
			/obj/vehicle/sealed/mecha/gygax/streetsweeper,
			/obj/vehicle/sealed/mecha/savannah_ivanov/exstasi,
			/obj/vehicle/sealed/mecha/durand/tortuga,
			/obj/vehicle/sealed/mecha/marauder/horizon
		)
		for(var/obj/vehicle/sealed/mecha/exosuit_pack as anything in possible_exosuit_packs)
			exosuit_packs[initial(exosuit_pack.name)] = exosuit_pack
	return exosuit_packs

//special pre equipped exosuits for it to deploy. they get max ammo and better parts.
/obj/vehicle/sealed/mecha/gygax/streetsweeper
	name = "\improper Gygax 'Streetsweeper'"
	desc = "A light weight, high mobility exosuit equipped with an LBX-10 Autocannon and heavy laser, intended for breachwork and urban crowd control."
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy,
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
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/railgun,
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


/obj/vehicle/sealed/mecha/durand/tortuga
	name = "\improper Durand 'Tortuga'"
	desc = "A heavy defensive powerhouse of a mech. Very slow with a energy shield to deflect all damage from the front, comes with a Ultra AC2 and a impact gernade launcher to flush people out of cover"
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/stringers,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),)

/obj/vehicle/sealed/mecha/durand/tortuga/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/durand/tortuga/populate_parts()
	cell = new /obj/item/stock_parts/cell/hyper(src)
	scanmod = new /obj/item/stock_parts/scanning_module/adv(src)
	capacitor = new /obj/item/stock_parts/capacitor/adv(src)
	servo = new /obj/item/stock_parts/servo/nano(src)
	update_part_values()

/obj/vehicle/sealed/mecha/marauder/horizon
	name = "\improper Marauder 'Horizon'"
	desc = "A medium chasis, highly customizable but defualted to long range combat. This one comes with one rapid fire energy weapon to keep enemies off of you and one fast a light beam to deal damage from afar"
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/lasershot,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),)

/obj/vehicle/sealed/mecha/marauder/horizon/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/marauder/horizon/populate_parts()
	cell = new /obj/item/stock_parts/cell/hyper(src)
	scanmod = new /obj/item/stock_parts/scanning_module/adv(src)
	capacitor = new /obj/item/stock_parts/capacitor/adv(src)
	servo = new /obj/item/stock_parts/servo/nano(src)
	update_part_values()
