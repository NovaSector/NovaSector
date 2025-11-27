/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon
	name = "\improper M/FC-8 \"Forge\" Fabrication Cannon"
	desc = "A heavy 76mm cannon for mechs, integrated with an onboard nanoforge. It fabricates specialized rounds on-demand from a generic \
	fodder canister, allowing for sustained fire support without conventional ammunition logistics. The system automatically identifies \
	targets and selects the optimal round type."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_cannon"
	equip_cooldown = 3 SECONDS
	fire_sound = 'modular_nova/modules/novaya_ert/sound/shell_out_med.ogg'
	projectile = /obj/projectile/bullet/tank_cannon/smoke
	projectiles = 4
	projectiles_cache = 24
	projectiles_cache_max = 24
	harmful = TRUE
	///Currently selected ammo type, as per identification procedure.
	var/current_ammo_type
	///Currently selected target for the ID procedure.
	var/current_target = null
	///All available ammo types and their associated flavorful names.
	var/ammo_types = list(
		"Obscurant" = /obj/projectile/bullet/tank_cannon/smoke,
		"Fragmentation" = /obj/projectile/bullet/tank_cannon/canister,
		"Penetrator" = /obj/projectile/bullet/tank_cannon/sabot,
	)
	///Whether the gun is ready to fire.
	var/ready_to_fire = FALSE
	///Whether the gun is currently printing/loading.
	var/loading_in_progress = FALSE
	///How long does it take to load a round?
	var/loading_time = 3 SECONDS

/// The system acts as the Commander, identifying the target and selecting ammo.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/spot_target(atom/target)
	if(!target || loading_in_progress)
		return

	current_target = target
	ready_to_fire = FALSE
	loading_in_progress = TRUE

	var/target_type
	if(ismob(target))
		target_type = "SOFT TARGET"
		current_ammo_type = "Fragmentation"
	else if(ismecha(target))
		target_type = "HARD TARGET"
		current_ammo_type = "Penetrator"
	else
		target_type = "AREA SUPPRESSION"
		current_ammo_type = "Obscurant"

	// Commander's callout.
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("TARGET: [target_type]. PRINT QUEUE: [uppertext(current_ammo_type)].")]")
	addtimer(CALLBACK(src, PROC_REF(call_identified)), 15) // Short immersive delay for the "gunner" to acquire.

/// System confirms target.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_identified()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE SPOOLING. PREPARING FOR: [uppertext(current_ammo_type)].")]")
	addtimer(CALLBACK(src, PROC_REF(call_load)), 15) // Short immersive delay for the "loader" to start loading.

/// System starts loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE ACTIVE. PRINTING [uppertext(current_ammo_type)]!")]")
	playsound(chassis, 'modular_nova/modules/colony_fabricator/sound/fabricator/fabricator_mid_2.wav', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 15) // Short immersive delay for the "loading" to start.

/// System is loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_loading()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("ROUND READY. LOADING [uppertext(current_ammo_type)]!")]")
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
	name = "nonexistent tank shell"
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "canister"
	damage = 60
	/// Whether we do extra damage when hitting a mech or silicon
	var/anti_armour_damage = 0

/obj/projectile/bullet/tank_cannon/smoke
	name = "smoke shot"
	icon_state = "smoke"
	damage = 20
	sharpness = NONE

/obj/projectile/bullet/tank_cannon/smoke/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(!ismineralturf(target))
		var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
		smoke.set_up(3, holder = src, location = get_turf(target))
		smoke.start()

/obj/projectile/bullet/tank_cannon/canister
	name = "canister shot"
	damage = 50
	speed = 1.25
	range = 6
	sharpness = NONE
	/// What type of casing should we put inside the bullet to act as shrapnel later
	var/casing_to_spawn = /obj/item/grenade/forge_fakeshell/canister

/obj/projectile/bullet/tank_cannon/canister/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	fuse_activation(target)
	return BULLET_ACT_HIT

/obj/projectile/bullet/tank_cannon/canister/on_range()
	fuse_activation(get_turf(src))
	return ..()

/// Called when the projectile reaches its max range, or hits something
/obj/projectile/bullet/tank_cannon/canister/proc/fuse_activation(atom/target)
	var/obj/item/grenade/shrapnel_maker = new casing_to_spawn(get_turf(target))
	shrapnel_maker.detonate()
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 75, TRUE, -3)
	qdel(shrapnel_maker)

/obj/item/grenade/forge_fakeshell/canister
	shrapnel_type = /obj/projectile/bullet/shrapnel/short_range
	shrapnel_radius = 4

/obj/projectile/bullet/tank_cannon/sabot
	name = "sabot shot"
	icon_state = "sabot"
	damage = 45 //we go clean through
	speed = 2.5
	armour_penetration = 50 //we go clean through
	max_pierces = 1 //we go clean through
	projectile_piercing = PASSMOB|PASSVEHICLE
	projectile_phasing = ~(PASSMOB|PASSVEHICLE)
	phasing_ignore_direct_target = TRUE
	anti_armour_damage = 105 //we go clean through

/obj/projectile/bullet/tank_cannon/sabot/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(anti_armour_damage && ismecha(target))
		var/obj/vehicle/sealed/mecha/M = target
		M.take_damage(anti_armour_damage)
	if(issilicon(target))
		var/mob/living/silicon/S = target
		S.take_overall_damage(anti_armour_damage)
