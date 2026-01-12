/obj/vehicle/sealed/mecha/solfed/thanatos
	desc = "A siege-grade mech designed for overwhelming firepower and area denial. Its massive railgun and rocket payload make it a last-resort asset in total containment failure."
	name = "\improper MHS-2552X1 \"Thanatos\""
	icon_state = "thanatos" //Sprite by zy.dras on discord
	base_icon_state = "thanatos"
	movedelay = 5.5
	max_integrity = 600
	armor_type = /datum/armor/mecha_thanatos
	max_temperature = 30000
	force = 35
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/solfed/thanatos
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 5,
		MECHA_POWER = 1,
		MECHA_ARMOR = 2,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_railgun,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/turret/solfed_minigun,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/kinetic_dampener, /obj/item/mecha_parts/mecha_equipment/swarm_rocket_pod/solfed, /obj/item/mecha_parts/mecha_equipment/repair_droid),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine, /obj/item/mecha_parts/mecha_equipment/armor/antiproj_armor_booster),
	)

/datum/armor/mecha_thanatos
	melee = 75
	bullet = 65
	laser = 60
	energy = 40
	bomb = 60
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/solfed/thanatos/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/solfed/thanatos/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/solfed/thanatos
	name = "\improper Thanatos wreckage"
	desc = "The twisted shell of a Thanatos-class siege platform. Its railgun is cracked, its turret scorched, and its legs are half-buried in rubble. Even monsters fall, eventually."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	icon_state = "thanatos-broken"
	welder_salvage = list(/obj/item/stack/sheet/iron, /obj/item/stack/rods)
