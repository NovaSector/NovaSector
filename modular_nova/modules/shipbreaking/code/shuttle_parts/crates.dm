/obj/structure/closet/shipping_container
	name = "shipping container"
	desc = "Heavy duty shipping containers, insulated from pressure and temperature changes, and resistant to most impacts."
	icon = 'modular_nova/modules/shipbreaking/icons/closet.dmi'
	icon_state = "shipping"
	base_icon_state = "shipping"
	delivery_icon = null
	sealed = TRUE
	paint_jobs = null
	can_weld_shut = TRUE
	can_install_electronics = FALSE
	mob_storage_capacity = 5
	storage_capacity = 50
	inertia_force_weight = 2
	drag_slowdown = 3
	max_integrity = 400
	door_anim_time = 0 // no animation
	contents_pressure_protection = 1
	contents_thermal_insulation = 1
	material_drop = /obj/item/stack/sheet/plasteel
	material_drop_amount = 5
	air_volume = CELL_VOLUME * 0.2
	custom_materials = list(
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 5,
	)
	/// The chance that this container spawns welded shut
	var/welded_chance = 15

/obj/structure/closet/shipping_container/secured
	anchored = TRUE

/obj/structure/closet/shipping_container/Initialize(mapload)
	. = ..()
	base_icon_state = pick(
		"shipping",
		"shippingyellow",
		"shippinggreen",
		"shippingred",
		"shippingourple",
	)
	icon_state = base_icon_state
	if(prob(welded_chance))
		welded = TRUE
	update_appearance(UPDATE_ICON)

/obj/structure/closet/crate/shuttle
	name = "shipping crate"
	desc = "A soft, padded crate for shipping things around without denting up your walls, or your skull, when someone hits the brakes."
	icon = 'modular_nova/modules/shipbreaking/icons/crates.dmi'
	icon_state = "soft"
	base_icon_state = "soft"
	lid_icon_state = "softopen"
	delivery_icon = null
	sealed = FALSE
	resistance_flags = FLAMMABLE
	pass_flags_self = PASSSTRUCTURE
	cutting_tool = /obj/item/wirecutters
	material_drop = /obj/item/stack/sheet/durathread
	material_drop_amount = 4
	open_sound = 'sound/items/poster/poster_ripped.ogg'
	close_sound = 'sound/machines/cardboard_box.ogg'
	open_sound_volume = 25
	close_sound_volume = 25
	paint_jobs = null
	can_weld_shut = FALSE
	can_install_electronics = FALSE
	dense_when_open = FALSE
	mob_storage_capacity = 0
	storage_capacity = 20
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
	)
	contents_pressure_protection = 0
	contents_thermal_insulation = 0.1

/obj/structure/closet/crate/shuttle/secured
	anchored = TRUE

/obj/structure/closet/crate/shuttle/small
	name = "small shipping crate"
	desc = "A soft, padded crate for shipping small things around without denting up your walls, or your skull, when someone hits the brakes."
	icon_state = "softsmall"
	base_icon_state = "softsmall"
	lid_icon_state = "softsmallopen"
	material_drop_amount = 2
	storage_capacity = 10
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)

/obj/structure/closet/crate/shuttle/small/secured
	anchored = TRUE

/obj/structure/closet/crate/shuttle_hard
	name = "hard shipping crate"
	desc = "A hard plastic crate for shipping valuable things that don't like to go bump in the night."
	icon = 'modular_nova/modules/shipbreaking/icons/crates.dmi'
	icon_state = "hard"
	base_icon_state = "hard"
	lid_icon_state = "hardopen"
	delivery_icon = null
	sealed = TRUE
	material_drop = /obj/item/stack/sheet/plastic_wall_panel
	material_drop_amount = 4
	paint_jobs = null
	can_weld_shut = FALSE
	can_install_electronics = FALSE
	mob_storage_capacity = 1
	storage_capacity = 30
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)
	contents_pressure_protection = 1
	contents_thermal_insulation = 0.75

/obj/structure/closet/crate/shuttle_hard/secured
	anchored = TRUE
