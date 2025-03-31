// Base yellow carwo case

/obj/item/storage/toolbox/guncase/nova/xhihao_large_case

	icon = 'modular_nova/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "case_xhihao"

// Empty version of the case

/obj/item/storage/toolbox/guncase/nova/xhihao_large_case/empty

/obj/item/storage/toolbox/guncase/nova/xhihao_large_case/empty/PopulateContents()
	return NONE

// Contains the Bogseo submachinegun, excellent for breaking shoulders

/obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo
	name = "\improper Xhihao 'Bogseo' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/xhihao_smg/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c585trappiste_pistol

/obj/item/storage/toolbox/guncase/nova/xhihao_large_case/bogseo/PopulateContents()
	return flatten_quantified_list(list(
		weapon_to_spawn = 1,
		/obj/item/ammo_box/c585trappiste/incapacitator = 1,
		/obj/item/ammo_box/c585trappiste = 1,
		/obj/item/ammo_box/magazine/c585trappiste_pistol/spawns_empty = 3,
	))
