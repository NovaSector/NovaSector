/obj/item/melee/energy
	/// The sound played when the item is turned on
	var/enable_sound = 'sound/items/weapons/saberon.ogg'

	/// The sound played when the item is turned off
	var/disable_sound = 'sound/items/weapons/saberoff.ogg'

// at the time of balancing this, chance was 75 and pain mult 10, but it was not taking Huge weight class into account.
/datum/embedding/esword/surplus
	embed_chance = 50
	impact_pain_mult = 5

/obj/item/melee/energy/sword/surplus
	embed_type = /datum/embedding/esword/surplus

/obj/item/melee/energy/sword/surplus/improvised
	name = "\improper Type II 'Bokuto' energy sword"
	desc = "A hand made energy sword used for live training and pest control. It can be recharged with the dynamos in the handle."
	block_chance = 25 // Surplus is 50
