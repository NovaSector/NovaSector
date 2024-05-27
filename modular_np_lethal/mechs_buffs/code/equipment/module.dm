// all the mechs have double the health, therefore this heals faster.

/obj/item/mecha_parts/mecha_equipment/repair_droid
	name = "exosuit repair droid"
	desc = "An automated repair droid for exosuits. Scans for damage and repairs it. Can fix almost all types of external or internal damage."
	icon_state = "repair_droid"
	energy_drain = 100
	range = 0
	can_be_toggled = TRUE
	active = FALSE
	equipment_slot = MECHA_UTILITY
	/// Repaired health per second
	health_boost = 3
