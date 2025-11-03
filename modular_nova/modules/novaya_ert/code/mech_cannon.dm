/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon
	name = "76mm Tank Cannon"
	desc = "A heavy caliber cannon mounted on mechs. Can load different types of ammunition based on target."
	icon_state = "mech_cannon"
	equip_cooldown = 30
	projectile = /obj/projectile/bullet/cannon/smoke
	projectiles = 1
	projectiles_cache = 24
	projectiles_cache_max = 24
	harmful = TRUE
	var/current_ammo_type = "Smoke"
	var/ammo_types = list(
		"Smoke" = /obj/projectile/bullet/cannon/smoke,
		"Canister" = /obj/projectile/bullet/cannon/canister,
		"Sabot" = /obj/projectile/bullet/cannon/sabot,
	)
	var/ready_to_fire = TRUE // Start ready. Becomes FALSE during the loading cycle.
	var/loading_time = 30 // 3 seconds at 10 ticks per second
	var/current_target = null

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/spot_target(atom/target)
	if(!target)
		return

	current_target = target
	ready_to_fire = FALSE

	// **PHASE 1: SPOTTING & AMMO SELECTION**
	// The system acts as the Commander, identifying the target and selecting ammo.
	var/target_type
	if(ismob(target))
		target_type = "INFANTRY"
		current_ammo_type = "Canister"
	else if(ismecha(target))
		target_type = "ARMOR"
		current_ammo_type = "Sabot"
	else
		target_type = "POSITION"
		current_ammo_type = "Smoke"

	// Commander's Callout: "GUNNER! [AMMO]! [TARGET]!"
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("GUNNER! [uppertext(current_ammo_type)]! [target_type]!")]")
	addtimer(CALLBACK(src, PROC_REF(call_identified)), 5) // Short delay for the "gunner" to acquire

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_identified()
	// Gunner's Response: "IDENTIFIED!" (System confirms target is locked and ammo type is set)
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice(">&nbsp;IDENTIFIED!")]") // The > simulates a different crew member speaking
	addtimer(CALLBACK(src, PROC_REF(call_load)), 5)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	// **PHASE 2: LOADING**
	// The system acts as the Loader, announcing the reload.
	// Loader's Callout: "[AMMO] UP!" (The classic "SABOT UP!" call)
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice(">&nbsp;[uppertext(current_ammo_type)] UP!")]")
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 10) // Brief pause before the loading process "starts"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_loading()
	// System is loading. We can add a sound effect here if desired.
	// After the loading_time delay, the round is ready.
	addtimer(CALLBACK(src, PROC_REF(call_ready)), loading_time)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_ready()
	// **PHASE 3: READY TO FIRE**
	// Loader's Final Callout: "READY!"
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_notice(">&nbsp;READY!")]")
	ready_to_fire = TRUE
	projectile = ammo_types[current_ammo_type] // Ensure the projectile type is set *before* firing.

	// Optional: If we still have a target, we can automatically shout "ON THE WAY!" when the pilot clicks again.
	// For now, we'll let the pilot take the shot.

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/action(mob/source, atom/target, list/modifiers)
	// **FIRING SEQUENCE**
	if(!action_checks(target))
		return FALSE

	// If not ready, start the spotting/loading sequence.
	if(!ready_to_fire)
		spot_target(target)
		return FALSE

	// If we are ready, proceed to fire.
	// Gunner's Callout: "ON THE WAY!"
	to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("ON THE WAY!")]")

	var/fired = ..() // Call parent to handle the actual firing logic and projectile creation.

	if(fired)
		// After firing, the cycle resets.
		// Commander's Callout: "NEXT TARGET!" or "TARGET!" (acknowledging a hit, though we don't know for sure)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_danger("TARGET!")]")
		ready_to_fire = FALSE
		current_target = null
		// After firing, the cannon is empty and needs a new round.
		// You could add an automatic reload sequence here if desired, or wait for the next target click.
	return fired

/obj/projectile/bullet/cannon
	name = "tank shell"
	icon_state = "cannonball"
	damage = 60

/obj/projectile/bullet/cannon/smoke
	name = "smoke shot"
	damage = 0

/obj/projectile/bullet/cannon/smoke/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(!ismineralturf(target))
		var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
		smoke.set_up(3, holder = src, location = get_turf(target))
		smoke.start()

/obj/projectile/bullet/cannon/canister
	name = "canister shot"
	damage = 20
	sharpness = NONE

/obj/projectile/bullet/cannon/canister/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.Knockdown(20)

/obj/projectile/bullet/cannon/sabot
	name = "sabot shot"
	damage = 80
	armour_penetration = 80
