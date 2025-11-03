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
	var/current_ammo_type = "smoke"
	var/ammo_types = list(
		"smoke" = /obj/projectile/bullet/cannon/smoke,
		"canister" = /obj/projectile/bullet/cannon/canister,
		"apfsds" = /obj/projectile/bullet/cannon/apfsds
	)
	var/ready_to_fire = FALSE
	var/loading_time = 30 // 3 seconds at 10 ticks per second
	var/current_target = null

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/spot_target(atom/target)
	if(!target)
		return

	current_target = target
	ready_to_fire = FALSE

	// Initial spotting callout
	var/target_type
	if(ismob(target))
		target_type = "infantry"
		current_ammo_type = "canister"
	else if(ismecha(target))
		target_type = "armor"
		current_ammo_type = "apfsds"
	else
		target_type = "position"
		current_ammo_type = "smoke"

	// Tank crew callout sequence
	say("Target spotted, [target_type]!")
	addtimer(CALLBACK(src, PROC_REF(call_load)), 10) // 1 second delay

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_load()
	say("Gunner, [current_ammo_type]!")
	addtimer(CALLBACK(src, PROC_REF(call_loading)), 10) // 1 second delay

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_loading()
	say("Loading [current_ammo_type]!")
	addtimer(CALLBACK(src, PROC_REF(call_ready)), loading_time) // 3 seconds loading

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/proc/call_ready()
	say("[current_ammo_type] up!")
	ready_to_fire = TRUE
	projectile = ammo_types[current_ammo_type]

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/cannon/action(mob/source, atom/target, list/modifiers)
	if(!ready_to_fire)
		spot_target(target)
		return FALSE
	if(target != current_target)
		say("Target lost!")
		ready_to_fire = FALSE
		return FALSE

	. = ..() // Call parent to handle actual firing
	if(.)
		ready_to_fire = FALSE
		current_target = null

/obj/projectile/bullet/cannon
	name = "cannon shell"
	icon_state = "cannonball"
	damage = 60

/obj/projectile/bullet/cannon/smoke
	name = "smoke shell"
	damage = 0

/obj/projectile/bullet/cannon/smoke/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismineralturf(target))
		var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
		smoke.set_up(3, holder = src, location = get_turf(target))
		smoke.start()

/obj/projectile/bullet/cannon/canister
	name = "canister shot"
	damage = 20
	sharpness = NONE

/obj/projectile/bullet/cannon/canister/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.Knockdown(20)

/obj/projectile/bullet/cannon/apfsds
	name = "APFSDS"
	damage = 80
	armour_penetration = 80
