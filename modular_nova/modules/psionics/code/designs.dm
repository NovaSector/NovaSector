/datum/design/cyberimp_psionic_limiter
	name = "Psionic Limiter Implant"
	desc = "A subdermal regulator that suppresses dangerous psionic potential until removed."
	id = "ci-psionic-limiter"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/organ/cyberimp/brain/psionic_limiter
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/psionic_dampener_cuffs
	name = "Psionic Dampener Cuffs"
	id = "psionic_dampener_cuffs"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/restraints/handcuffs/psionic_dampener
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
