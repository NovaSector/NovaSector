/obj/item/ammo_workbench_module
	name = "ammo fabricator module"

	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'

	icon_state = "std_mod" // colorcoding one day, right chat
	desc = "A blank hardware authentication module for inserting into ammunition workbenches. \
	Digital rights management for ammo is real, and it's coming for you."
	/// What ammo categories does this module unlock?
	var/ammo_categories = NONE
	/// How many points is this module still good for?
	var/allowed_prints = 150

/obj/item/ammo_workbench_module/examine(mob/user)
	. = ..()
	. += span_notice("A small display on the board reads \"<b>[allowed_prints]</b> authentication points left\".")

/obj/item/ammo_workbench_module/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/ammo_workbench_reboot))
		to_chat(user, span_notice("You reset the authentication module on [src] with [tool], and it self-destructs shortly after."))
		allowed_prints = initial(allowed_prints)
		qdel(tool)

/obj/item/ammo_workbench_module/gimmick
	name = "gimmick nonlethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to print smart or otherwise niche nonlethal ammunition."
	ammo_categories = AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART

/obj/item/ammo_workbench_module/lethal
	name = "standard lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard lethal ammunition. \
	Useful for solving problems."
	ammo_categories = AMMO_CATEGORY_LETHAL

/obj/item/ammo_workbench_module/lethal_hp
	name = "manstopper lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one has the keys to allow fabricating standard or hollow-point lethal ammunition. \
	Useful for solving problems that either have no or middling amounts of armor."
	allowed_prints = 120
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW

/obj/item/ammo_workbench_module/lethal_hpap
	name = "variant lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one has the keys to allow fabricating standard, hollow-point, or armor-piercing lethal ammunition. \
	Useful for solving specific problems."
	allowed_prints = 120
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW | AMMO_CATEGORY_ARMORPEN

/obj/item/ammo_workbench_module/lethal_super
	name = "advanced lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, hollow-point, armor-piercing, or premium lethal ammunition. \
	Useful for causing lots of problems very intentionally."
	allowed_prints = 90
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW | AMMO_CATEGORY_ARMORPEN | AMMO_CATEGORY_SUPER

/obj/item/ammo_workbench_module/lethal_gimmick
	name = "niche " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, niche, electronic, or thermal ammunition. \
	Useful for solving particular problems with equally particular solutions."
	allowed_prints = 60
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART | AMMO_CATEGORY_THERMAL

// esoteric ammo includes phasic.
/obj/item/ammo_workbench_module/lethal_esoteric
	name = "esoteric " + parent_type::name
	desc = "A very limited hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, niche, electronic, thermal, or esoteric. \
	Useful for solving, or causing, especially weird problems."
	allowed_prints = 60
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART | AMMO_CATEGORY_THERMAL | AMMO_CATEGORY_ESOTERIC

/obj/item/ammo_workbench_reboot
	name = "ammo fabricator module reauthenticator"

	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'

	icon_state = "card_mini"
	desc = "A hardware authentication module reauthenticator, for resetting a fabricator module's licenses. \
	Digital rights management for ammo is real, and it's coming for you."

/*
/obj/item/ammo_workbench_module/advanced
	name = "advanced munitions datadisk"
	desc = "An datadisk filled with advanced munition fabrication data for the ammunition workbench, including lethal ammotypes if not previously enabled. \
	No parties are liable for any incidents that occur if safeties were circumvented beforehand."

/datum/design/ammo_workbench_module_lethal
	name = "Ammo Workbench Advanced Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT
	)
	build_path = /obj/item/ammo_workbench_module/advanced
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
*/
