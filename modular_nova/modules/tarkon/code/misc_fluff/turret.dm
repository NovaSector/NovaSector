/obj/item/storage/toolbox/emergency/turret/mag_fed

/obj/item/storage/toolbox/emergency/turret/mag_fed/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

/obj/item/storage/toolbox/emergency/turret/mag_fed/proc/get_mag(keep = FALSE)
	var/mag_len = length(contents)
	if (!mag_len)
		return null
	var/yoink = contents[mag_len]
	if (keep)
		contents -= yoink
		contents.Insert(1,yoink)
	return yoink

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed
	integrity_failure = 0
	max_integrity = 250
	move_resist = INFINITY
	shot_delay = 1 SECONDS
	stun_projectile = null
	lethal_projectile = null
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = TRUE
	faction = list()
	var/casing_ejector = TRUE // WILL THIS FIX IT!?
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/mag_box //Container of the turret. Needs expanded ref.
	var/obj/item/ammo_box/magazine/magazine = null // Magazine inside the turret.
	var/obj/item/ammo_casing/chambered = null // currently loaded bullet
	var/mob/living/turret_ai/shutupruntimes // WE PUT A HOPEFULLY INVISIBLE MOB ONTOP TO STOP RUNTIMES. I LOVE BULLET CODE

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/Initialize(mapload)
	. = ..()
	shutupruntimes = new /mob/living/turret_ai(get_turf(src))
	shutupruntimes.turretsync = src

/obj/item/storage/toolbox/emergency/turret/mag_fed/set_faction(obj/machinery/porta_turret/turret, mob/user)
	turret.faction = user.faction

/obj/item/storage/toolbox/emergency/turret/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(!user.combat_mode)
		return

	if(!attacking_item.toolspeed)
		return

	balloon_alert_to_viewers("constructing...")
	if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
		return

	balloon_alert_to_viewers("constructed!")
	user.visible_message(span_danger("[user] bashes [src] with [attacking_item]!"), \
		span_danger("You bash [src] with [attacking_item]!"), null, COMBAT_MESSAGE_RANGE)

	playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret = new(get_turf(loc))
	set_faction(turret, user)
	turret.mag_box = src
	forceMove(turret)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!magazine)
		load_mag()

	else if(!magazine.ammo_count())
		handle_mag()

	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(QDELING(casing)) //I WONT LOSE TO YOU, CODE. MY HUBRIS KNOWS NO BOUNDS.
			var/obj/item/ammo_casing/spent_round = new casing.type(get_turf(src))
			spent_round.loaded_projectile = null
			spent_round.bounce_away(TRUE)
			SEND_SIGNAL(spent_round, COMSIG_CASING_EJECTED)
			chambered = null
		else if(casing_ejector || !from_firing) //If, It somehow, Didn't delete the casing.
			casing.forceMove(drop_location()) //Eject casing onto ground.
			chambered = null
			if(!QDELETED(casing))
				casing.bounce_away(TRUE)
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
		else if(empty_chamber)
			UnregisterSignal(chambered, COMSIG_MOVABLE_MOVED)
			chambered = null
	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()
		return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/chamber_round(replace_new_round)
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		chambered = magazine.get_round(keep = FALSE)
		chambered.forceMove(src)
		if(replace_new_round)
			magazine.give_round(new chambered.type)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_mag()
	if(magazine)
		var/obj/item/ammo_box/magazine/mag = magazine
		if(istype(mag)) //there's a chambered round
			magazine.forceMove(drop_location())
			UnregisterSignal(magazine, COMSIG_MOVABLE_MOVED)
			magazine = null
	load_mag()
	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/load_mag()
	if(!mag_box.get_mag())
		balloon_alert_to_viewers("Magazine Wells Empty!")
		toggle_on(FALSE) // If its in this state, it needs to STFU
		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 6 SECONDS)
		return
	magazine = mag_box.get_mag(FALSE)
	magazine.forceMove(src)
	balloon_alert_to_viewers("Loading Magazine")
	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/shootAt(atom/movable/target)
	if(!chambered) //Ok, We need to START the cycle
		handle_chamber(TRUE, FALSE, TRUE)
		return

	if(!raised) //the turret has to be raised in order to fire - makes sense, right?
		return

	if(!(obj_flags & EMAGGED)) //if it hasn't been emagged, cooldown before shooting again
		if(last_fired + shot_delay > world.time)
			return
		last_fired = world.time

	var/turf/Turf = get_turf(src)
	var/turf/targetturf = get_turf(target)
	if(!istype(Turf) || !istype(targetturf))
		return

	//Wall turrets will try to find adjacent empty turf to shoot from to cover full arc
	if(Turf.density)
		if(wall_turret_direction)
			var/turf/closer = get_step(Turf,wall_turret_direction)
			if(istype(closer) && !closer.is_blocked_turf() && Turf.Adjacent(closer))
				Turf = closer
		else
			var/target_dir = get_dir(Turf,target)
			for(var/d in list(0,-45,45))
				var/turf/closer = get_step(Turf,turn(target_dir,d))
				if(istype(closer) && !closer.is_blocked_turf() && Turf.Adjacent(closer))
					Turf = closer
					break

	update_appearance()
	if(!chambered.fire_casing(target, shutupruntimes, null, 0, 0, null, 0, shutupruntimes.turretsync))
		handle_chamber(FALSE, FALSE, TRUE)
	else
		handle_chamber(FALSE, TRUE, TRUE)

	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(!attacking_item.toolspeed)
		return

	if(user.combat_mode)
		balloon_alert(user, "deconstructing...")
		if(!attacking_item.use_tool(src, user, 5 SECONDS, volume = 20))
			return

		attacking_item.play_tool_sound(src, 50)
		deconstruct(TRUE)
		return

	else
		if(atom_integrity == max_integrity)
			balloon_alert(user, "already repaired!")
			return

		balloon_alert(user, "repairing...")
		while(atom_integrity != max_integrity)
			if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
				return

			repair_damage(10)

		balloon_alert(user, "repaired!")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/deconstruct(disassembled) // Full re-write, to stop the toolbox var from being a runtimer
	if(chambered)
		if(!magazine)
			chambered.forceMove(drop_location())
		magazine.stored_ammo.Insert(1,chambered)
		chambered = null

	if(magazine)
		mag_box.contents.Insert(1,magazine)
		magazine = null

	if(shutupruntimes)
		shutupruntimes.turretsync = null
		qdel(shutupruntimes)
		shutupruntimes = null

	if(disassembled)
		var/atom/movable/shell = mag_box
		mag_box = null
		shell.forceMove(drop_location())

	qdel(src)
	return

/mob/living/turret_ai // SHOULD NOT BE SEEN. SHOULD NOT BE TOUCHED. SHOULD NOT BE VISIBLE OUTSIDE OF- IDK. I'M NOT A GOOD CODER.
	name = "mag_fed turret AI"
	desc = "Part of the Itty Bitty Anti-Runtime Committee. You probably shouldn't be seeing this."
	density = FALSE
	see_invisible = 0
	invisibility = INVISIBILITY_OBSERVER
	plane = POINT_PLANE
	combat_mode = TRUE
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turretsync

