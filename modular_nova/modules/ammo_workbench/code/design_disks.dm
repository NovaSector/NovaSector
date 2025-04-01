/obj/item/disk/ammo_workbench
	name = "ammunition workbench hardware module"
	icon_state = "std_mod" // colorcoding one day, right chat
	desc = "A blank hardware authentication module for inserting into ammunition workbenches. \
	Digital rights management for ammo is real, and it's coming for you."
	/// What ammo categories does this module unlock?
	var/ammo_categories = NONE
	/// How many casings can this module print?
	var/allowed_prints = 240

/obj/item/disk/ammo_workbench/lethal
	name = "standard lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard lethal ammunition. \
	It'll do the job."
	ammo_categories = AMMO_CLASS_LETHAL

/obj/item/disk/ammo_workbench/lethal_hollow
	name = "hollowpoint lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard or hollow-point lethal ammunition. \
	Useful for carving through unarmored targets."
	ammo_categories = AMMO_CLASS_HOLLOW

/obj/item/disk/ammo_workbench/lethal_ap
	name = "armor-piercing lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard or armor-penetrating lethal ammunition. \
	Useful for punching through armor."
	ammo_categories = AMMO_CLASS_ARMORPEN

/obj/item/disk/ammo_workbench/lethal_super
	name = "improved lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard or premium lethal ammunition. \
	Useful for causing lots of problems very intentionally."
	ammo_categories = AMMO_CLASS_SUPER
	allowed_prints = 120

/*
/obj/item/disk/ammo_workbench/advanced
	name = "advanced munitions datadisk"
	desc = "An datadisk filled with advanced munition fabrication data for the ammunition workbench, including lethal ammotypes if not previously enabled. \
	No parties are liable for any incidents that occur if safeties were circumvented beforehand."

/datum/design/disk/ammo_workbench_lethal
	name = "Ammo Workbench Advanced Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT
	)
	build_path = /obj/item/disk/ammo_workbench/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
*/
