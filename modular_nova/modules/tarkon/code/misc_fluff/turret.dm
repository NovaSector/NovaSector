/obj/item/storage/toolbox/emergency/turret/mag_fed
	name = "T.I.B.S Cerberus Kit"
	desc = "A \"Tarkon Industries Blackwall Salvage\" \"Cerberus\" Turret Deployment Kit, It deploys a turret feeding from provided magazines. \
	This model comes with 3 adjustable magazine slots, supporting most commonly available magazines."
	has_latches = FALSE
	slot_flags = ITEM_SLOT_BELT
	var/turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed //To make it more available for subtyping. LET. THEM. COOK.
	var/mag_slots = 3 //how many magazines can be held.
	var/mag_types_allowed = list( //This is a whitelist for what is allowed. Nothing else may enter.
		/obj/item/ammo_box/magazine/c35sol_pistol,
		/obj/item/ammo_box/magazine/c40sol_rifle,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
		/obj/item/ammo_box/magazine/lanca,)

/obj/item/storage/toolbox/emergency/turret/mag_fed/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = mag_slots
	atom_storage.can_hold = typecacheof(mag_types_allowed)
	update_appearance()

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
	name = "T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackwall Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 350
	move_resist = INFINITY
	shot_delay = 2 SECONDS
	stun_projectile = null
	lethal_projectile = null
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = TRUE
	faction = list()
	var/claptrap_moment = FALSE //Do we want this to shut up?
	var/casing_ejector = TRUE // Do we want it to eject casings?
	var/mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed //what box should this spawn with if its map_spawned?
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/mag_box //Container of the turret. Needs expanded ref.
	var/obj/item/ammo_box/magazine/magazine = null // Magazine inside the turret.
	var/obj/item/ammo_casing/chambered = null // currently loaded bullet
	var/mob/living/turret_ai/shutupruntimes // WE PUT A HOPEFULLY INVISIBLE MOB ONTOP TO STOP RUNTIMES. I LOVE BULLET CODE

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/Initialize(mapload)
	. = ..()
	shutupruntimes = new /mob/living/turret_ai(get_turf(src))
	shutupruntimes.turretsync = src

	if(!mag_box) //If we want to make map-spawned turrets in turret form.
		mag_box = new mag_box_type

/obj/item/storage/toolbox/emergency/turret/mag_fed/set_faction(obj/machinery/porta_turret/turret, mob/user)
	if(!(user.faction in turret.faction))
		turret.faction += user.faction
		turret.faction += REF(user)

/obj/item/storage/toolbox/emergency/turret/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(in_contents_of(user))
		return

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
			if(!casing_ejector) //if the case ejector is turned off, we just dont make it.
				return
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
		if(!claptrap_moment)
			balloon_alert_to_viewers("Loading Cartridge")
		if(ignore_faction) //If we want projectiles to phase through allies. Thank that its possible.
			if(chambered.loaded_projectile)
				chambered.loaded_projectile.ignored_factions = faction
		if(replace_new_round) //For edge-case additions later in the road.
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

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/target(atom/movable/target)
	if(!target)
		if(!claptrap_moment)
			balloon_alert_to_viewers("Assessing Targets")
	..()

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/load_mag()
	if(!mag_box.get_mag())
		if(!claptrap_moment)
			balloon_alert_to_viewers("Magazine Wells Empty!")
		toggle_on(FALSE) // I know i added the shupt-up toggle after adding this, This is just to prevent rapid proccing
		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 5 SECONDS)
		return
	magazine = mag_box.get_mag(FALSE)
	magazine.forceMove(src)
	if(!claptrap_moment)
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
	if(!chambered.fire_casing(target, shutupruntimes, null, 0, 0, null, 0, src)) //Something here about having the AI mob breaks the turret ejecting spent shells. But without it, we runtime like hell.
		handle_chamber(FALSE, FALSE, TRUE)
	else
		handle_chamber(FALSE, TRUE, TRUE)

	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.type in mag_box.atom_storage.can_hold)
		if(magazine)
			if(length(mag_box.contents) < 2)
				mag_box.contents.Insert(1,attacking_item)
				if(!claptrap_moment)
					balloon_alert(user, "Magazine added!")
				return
		else if(!magazine)
			if(length(mag_box.contents) < 3)
				mag_box.contents.Insert(1,attacking_item)
				if(!claptrap_moment)
					balloon_alert(user, "Magazine added!")
				return
		else
			if(!claptrap_moment)
				balloon_alert(user, "Magazine slots full!")
			return

	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(!attacking_item.toolspeed)
		return

	if(user.combat_mode)
		if(!claptrap_moment)
			balloon_alert(user, "deconstructing...")
		if(!attacking_item.use_tool(src, user, 5 SECONDS, volume = 20))
			return

		attacking_item.play_tool_sound(src, 50)
		deconstruct(TRUE)
		return

	else
		if(atom_integrity == max_integrity)
			if(!claptrap_moment)
				balloon_alert(user, "already repaired!")
			return

		if(!claptrap_moment)
			balloon_alert(user, "repairing...")
		while(atom_integrity != max_integrity)
			if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
				return

			repair_damage(10)
		if(!claptrap_moment)
			balloon_alert(user, "repaired!")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby_secondary(obj/item/weapon, mob/living/user, params)
	. = ..()
	if(istype(weapon, /obj/item/wrench) && user.combat_mode)
		if(atom_integrity == max_integrity)
			if(!claptrap_moment)
				balloon_alert(user, "already repaired!")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		if(!claptrap_moment)
			balloon_alert(user, "repairing...")
		while(atom_integrity != max_integrity)
			if(!weapon.use_tool(src, user, 2 SECONDS, volume = 20))
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

			repair_damage(10)
			if(!claptrap_moment)
				balloon_alert(user, "repaired!")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!chambered)
		handle_chamber(FALSE,FALSE,TRUE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/deconstruct(disassembled) // Full re-write, to stop the toolbox var from being a runtimer
	if(chambered)
		if(!chambered.loaded_projectile) //to catch very edge-case stuff thats likely to happen if the turret breaks mid-firing.
			chambered.forceMove(drop_location())
		if(!magazine)
			chambered.forceMove(drop_location())
		chambered.loaded_projectile.ignored_factions = initial(chambered.loaded_projectile.ignored_factions) //Cover our asses hopefully?
		magazine.stored_ammo.Insert(1,chambered) //put bullet back in magazine
		chambered = null

	if(magazine)
		mag_box.contents.Insert(1,magazine) //if the magazine is being kept this long, it might aswell be shoved back in.
		magazine = null

	if(shutupruntimes) //to avoid leftover mobs.
		shutupruntimes.turretsync = null
		qdel(shutupruntimes)
		shutupruntimes = null

	if(!disassembled) //We make it oilsplode, but still retrievable.
		new /obj/effect/gibspawner/robot(drop_location())

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
	plane = POINT_PLANE //Should not be seen. Should not be touched. WE CANT PUT IT IN THE TURRET OR TURRET SHOOTS ITSELF.
	combat_mode = TRUE //Because bullet has combat_mode queries and we want them to trigger.
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turretsync

