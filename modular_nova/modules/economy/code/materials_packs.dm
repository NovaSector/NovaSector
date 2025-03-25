// Readds the materials crates the GMM removed, but mostly for things like assistant projects.

/datum/supply_pack/materials/glass_fifty
	name = "50 Glass Sheets"
	desc = "Let some nice light in with fifty glass sheets!"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/stack/sheet/glass/fifty)
	crate_name = "glass sheets crate"

/datum/supply_pack/materials/iron_fifty
	name = "50 Iron Sheets"
	desc = "Any construction project begins with a good stack of fifty iron sheets!"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/stack/sheet/iron/fifty)
	crate_name = "iron sheets crate"

/datum/supply_pack/materials/plasteel_twenty
	name = "20 Plasteel Sheets"
	desc = "Reinforce the station's integrity with twenty plasteel sheets!"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/stack/sheet/plasteel/twenty)
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/plasteel_fifty
	name = "50 Plasteel Sheets"
	desc = "For when you REALLY have to reinforce something."
	cost = CARGO_CRATE_VALUE * 33
	contains = list(/obj/item/stack/sheet/plasteel/fifty)
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/stone_fifty
	name = "50 Stone Bricks"
	desc = "Too busy to go down to mine your own rock? We got you!"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/stack/sheet/mineral/stone/fifty)
	crate_name = "stone bricks crate"
