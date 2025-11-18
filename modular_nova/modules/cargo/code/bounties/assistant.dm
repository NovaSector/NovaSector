/datum/bounty/item/assistant/nuggies
	name = "Chicken Nuggets"
	description = "We tried begging the chef and failed. We heard assistants get a free box from the blue machine with each redeemed GAP card."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 5
	wanted_types = list(/obj/item/food/nugget = TRUE)

/datum/bounty/item/assistant/fake_id
	name = "Cardboard Identifications"
	description = "Our HoP Identification machine is busted, send us some cardboard ID's so we can assign roles by hand."
	reward = CARGO_CRATE_VALUE * 3
	required_count = 3
	wanted_types = list(/obj/item/card/cardboard = TRUE)

/datum/bounty/item/assistant/glass_bowl
	name = "Glass Bowl"
	description = "We broke the representative's commemorative glass bowl during an aggressive redecoration, please send a replacement ASAP!"
	reward = CARGO_CRATE_VALUE * 12.5
	wanted_types = list(/obj/item/reagent_containers/cup/bowl/blowing_glass = TRUE)

/datum/bounty/item/assistant/clay_craft
	name = "Clay Crafts"
	description = "Our museum ashwalker pots collection was smashed by a maniac mime wearing a green outfit! We need three ceramic pieces so we can still get the culture stimulus."
	reward = CARGO_CRATE_VALUE * 12.5
	required_count = 3
	wanted_types = list(
		/obj/item/reagent_containers/cup/bowl/ceramic = TRUE,
		/obj/item/plate/oven_tray/material/ceramic = TRUE,
		/obj/item/reagent_containers/cup/beaker/large/ceramic = TRUE,
		/obj/item/plate/ceramic = TRUE,
	)

/datum/bounty/item/assistant/forged_sharp
	name = "Forged Dagger"
	description = "Our chef is adamant to use an authentic Tiziran made knife. Send us anything that cuts and was forged and we will do the rest."
	reward = CARGO_CRATE_VALUE * 9
	wanted_types = list(
		/obj/item/forging/reagent_weapon/sword = TRUE,
		/obj/item/forging/reagent_weapon/katana = TRUE,
		/obj/item/forging/reagent_weapon/dagger = TRUE,
		/obj/item/forging/reagent_weapon/axe = TRUE,
	)

/datum/bounty/item/assistant/wheelchair
	name = "Two Wheelchairs"
	description = "We had too many incidents with the Tram and people trying to skate in the middle rail, we now need extra wheelchairs. You can send them folded."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 2
	wanted_types = list(
		/obj/vehicle/ridden/wheelchair = TRUE,
		/obj/item/wheelchair = TRUE,
	)

/datum/bounty/item/assistant/floodlight
	name = "Flood Light"
	description = "An electrical storm overloaded most of our lights! Please send us a complete floodlight, with the cables and light tube already assembled!"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/machinery/power/floodlight = TRUE)

/datum/bounty/item/assistant/mannequin
	name = "Mannequin"
	description = "I need to take a bathroom break and the desk needs to be manned. Send a Mannequin made out of wood or plastic, but do so urgently, I beg you!"
	reward = CARGO_CRATE_VALUE * 4
	wanted_types = list(/obj/structure/mannequin = TRUE)

/datum/bounty/item/assistant/blackmarket
	name = "Black Market Uplink"
	description = "We are having trouble receiving critical supplies through the regular channels, so we need a device that allows us to contact less regulated routes. Do not mention this shipment to security."
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/market_uplink/blackmarket = TRUE)
