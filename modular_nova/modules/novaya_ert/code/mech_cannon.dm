/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon
	name = "\improper M/FC-8 \"Forge\" Fabrication Cannon"
	desc = "A heavy 76mm cannon for mechs, integrated with an onboard nanoforge. It fabricates specialized rounds on-demand from a generic fodder canister, \
	allowing for sustained fire support without conventional ammunition logistics. The system automatically identifies targets and selects the optimal round type."
	icon_state = "mech_cannon"
	equip_cooldown = 30
	fire_sound = 'modular_nova/modules/novaya_ert/sound/shell_out_med.ogg'
	projectile = /obj/projectile/bullet/tank_cannon/smoke
	projectiles = 1
	projectiles_cache = 24
	projectiles_cache_max = 24
	harmful = TRUE
	var/current_ammo_type
	var/ammo_types = list(
		"Obscurant" = /obj/projectile/bullet/tank_cannon/smoke,
		"Canister" = /obj/projectile/bullet/tank_cannon/canister,
		"Sabot" = /obj/projectile/bullet/tank_cannon/sabot,
	)
	var/ready_to_fire = FALSE
	var/loading_time = 30 // 3 seconds at 10 ticks per second
	var/current_target = null
	var/loading_in_progress = FALSE

///The system acts as the Commander, identifying the target and selecting ammo.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/spot_target(atom/target)
	if(!target || loading_in_progress)
		return

	current_target = target
	ready_to_fire = FALSE
	loading_in_progress = TRUE

	var/target_type
	if(ismob(target))
		target_type = "BIOLOGICAL"
		current_ammo_type = "Fragmentation"
	else if(ismecha(target))
		target_type = "HARD TARGET"
		current_ammo_type = "Penetrator"
	else
		target_type = "AREA SUPPRESSION"
		current_ammo_type = "Obscurant"

	// Commander's Callout: "GUNNER! [AMMO]! [TARGET]!"
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("GUNNER! [uppertext(current_ammo_type)]! [target_type]!")]")
	addtimer(CALLBACK(src, PROC_REF(call_identified)), 15) // Short immersive delay for the "gunner" to acquire.

///System confirms target.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_identified()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("IDENTIFIED!")]")
	addtimer(CALLBACK(src, PROC_REF(call_load)), 15) // Short immersive delay for the "loader" to start loading.

///System starts loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("PRINTING [uppertext(current_ammo_type)]!")]")
	playsound(chassis, 'modular_nova/modules/colony_fabricator/sound/fabricator/fabricator_mid_2.wav', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 15) // Short immersive delay for the "loading" to start.

/// System is loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_loading()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("LOADING [uppertext(current_ammo_type)]!")]")
	playsound(chassis, 'modular_nova/modules/novaya_ert/sound/servo.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(call_ready)), loading_time)

/// System has finished loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_ready()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("[uppertext(current_ammo_type)] UP!")]")
	playsound(chassis, 'modular_nova/modules/novaya_ert/sound/shell_in_med.ogg', 50, TRUE)
	ready_to_fire = TRUE
	loading_in_progress = FALSE
	projectile = ammo_types[current_ammo_type] // Projectile type is set before firing.

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return FALSE

	// If not ready, start the spotting/loading sequence.
	if(!ready_to_fire)
		spot_target(target)
		return FALSE

	var/fired = ..() // Call parent to handle the actual firing logic and projectile creation.

	if(fired)
		// After firing, the cycle resets.
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("NEXT TARGET!")]")
		ready_to_fire = FALSE
		current_target = null
		// Note: loading_in_progress remains FALSE here since we just fired
	return fired

/obj/projectile/bullet/tank_cannon
	name = "tank shell"
	icon_state = "cannonball"
	damage = 60

/obj/projectile/bullet/tank_cannon/smoke
	name = "smoke shot"
	damage = 0

/obj/projectile/bullet/tank_cannon/smoke/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(!ismineralturf(target))
		var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
		smoke.set_up(3, holder = src, location = get_turf(target))
		smoke.start()

/obj/projectile/bullet/tank_cannon/canister
	name = "canister shot"
	damage = 20
	sharpness = NONE

/obj/projectile/bullet/tank_cannon/canister/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.Knockdown(20)

/obj/projectile/bullet/tank_cannon/sabot
	name = "sabot shot"
	damage = 80
	armour_penetration = 80
