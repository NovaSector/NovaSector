/obj/effect/spawner/random/magturret
	name = "Random Magazine Turret"
	icon_state = "dice" //i'm tired boss.
	loot = list(
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost/malf,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster,
		/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/toy
	)

/obj/effect/spawner/random/turretkit
	name = "Random Magazine Turret Kit"
	icon_state = "dice"
	loot = list(
		/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled = 45,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled = 20,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled = 20,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled = 10,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/toy = 5
	)

/obj/effect/spawner/random/throwturretkit
	name = "Random Throwable Turret Kit"
	icon_state = "dice"
	loot = list(
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled = 70,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled = 25,
		/obj/item/storage/toolbox/emergency/turret/mag_fed/toy = 5
	)

/obj/effect/spawner/random/turretassembly
	name = "Random Turret Assembly"
	icon_state = "dice"
	loot = list(
		/obj/item/turret_assembly = 50,
		/obj/item/turret_assembly/twin_fang = 20,
		/obj/item/turret_assembly/duster = 30
	)
