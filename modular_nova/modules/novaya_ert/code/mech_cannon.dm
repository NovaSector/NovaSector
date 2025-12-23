#define MECHA_AMMO_CANNON "Cannon fodder"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon
	name = "\improper M/FC-8-LF \"Forge\" Fabrication Cannon"
	desc = "A heavy 76mm cannon for mechs, integrated with an onboard nanoforge. It fabricates specialized rounds on-demand from a generic \
		fodder canister, allowing for sustained fire support without conventional ammunition logistics. The system automatically identifies \
		targets and selects the optimal round type."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_cannon"
	equip_cooldown = 3 SECONDS
	fire_sound = 'modular_nova/modules/novaya_ert/sound/shell_out_med.ogg'
	projectile = /obj/projectile/bullet/tank_cannon/smoke
	projectiles = 7
	projectiles_cache = 28
	projectiles_cache_max = 28
	harmful = TRUE
	ammo_type = MECHA_AMMO_CANNON
	///Currently selected ammo type, as per identification procedure.
	var/current_ammo_type
	///Currently selected target for the ID procedure.
	var/current_target = null
	///All available ammo types and their associated flavorful names.
	var/ammo_types = list(
		"Caustic Obscurant" = /obj/projectile/bullet/tank_cannon/smoke,
		"Explosive Fragmentation" = /obj/projectile/bullet/tank_cannon/heap,
		"Electric Penetrator" = /obj/projectile/bullet/tank_cannon/sabot,
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

	var/target_type = scan_area(get_turf(target))

	switch(target_type)
		if("SOFT TARGET")
			current_ammo_type = "Explosive Fragmentation"
		if("HARD TARGET")
			current_ammo_type = "Electric Penetrator"
		else
			current_ammo_type = "Caustic Obscurant"

	// Commander's callout.
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("TARGET: [target_type]. PRINT QUEUE: [uppertext(current_ammo_type)].")]")
	addtimer(CALLBACK(src, PROC_REF(call_identified)), 1.5 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "gunner" to acquire.

/// System confirms target.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_identified()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE SPOOLING. PREPARING FOR: [uppertext(current_ammo_type)].")]")
	addtimer(CALLBACK(src, PROC_REF(call_load)), 1.5 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "loader" to start loading.

/// System starts loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE ACTIVE. PRINTING [uppertext(current_ammo_type)]!")]")
	playsound(chassis, 'modular_nova/modules/colony_fabricator/sound/fabricator/fabricator_mid_2.wav', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 1.5 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "loading" to start.

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

///Scans the nearby area for appropriate targets; removing the need for pixelhunting.
///Returns the type of threat detected to print the shell.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/scan_area(turf/center)
	if(!center)
		return null

	var/threat_counts = list(
		"SOFT TARGET" = 0,
		"HARD TARGET" = 0,
		"AREA DENIAL" = 0
	)

	// Scan 3x3 area
	for(var/turf/T in range(1, center))
		for(var/atom/movable/AM in T)
			if(iscarbon(AM) || isbasicmob(AM))
				threat_counts["SOFT TARGET"]++
			else if(ismecha(AM) || issilicon(AM))
				threat_counts["HARD TARGET"]++

	// If no targets found, default to area denial
	if(threat_counts["SOFT TARGET"] == 0 && threat_counts["HARD TARGET"] == 0)
		return "AREA DENIAL"

	// Return the threat type with highest count
	var/highest_threat = "AREA DENIAL"
	var/highest_count = 0
	for(var/threat_type in threat_counts)
		if(threat_counts[threat_type] > highest_count)
			highest_count = threat_counts[threat_type]
			highest_threat = threat_type

	return highest_threat

/obj/projectile/bullet/tank_cannon
	name = "nonexistent tank shell"
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "heap"
	damage = 60

/obj/projectile/bullet/tank_cannon/smoke
	name = "corrosive smoke shot"
	icon_state = "smoke"
	damage = 20
	sharpness = NONE

/obj/projectile/bullet/tank_cannon/smoke/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(!ismineralturf(target))
		var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
		smoke.chemholder.add_reagent(/datum/reagent/toxin/acid, 45)
		smoke.set_up(1.25, holder = src, location = get_turf(target))
		smoke.start()

/obj/projectile/bullet/tank_cannon/heap
	name = "heap shot"
	damage = 20
	speed = 1.25
	range = 11
	sharpness = NONE
	/// What type of casing should we put inside the bullet to act as shrapnel later
	var/casing_to_spawn = /obj/item/grenade/forge_fakeshell/heap

/obj/projectile/bullet/tank_cannon/heap/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	fuse_activation(target)
	return BULLET_ACT_HIT

/obj/projectile/bullet/tank_cannon/heap/on_range()
	fuse_activation(get_turf(src))
	return ..()

/// Called when the projectile reaches its max range, or hits something
/obj/projectile/bullet/tank_cannon/heap/proc/fuse_activation(atom/target)
	var/obj/item/grenade/shrapnel_maker = new casing_to_spawn(get_turf(target))
	shrapnel_maker.detonate()
	explosion(target, devastation_range = -1, heavy_impact_range = 1, light_impact_range = 3, flame_range = 2, flash_range = 1, adminlog = FALSE)
	playsound(src, 'modular_nova/modules/modular_weapons/sounds/grenade_burst.ogg', 100, FALSE, 3)
	qdel(shrapnel_maker)

/obj/item/grenade/forge_fakeshell/heap
	shrapnel_type = /obj/projectile/bullet/shrapnel/short_range/piercing
	shrapnel_radius = 7

/obj/projectile/bullet/shrapnel/short_range/piercing
	armour_penetration = 15
	max_pierces = 1
	projectile_piercing = ALL

/obj/projectile/bullet/tank_cannon/sabot
	name = "electric sabot shot"
	icon_state = "sabot"
	damage = 45 //we go clean through
	speed = 2.5
	armour_penetration = 50 //we go clean through
	max_pierces = 2 //we go clean through
	projectile_piercing = ALL
	/// Whether we do extra damage when hitting a mech or silicon
	var/anti_armour_damage = 85

/obj/projectile/bullet/tank_cannon/sabot/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(anti_armour_damage && ismecha(target))
		var/obj/vehicle/sealed/mecha/M = target
		M.take_damage(anti_armour_damage, armour_penetration = 50)
	if(issilicon(target))
		var/mob/living/silicon/S = target
		S.take_overall_damage(anti_armour_damage*0.75, anti_armour_damage*0.25)
	if(isliving(target))
		var/mob/living/shocker = target
		shocker.electrocute_act(30, "electric sabot", flags = SHOCK_NOGLOVES|SHOCK_NOSTUN)
	do_sparks(5, FALSE, target)

/obj/item/mecha_ammo/cannon
	name = "fabricator canister container"
	desc = "A container of fabricator 'fodder' canisters for use with exosuit weapons."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "fodder"
	rounds = 28
	ammo_type = MECHA_AMMO_CANNON

#undef MECHA_AMMO_CANNON
