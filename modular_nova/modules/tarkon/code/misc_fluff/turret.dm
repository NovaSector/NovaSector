//////// Mag-fed Turret Framework.

////// Toolbox Handling //////
/obj/item/storage/toolbox/emergency/turret/mag_fed
	name = "\improper T.I.B.S Cerberus Kit"
	desc = "A \"Tarkon Industries Blackrust Salvage\" \"Cerberus\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 3 adjustable magazine slots, supporting most commonly available magazines."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_toolbox"
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	inhand_icon_state = "cerberus_turretkit"
	worn_icon_state = "cerberus_harness"
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
		/obj/item/ammo_box/magazine/lanca,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = mag_slots
	atom_storage.can_hold = typecacheof(mag_types_allowed)
	update_appearance()

/obj/item/storage/toolbox/emergency/turret/mag_fed/examine(mob/user)
	. = ..()
	. += span_notice("You can deploy this by clicking in <b>combat mode</b> with a <b>wrenching tool</b>")

/obj/item/storage/toolbox/emergency/turret/mag_fed/PopulateContents()

/obj/item/storage/toolbox/emergency/turret/mag_fed/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)
	new /obj/item/ammo_box/magazine/c585trappiste_pistol(src)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite
	name = "\improper Tarkon Industries Hoplite Kit"
	desc = "A \"Tarkon Industries\" \"Hoplite\" Turret Deployment Kit, it deploys a turret feeding from provided magazines. \
	This model comes with 2 adjustable magazine slots, supporting most commonly available pistol-cal magazines."
	icon_state = "hoplite_toolbox"
	worn_icon_state = "hoplite_harness"
	inhand_icon_state = "hoplite_turretkit"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	mag_slots = 2
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c35sol_pistol,
		/obj/item/ammo_box/magazine/c585trappiste_pistol,
		/obj/item/ammo_box/magazine/miecz,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

//////Grabs a mag to load into the turret
/obj/item/storage/toolbox/emergency/turret/mag_fed/proc/get_mag(keep = FALSE)
	var/mag_len = length(contents)
	if (!mag_len)
		return
	var/yoink = contents[mag_len]
	if (keep)
		atom_storage?.attempt_insert(yoink, override = TRUE)
	return yoink

/obj/item/storage/toolbox/emergency/turret/mag_fed/set_faction(obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret, mob/user)
	if(!(user.faction in turret.faction))
		turret.faction += user.faction
		turret.allies += REF(user)

/obj/item/storage/toolbox/emergency/turret/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.tool_behaviour != TOOL_WRENCH)
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
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret = new turret_type(get_turf(loc))
	set_faction(turret, user)
	turret.mag_box = WEAKREF(src)
	forceMove(turret)

////// Targeting Device handling

/obj/item/target_designator
	name = "Turret Target Designator"
	desc = "A simple target designation system used to let someone over-ride a turrets targeting software and focus on one entity, or designate someone as a \"Friend\"."
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "designator"
	inhand_icon_state = "designator"
	righthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/tarkon/icons/mob/inhands/lefthand.dmi'
	worn_icon_state = "designator"
	worn_icon = 'modular_nova/modules/tarkon/icons/mob/clothing/belt.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	////// the range it can scan at.
	var/scan_range = 10
	////// how many turrets it can have. changable incase of better ones wanted.
	var/turret_limit = 3
	////// the currently linked turrets.
	var/linked_turrets = list()
	////// the target currently being targeted.
	var/datum/weakref/acquired_target
	////// how long the target can be focused. changable incase of better ones wanted.
	var/acquisition_duration = 5 SECONDS

/obj/item/target_designator/examine(mob/user)
	. = ..()
	. += span_notice("<b>[length(linked_turrets)]/[turret_limit]</b> turrets linked.")
	. += span_notice("<b>Right click</b> an entity to designate it as an ally.")
	. += span_notice("<b>Left click</b> a spot or entity to designate it as a target.")

/obj/item/target_designator/afterattack(atom/movable/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!can_see(user,target,scan_range)) //if outside range, dont bother.
		return

	if(target in linked_turrets) //to stop issues with linking turrets.
		return

	if(acquired_target) //if there's a target already, cant designate one.
		return

	designate_enemy(target, user)
	addtimer(CALLBACK(src, PROC_REF(clear_target), user), acquisition_duration) //clears after 5 seconds. to avoid issues.
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
	acquired_target = WEAKREF(target)
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.override_target(acquired_target?.resolve())
		balloon_alert(user, "target designated!")


/obj/item/target_designator/proc/clear_target(user)
	acquired_target = null
	for(var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret in linked_turrets)
		for(var/turret_to_control in 1 to length(linked_turrets))
			turret.clear_override()
		balloon_alert(user, "designation cleared!")


////// Turret handling

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed
	name = "T.I.B.S \"Cerberus\" Guardian Turret"
	desc = "A heavy-protection turret used in the Tarkon Industries Blackrust Salvage group to protect its workers in hazardous conditions."
	integrity_failure = 0
	max_integrity = 200
	icon = 'modular_nova/modules/tarkon/icons/obj/turret.dmi'
	icon_state = "cerberus_off"
	base_icon_state = "cerberus"
	shot_delay = 2 SECONDS
	uses_stored = FALSE
	stored_gun = null
	stun_projectile = null
	stun_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	lethal_projectile = null
	lethal_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = TRUE
	req_access = list() //We use faction and ally system for access. Also so people can change turret flags as needed, though useless bc of syndicate subtyping.
	faction = list()
	////// Can this turret load more than one ammunition type. Mostly for sound handling. Might be more important if used in a rework.
	var/adjustable_magwell = TRUE
	//////This is for manual target acquisition stuff. If present, should immediately over-ride as a target.
	var/target_acquisition = null
	//////Ally system.
	var/allies = list()
	//////Do we want this to shut up? Mostly for testing and debugging purposes purposes.
	var/claptrap_moment = TRUE
	////// Do we want it to eject casings?
	var/casing_ejector = TRUE
	//////what box should this spawn with if its map_spawned?
	var/mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/pre_filled
	//////Container of the turret. Needs expanded ref.
	var/datum/weakref/mag_box
	////// Magazine inside the turret.
	var/datum/weakref/magazine_ref
	////// currently loaded bullet
	var/datum/weakref/chambered
	////// linked target designator
	var/datum/weakref/linkage

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/Initialize(mapload)
	. = ..()
	if(!mag_box) //If we want to make map-spawned turrets in turret form.
		var/auto_loader = new mag_box_type
		mag_box = WEAKREF(auto_loader)

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
			. += span_notice("<b><i>This turret is currently linked!</i></b>")

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/on_deconstruction(disassembled) // Full re-write, to stop the toolbox var from being a runtimer
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	var/obj/item/ammo_casing/casing = chambered?.resolve()
	if(isnull(casing))
		chambered = null
	if(chambered)
		if(!casing.loaded_projectile || QDELETED(casing.loaded_projectile) || !casing.loaded_projectile) //to catch very edge-case stuff thats likely to happen if the turret breaks mid-firing.
			casing.forceMove(drop_location())
			casing.loaded_projectile = null
		if(!magazine_ref)
			casing.forceMove(drop_location())
		else if(mag)
			mag.give_round(casing) //put bullet back in magazine
		chambered = null

	if(magazine_ref)
		if(auto_loader) //if the magazine is being kept this long, it might aswell be shoved back in.
			auto_loader.atom_storage?.attempt_insert(mag, override = TRUE)
		magazine_ref = null

	if(!disassembled) //We make it oilsplode, but still retrievable.
		new /obj/effect/gibspawner/robot(drop_location())

	var/obj/item/target_designator/controller = linkage?.resolve()
	if(!isnull(controller))
		controller.linked_turrets -= src
		UnregisterSignal(controller, COMSIG_QDELETING)
	linkage = null

	mag_box = null
	auto_loader?.forceMove(drop_location())

	qdel(src)
	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/hoplite
	name = "\improper Tarkon Industries \"Hoplite\" Point-Defense Turret"
	desc = "A protection turret used by Tarkon Industries for civilian installation protection."
	max_integrity = 120
	icon_state = "hoplite_off"
	base_icon_state = "hoplite"
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/hoplite


////// Ammo and magazine handling //////
//////main proc to handle loading magazines and bullets. might need improved?
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_chamber(chamber_next_round = TRUE)
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	if(isnull(magazine_ref))
		load_mag()

	else if(mag && !mag.ammo_count())
		handle_mag()

	if(chambered)
		eject_cartridge()

	if (chamber_next_round && (mag?.max_ammo > 1))
		chamber_round(FALSE)
		return

////// proc to insert the round.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/chamber_round(replace_new_round)
	var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
	if(isnull(mag))
		magazine_ref = null
	if (chambered || isnull(magazine_ref))
		return
	if (mag.ammo_count())
		if(!claptrap_moment)
			balloon_alert_to_viewers("loading cartridge...")
		chambered = WEAKREF(mag.get_round(keep = FALSE))
		var/obj/item/ammo_casing/casing = chambered?.resolve()
		if(isnull(casing))
			chambered = null
		casing.forceMove(src)
		playsound(src, 'sound/weapons/gun/general/bolt_rack.ogg', 10, TRUE)
		if(replace_new_round) //For edge-case additions later in the road.
			mag.give_round(new casing.type)

////// handles magazine ejecting and automatic load proccing
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/handle_mag()
	if(magazine_ref)
		var/obj/item/ammo_box/magazine/mag = magazine_ref?.resolve()
		if(istype(mag))
			mag.forceMove(drop_location())
			UnregisterSignal(magazine_ref, COMSIG_MOVABLE_MOVED)
		magazine_ref = null
	load_mag()
	playsound(src, 'sound/weapons/gun/general/chunkyrack.ogg', 30, TRUE)
	return

////// handles magazine loading
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/load_mag()
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(!auto_loader.get_mag())
		balloon_alert_to_viewers("magazine well empty!") // hey, this is actually important info to convey.
		toggle_on(FALSE) // I know i added the shupt-up toggle after adding this, This is just to prevent rapid proccing
		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 5 SECONDS)
		return
	magazine_ref = WEAKREF(auto_loader.get_mag(FALSE))
	var/obj/item/ammo_box/magazine/get_that_mag = magazine_ref?.resolve()
	if(isnull(get_that_mag))
		magazine_ref = null
	get_that_mag.forceMove(src)
	if(!claptrap_moment)
		balloon_alert_to_viewers("loading magazine...")
	return

////// ejects cartridge and calls if issues arrive.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/eject_cartridge()
	var/obj/item/ammo_casing/casing = chambered?.resolve() //Find chambered round. i'd give this a funny var name but casing was already here.
	if(isnull(casing))
		chambered = null
	if(istype(casing)) //there's a chambered round
		if(casing.loaded_projectile)
			if(QDELETED(casing.loaded_projectile))
				stack_trace("Trying to move a casing with a deleted projectile!")
				casing.loaded_projectile = null
		if(QDELETED(casing))
			stack_trace("Trying to move a qdeleted casing of type [casing.type]!")
			chambered = null
		else if(casing_ejector) //If, It somehow, Didn't delete the casing.
			if(!claptrap_moment)
				balloon_alert_to_viewers("ejecting cartridge") // will proc even on caseless cartridges, but its a debug message.
			casing.forceMove(drop_location()) //Eject casing onto ground.
			chambered = null
			SEND_SIGNAL(casing, COMSIG_FIRE_CASING) //to account for caseless cartridges.
			casing.bounce_away(TRUE)
			SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)

////// redundant proc thats mostly for making sure stuff isn't qdel'ing
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/check_cartridge() //There's some edge cases where shite happens.
	var/obj/item/ammo_casing/casing = chambered?.resolve() //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(casing.loaded_projectile)
			if(QDELETED(casing.loaded_projectile))
				stack_trace("Trying to shoot bullet with a deleted projectile!")
				return FALSE
	return TRUE

////// Allows you to insert magazines while the turret is deployed
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/insert_mag(obj/item/ammo_box/magazine/magaroni, mob/living/guy_with_mag)
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	if(!(magaroni.type in auto_loader.atom_storage.can_hold))
		balloon_alert(guy_with_mag, "can't fit!")
		return
	balloon_alert(guy_with_mag, "magazine inserted!")
	auto_loader?.atom_storage.attempt_insert(magaroni, guy_with_mag, TRUE)
	return

////// I rewrite/add to the entire proccess. //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/process()
	if(linkage)
		if(target_acquisition) //Forces turret to shoot
			var/ineedtoshootthis = list(target_acquisition)
			tryToShootAt(ineedtoshootthis)
			return

	return ..()


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
		balloon_alert_to_viewers("ally removed!")
		return
	else
		allies += REF(target)
		balloon_alert_to_viewers("ally designated!")
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
	balloon_alert_to_viewers("target acquired!") // So you know whats causing it to fire
	shot_delay = (initial(shot_delay) / 2) //No need to scan for targets so faster work

////// clears the target and resets fire rate
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/clear_override()
	target_acquisition = null
	shot_delay = initial(shot_delay)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/tryToShootAt(list/atom/movable/things_in_my_lawn) //better target prioritization, shoots at closest simple mob
	while(target_acquisition)
		if(target(target_acquisition))
			return 1
	var/turf/my_lawn = get_turf(src)
	while(things_in_my_lawn.len > 0)
		var/atom/movable/whipper_snapper = get_closest_atom(/mob/living, things_in_my_lawn, my_lawn)
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

	var/turf/my_lawn = get_turf(src)
	var/turf/targetturf = get_turf(target)
	if(!istype(my_lawn) || !istype(targetturf))
		return

	setDir(get_dir(base, target))
	update_appearance()
	if(!check_cartridge())
		balloon_alert_to_viewers("gun jammed!")
		return

	var/obj/item/ammo_casing/casing = chambered?.resolve()
	if(casing.loaded_projectile && !QDELETED(casing.loaded_projectile))
		var/obj/projectile/our_projectile = casing.loaded_projectile
		our_projectile.preparePixelProjectile(target, my_lawn)
		our_projectile.firer = src
		our_projectile.fired_from = src
		if(ignore_faction)
			our_projectile.ignored_factions = (faction + allies)
		our_projectile.fire()
		our_projectile.fired = TRUE
		play_fire_sound(casing)
		our_projectile = null // We clear the ref from here. Pretty sure not needed but just in case.
		casing.loaded_projectile = null //clear the reference from here, as we didn't go through a casing_firing proc
		handle_chamber(TRUE)
		return

	handle_chamber(TRUE)

////// Handles which sound should play when the gun fires, as it does adjust between different ammo types.
/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/play_fire_sound(obj/item/ammo_casing/soundmaker) //Hella Iffy.
	var/fire_sound = lethal_projectile_sound
	if(!adjustable_magwell) //if it has 1 magazine type
		fire_sound = lethal_projectile_sound
	else if(istype(soundmaker, /obj/item/ammo_casing/c35sol))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_light.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c585trappiste))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_heavy.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c40sol))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/rifle_heavy.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/strilka310))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'
	else if(istype(soundmaker, /obj/item/ammo_casing/c27_54cesarzowa))
		fire_sound = 'modular_nova/modules/modular_weapons/sounds/smg_light.ogg'

	playsound(src, fire_sound, 60, TRUE)

////// Operation Handling //////

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/auto_loader = mag_box?.resolve()
	if(isnull(auto_loader))
		mag_box = null
	if(attacking_item.type in auto_loader.atom_storage.can_hold)
		balloon_alert(user, "attempting to load...")
		if(!do_after(user, 1 SECONDS, src))
			balloon_alert(user, "failed to load!")
		insert_mag(attacking_item, user)
		return

	if(istype(attacking_item, /obj/item/card/id))
		if(!in_faction(user))
			balloon_alert(user, "access denied!")
			return

	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/controller = attacking_item
			if(length(controller.linked_turrets) >= controller.turret_limit)
				balloon_alert(user, "turret limit reached!")
				return
			if(linkage) //should help both preventing dual-controlling AND double-linking causing odd issues with ally system
				balloon_alert(user, "turret already linked!")
				return
			linkage = WEAKREF(controller)
			controller.linked_turrets += src
			RegisterSignal(controller, COMSIG_QDELETING, PROC_REF(on_qdeleted), TRUE) //True otherwise it causes a runtime for overwriting parent qdeling. Dont know where to go elsewise.
			balloon_alert(user, "turret linked!")
			return

	if(attacking_item.tool_behaviour != TOOL_WRENCH)
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
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(in_faction(user))
		if(istype(attacking_item, /obj/item/target_designator))
			var/obj/item/target_designator/owner_check = linkage?.resolve()
			if(attacking_item != owner_check) //cant unlink if not the same one
				balloon_alert(user, "turret not linked!")
				return
			var/obj/item/target_designator/controller = attacking_item
			linkage = null
			controller.linked_turrets -= src
			balloon_alert(user, "turret unlinked!")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(attacking_item.tool_behaviour != TOOL_WRENCH)
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

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/on_qdeleted(datum/source) //I hope this is what you ment.
	SIGNAL_HANDLER

	var/obj/item/target_designator/controller = linkage?.resolve()
	controller.linked_turrets -= source
