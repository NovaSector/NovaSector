//! Contains admin storage types

/// A storage datum with infinite weight and many slots
/datum/storage/admin
	max_slots = 65
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = INFINITY
	allow_quick_empty = TRUE
	screen_max_columns = 13
	allow_big_nesting = TRUE

/// Used by bags like the trash bag/construction bag
/datum/storage/admin/bag
	allow_quick_gather = TRUE
	supports_smart_equip = FALSE
	numerical_stacking = TRUE

/// Used by the subspace pocket
/datum/storage/admin/bag/badmin

/datum/storage/admin/bag/subspace
	max_slots = 78 // max columns X max rows, selected because it doesn't cover the player icon

/// Standalone for a dropped proc override
/datum/storage/admin/cytotheca

/datum/storage/admin/cytotheca/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(
		can_hold_list = list(
			/obj/item/slimecross/stabilized,
		),
		cant_hold_list = list()
	)

// Overrides normal dumping code to instead dump from the pouch item inside
// todo: veryify this works
/datum/storage/admin/cytotheca/dump_content_at(atom/dest_object, dump_loc, mob/user)
	var/atom/used_belt = parent
	if(!used_belt)
		return
	var/obj/item/storage/subspace_pouch/cytotheca = locate() in real_location
	if(!cytotheca)
		cytotheca.balloon_alert(user, "no pouch!")
		return //oopsie!! If we don't have a pouch! You're fucked!
	if(locked)
		cytotheca.balloon_alert(user, "locked!")
		return
	cytotheca.atom_storage.dump_content_at(dest_object, user = user)

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
