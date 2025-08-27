/datum/loadout_category/glasses
	/// How many maximum of these can be chosen
	var/max_allowed = MAX_ALLOWED_EXTRA_CLOTHES

/datum/loadout_category/glasses/New()
	. = ..()
	category_info = "([max_allowed] allowed)"

/datum/loadout_category/glasses/handle_duplicate_entires(
	datum/preference_middleware/loadout/manager,
	datum/loadout_item/conflicting_item,
	datum/loadout_item/added_item,
	list/datum/loadout_item/all_loadout_items,
)
	var/datum/loadout_item/glasses/other_loadout_items = list()
	for(var/datum/loadout_item/glasses/other_loadout_item in all_loadout_items)
		other_loadout_items += other_loadout_item

	if(length(other_loadout_items) >= max_allowed)
		// We only need to deselect something if we're above the limit
		// (And if we are we prioritize the first item found, FIFO)
		manager.deselect_item(other_loadout_items[1])
	return TRUE

/datum/loadout_item/glasses/holo_infohud
	name = "Holographic Infohud"
	item_path = /obj/item/clothing/glasses/tajaran_hud

/datum/loadout_item/glasses/solid_infohud
	name = "Solid Infohud"
	item_path = /obj/item/clothing/glasses/lizard_hud

/datum/loadout_item/glasses/welding
	name = "Welding Goggles"
	item_path = /obj/item/clothing/glasses/welding

/datum/loadout_item/glasses/white_eyepatch
	name = "White Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/eyewrap
	name = "Eyepatch Wrap"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/fake_blindfold
	name = "Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/techno_visor
	name = "Techno-Visor"
	item_path = /obj/item/clothing/glasses/techno_visor

/datum/loadout_item/glasses/retinal_projector
	name = "Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector

/datum/loadout_item/glasses/retinal_projector_meson
	name = "Meson Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/meson

/datum/loadout_item/glasses/retinal_projector_health
	name = "Health Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/health

/datum/loadout_item/glasses/retinal_projector_security
	name = "Security Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/security

/datum/loadout_item/glasses/retinal_projector_diagnostic
	name = "Diagnostic Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic

/datum/loadout_item/glasses/aviator
	name = "Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator

/datum/loadout_item/glasses/aviator_security
	name = "Security Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security

/datum/loadout_item/glasses/aviator_health
	name = "Health Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health

/datum/loadout_item/glasses/aviator_meson
	name = "Meson Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson

/datum/loadout_item/glasses/aviator_diagnostic
	name = "Diagnostic Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic

/datum/loadout_item/glasses/aviator_science
	name = "Science Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science

/datum/loadout_item/glasses/hud_eyepatch_sec
	name = "Security HUD Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sec

/datum/loadout_item/glasses/hud_eyepatch_med
	name = "Medical HUD Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med

/datum/loadout_item/glasses/hud_eyepatch_meson
	name = "Meson HUD Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/meson

/datum/loadout_item/glasses/hud_eyepatch_diagnostic
	name = "Diagnostic HUD Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic

/datum/loadout_item/glasses/hud_eyepatch_sci
	name = "Science HUD Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
