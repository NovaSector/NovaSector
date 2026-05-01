/obj/item/ammo_box/speedloader/c38/hicap
	name = "expanded speed loader (.38)"
	desc = "Designed to quickly reload eight-chamber .38 Special revolvers."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/magazines.dmi'
	icon_state = "38hicap"
	base_icon_state = "38hicap"
	max_ammo = 8

/obj/item/ammo_box/speedloader/c38/hicap/empty
	start_empty = TRUE

/obj/item/ammo_box/speedloader/c96/
	name = "stripper clip (10mm)"
	desc = "Designed to quickly load the NT M-96 pistol."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_armories/magazines.dmi'
	ammo_type = /obj/item/ammo_casing/c10mm
	icon_state = "10_strip"
	base_icon_state = "10_strip"
	max_ammo = 10
	caliber = CALIBER_10MM
	w_class = WEIGHT_CLASS_SMALL
