/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	name = "outpost defense turret kit"
	desc = "A deployable turret designed for outpost point defense and management of stray fauna."
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_toolbox"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "outpost_turretkit"
	throw_speed = 2
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	mag_slots = 2
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c40sol_rifle
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	name = "\improper Outpost Point-Defense Turret"
	desc = "A deployable turret used for protection of outposts and civilian constructs."
	max_integrity = 200
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_off"
	base_icon_state = "outpost"
	shot_delay = 2 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled
