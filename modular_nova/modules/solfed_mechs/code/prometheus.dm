/obj/vehicle/sealed/mecha/solfed/prometheus
	desc = "A bipedal assault mech built for breach operations and urban warfare. Its heavy armament and reinforced chassis make it ideal for retaking compromised sectors."
	name = "\improper MAI-2548A2 \"Prometheus\""
	icon_state = "prometheus" //Sprite by diltyrr on discord
	base_icon_state = "prometheus"
	movedelay = 3.5
	max_integrity = 425
	armor_type = /datum/armor/mecha_prometheus
	max_temperature = 30000
	force = 35 // Will have a door only modifier of 2.5x
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/solfed/prometheus
	pivot_step = TRUE
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_rotary,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_napalm,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/repair_droid, /obj/item/mecha_parts/mecha_equipment/kinetic_dampener),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/datum/armor/mecha_prometheus
	melee = 60
	bullet = 45
	laser = 35
	energy = 25
	bomb = 50
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/solfed/prometheus/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/solfed/prometheus/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/solfed/prometheus
	name = "\improper Prometheus wreckage"
	desc = "The wreckage of a Prometheus-class breach mech. Its forward plating is buckled inward, and the hydraulic ram is fused in place. Something hit it harder than it was built to hit."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	icon_state = "prometheus-broken"
	welder_salvage = list(/obj/item/stack/sheet/iron, /obj/item/stack/rods)
