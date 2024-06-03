/obj/item/storage/toolbox/emergency/turret/mag_fed/quick_deploy
	name = "quick deploy turret kit"
	desc = "A deployable turret designed for to deploy after impact when thrown."
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/cargo.dmi'
	icon_state = "toy_toolbox"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "toy_turretkit"
	throw_speed = 2
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/quick_deploy
	mag_slots = 2
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/toy
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/quick_deploy/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	playsound(src, "sound/items/drill_use.ogg", 80, TRUE, -1)
	var/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/turret = new turret_type(get_turf(loc))
	set_faction(turret, throwingdatum.thrower?.resolve())
	turret.mag_box = WEAKREF(src)
	if(turret_safety == TRUE)
		turret.target_assessment = TURRET_FLAG_SHOOT_NOONE
	if(flags_on == TRUE)
		turret.target_assessment = TURRET_FLAG_OBEY_FLAGS
	forceMove(turret)
	turret.setState(TRUE)

/obj/item/storage/toolbox/emergency/turret/mag_fed/quick_deploy/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/toy/smg(src)
	new /obj/item/ammo_box/magazine/toy/smg(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/quick_deploy
	name = "\improper Outpost Point-Defense Turret"
	desc = "A small deployable turret designed to expand after being thrown, it is chambered in the most frightening of rounds. foam darts."
	max_integrity = 100
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/cargo.dmi'
	icon_state = "toy_off"
	base_icon_state = "toy"
	shot_delay = 1 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/quick_deploy/pre_filled
