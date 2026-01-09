/obj/vehicle/sealed/mecha/solfed/aegis
	desc = "A rugged riot-control platform deployed by Solfed SWAT forces. Designed for crowd suppression and defensive escort in high-risk zones."
	name = "\improper MRC-2544D1 \"Aegis\""
	icon_state = "aegis" //Sprite by diltyrr on discord
	base_icon_state = "aegis"
	movedelay = 4.5
	max_integrity = 375
	accesses = list() //check whatever SWAT access is.
	armor_type = /datum/armor/mecha_aegis
	max_temperature = 30000
	force = 30
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/solfed/aegis
	pivot_step = TRUE
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_riotgun,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/solfed_teargas,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/kinetic_dampener, /obj/item/mecha_parts/mecha_equipment/repair_droid),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster),
	)

/datum/armor/mecha_aegis
	melee = 50
	bullet = 40
	laser = 20
	energy = 15
	bomb = 30
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/solfed/aegis/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/solfed/aegis/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/solfed/aegis
	name = "\improper Aegis wreckage"
	desc = "A mangled husk of an Aegis-class mech. Its armor is torn and scorched, limbs twisted at unnatural angles. Whatever brought it down, it wasn't gentle."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	icon_state = "aegis-broken"
	welder_salvage = list(/obj/item/stack/sheet/iron, /obj/item/stack/rods)

