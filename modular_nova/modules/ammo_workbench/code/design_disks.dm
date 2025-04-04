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
	var/allowed_prints = 60

/obj/item/ammo_workbench_module/examine(mob/user)
	. = ..()
	. += span_notice("A small display on the board reads \"<b>[allowed_prints]</b> authentication points left\".")

/obj/item/ammo_workbench_module/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/ammo_workbench_reboot))
		var/obj/item/ammo_workbench_reboot/rex_sploded = tool
		to_chat(user, span_notice("You reset [src] with [rex_sploded]."))
		allowed_prints = initial(allowed_prints)
		rex_sploded.reboots--
		if(rex_sploded.reboots < 1)
			to_chat(user, span_warning("[rex_sploded] self-destructs."))
			rex_sploded.dust()

/obj/item/ammo_workbench_module/gimmick
	name = "niche nonlethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to print smart or otherwise niche non-or-less-lethal ammunition."
	ammo_categories = AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART

/obj/item/ammo_workbench_module/lethal
	name = "standard lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard lethal ammunition. \
	Useful for solving problems."
	ammo_categories = AMMO_CATEGORY_LETHAL

/obj/item/ammo_workbench_module/lethal/bulk
	name = "bulk " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard lethal ammunition - and \
	the expanded license allowance to print lots and lots of it. \
	Useful for selling people the means by which to solve problems."
	allowed_prints = 150

/obj/item/ammo_workbench_module/lethal_variant
	name = "variant lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one has the keys to allow fabricating standard, hollow-point, or armor-piercing lethal ammunition. \
	Useful for solving specific problems."
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW | AMMO_CATEGORY_ARMORPEN

/obj/item/ammo_workbench_module/lethal_super
	name = "advanced lethal " + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, hollow-point, armor-piercing, or premium lethal ammunition. \
	Useful for causing lots of problems very intentionally."
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_HOLLOW | AMMO_CATEGORY_ARMORPEN | AMMO_CATEGORY_SUPER

/obj/item/ammo_workbench_module/lethal_super/evil
	name = "marauder " + parent_type::name
	desc = parent_type::desc + " This one's been marked with a stylized imprint of a Gorlex Marauders MODsuit helmet."

/obj/item/ammo_workbench_module/lethal_super/evil/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/ammo_workbench_module/lethal_gimmick
	name = "niche lethal" + parent_type::name
	desc = "A hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, niche, electronic, or thermal ammunition. \
	Useful for solving particular problems with equally particular solutions."
	ammo_categories = AMMO_CATEGORY_LETHAL | AMMO_CATEGORY_NICHE | AMMO_CATEGORY_SMART | AMMO_CATEGORY_THERMAL

// esoteric ammo includes phasic, so probably be careful with this
/obj/item/ammo_workbench_module/lethal_esoteric
	name = "esoteric lethal" + parent_type::name
	desc = "A very limited hardware authentication module for inserting into ammunition workbenches. \
	This one should have the keys to allow fabricating standard, niche, electronic, thermal, or esoteric ammunition. \
	Useful for solving, or causing, especially weird problems."
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
	Digital rights management for ammo is real, but you can bribe your way out of it."
	/// How many print resets do we have left?
	var/reboots = 3

/obj/item/ammo_workbench_reboot/examine(mob/user)
	. = ..()
	. += span_notice("A small display on the board reads \"<b>[reboots]</b> reauthentications left\".")

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

/datum/design/ammo_workbench_reboot
	name = "Ammo Workbench Module Reauthenticator"
	id = "ammobench_reauth"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/ammo_workbench_reboot
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
