/obj/effect/spawner/armory_spawn
	icon_state = "loot"
	icon = 'icons/effects/random_spawners.dmi'

	layer = OBJ_LAYER
	/// A list of possible guns to spawn.
	var/list/guns
	/// Do we fan out the items spawned for a natural effect?
	var/fan_out_items = FALSE
	/// How many mags per gun do we spawn, if it takes magazines.
	var/mags_to_spawn = 3
	/// Do we want to angle it so that it is horizontal?
	var/vertical_guns = TRUE


/obj/effect/spawner/armory_spawn/Initialize(mapload)
	. = ..()

	if(!guns)
		return

	var/obj/structure/rack/gunrack/rack_on_tile
	for(var/obj/structure/rack/gunrack/found_rack in loc.contents)
		rack_on_tile = found_rack
		break

	var/gun_count = 0
	var/offset_percent = 20 / guns.len
	for(var/gun in guns) // 11/20/21: Gun spawners now spawn 1 of each gun in it's list no matter what, so as to reduce the RNG of the armory stock.
		var/obj/item/gun/spawned_gun = new gun(loc)

		if(vertical_guns && rack_on_tile)
			rack_on_tile.rotate_weapon(spawned_gun)
			spawned_gun.pixel_x = -10 + (offset_percent * gun_count) + spawned_gun.base_pixel_x
		else if (fan_out_items)
			spawned_gun.pixel_x = spawned_gun.pixel_y = ((!(gun_count%2)*gun_count/2)*-1)+((gun_count%2)*(gun_count+1)/2*1)

		gun_count++

		if(!istype(spawned_gun, /obj/item/gun/ballistic))
			continue

		var/obj/item/gun/ballistic/spawned_ballistic_gun = spawned_gun
		if(spawned_ballistic_gun.magazine && !istype(spawned_ballistic_gun.magazine, /obj/item/ammo_box/magazine/internal))
			var/obj/item/storage/box/spawned_box = new(loc)
			spawned_box.name = "ammo box - [spawned_ballistic_gun.name]"
			for(var/i in 1 to mags_to_spawn)
				new spawned_ballistic_gun.spawn_magazine_type(spawned_box)

/obj/effect/spawner/armory_spawn/shotguns
	guns = list(
		/obj/item/gun/ballistic/shotgun/riot/sol,
		/obj/item/gun/ballistic/shotgun/riot/sol,
		/obj/item/gun/ballistic/shotgun/riot/sol,
	)

/obj/effect/spawner/armory_spawn/mod_lasers_big
	guns = list(
		/obj/item/gun/energy/modular_laser_rifle,
		/obj/item/gun/energy/modular_laser_rifle,
		/obj/item/gun/energy/modular_laser_rifle,
	)

/obj/effect/spawner/armory_spawn/mod_lasers_small
	guns = list(
		/obj/item/gun/energy/modular_laser_rifle/carbine,
		/obj/item/gun/energy/modular_laser_rifle/carbine,
		/obj/item/gun/energy/modular_laser_rifle/carbine,
	)

/obj/structure/closet/ammunitionlocker/useful/PopulateContents()
	new /obj/item/storage/box/rubbershot(src)
	new /obj/item/storage/box/rubbershot(src)
	new /obj/item/storage/box/rubbershot(src)
	new /obj/item/storage/box/rubbershot(src)

/obj/effect/spawner/armory_spawn/centcom_rifles
	guns = list(
		/obj/item/gun/ballistic/automatic/sol_rifle,
		/obj/item/gun/ballistic/automatic/sol_rifle,
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun,
	)

/obj/effect/spawner/armory_spawn/centcom_lasers
	guns = list(
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/e_gun,
	)

/obj/effect/spawner/armory_spawn/smg
	vertical_guns = FALSE // Name slightly misleading, but i'd probably do more damage renaming it from SMG then letting it be.
	guns = list(
		/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano,
		/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano,
		/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sol_rifle,
		/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sol_rifle,
	)
