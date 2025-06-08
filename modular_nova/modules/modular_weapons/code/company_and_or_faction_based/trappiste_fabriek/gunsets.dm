// Base yellow with symbol trappiste case

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case
	desc = "A thick yellow gun case with foam inserts laid out to fit a weapon, magazines, and gear securely. The five square grid of Trappiste Fabriek is displayed prominently on the top."
	icon_state = "case_trappiste"
	worn_icon_state = "carwocase"
	inhand_icon_state = "carwocase"

// Empty version of the case

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/empty

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/empty/PopulateContents()
	return

// Gunset for the Wespe pistol

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/wespe
	name = "Trappiste 'Wespe' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c35sol_pistol

// Gunset for the Skild heavy pistol

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/skild
	name = "Trappiste 'Skild' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c585trappiste_pistol

// Gunset for the Takbok Revolver

/obj/item/storage/toolbox/guncase/nova/pistol/trappiste_small_case/takbok
	name = "Trappiste 'Takbok' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/revolver/takbok
	extra_to_spawn = /obj/item/ammo_box/c585trappiste
