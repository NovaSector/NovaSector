////// Outpost Turret, Will be used for space ruins.
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
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost/malf
	faction = list()
	shot_delay = 1 SECONDS

////// Colonist Turret. Kinda just made to be a ghost-role friendly version of the outpost turret

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist
	name = "colonist defense turret kit"
	desc = "A deployable turret designed for safety during colony construction and colonist expeditionary camps. It is chambered to fire .40 Sol ammunition"
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_toolbox"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "colonist_turretkit"
	throw_speed = 2
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	mag_slots = 2
	easy_deploy = TRUE
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c40sol_rifle
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)
	new /obj/item/ammo_box/magazine/c40sol_rifle(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	name = "\improper Colonist Point-Defense Turret"
	desc = "A deployable turret used for protection of colonists during construction or expeditionary trips. It is chambered to fire .40 Sol ammunition."
	max_integrity = 200
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_off"
	base_icon_state = "colonist"
	shot_delay = 2 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled

////// Spider turret. Throw-deployable turret with actual ammunition.

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider
	name = "spider offensive turret capsule"
	desc = "A throw-deployable turret capsule designed for securing areas within hostile fauna held zones. It is chambered in .35 Sol ammunition."
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_toolbox"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "35_spider_turretkit"
	throw_speed = 2
	quick_deployable = TRUE
	quick_deploy_timer = 1 SECONDS
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	mag_slots = 1
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/c35sol_pistol
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/c35sol_pistol(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	name = "\improper Stinger Spider Turret"
	desc = "A deployable turret used for aggressive expansion and zone defense. It is chambered to fire .35 Sol ammunition."
	max_integrity = 200
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_off"
	base_icon_state = "35_spider"
	shot_delay = 2 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled
