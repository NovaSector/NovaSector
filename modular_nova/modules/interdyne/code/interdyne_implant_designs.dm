/// Interdyne Pharmaceuticals — Implant Research Designs
/// These are auto-included by the Interdyne fabricator via the "implant" ID filter.
/// Not assigned to any research node, so they won't appear on standard protolathes.

/datum/design/implant_resuvol
	name = "Resuvol Auto-Injector Implant"
	desc = "An Interdyne cybernetic auto-injector. Load with chemicals via syringe before surgical implantation. Grants a manual inject button."
	id = "implant_resuvol"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/organ/cyberimp/chest/interdyne/resuvol
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_hepatixol
	name = "Hepatixol Toxin Filter Implant"
	desc = "An Interdyne cybernetic toxin filter. Passively purges toxins at the cost of slower metabolism."
	id = "implant_hepatixol"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/organ/cyberimp/chest/interdyne/hepatixol
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_propeller
	name = "Propeller Dash Implant"
	desc = "An Interdyne cybernetic leg implant with micro-propulsion. Grants a directional dash ability."
	id = "implant_propeller"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 4,
	)
	build_path = /obj/item/organ/cyberimp/leg/interdyne/propeller
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
