/datum/supply_pack/companies/general
	group = "★ General"
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

// Blacksteel
/datum/supply_pack/companies/general/blacksteel
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/general/blacksteel/forging_metals
	auto_name = FALSE
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/general/blacksteel/forging_metals/fake_cobalt
	name = "Cobolterium"
	contains = list(/obj/item/stack/sheet/cobolterium/three)
	desc = "A three-pack of our finest cobolterium alloy, with an unmatched regal blue color for creating the strongest metalworks from."

/datum/supply_pack/companies/general/blacksteel/forging_metals/fake_copper
	name = "Copporcitite"
	contains = list(/obj/item/stack/sheet/copporcitite/three)
	desc = "A three-pack of our finest copporcitite alloy, with a powerful, fiery orange color for creating the strongest metalworks from."

/datum/supply_pack/companies/general/blacksteel/forging_metals/fake_really_blue_aluminum
	name = "Tinumium"
	contains = list(/obj/item/stack/sheet/tinumium/three)
	desc = "A three-pack of our finest tinumium alloy, with a mystical faded blue color for creating the strongest metalworks from."

/datum/supply_pack/companies/general/blacksteel/forging_metals/fake_brass
	name = "Brussite"
	contains = list(/obj/item/stack/sheet/brussite/three)
	desc = "A three-pack of our finest brussite alloy, with a robust yellow color for creating the strongest metalworks from."

// Kahraman

/datum/supply_pack/companies/general/kahraman
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/general/kahraman/fireproof_spray
	contains = list(/obj/item/fireproof_spray)

// HC

/datum/supply_pack/companies/general/hc_surplus

/datum/supply_pack/companies/general/hc_surplus/hc_flag
	contains = list(/obj/item/sign/flag/hc)
	cost = CARGO_CRATE_VALUE * 0.2

// Donk
/datum/supply_pack/companies/general/donk
	cost = CARGO_CRATE_VALUE * 0.25

/datum/supply_pack/companies/general/donk/food

/datum/supply_pack/companies/general/donk/food/ready_donk
	contains = list(/obj/item/food/ready_donk)

/datum/supply_pack/companies/general/donk/food/ready_donkhiladas
	contains = list(/obj/item/food/ready_donk/donkhiladas)

/datum/supply_pack/companies/general/donk/food/ready_donk_n_cheese
	contains = list(/obj/item/food/ready_donk/mac_n_cheese)

/datum/supply_pack/companies/general/donk/food/pockets
	contains = list(/obj/item/storage/box/donkpockets)

/datum/supply_pack/companies/general/donk/food/berry_pockets
	contains = list(/obj/item/storage/box/donkpockets/donkpocketberry)

/datum/supply_pack/companies/general/donk/food/honk_pockets
	contains = list(/obj/item/storage/box/donkpockets/donkpockethonk)

/datum/supply_pack/companies/general/donk/food/pizza_pockets
	contains = list(/obj/item/storage/box/donkpockets/donkpocketpizza)

/datum/supply_pack/companies/general/donk/food/spicy_pockets
	contains = list(/obj/item/storage/box/donkpockets/donkpocketspicy)

/datum/supply_pack/companies/general/donk/food/teriyaki_pockets
	contains = list(/obj/item/storage/box/donkpockets/donkpocketteriyaki)

/datum/supply_pack/companies/general/donk/food/pizza_voucher
	desc = "WE ALWAYS DELIVER! WE ALWAYS DELIVER! WE ALWAYS DELIVER!"
	contains = list(/obj/item/pizzavoucher)

/datum/supply_pack/companies/general/donk/pet_food

/datum/supply_pack/companies/general/donk/pet_food/void
	cost = CARGO_CRATE_VALUE * 0.5
	contains = list(/obj/item/pet_food/pet_space_treat)

/datum/supply_pack/companies/general/donk/merch

/datum/supply_pack/companies/general/donk/merch/donk_carpet
	contains = list(/obj/item/stack/tile/carpet/donk/thirty)
