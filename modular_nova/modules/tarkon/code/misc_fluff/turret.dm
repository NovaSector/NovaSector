//////// Mag-fed Turret Framework.

////// Toolbox Handling //////
/obj/item/storage/toolbox/emergency/turret/mag_fed
	name = "T.I.B.S Cerberus Kit"
	desc = "A \"Tarkon Industries Blackrust Salvage\" \"Cerberus\" Turret Deployment Kit, It deploys a turret feeding from provided magazines. \
	This model comes with 3 adjustable magazine slots, supporting most commonly available magazines."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "toolbox"
	worn_icon_state = "turret_harness"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/belt.dmi'
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

/obj/item/storage/toolbox/emergency/turret/mag_fed/examine(mob/user)
	. = ..()
	. += span_notice("You can deploy this by clicking in <b>combat mode</b>")

/obj/item/storage/toolbox/emergency/turret/mag_fed/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

//////Grabs a mag to load into the turret
/obj/item/storage/toolbox/emergency/turret/mag_fed/proc/get_mag(keep = FALSE)
	var/mag_len = length(contents)
	if (!mag_len)
		return null
	var/yoink = contents[mag_len]
	if (keep)
		contents -= yoink
		contents.Insert(1,yoink)
	return yoink

/obj/item/storage/toolbox/emergency/turret/mag_fed/set_faction(obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret, mob/user)
	if(!(user.faction in turret.faction))
		turret.faction += user.faction
		turret.allies += REF(user)

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

////// Targeting Device handling

/obj/item/target_designator
	name = "Turret Target Designator"
	desc = "A simple target designation system used to let someone over-ride a turrets targeting software and focus on one entity, or designate someone as a \"Friend\"."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "designator"
	inhand_icon_state = ""
	lefthand_file = null
	righthand_file = null
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	var/scan_range = 7
	var/turret_limit = 3
	var/linked_turrets = list()
	var/acquired_target = null

/obj/item/target_designator/examine(mob/user)
	. = ..()
	. += span_notice("[length(linked_turrets)]/[turret_limit] turrets linked.")


/obj/item/target_designator/afterattack(atom/movable/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!can_see(user,target,scan_range)) //if outside range, dont bother.
		return

	if(target in linked_turrets) //to stop issues with linking turrets.
		return

	if(acquired_target) //if there's a target already, cant designate one.
		return

	designate_enemy(target, user)
	addtimer(CALLBACK(src, PROC_REF(clear_target), user), 5 SECONDS) //clears after 5 seconds. to avoid issues.
	return

/obj/item/target_designator/afterattack_secondary(atom/movable/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!can_see(user,target,scan_range)) //if outside range, dont bother.
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(istype(target, /mob/living))
		for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
			turret.toggle_ally(target)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN


/obj/item/target_designator/proc/designate_enemy(atom/movable/target, mob/user)
	if(!target)
		return
	acquired_target = target
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.override_target(acquired_target)
		balloon_alert(user, "Target Designated!")


/obj/item/target_designator/proc/clear_target(user)
	acquired_target = null
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.clear_override()
		balloon_alert(user, "Designation Cleared!")


////// Turret handling

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed
	name = "T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackrust Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	shot_delay = 2 SECONDS
	uses_stored = FALSE
	stored_gun = null
	stun_projectile = null
	lethal_projectile = null
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = TRUE
	req_access = list() //We use faction and ally system for access. Also so people can change turret flags as needed.
	faction = list()
	var/target_acquisition = null //This is for manual target acquisition stuff. If present, should immediately over-ride as a target.
	var/allies = list() //Ally system.
	var/claptrap_moment = FALSE //Do we want this to shut up? Mostly for testing purposes.
	var/casing_ejector = TRUE // Do we want it to eject casings?
	var/mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed //what box should this spawn with if its map_spawned?
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/mag_box //Container of the turret. Needs expanded ref.
	var/obj/item/ammo_box/magazine/magazine = null // Magazine inside the turret.
	var/obj/item/ammo_casing/chambered = null // currently loaded bullet
	var/obj/item/target_designator/linkage = null // linked targeter.

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/Initialize(mapload)
	. = ..()
	if(!mag_box) //If we want to make map-spawned turrets in turret form.
		mag_box = new mag_box_type

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/examine(mob/user) //If this breaks i'm gonna have to go to further seperate its examination text to allow better editing.
	. = ..()
	. -= span_notice("You can repair it by <b>left-clicking</b> with a combat wrench.")
	. -= span_notice("You can fold it by <b>right-clicking</b> with a combat wrench.")
	if((user.faction in faction) || (REF(user) in allies))
		. += span_notice("You can repair it by <b>left-clicking</b> with a wrench.")
		. += span_notice("You can fold it by <b>right-clicking</b> with a wrench.")
		. += span_notice("You can feed it by <b>left-clicking</b> with a magazine.")
		. += span_notice("You can link it by <b>left-clicking</b> with a target designator.")
		. += span_notice("You can unlink it by <b>right-clicking</b> with a target designator.")
		. += span_notice("You can force it to load a cartridge by <b>right-clicking</b> with an empty hand")
		if(linkage)
			. += span_notice("This turret is currently linked!")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/on_deconstruction(disassembled) // Full re-write, to stop the toolbox var from being a runtimer
	if(chambered)
		if(!chambered.loaded_projectile || QDELETED(chambered.loaded_projectile) || !chambered.loaded_projectile) //to catch very edge-case stuff thats likely to happen if the turret breaks mid-firing.
			chambered.forceMove(drop_location())
			chambered.loaded_projectile = null
		if(!magazine)
			chambered.forceMove(drop_location())
		else
			magazine.give_round(chambered) //put bullet back in magazine
		chambered = null

	if(magazine)
		mag_box.contents.Insert(1,magazine) //if the magazine is being kept this long, it might aswell be shoved back in.
		magazine = null

	if(!disassembled) //We make it oilsplode, but still retrievable.
		new /obj/effect/gibspawner/robot(drop_location())

	if(linkage)
		linkage.linked_turrets -= src
		linkage = null

	var/atom/movable/shell = mag_box
	mag_box = null
	shell.forceMove(drop_location())

	qdel(src)
	return


////// Ammo and magazine handling //////
//////main proc to handle loading magazines and bullets. might need improved?
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_chamber(chamber_next_round = TRUE)
	if(!magazine)
		load_mag()

	else if(!magazine.ammo_count())
		handle_mag()

	if(chambered)
		eject_cartridge()

	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round(FALSE)
		return

////// proc to insert the round.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/chamber_round(replace_new_round)
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		if(!claptrap_moment)
			balloon_alert_to_viewers("Loading Cartridge")
		chambered = magazine.get_round(keep = FALSE)
		chambered.forceMove(src)
		if(replace_new_round) //For edge-case additions later in the road.
			magazine.give_round(new chambered.type)

////// handles magazine ejecting and automatic load proccing
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_mag()
	if(magazine)
		var/obj/item/ammo_box/magazine/mag = magazine
		if(istype(mag))
			magazine.forceMove(drop_location())
			UnregisterSignal(magazine, COMSIG_MOVABLE_MOVED)
			magazine = null
	load_mag()
	return

////// handles magazine loading
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/load_mag()
	if(!mag_box.get_mag())
		balloon_alert_to_viewers("Magazine Wells Empty!") //hey, this is actually important info to convey.
		toggle_on(FALSE) // I know i added the shupt-up toggle after adding this, This is just to prevent rapid proccing
		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 5 SECONDS)
		return
	magazine = mag_box.get_mag(FALSE)
	magazine.forceMove(src)
	if(!claptrap_moment)
		balloon_alert_to_viewers("Loading Magazine")
	return

////// ejects cartridge and calls if issues arrive.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/eject_cartridge()
	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(casing.loaded_projectile)
			if(QDELETED(casing.loaded_projectile))
				stack_trace("Trying to move a casing with a deleted projectile!")
				chambered.loaded_projectile = null
		if(QDELING(casing))
			stack_trace("Trying to move a qdeleted casing of type [casing.type]!")
			chambered = null
		else if(casing_ejector) //If, It somehow, Didn't delete the casing.
			if(!claptrap_moment)
				balloon_alert_to_viewers("Ejecting Cartridge")
			casing.forceMove(drop_location()) //Eject casing onto ground.
			chambered = null
			if(!QDELETED(casing))
				casing.bounce_away(TRUE)
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)

////// redundant proc thats mostly for making sure stuff isn't qdel'ing
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/check_cartridge() //There's some edge cases where shite happens.
	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(casing.loaded_projectile)
			if(QDELETED(casing.loaded_projectile))
				stack_trace("Trying to shoot bullet with a deleted projectile!")
				return FALSE
	return TRUE

////// Allows you to insert magazines while the turret is deployed
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/insert_mag(obj/item/ammo_box/magazine/magaroni, mob/living/guy_with_mag)
	if(!(magaroni.type in mag_box.atom_storage.can_hold))
		balloon_alert(guy_with_mag, "Item Can't Fit, How did you get here?")
		return
	balloon_alert(guy_with_mag, "Magazine Inserted!")
	mag_box?.atom_storage.attempt_insert(magaroni, guy_with_mag, TRUE)
	return

////// I rewrite/add to the entire proccess. //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/process()
	if(linkage)
		if(target_acquisition) //Forces turret to shoot
			var/ineedtoshootthis = list(target_acquisition)
			tryToShootAt(ineedtoshootthis)
			return

	. = ..()


////// Firing and target acquisition //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/in_faction(mob/target)
	for(var/faction1 in faction)
		if((faction1 in target.faction) || (REF(target) in allies)) // For an Ally System
			return TRUE
	return FALSE

////// toggles between whether things are inside the ally system
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/toggle_ally(mob/living/target) //leave these since its kinda important to know which is being done.
	if(REF(target) in allies)
		allies -= REF(target)
		balloon_alert_to_viewers("Ally Removed!")
		return
	else
		allies += REF(target)
		balloon_alert_to_viewers("Ally Designated!")
		return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/target(atom/movable/target)
	if(target)
		popUp() //pop the turret up if it's not already up.
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		return 1
	return

////// manual target acquisition from target designator, improves fire rate.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/override_target(atom/movable/target)
	if(!target)
		return
	target_acquisition = target
	balloon_alert_to_viewers("Target Acquired!") //So you know whats causing it to fire
	shot_delay = (initial(shot_delay) / 2) //No need to scan for targets so faster work

////// clears the target and resets fire rate
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/clear_override()
	target_acquisition = null
	shot_delay = initial(shot_delay)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/tryToShootAt(list/atom/movable/things_in_my_lawn) //better target prioritization, shoots at closest simple mob
	while(target_acquisition)
		if(target(target_acquisition))
			return 1
	var/turf/MyLawn = get_turf(src)
	while(things_in_my_lawn.len > 0)
		var/atom/movable/whipper_snapper = get_closest_atom(/mob/living, things_in_my_lawn, MyLawn)
		if(target(whipper_snapper))
			return 1


/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/shootAt(atom/movable/target)
	if(!chambered) //Ok, We need to START the cycle
		handle_chamber(TRUE)
		return

	if(!raised) //the turret has to be raised in order to fire - makes sense, right?
		return

	if(!(obj_flags & EMAGGED)) //if it hasn't been emagged, cooldown before shooting again
		if(last_fired + shot_delay > world.time)
			return
		last_fired = world.time

	var/turf/MyLawn = get_turf(src)
	var/turf/targetturf = get_turf(target)
	if(!istype(MyLawn) || !istype(targetturf))
		return

	setDir(get_dir(base, target))
	update_appearance()
	if(!check_cartridge())
		balloon_alert_to_viewers("Gun jammed!")
		return

	if(chambered.loaded_projectile && !QDELETED(chambered.loaded_projectile))
		var/obj/projectile/MyLoad = chambered.loaded_projectile
		MyLoad.preparePixelProjectile(target, MyLawn)
		MyLoad.firer = src
		MyLoad.fired_from = src
		if(ignore_faction)
			MyLoad.ignored_factions = (faction + allies)
		MyLoad.fire()
		MyLoad.fired = TRUE
		MyLoad = null //We clear the ref from here. Pretty sure not needed but just in case.
		chambered.loaded_projectile = null //clear the reference from here, as we didn't go through a casing_firing proc
		handle_chamber(TRUE)
		return

	handle_chamber(TRUE)


////// Operation Handling //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.type in mag_box.atom_storage.can_hold)
		balloon_alert(user, "Attempting to load mag!")
		if(!do_after(user, 1 SECONDS, src))
			balloon_alert(user, "Failure to load mag!")
		insert_mag(attacking_item, user)
		return

	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/boss = attacking_item
			if(length(boss.linked_turrets) >= boss.turret_limit)
				balloon_alert(user, "Turret limit maxed!")
				return
			if(linkage) //should help both preventing dual-controlling AND double-linking causing odd issues with ally system
				balloon_alert(user, "Turret already linked!")
				return
			linkage = boss
			boss.linked_turrets += src
			return

	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(!attacking_item.toolspeed)
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

			repair_damage(25)

		if(!claptrap_moment)
			balloon_alert(user, "repaired!")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby_secondary(obj/item/attacking_item, mob/living/user, params) //IM TIRED OF MISMATCHED VAR NAMES. ITS ATTACK_ITEM ON MAIN, WHY WEAPON HERE?
	. = ..()
	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/boss = attacking_item
			linkage = null
			boss.linked_turrets -= src
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!istype(attacking_item, /obj/item/wrench))
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!attacking_item.toolspeed)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!claptrap_moment)
		balloon_alert(user, "deconstructing...")
	if(!attacking_item.use_tool(src, user, 5 SECONDS, volume = 20))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	attacking_item.play_tool_sound(src, 50)
	deconstruct(TRUE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!chambered)
		handle_chamber(TRUE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

