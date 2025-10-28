/obj/item/storage/belt/admin
	name = "\improper Administrative Toolbelt"
	desc = "Can hold a boat load of things...  Why do you have this?!"

	icon = 'modular_nova/modules/bluespace_admin/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = 'modular_nova/modules/bluespace_admin/icons/mob/belt.dmi'
	worn_icon_state = "admeme_satchel"

	storage_type = /datum/storage/debug
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/belt/admin
	preload = TRUE

/obj/item/storage/belt/admin/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/hugetank, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/admin/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool/hugetank
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/datum/storage/debug // Built BUSTED on purpose
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 21
	max_slots = 21
