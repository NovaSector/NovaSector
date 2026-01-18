/obj/vehicle/sealed/mecha/solfed/hermes
	desc = "A lightweight recon unit optimized for stealth and sabotage. Outfitted with advanced sensors and cloaking tech, it excels in infiltration and electronic disruption."
	name = "\improper MLR-2498G \"Hermes\""
	icon_state = "hermes" //Sprite by diltyrr on discord
	base_icon_state = "hermes"
	movedelay = 2.5
	max_integrity = 225
	armor_type = /datum/armor/mecha_hermes
	max_temperature = 30000
	force = 25
	destruction_sleep_duration = 40
	exit_delay = 40
	wreckage = /obj/structure/mecha_wreckage/solfed/hermes
	pivot_step = TRUE
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS | QUIET_STEPS | QUIET_TURNS
	max_equip_by_category = list(
		MECHA_L_ARM = 1,
		MECHA_R_ARM = 1,
		MECHA_UTILITY = 4,
		MECHA_POWER = 1,
		MECHA_ARMOR = 1,
	)
	///Is the mech's active camo on or off
	var/chameleon_active = FALSE
	///How fast are we fading in or out of view
	var/chameleon_fade_rate = 1.5 SECONDS
	///How much power does it cost to run the active camo
	var/chameleon_power_cost = 10
	equip_by_category = list(
		MECHA_L_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_emp_cannon,
		MECHA_R_ARM = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/solfed_carbine,
		MECHA_UTILITY = list(/obj/item/mecha_parts/mecha_equipment/radio, /obj/item/mecha_parts/mecha_equipment/air_tank/full, /obj/item/mecha_parts/mecha_equipment/thrusters/ion, /obj/item/mecha_parts/mecha_equipment/repair_droid),
		MECHA_POWER = list(/obj/item/mecha_parts/mecha_equipment/generator),
		MECHA_ARMOR = list(/obj/item/mecha_parts/mecha_equipment/armor/antiemp_armor_booster/clandestine),
	)

/datum/armor/mecha_hermes
	melee = 20
	bullet = 20
	laser = 25
	energy = 30
	bomb = 15
	fire = 100
	acid = 100

/obj/vehicle/sealed/mecha/solfed/hermes/generate_actions()
	. = ..()
	initialize_controller_action_type(/datum/action/vehicle/sealed/mecha/hermes_toggle_chameleon, VEHICLE_CONTROL_SETTINGS)

/obj/vehicle/sealed/mecha/solfed/hermes/Initialize(mapload)
	. = ..()
	max_ammo()

/obj/vehicle/sealed/mecha/solfed/hermes/populate_parts()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace(src)
	scanmod = new /obj/item/stock_parts/scanning_module/triphasic(src)
	capacitor = new /obj/item/stock_parts/capacitor/quadratic(src)
	servo = new /obj/item/stock_parts/servo/femto(src)
	update_part_values()

/obj/structure/mecha_wreckage/solfed/hermes
	name = "\improper Hermes wreckage"
	desc = "A collapsed Hermes-class recon unit. The frame is crumpled, legs splayed, and its sensor array is shattered. Speed wasn't enough this time."
	icon = 'modular_nova/modules/solfed_mechs/icons/solfed_mechs.dmi'
	icon_state = "hermes-broken"
	welder_salvage = list(/obj/item/stack/sheet/iron, /obj/item/stack/rods)

/obj/vehicle/sealed/mecha/solfed/hermes/moved_inside(mob/living/carbon/human/human)
	. = ..()
	if(. && !HAS_TRAIT(human, TRAIT_THERMAL_VISION))
		ADD_TRAIT(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		human.update_sight()

/obj/vehicle/sealed/mecha/solfed/hermes/remove_occupant(mob/living/carbon/human/human)
	if(isliving(human) && HAS_TRAIT_FROM(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT))
		REMOVE_TRAIT(human, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		human.update_sight()
	return ..()

/obj/vehicle/sealed/mecha/solfed/hermes/mmi_moved_inside(obj/item/mmi/MMI, mob/user)
	. = ..()
	if(. && !isnull(MMI.brainmob) && !HAS_TRAIT(MMI.brainmob, TRAIT_THERMAL_VISION))
		ADD_TRAIT(MMI.brainmob, TRAIT_THERMAL_VISION, VEHICLE_TRAIT)
		MMI.brainmob.update_sight()

/datum/action/vehicle/sealed/mecha/hermes_toggle_chameleon
	name = "Toggle Chameleon Skin"
	button_icon_state = "mech_stealth_off"
	desc = "Activate or deactivate Hermes' adaptive camouflage."

/datum/action/vehicle/sealed/mecha/hermes_toggle_chameleon/Trigger(mob/user, trigger_flags)
	var/obj/vehicle/sealed/mecha/solfed/hermes/camod_mech = chassis
	if(!camod_mech)
		return

	camod_mech.chameleon_active = !camod_mech.chameleon_active
	button_icon_state = camod_mech.chameleon_active ? "mech_stealth_on" : "mech_stealth_off"
	build_all_button_icons()
	to_chat(user, "Chameleon skin [camod_mech.chameleon_active ? "activated" : "deactivated"].")
	if(!camod_mech.chameleon_active)
		camod_mech.alpha = 255

/obj/vehicle/sealed/mecha/solfed/hermes/process(seconds_per_tick)
	. = ..()
	if(!chameleon_active)
		return

	if(!cell || cell.charge < chameleon_power_cost)
		chameleon_active = FALSE
		alpha = 255
		to_chat(usr, "Chameleon skin deactivated: insufficient power.")
		return
	cell.use(chameleon_power_cost)
	alpha = max(alpha - (chameleon_fade_rate * seconds_per_tick), 5 SECONDS)

/obj/vehicle/sealed/mecha/solfed/hermes/on_move()
	if(!chameleon_active)
		return
	// Increase visibility by double the fade rate
	alpha = min(alpha + (chameleon_fade_rate * 2), 255)
