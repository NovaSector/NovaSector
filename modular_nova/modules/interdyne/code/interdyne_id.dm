/// Interdyne Pharmaceuticals — ID cards and access trims
/// Independent card system (like Tarkon), not a syndicom subtype.

// ---- Trims ----

/datum/id_trim/interdyne
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "Interdyne Scientist"
	trim_state = "trim_interdyne"
	sechud_icon_state = SECHUD_INTERDYNE_CREW
	department_color = COLOR_LIME
	department_state = "department"
	subdepartment_color = COLOR_VERY_DARK_LIME_GREEN
	access = list(ACCESS_SYNDICATE, ACCESS_INTERDYNE)
	threat_modifier = 2 // Interdyne is allowed on station, so this'll get beepskys off them.

/datum/id_trim/interdyne/shaftminer
	assignment = "Interdyne Shaft Miner"
	sechud_icon_state = SECHUD_INTERDYNE_SHAFTMINER
	department_color = COLOR_CARGO_BROWN

/datum/id_trim/interdyne/deckofficer
	assignment = "Deck Officer"
	trim_state = "trim_deckofficer"
	sechud_icon_state = SECHUD_INTERDYNE_DECKOFFICER
	department_color = COLOR_VERY_DARK_LIME_GREEN
	access = list(ACCESS_SYNDICATE, ACCESS_INTERDYNE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

// ---- ID Cards ----

/obj/item/card/id/advanced/interdyne
	name = "\improper Interdyne access card"
	desc = "An Interdyne Pharmaceuticals corporate access card. This person knows how to cook and is happy to bill you for it."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_card.dmi'
	icon_state = "interdyne"
	assigned_icon_state = "assigned_interdyne"
	trim = /datum/id_trim/interdyne

/obj/item/card/id/advanced/interdyne/shaftminer
	name = "\improper Interdyne shaft miner's access card"
	desc = "An Interdyne Pharmaceuticals access card designated for mining personnel. This person knows its rocks"
	trim = /datum/id_trim/interdyne/shaftminer

/obj/item/card/id/advanced/chameleon/elite/interdyne
	name = "\improper Interdyne deck officer's access card"
	desc = "An Interdyne Pharmaceuticals access card designated for the deck officer. The green trim is slightly more ornate. \
		Features an embedded high-end microchip with chameleon capabilities."
	icon = 'modular_nova/modules/interdyne/icons/interdyne_card.dmi'
	icon_state = "interdyne"
	assigned_icon_state = "assigned_interdyne"
	trim = /datum/id_trim/interdyne/deckofficer
