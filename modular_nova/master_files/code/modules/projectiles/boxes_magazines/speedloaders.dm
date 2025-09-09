/obj/item/ammo_box/c38
	ammo_box_multiload = (AMMO_BOX_MULTILOAD_IN | AMMO_BOX_MULTILOAD_OUT_LOADED)

/obj/item/ammo_box/a357
	ammo_box_multiload = (AMMO_BOX_MULTILOAD_IN | AMMO_BOX_MULTILOAD_OUT_LOADED)

/obj/item/ammo_box/strilka310
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL

/obj/item/ammo_box/speedloader
	name = "speed loader (base type)"
	desc = "This shouldn't be here. Report this to a coder, thanks!"
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_box_multiload = (AMMO_BOX_MULTILOAD_IN | AMMO_BOX_MULTILOAD_OUT_LOADED)

/obj/item/ammo_box/speedloader/c35sol
	name = "speed loader (.35 Sol Short)"
	desc = "Designed to quickly reload eight-chamber .35 Sol Short revolvers."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "sl35sol"
	ammo_type = /obj/item/ammo_casing/c35sol
	max_ammo = 8
	caliber = CALIBER_SOL35SHORT
	ammo_band_icon = "+sl35_band"
	ammo_band_color = null

/obj/item/ammo_box/speedloader/c585trappiste
	name = "speed loader (.585 Trappiste)"
	desc = "Designed to quickly reload six-chamber .585 Trappiste revolvers."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/ammo.dmi'
	icon_state = "sl585t"
	ammo_type = /obj/item/ammo_casing/c585trappiste
	max_ammo = 6
	caliber = CALIBER_585TRAPPISTE
	ammo_band_icon = "+sl585_band"
	ammo_band_color = null
