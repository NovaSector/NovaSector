/obj/item/ammo_workbench_module
	name = "ammo module"

	icon = 'modular_nova/modules/ammo_workbench/icons/ammo_workbench.dmi'
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'
	icon_state = "lethal_mod"

	desc = "A blank hardware authentication module for inserting into ammunition workbenches. \
		Digital rights management for ammo is real, and it's coming for you."
	/// What ammo categories does this module unlock?
	var/ammo_categories = NONE

/obj/item/ammo_workbench_module/gimmick
	name = "niche nonlethal " + parent_type::name
	desc = "A hardware authentication module for ammunition workbenches, \
		with keys to print niche non- or less-lethal ammunition."
	icon_state = "nonlethal_mod"
	ammo_categories = AMMO_CATEGORY_NICHE

/obj/item/ammo_workbench_module/lethal
	name = "standard lethal " + parent_type::name
	desc = "A hardware authentication module for ammunition workbenches, \
		with keys to allow fabricating standard lethal ammunition."
	icon_state = "lethal_mod"
	ammo_categories = AMMO_CATEGORY_LETHAL

/obj/item/ammo_workbench_module/lethal_variant
	name = "variant lethal " + parent_type::name
	desc = "A hardware authentication module for ammunition workbenches, \
		with keys to allow fabricating standard or enhanced lethal ammunition."
	icon_state = "lethal_plus_mod"
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_PLUS

/obj/item/ammo_workbench_module/lethal_super
	name = "advanced lethal " + parent_type::name
	desc = "A hardware authentication module for ammunition workbenches, \
		with keys to allow fabricating standard, enhanced, or premium lethal ammunition."
	icon_state = "lethal_super_mod"
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_PLUS | AMMO_CATEGORY_SUPER

/obj/item/ammo_workbench_module/lethal_super/evil
	name = "marauder " + parent_type::name
	desc = parent_type::desc + " This one's been marked with a stylized imprint of a Gorlex Marauders MODsuit helmet, \
		and is specifically labeled as being of Scarborough Arms manufacture, which probably makes it less than legal to use \
		on corporate installations."

/obj/item/ammo_workbench_module/lethal_super/evil/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/ammo_workbench_module/lethal_gimmick
	name = "niche lethal " + parent_type::name
	desc = "A hardware authentication module for ammunition workbenches, \
		with keys to allow fabricating standard or niche ammunition."
	icon_state = "lethal_gimmick_mod"
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE

// esoteric ammo includes phasic, so probably be careful with this
/obj/item/ammo_workbench_module/lethal_esoteric
	name = "esoteric lethal " + parent_type::name
	desc = "A very limited hardware authentication module for ammunition workbenches, \
		with keys to allow fabricating standard, niche, or esoteric ammunition."
	icon_state = "lethal_weird_mod"
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_ESOTERIC

/datum/design/ammo_workbench_module_gimmick
	name = "Ammo Workbench Niche Nonlethal Module"
	id = "ammobench_gimmick"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_workbench_module/gimmick
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/ammo_workbench_module_niche
	name = "Ammo Workbench Niche Lethal Module"
	id = "ammobench_niche"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_workbench_module/lethal_gimmick
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
