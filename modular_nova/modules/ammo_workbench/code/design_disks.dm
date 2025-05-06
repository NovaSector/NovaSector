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
	/// How many points is this module still good for?
	var/allowed_prints = 120

/obj/item/ammo_workbench_module/examine(mob/user)
	. = ..()
	. += span_notice("A small display on the board reads \"<b>[allowed_prints]/[initial(allowed_prints)]</b> authentication points left\".")

/obj/item/ammo_workbench_module/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/ammo_workbench_reboot))
		var/obj/item/ammo_workbench_reboot/rex_sploded = tool
		var/current_diff_to_cap = allowed_prints - initial(allowed_prints)
		if(current_diff_to_cap >= 0) // in case there's a varedited one with a bajillion points or w/e
			to_chat(user, span_notice("You try to reallocate some license points to [src], but its authentication module is fully licensed, and nothing happens."))
			return NONE // no need to reauth
		var/reauth_amount = min(rex_sploded.license_points, abs(current_diff_to_cap))
		to_chat(user, span_notice("You reallocate [reauth_amount] license points to [src] with [rex_sploded]."))
		allowed_prints += reauth_amount
		rex_sploded.license_points -= reauth_amount
		if(!rex_sploded.license_points)
			to_chat(user, span_warning("[rex_sploded] self-destructs."))
			rex_sploded.dust()

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

/obj/item/ammo_workbench_reboot
	name = "ammo fabricator module reauthenticator"

	icon = 'modular_nova/modules/ammo_workbench/icons/ammo_workbench.dmi'
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'
	icon_state = "card_mini"

	desc = "A hardware authentication module reauthenticator, for extending a fabricator module's license point allowance. \
		Digital rights management for ammo is real, but you can bribe your way out of it."
	/// How many additional license points do we have left?
	var/license_points = 120

/obj/item/ammo_workbench_reboot/examine(mob/user)
	. = ..()
	. += span_notice("A small display on the board reads \"<b>[license_points]</b> license points left\".")

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
