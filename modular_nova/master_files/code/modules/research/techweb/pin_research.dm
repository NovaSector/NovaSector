/datum/design/pin_standard
	name = "Standard Firing Pin"
	desc = "This is a firing pin which allows users to shoot their guns."
	id = "pin_standard"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/firing_pin
	materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 6, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 6, /datum/material/uranium =SMALL_MATERIAL_AMOUNT * 2)
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_FIRING_PINS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
