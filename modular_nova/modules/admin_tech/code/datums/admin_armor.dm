//! Contains admin armor types

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
