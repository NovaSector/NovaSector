/obj/structure/window/reinforced/survival_pod
	max_integrity = 75
	reinf = FALSE // this actually only determines if it drops a rod when broken. neat!
	armor_type = /datum/armor/reinforced_shuttle
	explosion_block = 2
	glass_type = /obj/item/stack/sheet/titaniumglass
	glass_amount = 1
	receive_ricochet_chance_mod = 1.2
	rad_insulation = RAD_MEDIUM_INSULATION
	glass_material_datum = /datum/material/alloy/titaniumglass
	custom_materials = list(/datum/material/alloy/titaniumglass = SHEET_MATERIAL_AMOUNT)

/obj/structure/window/reinforced/survival_pod/unanchored
	anchored = FALSE
	state = WINDOW_OUT_OF_FRAME
