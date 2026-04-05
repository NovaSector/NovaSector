/datum/techweb_node/advanced_sec
	id = TECHWEB_SEC_ADVANCED
	display_name = "Advanced Security Equipment"
	description = "Advanced equipment used by security."
	prereq_ids = list(TECHWEB_NODE_SEC_EQUIP)
	design_ids = list(
		"stungloves_empty"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)


/datum/design/stunglove_empty //tacking this onto basic sectech
	name = "Mark-Three Stungloves"
	desc = "A specialized set of tools. Wraps around an Officer's hand, and projects an energy field while enabled - allowing punches to successfully stun a target."
	id = "stungloves_empty"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT*9, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT*6, /datum/material/titanium =SMALL_MATERIAL_AMOUNT*8) //Low titanium cost.
	build_path = /obj/item/melee/baton/security/stungloves
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE
