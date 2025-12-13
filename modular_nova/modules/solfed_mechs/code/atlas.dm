/obj/vehicle/sealed/mecha/solfed/atlas
	desc = "A field support mech equipped for engineering and medical aid. Deployed to stabilize infrastructure and patch up wounded personnel under fire."
	name = "\improper MSU-2539B1 \"Atlas\""
	icon_state = "atlas" //Sprite by diltyrr on discord
	base_icon_state = "atlas"
	movedelay = 3.75
	max_integrity = 300
	armor_type = /datum/armor/mecha_atlas
	max_temperature = 30000
	force = 25
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/solfed/atlas
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 6,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/solfed_welder,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/solfed,
		MECHA_UTILITY = list(
			/obj/item/mecha_parts/mecha_equipment/radio,
			/obj/item/mecha_parts/mecha_equipment/air_tank/full,
			/obj/item/mecha_parts/mecha_equipment/thrusters/ion,
			/obj/item/mecha_parts/mecha_equipment/repair_droid,
			/obj/item/mecha_parts/mecha_equipment/kinetic_dampener,
			/obj/item/mecha_parts/mecha_equipment/utility/fob_3d_printer,
		),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/anticcw_armor_booster),
	)

/datum/armor/mecha_atlas
	melee = 35
	bullet = 30
	laser = 20
	energy = 20
	bomb = 40
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/solfed/atlas/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/solfed/atlas/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/solfed/atlas
	name = "\improper Atlas wreckage"
	desc = "The remains of an Atlas-class support mech. Its pincer module is warped and half-melted, and the chassis is scorched."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	icon_state = "atlas-broken"
	welder_salvage = list(/obj/item/stack/sheet/iron, /obj/item/stack/rods)

/obj/vehicle/sealed/mecha/solfed/atlas/moved_inside(mob/living/carbon/human/human)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(human, TRAIT_MEDICAL_HUD, VEHICLE_TRAIT)
	ADD_TRAIT(human, TRAIT_DIAGNOSTIC_HUD, VEHICLE_TRAIT)

/obj/vehicle/sealed/mecha/solfed/atlas/remove_occupant(mob/living/carbon/human/human)
	REMOVE_TRAIT(human, TRAIT_MEDICAL_HUD, VEHICLE_TRAIT)
	REMOVE_TRAIT(human, TRAIT_DIAGNOSTIC_HUD, VEHICLE_TRAIT)
	return ..()
