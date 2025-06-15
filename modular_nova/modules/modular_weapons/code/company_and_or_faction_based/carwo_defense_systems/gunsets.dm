// Sindano in a box, how innovative!

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano
	name = "\improper Carwo 'Sindano' gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_smg/no_mag

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/ammo_box/c35sol/incapacitator = 1,
		/obj/item/ammo_box/c35sol = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo/starts_empty = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol/starts_empty = 2,
	), src)

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sindano/evil
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_smg/evil/no_mag

// For the armory, generic-john-halo rifle.

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sol_rifle
	name = "\improper MR-2543 Rifle Kit"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_rifle/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c40sol_rifle/starts_empty

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/sol_rifle/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/ammo_box/c40sol = 3,
	), src)

// Boxed grenade launcher, grenades sold seperately on this one

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/kiboko_magless
	name = "\improper Carwo 'Kiboko' gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c980_grenade/starts_empty

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko
	name = "\improper Carwo 'Kiboko' gunset"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/no_mag

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/c980_grenade/thunderdome_shrapnel = 1,
		/obj/item/ammo_box/magazine/c980_grenade/thunderdome_smoke = 1,
		/obj/item/ammo_box/magazine/c980_grenade/thunderdome_gas = 1,
	), src)

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko/evil
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil/no_mag

/obj/item/storage/toolbox/guncase/nova/carwo_large_case/thunderdome_kiboko/evil/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/c980_grenade/drum/thunderdome_fire = 1,
		/obj/item/ammo_box/magazine/c980_grenade/drum/thunderdome_shrapnel = 1,
		/obj/item/ammo_box/magazine/c980_grenade/drum/thunderdome_gas = 1,
	), src)

/obj/structure/closet/secure_closet/armory_kiboko
	name = "heavy equipment locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/armory_kiboko/PopulateContents()
	. = ..()
	generate_items_inside(list(
		/obj/item/storage/toolbox/guncase/nova/carwo_large_case/kiboko_magless = 1,
		/obj/item/ammo_box/c980grenade = 2,
		/obj/item/ammo_box/c980grenade/smoke = 1,
		/obj/item/ammo_box/c980grenade/riot = 1,
	), src)

/obj/structure/closet/secure_closet/armory_kiboko_but_evil
	name = "heavy equipment locker"
	icon = 'modular_nova/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	req_access = list(ACCESS_SYNDICATE)
	anchored = 1

/obj/structure/closet/secure_closet/armory_kiboko_but_evil/PopulateContents()
	. = ..()

	generate_items_inside(list(
		/obj/item/gun/ballistic/automatic/sol_grenade_launcher/evil/no_mag = 1,
		/obj/item/ammo_box/magazine/c980_grenade/drum/starts_empty = 2,
		/obj/item/ammo_box/c980grenade/shrapnel = 1,
		/obj/item/ammo_box/c980grenade/shrapnel/phosphor = 1,
		/obj/item/ammo_box/c980grenade/smoke = 1,
		/obj/item/ammo_box/c980grenade/riot = 1,
	), src)
