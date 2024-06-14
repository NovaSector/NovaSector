/obj/item/storage/toolbox/emergency/turret/mag_fed/toy
	name = "toy turret kit"
	desc = "A deployable turret designed for office warfare. Throw it in the neighboring cubicle and take cover as it does the rest."
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/cargo.dmi'
	icon_state = "toy_toolbox"
	righthand_file = 'modular_nova/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_nova/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "toy_turretkit"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_config = /datum/greyscale_config/turret/toolbox
	greyscale_colors = "#E0C14F#C67A4B"
	throw_speed = 2
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/toy
	mag_slots = 1
	quick_deployable = TRUE
	quick_deploy_timer = 0.5 SECONDS
	easy_deploy = TRUE
	easy_deploy_timer = 0.5 SECONDS
	turret_safety = FALSE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/toy
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/toy/smg(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/toy
	name = "\improper Cubicle Point-Defense Turret"
	desc = "A small deployable turret designed to expand after being thrown. It is chambered in the most frightening of rounds: foam darts."
	max_integrity = 100
	icon = 'modular_nova/modules/magfed_turret/icons/turrets/cargo.dmi'
	icon_state = "toy_off"
	base_icon_state = "toy"
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_config = /datum/greyscale_config/turret
	greyscale_colors = "#E0C14F#C67A4B"
	quick_retract = TRUE
	retract_timer = 1 SECONDS
	shot_delay = 0.5 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/toy/pre_filled
