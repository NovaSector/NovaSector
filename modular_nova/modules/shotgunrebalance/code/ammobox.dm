/obj/item/ammo_box/advanced/s12gauge
	name = "shell box (slugs)"
	desc = "A box of 15 slug shells. Large, singular shots that pack a punch."
	icon = 'modular_nova/modules/shotgunrebalance/icons/shotbox.dmi'
	icon_state = "slug"
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 15
	multitype = FALSE // if you enable this and set the box's caliber var to CALIBER_SHOTGUN (at time of writing, "shotgun"), then you can have the fabled any-ammo shellbox

/obj/item/ammo_box/advanced/s12gauge/buckshot
	name = "shell box (buckshot)"
	desc = "A box of 15 buckshot shells. These have a modest spread of weaker projectiles."
	icon_state = "buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/rubber
	name = "shell box (rubber shot)"
	desc = "A box of 15 rubber shot shells. These have a modest spread of weaker, less-lethal projectiles."
	icon_state = "rubber"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/bean
	name = "shell box (beanbag slugs)"
	desc = "A box of 15 beanbag slug shells. These are large, singular beanbags that pack a less-lethal punch."
	icon_state = "bean"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/magnum
	name = "shell box (magnum blockshot)"
	desc = "A box of 15 magnum blockshot shells. The size of the pellet is larger in diameter than the typical shot, but there are less of them inside each shell."
	icon_state = "magnum"
	ammo_type = /obj/item/ammo_casing/shotgun/magnum
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/express
	name = "shell box (express pelletshot)"
	desc = "A box of 15 express pelletshot shells. The size of the pellet is smaller in diameter than the typical shot, but there are more of them inside each shell."
	icon_state = "express"
	ammo_type = /obj/item/ammo_casing/shotgun/express
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/hunter
	name = "shell box (hunter slug)"
	desc = "A box of 15 hunter slug shells. These shotgun slugs excel at damaging the local fauna."
	icon_state = "hunter"
	ammo_type = /obj/item/ammo_casing/shotgun/hunter
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/flechette
	name = "shell box (ripper flechette)"
	desc = "A box of 15 ripper flechette shells. Each shell contains a small group of tumbling blades that excel at causing terrible wounds."
	icon_state = "flechette"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette_nova
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/beehive
	name = "shell box (hornet's nest)"
	desc = "A box of 15 hornet's nest shells. These are less-lethal shells that will bounce off walls and direct themselves toward nearby targets."
	icon_state = "beehive"
	ammo_type = /obj/item/ammo_casing/shotgun/beehive
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/antitide
	name = "shell box (stardust)"
	desc = "A box of 15 stardust shells. These are less-lethal, firing a cable that embeds in target, draining stamina while connected in a manner similar to tasers."
	icon_state = "antitide"
	ammo_type = /obj/item/ammo_casing/shotgun/antitide
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/incendiary
	name = "shell box (incendiary slug)"
	desc = "A box of 15 incendiary slug shells. These will ignite targets and leave a trail of fire behind them."
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/honkshot
	name = "shell box (confetti)"
	desc = "A box of 35 confetti shells, for making a gratuitous mess."
	icon_state = "honk"
	ammo_type = /obj/item/ammo_casing/shotgun/honkshot
	max_ammo = 35

/obj/item/ammo_box/advanced/s12gauge/milspec
	name = "shell box (milspec slug)"
	desc = "A box of 15 hot-loaded milspec slug shells manufactured by Scarborough Arms. Faster and harder-hitting than conventional slugs."
	icon_state = "mslug"
	ammo_type = /obj/item/ammo_casing/shotgun/milspec
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/milspec/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/ammo_box/advanced/s12gauge/buckshot/milspec
	name = "shell box (milspec buckshot)"
	desc = "A box of 15 hot-loaded milspec buckshot shells manufactured by Scarborough Arms. Faster and harder-hitting than conventional buckshot."
	icon_state = "mbuckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot/milspec
	max_ammo = 15

/obj/item/ammo_box/advanced/s12gauge/buckshot/milspec/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)
