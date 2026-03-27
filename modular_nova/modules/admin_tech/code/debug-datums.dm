// Debug Datums
// TODO: merge traits, weight classes, and shit into these, to reduce input on the items themselves. Need one thats just armor, and one thats got the additional bonuses
// todo: make defines?
// Debug Storage Datums. Need more slots? Raise the number on max_total_storage and max_slots symmetrically
/datum/storage/debug
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 63
	max_slots = 63
	allow_big_nesting = TRUE

/datum/storage/box/debug// Overwrites the original debug box datum to be more sane / match our other debug storage
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_GIGANTIC * 63
	max_slots = 63
	allow_big_nesting = TRUE

///Debug construction bag
/datum/storage/bag/construction/debug
	allow_big_nesting = TRUE
	max_slots = 99
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = 6769

/datum/armor/debug//No one is invincible.
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

/datum/armor/debug/badmin//I'm serious, this isnt enough to save your un-robust ass.
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
