#define MECHA_AMMO_CANNON "Cannon fodder"
#define MECHA_AMMO_MISSILE_DAGR "Semi-guided rocket"
#define MECHA_AMMO_AUTOCANNON "35mm Multipurpose"

//Snowflakey primary weapon with a unique'ish mechanic of ammunition swapping-via-scanning.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon
	name = "\improper M/FC-8-LF \"Forge\" fabrication cannon"
	desc = "A heavy 76mm cannon for mechs, integrated with an onboard nanoforge, produced by KMIF. It fabricates specialized rounds on-demand from a generic \
		fodder canister, allowing for sustained fire support without conventional ammunition logistics. The system automatically identifies \
		targets and selects the optimal round type."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_cannon"
	equip_cooldown = 2 SECONDS
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
	var/loading_time = 2 SECONDS

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
	addtimer(CALLBACK(src, PROC_REF(call_identified)), 1 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "gunner" to acquire.

/// System confirms target.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_identified()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE SPOOLING. PREPARING FOR: [uppertext(current_ammo_type)].")]")
	addtimer(CALLBACK(src, PROC_REF(call_load)), 1 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "loader" to start loading.

/// System starts loading.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice("FORGE ACTIVE. PRINTING [uppertext(current_ammo_type)]!")]")
	playsound(chassis, 'modular_nova/modules/colony_fabricator/sound/fabricator/fabricator_mid_2.wav', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 1 SECONDS, TIMER_STOPPABLE | TIMER_DELETE_ME) // Short immersive delay for the "loading" to start.

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

//Secondary weapon that's just an effectively-infinite ammo coaxial Zaibas.
/obj/item/mecha_parts/mecha_equipment/weapon/energy/zaibas_lmg
	name = "\improper M/HP-22 \"Strele\" coaxial plasma pulse machinegun"
	desc = "A weapon for combat exosuits, produced by KMIF-SŻD joint initiative. Shoots assault rifle caliber-proportionate plasma-saboted tungsten penetrators. \
		The preloaded amounts of plasma and tungsten allow it to sustain fire indefinitely within regular combat scenarios."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_plasma_lmg"
	equip_cooldown = 10
	projectiles_per_shot = 4
	variance = 5
	randomspread = 1
	projectile_delay = 2
	energy_drain = 250
	projectile = /obj/projectile/beam/laser/plasma_glob/pulse
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pulse_shoot.ogg'
	harmful = TRUE

//35mm gunpod with an auto-ejection system when it runs dry, so you don't have to navigate UIs.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/gunpod
	name = "\improper M/AC-41 \"Seklys\" flex-mount autocannon gunpod"
	desc = "A weapon for combat exosuits, produced by KMIF. Shoots a rapid, three shot burst of 35mm multipurpose shells. Jettisons itself automatically if it ever runs dry."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_gunpod"
	equip_cooldown = 12
	projectile = /obj/projectile/bullet/autocannon
	projectiles = 150
	projectiles_per_shot = 3
	fire_sound = 'modular_nova/modules/novaya_ert/sound/amr_fire.ogg'
	variance = 2
	randomspread = 1
	projectile_delay = 4
	harmful = TRUE
	ammo_type = MECHA_AMMO_AUTOCANNON

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/gunpod/action(mob/source, atom/target, list/modifiers)
	. = ..()
	if(projectiles <= 0)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("Gunpod exhausted. Ejecting.")]")
		detach()
		return

//Guided rockets, which would make them missiles, but they're rockets because their guidance is APKWS-style. 'Easy' but capacity-inefficient alternative to FC-8.
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/dagr
	name = "\improper M/RP-66 \"Smilgas\" anti-tank guided rocket pod"
	desc = "A weapon for combat exosuits, produced by KMIF. Launches anti-tank guided missiles with optical and infrared guidance designed to lock-on after launch \
		and track targets autonomously. Due to the nature of their design, turn rates remain subpar, and its design will do nothing to soft targets."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "mecha_dagr"
	projectile = /obj/projectile/bullet/rocket/pep/dagr
	projectiles = 7
	ammo_type = MECHA_AMMO_MISSILE_DAGR

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
		do_chem_smoke(1.25, src, get_turf(target), /datum/reagent/toxin/acid, 45)

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

/obj/projectile/bullet/autocannon
	name = "35mm multipurpose autocannon shell"
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "35mm"
	damage = 45
	armour_penetration = 35

/obj/projectile/bullet/autocannon/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	explosion(target, light_impact_range = 1, flame_range = 1, flash_range = 1, adminlog = FALSE, silent = TRUE)
	return BULLET_ACT_HIT

/obj/projectile/bullet/rocket/pep/dagr
	name = "precision guided rocket"
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "dagr_rocket"
	homing_turn_speed = 10

/obj/projectile/bullet/rocket/pep/dagr/Initialize(mapload)
	. = ..()
	src.homing = TRUE
	src.set_homing_target(original)

/obj/item/mecha_ammo/cannon
	name = "fabricator canister container"
	desc = "A container of fabricator 'fodder' canisters for use with exosuit weapons."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "fodder"
	rounds = 28
	ammo_type = MECHA_AMMO_CANNON

/obj/item/mecha_ammo/dagr
	name = "guided rocket container"
	desc = "A container of semi-guided rockets for use with exosuit weapons."
	icon = 'modular_nova/modules/novaya_ert/icons/mech.dmi'
	icon_state = "dagr_ammo"
	rounds = 7
	direct_load = TRUE
	load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_DAGR

#undef MECHA_AMMO_CANNON
#undef MECHA_AMMO_MISSILE_DAGR
#undef MECHA_AMMO_AUTOCANNON
