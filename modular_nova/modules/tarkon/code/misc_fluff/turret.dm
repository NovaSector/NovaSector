//////// Mag-fed Turret Framework.
////// Defines //////
#define TURRET_FLAG_SHOOT_MANUAL (1<<8) // Is the turret running off manual target acquisition?
#define TURRET_FLAG_SHOOT_FACTIONS (1<<9) // Is the target running on faction or only user-ref ally system?
#define TURRET_FLAG_SHOOT_HUMANS (1<<10) // Checks if it can shoot player people. Dont care if prisoner or not, but wont make them bullet immune outside of ally system.
#define TURRET_FLAG_FIRING_SEMI (1<<11)  // Is the turret running at semi-auto firing?
#define TURRET_FLAG_FIRING_BURST (1<<12)  // Is the turret firing in burst mode?
#define TURRET_FLAG_FIRING_AUTO (1<<13) // Is the turret firing full auto? (Emagged only)
#define TURRET_FLAG_SHOOT_ALL_REACT (1<<0) // The turret gets pissed off and shoots at people nearby. Stealing so i dont need to rewrite more stuff.
#define TURRET_FLAG_SHOOT_ANOMALOUS (1<<4)  // Checks if it can shoot at unidentified lifeforms (ie xenos) We're stealing for neccessity
#define TURRET_FLAG_SHOOT_BORGS (1<<6) // checks if it can shoot cyborgs. We just want this in.

DEFINE_BITFIELD(turret_flags, list(
	"TURRET_FLAG_SHOOT_MANUAL" = TURRET_FLAG_SHOOT_MANUAL,
	"TURRET_FLAG_SHOOT_FACTIONS" = TURRET_FLAG_SHOOT_FACTIONS,
	"TURRET_FLAG_SHOOT_BORGS" = TURRET_FLAG_SHOOT_BORGS,
	"TURRET_FLAG_SHOOT_HUMANS" = TURRET_FLAG_SHOOT_HUMANS,
	"TURRET_FLAG_SHOOT_ANOMALOUS" = TURRET_FLAG_SHOOT_ANOMALOUS,
))

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
	turret_flags = TURRET_FLAG_SHOOT_HUMANS
	ignore_faction = TRUE
	req_access = list()
	faction = list(FACTION_TURRET) //We're gonna do some funky stuff. also turret flags are undef'd at end of porta turret file so >:(
	var/target_acquisition = null //This is for manual target acquisition stuff. If present, should immediately over-ride as a target.
	var/allies = list() //Ally system.
	var/firing_mode = TURRET_FLAG_FIRING_SEMI
	var/claptrap_moment = FALSE //Do we want this to shut up? Mostly for testing purposes.
	var/casing_ejector = TRUE // Do we want it to eject casings?
	var/mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed //what box should this spawn with if its map_spawned?
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/mag_box //Container of the turret. Needs expanded ref.
	var/obj/item/ammo_box/magazine/magazine = null // Magazine inside the turret.
	var/obj/item/ammo_casing/chambered = null // currently loaded bullet

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
		. += span_notice("You can force it to load a cartridge by <b>right-clicking</b> with an empty hand")

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

	var/atom/movable/shell = mag_box
	mag_box = null
	shell.forceMove(drop_location())

	qdel(src)
	return

////// UI. I have no idea what i'm doing so :D

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DeployableTurret", name)
		ui.open()

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/ui_data(mob/user)
	var/list/data = list(
		"locked" = locked,
		"on" = on,
		"manual_target_acquisition_toggle" = turret_flags & TURRET_FLAG_SHOOT_MANUAL,
		"fire_at_humans" = turret_flags & TURRET_FLAG_SHOOT_HUMANS,
		"fire_at_cyborgs" = turret_flags & TURRET_FLAG_SHOOT_BORGS,
		"target_factions" = turret_flags & TURRET_FLAG_SHOOT_FACTIONS,
		"manual_control" = manual_control,
		"silicon_user" = FALSE,
		"allow_manual_control" = FALSE,
		"lasertag_turret" = istype(src, /obj/machinery/porta_turret/lasertag),
	)
	if(issilicon(user))
		data["silicon_user"] = TRUE
		if(!manual_control)
			var/mob/living/silicon/S = user
			if(S.hack_software)
				data["allow_manual_control"] = TRUE
	return data

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/ui_act(action, list/params)
	add_fingerprint(usr)
	update_last_used(usr)
	if(isAI(usr) && !GLOB.cameranet.checkTurfVis(get_turf(src))) //We check if they're an AI specifically here, so borgs can still access off-camera stuff.
		to_chat(usr, span_warning("You can no longer connect to this device!"))
		return FALSE

	if(.)
		return

	switch(action)
		if("power")
			if(anchored)
				toggle_on()
				return TRUE
			else
				to_chat(usr, span_warning("It has to be secured first!"))
		if("togglemanual")
			turret_flags ^= TURRET_FLAG_SHOOT_MANUAL
			return TRUE
		if("checkfactions")
			turret_flags ^= TURRET_FLAG_SHOOT_FACTIONS
			return TRUE
		if("checkhumans")
			turret_flags ^= TURRET_FLAG_SHOOT_HUMANS
			return TRUE
		if("shootborgs")
			turret_flags ^= TURRET_FLAG_SHOOT_BORGS
			return TRUE
		if("manual")
			if(!issilicon(usr))
				return
			give_control(usr)
			return TRUE
	return ..()

/obj/machinery/porta_turret/ui_host(mob/user)
	if(has_cover && cover)
		return cover
	if(base)
		return base
	return src

////// Ammo and magazine handling

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

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/check_cartridge() //There's some edge cases where shite happens.
	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(casing.loaded_projectile)
			if(QDELETED(casing.loaded_projectile))
				stack_trace("Trying to shoot bullet with a deleted projectile!")
				return FALSE
	return TRUE

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/proc/insert_mag(obj/item/ammo_box/magazine/magaroni, mob/living/guy_with_mag)
	if(!(magaroni.type in mag_box.atom_storage.can_hold))
		balloon_alert(guy_with_mag, "Item Can't Fit, How did you get here?")
		return
	balloon_alert(guy_with_mag, "Magazine Inserted")
	mag_box?.atom_storage.attempt_insert(magaroni, guy_with_mag, TRUE)
	return

////// Firing and target acquisition

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/in_faction(mob/target)
	if(turret_flags & TURRET_FLAG_SHOOT_FACTIONS)
		if(REF(target) in allies)
			return TRUE
	for(var/faction1 in faction)
		if((faction1 in target.faction) || (REF(target) in allies)) // For an Ally System
			return TRUE
	return FALSE

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/assess_perp(mob/living/carbon/human/intruder) //Because we're re-doing targeting.
	var/threatcount = 0 //the integer returned

	if(obj_flags & EMAGGED)
		return 10 //if emagged, always return 10.

	if((turret_flags & (TURRET_FLAG_SHOOT_HUMANS | TURRET_FLAG_SHOOT_ALL_REACT)) && !(REF(intruder) in allies))
		//if the turret has been attacked or is angry, target all non-factioned people
		if(!(REF(intruder) in allies))
			return 10

	if(!(turret_flags & TURRET_FLAG_SHOOT_FACTIONS))
		if(!in_faction(intruder))
			for(var/faction1 in faction)
				if(!(faction1 in intruder.faction))
					threatcount += 10

	return threatcount

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/target(atom/movable/target)
	if(target)
		popUp() //pop the turret up if it's not already up.
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		if(firing_mode & TURRET_FLAG_FIRING_BURST)
			shootAt(target)
			addtimer(CALLBACK(src, PROC_REF(shootAt), target), 5)
			addtimer(CALLBACK(src, PROC_REF(shootAt), target), 10)
		else
			shootAt(target)
		return 1
	return

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/tryToShootAt(list/atom/movable/things_in_my_lawn) //better target prioritization, shoots at closest simple mob
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
			MyLoad.ignored_factions = faction
		MyLoad.fire()
		MyLoad.fired = TRUE
		MyLoad = null //We clear the ref from here. Pretty sure not needed but just in case.
		chambered.loaded_projectile = null //clear the reference from here, as we didn't go through a casing_firing proc
		handle_chamber(TRUE)
		return

	handle_chamber(TRUE)


////// Operation Handling

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.type in mag_box.atom_storage.can_hold)
		balloon_alert(user, "Attempting to load mag")
		if(!do_after(user, 1 SECONDS, src))
			balloon_alert(user, "Failure to load maga")
		insert_mag(attacking_item, user)
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

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attackby_secondary(obj/item/weapon, mob/living/user, params)
	. = ..()
	if(!istype(weapon, /obj/item/wrench))
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!weapon.toolspeed)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(user.combat_mode)
		if(!claptrap_moment)
			balloon_alert(user, "deconstructing...")
		if(!weapon.use_tool(src, user, 5 SECONDS, volume = 20))
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		weapon.play_tool_sound(src, 50)
		deconstruct(TRUE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!chambered)
		handle_chamber(TRUE)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

////// because we're already parroting turret code: undef's.

#undef TURRET_FLAG_SHOOT_HUMANS
#undef TURRET_FLAG_SHOOT_FACTIONS
#undef TURRET_FLAG_SHOOT_MANUAL
#undef TURRET_FLAG_SHOOT_BORGS
#undef TURRET_FLAG_FIRING_SEMI
#undef TURRET_FLAG_FIRING_BURST
#undef TURRET_FLAG_FIRING_AUTO
#undef TURRET_FLAG_SHOOT_ANOMALOUS
#undef TURRET_FLAG_SHOOT_ALL_REACT
