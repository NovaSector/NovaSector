// Special ammo

// .980 grenades

/obj/item/ammo_casing/c980grenade
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c980

/obj/item/ammo_box/magazine/ammo_stack/c980
	name = ".980 Tydhouer grenades"
	desc = "A stack of .980 Tydhouer grenades."
	caliber = CALIBER_980TYDHOUER
	ammo_type = /obj/item/ammo_casing/c980grenade
	casing_phrasing = "shell"
	max_ammo = 6
	casing_x_positions = list(
		-6,
		-3,
		0,
		3,
		6,
	)
	casing_y_padding = 9

/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled/smoke
	name = ".980 Tydhouer smoke grenades"
	ammo_type = /obj/item/ammo_casing/c980grenade/smoke

/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled/gas
	name = ".980 Tydhouer tear gas grenades"
	ammo_type = /obj/item/ammo_casing/c980grenade/riot

/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled/shrap
	name = ".980 Tydhouer shrapnel grenades"
	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c980/prefilled/fire
	name = ".980 Tydhouer phosphor grenades"
	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel/phosphor
	icon_state = "stack_spec"

// 12ga shotgun shells

/obj/item/ammo_casing/shotgun
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/s12gauge

/obj/item/ammo_box/magazine/ammo_stack/s12gauge
	name = "12 gauge shells"
	desc = "A stack of 12 gauge shells."
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun
	casing_phrasing = "shell"
	max_ammo = 8
	casing_x_positions = list(
		-6,
		-3,
		0,
		3,
		6,
	)
	casing_y_padding = 4

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled
	name = "12 gauge slug shells"
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/antitide
	name = "12 gauge lighting shot shells"
	ammo_type = /obj/item/ammo_casing/shotgun/antitide
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/beanbag
	name = "12 gauge beanbag shells"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/beehive
	name = "12 gauge hornet shells"
	ammo_type = /obj/item/ammo_casing/shotgun/beehive
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/breacher
	name = "12 gauge breaching shells"
	ammo_type = /obj/item/ammo_casing/shotgun/breacher
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/buckshot
	name = "12 gauge buckshot shells"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/dragonsbreath
	name = "12 gauge dragonsbreath shells"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/express
	name = "12 gauge express shells"
	ammo_type = /obj/item/ammo_casing/shotgun/express

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/flechette
	name = "12 gauge ripper flechette shells"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette_nova
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/frag12
	name = "12 gauge frag shells"
	ammo_type = /obj/item/ammo_casing/shotgun/frag12
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/hunter
	name = "12 gauge hunter shells"
	ammo_type = /obj/item/ammo_casing/shotgun/hunter
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/incendiary
	name = "12 gauge incendiary shells"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/magnum
	name = "12 gauge magnum shells"
	ammo_type = /obj/item/ammo_casing/shotgun/magnum

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/rubbershot
	name = "12 gauge rubbershot shells"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/milspec
	name = "12 gauge milspec slug shells"
	ammo_type = /obj/item/ammo_casing/shotgun/milspec

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/buckshot/milspec
	name = "12 gauge milspec buckshot shells"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/milspec

// Pistol ammo

// .35 sol short

/obj/item/ammo_casing/c35sol
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c35_sol

/obj/item/ammo_box/magazine/ammo_stack/c35_sol
	name = ".35 Sol Short casings"
	desc = "A stack of .35 Sol Short cartridges."
	caliber = CALIBER_SOL35SHORT
	ammo_type = /obj/item/ammo_casing/c35sol
	max_ammo = 12
	casing_x_positions = list(
		-6,
		-4,
		-2,
		0,
		2,
		4,
		6,
	)
	casing_y_padding = 6

/obj/item/ammo_box/magazine/ammo_stack/c35_sol/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c35_sol/prefilled/incapacitator
	name = ".35 Sol Short incapacitator casings"
	ammo_type = /obj/item/ammo_casing/c35sol/incapacitator
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c35_sol/prefilled/ripper
	name = ".35 Sol Short ripper casings"
	ammo_type = /obj/item/ammo_casing/c35sol/ripper
	icon_state = "stack_spec"

// .27-54 Cesarzowa

/obj/item/ammo_casing/c27_54cesarzowa
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c27_54cesarzowa

/obj/item/ammo_box/magazine/ammo_stack/c27_54cesarzowa
	name = ".27-54 Cesarzowa casings"
	desc = "A stack of .27-54 Cesarzowa cartridges."
	caliber = CALIBER_CESARZOWA
	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	max_ammo = 18
	casing_x_positions = list(
		-6,
		-4,
		-2,
		0,
		2,
		4,
		6,
	)
	casing_y_padding = 6

/obj/item/ammo_box/magazine/ammo_stack/c27_54cesarzowa/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c27_54cesarzowa/prefilled/incapacitator
	name = ".27-54 Cesarzowa rubber casings"
	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa/rubber
	icon_state = "stack_spec"

// .585 trappiste

/obj/item/ammo_casing/c585trappiste
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c585_trappiste

/obj/item/ammo_box/magazine/ammo_stack/c585_trappiste
	name = ".585 Trappiste casings"
	desc = "A stack of .585 Trappiste casings."
	caliber = CALIBER_585TRAPPISTE
	ammo_type = /obj/item/ammo_casing/c585trappiste
	max_ammo = 6
	casing_x_positions = list(
		-4,
		-2,
		0,
		2,
		4,
	)
	casing_y_padding = 9

/obj/item/ammo_box/magazine/ammo_stack/c585_trappiste/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c585_trappiste/prefilled/incapacitator
	name = ".585 Trappiste flathead casings"
	ammo_type = /obj/item/ammo_casing/c585trappiste/incapacitator
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c585_trappiste/prefilled/incendiary
	name = ".585 Trappiste incendiary casings"
	ammo_type = /obj/item/ammo_casing/c585trappiste/incendiary
	icon_state = "stack_spec"

// Rifle ammo

// .40 sol long

/obj/item/ammo_casing/c40sol
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c40_sol

/obj/item/ammo_box/magazine/ammo_stack/c40_sol
	name = ".40 Sol Long casings"
	desc = "A stack of .40 Sol Long cartridges."
	caliber = CALIBER_SOL40LONG
	ammo_type = /obj/item/ammo_casing/c40sol
	max_ammo = 15
	casing_x_positions = list(
		-6,
		-4,
		-2,
		0,
		2,
		4,
		6,
	)
	casing_y_padding = 6

/obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled/frag
	name = ".40 Sol Long fragmentation casings"
	ammo_type = /obj/item/ammo_casing/c40sol/fragmentation
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled/incendiary
	name = ".40 Sol Long incendiary casings"
	ammo_type = /obj/item/ammo_casing/c40sol/incendiary
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c40_sol/prefilled/match
	name = ".40 Sol Long match casings"
	ammo_type = /obj/item/ammo_casing/c40sol/pierce
	icon_state = "stack_spec"

// .310 strilka

/obj/item/ammo_casing/strilka310
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c310_strilka

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka
	name = ".310 Strilka casings"
	desc = "A stack of .310 Strilka cartridges."
	caliber = CALIBER_STRILKA310
	ammo_type = /obj/item/ammo_casing/strilka310
	max_ammo = 5
	casing_x_positions = list(
		-4,
		-2,
		0,
		2,
		4,
	)
	casing_y_padding = 8

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled
	start_empty = FALSE

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled/incapacitator
	name = ".310 Strilka rubber casings"
	ammo_type = /obj/item/ammo_casing/strilka310/rubber
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled/dollar_tree
	name = ".310 Strilka surplus casings"
	ammo_type = /obj/item/ammo_casing/strilka310/surplus

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled/ap
	name = ".310 Strilka piercing casings"
	ammo_type = /obj/item/ammo_casing/strilka310/ap
	icon_state = "stack_spec"

// .60 strela

/obj/item/ammo_casing/p60strela
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c60_strela

/obj/item/ammo_box/magazine/ammo_stack/c60_strela
	name = ".60 Strela casings"
	desc = "A stack of .60 Strela cartridges."
	caliber = CALIBER_60STRELA
	ammo_type = /obj/item/ammo_casing/p60strela
	max_ammo = 6
	casing_x_positions = list(
		-6,
		-3,
		0,
		3,
		6,
	)
	casing_y_padding = 9

/obj/item/ammo_box/magazine/ammo_stack/c60_strela/prefilled
	start_empty = FALSE
