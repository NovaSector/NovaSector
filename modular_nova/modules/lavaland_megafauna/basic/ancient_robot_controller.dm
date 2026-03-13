#define BODY_SHIELD_COOLDOWN_TIME 3 SECONDS
#define EXTRA_PLAYER_ANGER_NORMAL_CAP 6
#define EXTRA_PLAYER_ANGER_STATION_CAP 3
#define BLUESPACE 1
#define GRAV 2
#define PYRO 3
#define FLUX 4
#define VORTEX 5
#define CRYO 6
#define TOP_RIGHT 1
#define TOP_LEFT 2
#define BOTTOM_RIGHT 3
#define BOTTOM_LEFT 4

#define ROBOT_ENRAGED (health < maxHealth*0.5)

/datum/ai_controller/basic_controller/ancient_robot
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/no_gutted_mobs,
		BB_TARGET_MINIMUM_STAT = DEAD,
		BB_AGGRO_RANGE = 12,
		BB_ANCIENT_ROBOT_SPECIAL_COOLDOWN = 0,
	)

	movement_delay = 0.5 SECONDS
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/ancient_robot_combat,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/ancient_robot_leg_sync,
	)

/datum/ai_planning_subtree/ancient_robot_combat

/datum/ai_planning_subtree/ancient_robot_combat/SelectBehaviors(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/pawn)
	// Do not plan new attacks if currently charging or dying [cite: 31, 35]
	if(pawn.charging || pawn.exploding || pawn.ranged_cooldown > world.time)
		return

	// Retrieve target from blackboard
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return

	// Anger scales based on missing health
	var/anger_modifier = clamp(((pawn.maxHealth - pawn.health) / 50), 0, 20)

	if(prob(20))
		controller.queue_behavior(/datum/ai_behavior/ancient_robot_laser)
		return TRUE

	if(prob(30 + (anger_modifier / 2)))
		controller.queue_behavior(/datum/ai_behavior/ancient_robot_charge, target)
		return TRUE

	if(prob(30 + anger_modifier))
		controller.queue_behavior(/datum/ai_behavior/ancient_robot_anomalies)
		return TRUE

	if(prob(60 + anger_modifier))
		controller.queue_behavior(/datum/ai_behavior/ancient_robot_special, target)
		return TRUE

/datum/ai_planning_subtree/ancient_robot_leg_sync

/datum/ai_planning_subtree/ancient_robot_leg_sync/SelectBehaviors(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/pawn)
	// Check distance for all legs
	if(get_dist(pawn, pawn.TR) > 3 || get_dist(pawn, pawn.TL) > 3 || get_dist(pawn, pawn.BR) > 3 || get_dist(pawn, pawn.BL) > 3)
		controller.queue_behavior(/datum/ai_behavior/ancient_robot_snap_legs)
		return TRUE

/datum/ai_behavior/ancient_robot_charge/perform(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/robot)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return AI_BEHAVIOR_FAILED
	robot.triple_charge()
	return AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/ancient_robot_laser/perform(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/robot)
	robot.single_laser()
	return AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/ancient_robot_anomalies/perform(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/robot)
	robot.spawn_anomalies()
	return AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/ancient_robot_special/perform(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/robot)
	robot.do_special_move()
	return AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/ancient_robot_snap_legs/perform(datum/ai_controller/controller, mob/living/basic/megafauna/ancient_robot/pawn)
	// We force the legs to the core's location if they are too far [cite: 51]
	pawn.fix_specific_leg(TOP_RIGHT)
	pawn.fix_specific_leg(TOP_LEFT)
	pawn.fix_specific_leg(BOTTOM_RIGHT)
	pawn.fix_specific_leg(BOTTOM_LEFT)
	return AI_BEHAVIOR_SUCCEEDED

/mob/living/basic/megafauna/ancient_robot/proc/fix_specific_leg(input)
	switch(input)
		if(TOP_RIGHT)
			leg_control_system(input, 2, 2)
		if(TOP_LEFT)
			leg_control_system(input, -2, 2)
		if(BOTTOM_RIGHT)
			leg_control_system(input, 2, -2)
		if(BOTTOM_LEFT)
			leg_control_system(input, -2, -2)

/mob/living/basic/megafauna/ancient_robot/proc/leg_control_system(input, horizontal, vertical)
	var/turf/target = locate(x + horizontal, y + vertical, z)
	switch(input)
		if(TOP_RIGHT)
			TR.leg_movement(target, 0.6)
		if(TOP_LEFT)
			TL.leg_movement(target, 0.6)
		if(BOTTOM_RIGHT)
			BR.leg_movement(target, 0.6)
		if(BOTTOM_LEFT)
			BL.leg_movement(target, 0.6)

/mob/living/basic/ancient_robot_leg/proc/leg_movement(turf/T, movespeed)
	walk_towards(src, T, movespeed)
	DestroySurroundings()

/mob/living/basic/ancient_robot_leg/proc/DestroySurroundings()
	var/static/list/ignore_types = list(/obj/machinery/camera, /obj/effect)
	for(var/dir in GLOB.alldirs)
		var/turf/T = get_step(src, dir)
		if(!T)
			continue
		if(T.density)
			T.attackby(src, src) // Smash walls/turfs
		for(var/obj/O in T.contents)
			if(O.density && !is_type_in_list(O, ignore_types))
				O.attackby(src, src) // Smash structures/machines

/mob/living/basic/megafauna/ancient_robot
	name = "\improper Vetus Speculator"
	desc = "An ancient robot from a long forgotten civilization. Adapts to the environment, and what it finds, to be the ideal combatant."
	health = 3000
	maxHealth = 3000
	icon = 'modular_nova/modules/lavaland_megafauna/icons/64x64megafauna.dmi'
	icon_state = "ancient_robot"
	ai_controller = /datum/ai_controller/basic_controller/ancient_robot

	var/charging = FALSE
	var/exploding = FALSE
	var/body_shield_enabled = FALSE
	var/mode = 0
	var/anger_modifier = 0
	var/ranged_cooldown = 2 SECONDS

	// Leg and effect references
	var/mob/living/basic/ancient_robot_leg/TR
	var/mob/living/basic/ancient_robot_leg/TL
	var/mob/living/basic/ancient_robot_leg/BR
	var/mob/living/basic/ancient_robot_leg/BL
	var/obj/effect/abstract/beam

/mob/living/basic/megafauna/ancient_robot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_HEAVY)
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE, TRAIT_BOMBIMMUNE, TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT), INNATE_TRAIT)

	beam = new(loc)
	TR = new(loc, src, TOP_RIGHT)
	TL = new(loc, src, TOP_LEFT)
	BR = new(loc, src, BOTTOM_RIGHT)
	BL = new(loc, src, BOTTOM_LEFT)

	mode = pick(BLUESPACE, GRAV, PYRO, FLUX, VORTEX, CRYO) //picks one of the 6 cores
	switch(mode)
		if(BLUESPACE)
			desc += " It emits sparks of blue energy."
		if(GRAV)
			desc += " Gravity seems to distort around it."
		if(PYRO)
			desc += " You see flames burning around it."
		if(FLUX) // Main attack is shock, so flux makes it stronger
			melee_damage_lower = 40
			melee_damage_upper = 60
			desc += " It seems to overflow with energy."
		if(VORTEX)
			desc += " You see space bend and distort around it."
		if(CRYO)
			desc += " The air surrounding it is cold and listless."
	body_shield()
	add_overlay("[mode]")

	body_shield()
	return INITIALIZE_HINT_LATELOAD

/mob/living/basic/megafauna/ancient_robot/Life(seconds, times_fired)
	. = ..()
	if(stat == DEAD)
		return
	anger_modifier = clamp(((maxHealth - health) / 50), 0, 20)
	if(exploding)
		playsound(src, 'sound/items/timer.ogg', 70, 0)

/mob/living/basic/megafauna/ancient_robot/death(gibbed, allowed = FALSE)
	if(allowed)
		return ..()
	if(exploding)
		return
	self_destruct()
	exploding = TRUE

// Logic for the body shield
/mob/living/basic/megafauna/ancient_robot/proc/body_shield()
	body_shield_enabled = TRUE
	add_overlay("shield")

/mob/living/basic/megafauna/ancient_robot/bullet_act(obj/projectile/P)
	if(!body_shield_enabled)
		return ..()
	if(P.damage)
		disable_shield()
	return ..()

/mob/living/basic/megafauna/ancient_robot/proc/disable_shield()
	cut_overlay("shield")
	body_shield_enabled = FALSE
	addtimer(CALLBACK(src, PROC_REF(body_shield)), 3 SECONDS)

/mob/living/basic/megafauna/ancient_robot/proc/self_destruct()
	say("-ROQK ZKGXY OT XGOT-")
	addtimer(CALLBACK(src, PROC_REF(kaboom)), 10 SECONDS)

/mob/living/basic/megafauna/ancient_robot/proc/kaboom()
	explosion(get_turf(src), -1, 7, 15, 20)
	death(allowed = TRUE)

/mob/living/basic/ancient_robot_leg
	name = "leg"
	icon = 'modular_nova/modules/lavaland_megafauna/icons/lavaland_monsters.dmi'
	icon_state = "leg"
	health = INFINITY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/mob/living/basic/megafauna/ancient_robot/core

/mob/living/basic/ancient_robot_leg/Initialize(mapload, mob/living/basic/megafauna/ancient_robot/owner, who)
	. = ..()
	core = owner
	if(!core)
		return INITIALIZE_HINT_QDEL
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE, TRAIT_BOMBIMMUNE), INNATE_TRAIT)

/mob/living/basic/ancient_robot_leg/adjust_health(amount, updating_health = TRUE)
	var/damage = amount * 0.75
	core.adjust_brute_loss(damage)
	return ..()

/mob/living/basic/megafauna/ancient_robot/proc/triple_charge()
	if(mode == BLUESPACE)
		// Bluespace cadence is slower to account for teleportation
		charge(delay = 24)
		charge(delay = 18)
		charge(delay = 12)
		charge(delay = 6)
	else
		// Standard physical charge cadence
		charge(delay = 9)
		charge(delay = 6)
		charge(delay = 3)

/mob/living/basic/megafauna/ancient_robot/proc/charge(atom/target, delay)
	if(mode == BLUESPACE || prob(13))
		do_teleport(src, target, precision = 7)
		TR.forceMove(loc)
		TL.forceMove(loc)
		BR.forceMove(loc)
		BL.forceMove(loc)

	charging = TRUE
	walk_towards(src, target, 0.8)
	addtimer(CALLBACK(src, .proc/end_charge), 3 SECONDS)

/mob/living/basic/megafauna/ancient_robot/proc/end_charge()
	walk(src, 0)
	charging = FALSE

/mob/living/basic/megafauna/ancient_robot/proc/single_laser()
	say(pick("KTMGMK JOYIU OTLKXTU", "ROQK G OTZKXTGR JOYQ", "HO-JOXKIZOUTGR RGYKXY KTMGMKJ"))
	new /obj/effect/vetus_laser(get_turf(src))

/obj/effect/vetus_laser
	icon = 'icons/obj/machines/engine/energy_ball.dmi'
	icon_state = "energy_ball"
	pixel_x = -32
	pixel_y = -32

/obj/effect/vetus_laser/Initialize(mapload)
	. = ..()
	var/newcolor = rgb(241, 137, 172)
	add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(src, PROC_REF(beam_it_up)), 0)

/obj/effect/vetus_laser/ex_act(severity)
	return

/obj/effect/vetus_laser/proc/beam_it_up()
	var/turf/beam_me_up_scotty = get_turf(src)
	for(var/turf/T in spiral_range_turfs(9, src, 9))
		T.Beam(beam_me_up_scotty, icon_state = "sm_arc_dbz_referance", time = 0.1, beam_type = /obj/effect/ebeam/vetus)
		SLEEP_CHECK_DEATH(1, src)
	qdel(src)

// The effect handles its own spiral beam logic via timers

/mob/living/basic/megafauna/ancient_robot/proc/spawn_anomalies()
	say(pick("JKVRUEOTM XGC VUCKX", "KXXUX OT GTUSGRE IUTZGOTSKTZ"))
	var/list/turfs = list()
	for(var/turf/T in view(7, src))
		if(!T.density)
			turfs += T

	var/count = 5
	while(count > 0 && length(turfs))
		var/turf/spot = pick_n_take(turfs)
		var/time_to_use = 25 SECONDS
		switch(mode)
			if(BLUESPACE)
				var/obj/effect/anomaly/bluespace/A = new(spot, time_to_use, FALSE)
				A.allow_detonate = FALSE
				new /obj/effect/anomaly/grav(spot, time_to_use, FALSE, FALSE)
			if(PYRO)
				var/obj/effect/anomaly/pyro/A = new(spot, time_to_use, FALSE)
				A.allow_detonate = FALSE
			if(FLUX)
				var/obj/effect/anomaly/flux/A = new(spot, time_to_use, FALSE)
				A.canshock = TRUE
			if(VORTEX)
				new /obj/effect/anomaly/bhole(spot, time_to_use, FALSE)
		count--

/mob/living/basic/megafauna/ancient_robot/proc/do_special_move(atom/target)
	say(pick("JKVRUEOTM LUIAYKJ VUCKX", "JKVRUEOTM KDVKXOSKTZGR GZZGIQ", "LUIAYOTM VUCKX OTZU GTUSGRUAY UHPKIZ", "VUCKX UL ZNK YAT OT ZNK NKGXZ UL SE IUXK"))
	switch(mode)
		if(BLUESPACE)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				to_chat(H, "<span class='danger'>[src] starts to slow time around you!</span>")
				H.apply_status_effect(/datum/status_effect/freezing_blast, src)
		if(GRAV)
			visible_message("<span class='danger'>Debris from the battlefield begin to get compressed into rocks!</span>")
			var/list/turfs = list()
			var/rocks = 0
			for(var/turf/T in view(4, target))
				if(T.density)
					continue
				if(T in range (2, target))
					continue
				turfs += T
			var/amount = 5
			while(rocks < amount && length(turfs))
				var/turf/spot = pick_n_take(turfs)
				if(!spot)
					return
				new /obj/effect/temp_visual/rock(spot)
				addtimer(CALLBACK(src, PROC_REF(throw_rock), spot, target), 2 SECONDS)
				rocks++
		if(PYRO)
			visible_message("<span class='danger'>The ground begins to heat up around you!</span>")
			var/list/turfs = list()
			var/volcanos = 0
			for(var/turf/T in view(4, target))
				if(T.density)
					continue
				if(T in range(1, target))
					continue
				turfs += T
			var/amount = 5
			while(volcanos < amount && length(turfs))
				var/turf/spot = pick_n_take(turfs)
				if(!spot)
					return
				for(var/turf/around in range(1, spot))
					new /obj/effect/temp_visual/lava_warning(around,18 SECONDS)
				volcanos++
		if(FLUX)
			for(var/mob/living/carbon/human/Human in view(7, src))
				var/turf/turf = get_turf(Human)
				var/turf/source = get_turf(src)
				if(!source || !turf)
					return
				var/obj/projectile/energy/tesla_bolt/bolt = new /obj/projectile/energy/tesla_bolt(source)
				bolt.yo = turf.y - source.y
				bolt.xo = turf.x - source.x
				bolt.fire()
		if(VORTEX)
			visible_message("<span class='danger'>[src] begins vibrate rapidly. It's causing an earthquake!</span>")
			for(var/turf/turf in range(16,get_turf(target)))
				if(prob(40))
					new /obj/effect/temp_visual/target/ancient(turf)
		if(CRYO)
			visible_message("<span class='danger'>[src]'s shell opens slightly, as sensors begin locking on to everyone around it!</span>")
			for(var/mob/living/carbon/human/H in view(20, src))
				H.apply_status_effect(/datum/status_effect/freezing_blast, src)

/// Leaving here for adminbus / so vetus still uses it.
/obj/projectile/energy/tesla_bolt
	name = "shock bolt"
	icon_state = "purple_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	damage = 5 //A worse lasergun
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE
	var/zap_range = 8
	var/power = 10000

/obj/item/ammo_casing/energy/tesla_bolt/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	..()
	var/obj/projectile/energy/tesla_bolt/P = loaded_projectile
	P.Beam(user, icon_state = "purple_lightning", icon = 'icons/effects/effects.dmi', time = 1000, maxdistance = 30)

/obj/projectile/energy/tesla_bolt/on_hit(atom/target)
	. = ..()
	tesla_zap(src, zap_range, power, zap_flags)
	qdel(src)

/obj/projectile/energy/tesla_bolt/Bump(atom/A, yes) // Don't want the projectile hitting the legs
	if(!istype(/mob/living/basic/ancient_robot_leg, A))
		return ..()
	var/turf/target_turf = get_turf(A)
	loc = target_turf

/mob/living/basic/megafauna/ancient_robot/proc/throw_rock(turf/spot, mob/target)
	var/turf/turf = get_turf(target)
	if(!spot || !turf)
		return
	var/obj/projectile/ancient_robot_rock/rock = new /obj/projectile/ancient_robot_rock(spot)
	rock.yo = turf.y - spot.y
	rock.xo = turf.x - spot.x
	rock.fire()

/obj/effect/temp_visual/fireball/rock
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small1"

/obj/projectile/ancient_robot_bullet
	damage = 8
	damage_type = BRUTE

/obj/projectile/ancient_robot_rock
	name= "thrown rock"
	damage = 25
	damage_type = BRUTE
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small1"

/obj/effect/temp_visual/rock
	name = "floating rock"
	desc = "Might want to focus on dodging, rather than looking at it."
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small1"
	duration = 20

/obj/effect/temp_visual/target/ancient

/obj/effect/temp_visual/target/ancient/fall(list/flame_hit)
	var/turf/current_loc = get_turf(src)
	playsound(current_loc,'sound/effects/magic/fleshtostone.ogg', 80, TRUE)
	new /obj/effect/temp_visual/fireball/rock(current_loc)
	SLEEP_CHECK_DEATH(duration,src)
	if(ismineralturf(current_loc))
		var/turf/closed/mineral/mineral_turf = current_loc
		mineral_turf.gets_drilled(src)
	playsound(current_loc, 'sound/effects/meteorimpact.ogg', 80, TRUE)
	for(var/mob/living/L in current_loc.contents)
		if(istype(L, /mob/living/basic/megafauna/ancient_robot))
			continue
		L.adjust_brute_loss(35)
		to_chat(L, "<span class='userdanger'>You're hit by the falling rock!</span>")

#undef BODY_SHIELD_COOLDOWN_TIME
#undef EXTRA_PLAYER_ANGER_NORMAL_CAP
#undef EXTRA_PLAYER_ANGER_STATION_CAP
#undef BLUESPACE
#undef GRAV
#undef PYRO
#undef FLUX
#undef CRYO
#undef VORTEX
#undef TOP_RIGHT
#undef TOP_LEFT
#undef BOTTOM_RIGHT
#undef BOTTOM_LEFT
