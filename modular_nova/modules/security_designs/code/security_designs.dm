/datum/design/handlabeler
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/paperroll
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/mag_c20r // sec printable so that the blueshield can get more mags for the nt20, which takes the c20r mag
	name = "Magazine (.460 Ceres)"
	desc = "A 24-round magazine designed to fit in submachine guns which fire .460 Ceres."
	id = "mag_c20r"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/ammo_box/magazine/smgm45/empty
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
