/datum/crafting_recipe/crusher_trophy
	tool_paths = null // originally: tool_paths = list(/obj/item/kinetic_crusher)
	time = 2 SECONDS // originally 5 seconds. this... doesn't feel like it changes much for some reason, though

/datum/crafting_recipe/crusher_trophy/watcher_wing
	reqs = list(
		/obj/item/stack/sheet/sinew = 7,
		/obj/item/stack/ore/diamond = 4, // originally 10
		/obj/item/stack/sheet/bone = 5,
	)

/obj/item/crusher_trophy/watcher_wing
	// reduced diamond count to match recipe
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 4, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 5)

/datum/crafting_recipe/crusher_trophy/icewing_watcher_wing
	reqs = list(
		/obj/item/stack/sheet/sinew/icewing = 3,
		/obj/item/stack/ore/diamond = 2, // originally 6
		/obj/item/stack/sheet/bone = 3,
	)

/obj/item/crusher_trophy/ice_wing
	// reduced diamond count to match new recipe
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 3)

/datum/crafting_recipe/crusher_trophy/magmawing_watcher_wing
	reqs = list(
		/obj/item/stack/sheet/sinew/magmawing = 3,
		/obj/item/stack/ore/diamond = 2, // originally 6
		/obj/item/stack/sheet/bone = 3,
	)

/obj/item/crusher_trophy/magma_wing
	// reduced diamond count to match new recipe
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2, /datum/material/bone = SHEET_MATERIAL_AMOUNT * 3)

