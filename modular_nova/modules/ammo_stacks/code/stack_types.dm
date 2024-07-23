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
	name = "12 gauge stardust shells"
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
	name = "12 gauge flechette shells"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/frag12
	name = "12 gauge frag shells"
	ammo_type = /obj/item/ammo_casing/shotgun/frag12
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/hunter
	name = "12 gauge hunter shells"
	ammo_type = /obj/item/ammo_casing/shotgun/hunter
	icon_state = "stack_spec"

/obj/item/ammo_box/magazine/ammo_stack/s12gauge/prefilled/improvised
	name = "12 gauge improvised shells"
	ammo_type = /obj/item/ammo_casing/shotgun/improvised

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

/obj/item/ammo_box/magazine/ammo_stack/c310_strilka/prefilled/dollar_tree
	name = ".310 Strilka surplus casings"
	ammo_type = /obj/item/ammo_casing/strilka310/surplus
