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

/datum/storage/admin/bag/badmin

/datum/storage/admin/bag/subspace
	max_slots = 78 // max columns X max rows, selected because it doesn't cover the player icon

/// Standalone for a dropped proc overwrite in [admin_clothing.dm]
/datum/storage/admin/cytotheca

/// 2 slots, used by boots
/datum/storage/admin/pockets
	max_slots = 2

/// This overrides the TG version to not have 100% damage
/// 100% resistance. This is still worse than you'd expect.
/datum/armor/admin
	acid = 98
	bio = 95
	bomb = 95
	bullet = 95
	consume = 95
	energy = 95
	laser = 95
	fire = 98
	melee = 95
	wound = 95

/// This one DOES have 100% damage resistance.
/// It's not as good as you'd expect (allegedly).
/datum/armor/admin/badmin
	acid = 100
	bio = 100
	bomb = 100
	bullet = 100
	consume = 100
	energy = 100
	laser = 100
	fire = 100
	melee = 100
	wound = 100
