/obj/vehicle/sealed/mecha/solfed/prometheus
	desc = "A bipedal assault mech built for breach operations and urban warfare. Its heavy armament and reinforced chassis make it ideal for retaking compromised sectors."
	name = "\improper MAI-2548A2 \"Prometheus\""
	icon_state = "prometheus" //Sprite by diltyrr on discord
	base_icon_state = "prometheus"
	movedelay = 3.5
	max_integrity = 425
	armor_type = /datum/armor/mecha_prometheus
	max_temperature = 30000
	force = 35
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

/obj/vehicle/sealed/mecha/solfed/prometheus/generate_actions()
	. = ..()
	initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/prometheus_ram, VEHICLE_CONTROL_SETTINGS)

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

/datum/action/vehicle/sealed/mecha/prometheus_ram
	name = "Hydraulic Ram"
	desc = "Engage the Prometheus' chest-mounted hydraulic ram to smash targets directly ahead."
	button_icon = 'modular_nova/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	button_icon_state = "peacekeeper_hammer"

/datum/action/vehicle/sealed/mecha/prometheus_ram/Trigger(mob/user, trigger_flags)
	var/turf/front_turf = get_step(chassis, chassis.dir)
	if(!front_turf)
		return

	var/atom/movable/ram_target

	// Priority 1: Vehicle
	var/obj/vehicle/vehicle_target = locate(/obj/vehicle) in front_turf
	if(vehicle_target)
		ram_target = vehicle_target

	// Priority 2: Mob
	if(!ram_target)
		var/mob/living/living_target = locate(/mob/living) in front_turf
		if(living_target)
			ram_target = living_target

	// Priority 3: Firedoor (active only)
	if(!ram_target)
		var/obj/machinery/door/firedoor/firedoor_target = locate(/obj/machinery/door/firedoor) in front_turf
		if(firedoor_target && firedoor_target.active)
			ram_target = firedoor_target

	// Priority 4: airlock door
	if(!ram_target)
		var/obj/machinery/door/door_target = locate(/obj/machinery/door/airlock) in front_turf
		ram_target = door_target

	// Priority 5: Door assembly
	if(!ram_target)
		var/obj/structure/door_assembly/assembly_target = locate(/obj/structure/door_assembly) in front_turf
		ram_target = assembly_target

	if(!ram_target)
		to_chat(user, span_warning("No valid target directly ahead!"))
		return

	// Wind-up with do_after (2 seconds)
	if(!do_after(user, 2 SECONDS, ram_target))
		return

	playsound(chassis, 'sound/effects/clang.ogg', 70, TRUE)
	user.visible_message(
		span_danger("[chassis] slams its hydraulic ram into [ram_target] with a deafening clang!"),
		span_danger("You slam the hydraulic ram into [ram_target]!"),
		null,
		COMBAT_MESSAGE_RANGE
	)

	var/damage_amount = chassis.force
	if(istype(ram_target, /mob/living))
		var/mob/living/living_target = ram_target
		living_target.apply_damage(damage_amount, BRUTE)
	else
		damage_amount = chassis.force * 9
		var/atom/ramget = ram_target
		ramget.take_damage(damage_amount)
