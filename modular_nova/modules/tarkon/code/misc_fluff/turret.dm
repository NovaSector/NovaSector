/obj/item/storage/toolbox/emergency/turret/tarkon

/obj/item/storage/toolbox/emergency/turret/tarkon/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol
	new /obj/item/ammo_box/magazine/c35sol_pistol
	new /obj/item/ammo_box/magazine/c35sol_pistol

/obj/machinery/porta_turret/syndicate/toolbox/tarkon
	integrity_failure = 0
	max_integrity = 150
	shot_delay = 1.5 SECONDS
	stun_projectile = null
	lethal_projectile = null
	subsystem_type = /datum/controller/subsystem/processing/projectiles
	ignore_faction = FALSE
	faction = list(FACTION_TARKON)
	var/obj/item/ammo_box/magazine/magazine = null
	var/obj/item/ammo_casing/chambered = null

/obj/item/storage/toolbox/emergency/turret/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/wrench))
		return ..()

	if(!user.combat_mode)
		return

	if(!attacking_item.toolspeed)
		return

	balloon_alert(user, "constructing...")
	if(!attacking_item.use_tool(src, user, 2 SECONDS, volume = 20))
		return

	balloon_alert(user, "constructed!")
	user.visible_message(span_danger("[user] bashes [src] with [attacking_item]!"), \
		span_danger("You bash [src] with [attacking_item]!"), null, COMBAT_MESSAGE_RANGE)

	playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
	var/obj/machinery/porta_turret/syndicate/toolbox/tarkon/turret = new(get_turf(loc))
	set_faction(turret, user)
	turret.toolbox = src
	forceMove(turret)

/obj/machinery/porta_turret/syndicate/toolbox/tarkon/proc/load_chamber()
	if(!magazine)
		balloon_alert(src, "Magazine missing!")
		handle_mag()
		return

	if(!magazine.stored_ammo)
		balloon_alert(src, "Magazine empty!")
		handle_mag()
		return

	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(QDELING(casing))
			stack_trace("Trying to move a qdeleted casing of type [casing.type]!")
			chambered = null
		else if(casing_ejector || !from_firing)
			casing.forceMove(drop_location()) //Eject casing onto ground.
			if(!QDELETED(casing))
				casing.bounce_away(TRUE)
				SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
		else if(empty_chamber)
			UnregisterSignal(chambered, COMSIG_MOVABLE_MOVED)
			chambered = null
	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()

/obj/machinery/porta_turret/syndicate/toolbox/tarkon/proc/chamber_round()
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		chambered = magazine.get_round(keep = FALSE)
		chambered.forceMove(src)


/obj/machinery/porta_turret/syndicate/toolbox/tarkon/proc/handle_mag()
	if(toolbox.contents)
	return
