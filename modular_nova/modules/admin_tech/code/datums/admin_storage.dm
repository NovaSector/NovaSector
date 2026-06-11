//! Contains admin storage types

/// A storage datum with infinite weight and many slots
/datum/storage/admin
	max_slots = 65 // max columns X max rows, selected because it doesn't cover the player icon
	max_specific_storage = WEIGHT_CLASS_GIGANTIC // fixes boxes down the chain too
	max_total_storage = INFINITY
	allow_quick_empty = TRUE
	screen_max_columns = 13
	allow_big_nesting = TRUE

/// This one is optimized for bags
/datum/storage/admin/bag
	allow_quick_gather = TRUE
	supports_smart_equip = FALSE
	numerical_stacking = TRUE

/datum/storage/admin/bag/subspace
	max_slots = 78 // max columns X max rows, selected because it doesn't cover the player icon

/// Standalone for a dropped proc overwrite in [admin_clothing.dm]
/datum/storage/admin/cytotheca

/// 2 slots, used by boots
/datum/storage/admin/pockets
	max_slots = 2
