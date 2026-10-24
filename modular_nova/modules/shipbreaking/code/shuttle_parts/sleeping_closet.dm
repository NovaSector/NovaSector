/obj/structure/closet/sleeping_compartment
	name = "sleeping compartment"
	desc = "A large sleeping compartment for allowing crew to stow themselves somewhere they won't float away while sleeping in zero gravity. \
		Includes that sleeping bag tied to the wall, how cozy. Temperature-regulated inside, but NOT air tight."
	icon = 'modular_nova/modules/shipbreaking/icons/sleeping_closet.dmi'
	icon_state = "sleeping"
	base_icon_state = "sleeping"
	anchored = TRUE
	delivery_icon = null
	paint_jobs = null
	can_weld_shut = FALSE
	can_install_electronics = TRUE
	inertia_force_weight = 2
	drag_slowdown = 3
	max_integrity = 400
	door_anim_time = 0 // no animation
	contents_thermal_insulation = 1
	material_drop = /obj/item/stack/sheet/plastic_wall_panel
	material_drop_amount = 3
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3,
	)
