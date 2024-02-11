/*
*	AMMO
*/

/datum/design/strilka310_rubber
	name = ".310 Rubber Bullet (Less Lethal)"
	id = "astrilka310_rubber"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_casing/strilka310/rubber
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)
